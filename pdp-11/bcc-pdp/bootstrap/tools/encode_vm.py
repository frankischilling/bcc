"""Experimental seed encoder for resolved B records, not a self-hosted compiler."""
import argparse
from pathlib import Path
import struct

PRIMITIVES = dict(zip(('read','write','open','creat','close','char','lchar','exit',
                      'unlink','seek','putchar','getchar'), range(32701,32713)))

class Code:
    def __init__(self):
        self.words=[]; self.labels={}; self.fix=[]
    def emit(self,op,*args):
        self.words.append(op)
        for arg in args:
            if isinstance(arg,tuple):self.fix.append((len(self.words),arg));self.words.append(0)
            else:self.words.append(arg)
    def label(self,key):
        if key in self.labels:raise ValueError(f'duplicate code label {key}')
        self.labels[key]=len(self.words)
    def finish(self):
        for at,key in self.fix:
            if key not in self.labels:raise ValueError(f'undefined code label {key}')
            self.words[at]=self.labels[key]
        return self.words

def encode(text):
    rows=[line.split() for line in text.splitlines() if line.strip()]
    data=[0]*16; symbols={}; literals={}; label_cells={}; refs=[]; initial=[]
    def alloc(count):
        at=len(data);data.extend([0]*count)
        if len(data)>=8192:raise ValueError('static data fills the VM heap')
        return at
    def define(name,count):
        if name in symbols:raise ValueError(f'duplicate external {name}')
        at=alloc(count);symbols[name]=at;return at
    current=None
    for index,row in enumerate(rows):
        tag,*fields=row
        if tag in ('gvb','gvp'):
            if current:raise ValueError('nested global')
            current=(tag,fields[0],int(fields[1]),[])
        elif tag in ('gvc','gvn','gvl'):
            if current is None:raise ValueError('initializer outside global')
            current[3].append((tag,fields[0]))
            if tag=='gvn':refs.append(fields[0])
        elif tag=='gve':
            if current is None:raise ValueError('global end without definition')
            kind,name,count,values=current
            if count<0:raise ValueError('negative global size')
            size=max(count,len(values));at=define(name,size+(kind=='gvp'))
            start=at+(kind=='gvp')
            if kind=='gvp':data[at]=start
            for offset,value in enumerate(values):initial.append((start+offset,*value))
            current=None
        elif tag=='pr':define(fields[0],1)
        elif tag in ('Slit','Glit'):
            n=int(fields[0]);values=[int(v)&255 for v in fields[1:]]
            if len(values)!=n or not 0<=n<=256:raise ValueError('invalid literal')
            at=alloc((n+1)//2);literals[index]=at
            for byte,value in enumerate(values):data[at+byte//2]|=value<<((byte%2)*8)
        elif tag=='lv':
            key=int(fields[0])
            if key in label_cells:raise ValueError('duplicate label cell')
            label_cells[key]=alloc(1)
        elif tag=='ex':refs.append(fields[0])
    if current:raise ValueError('unfinished global')
    own_argv='argv' in symbols
    for name in refs:
        if name in symbols:continue
        if name not in PRIMITIVES and name!='argv':raise ValueError(f'unresolved external {name}')
        at=define(name,1);data[at]=PRIMITIVES.get(name,0)
    if 'main' not in symbols:raise ValueError('missing main')
    lit_order=list(literals.values())
    for at,tag,value in initial:
        if tag=='gvc':data[at]=int(value)
        elif tag=='gvn':data[at]=symbols[value]
        else:data[at]=lit_order[int(value)]
    c=Code()
    c.emit(26,len(data));c.emit(28,16,len(data)-16)
    payload=len(c.words);c.words.extend(data[16:])
    # Reserved cells 1..7 hold startup temporaries. User globals start at 16.
    def n(value):c.emit(1,value)
    def load(at):c.emit(2,at)
    def store(at):c.emit(3,at)
    def call(target,args):
        n(target);c.emit(8)
        for arg in args:
            if isinstance(arg,tuple) and arg[0]=='cell':load(arg[1])
            else:n(arg)
            c.emit(8)
        c.emit(10,len(args))
    def branch(label):c.emit(7,('boot',label))
    call(32713,[]);store(2)  # argc includes the bytecode program name
    n(32715);c.emit(8);load(2);c.emit(4,1);c.emit(8);c.emit(10,1);store(1);branch('fail')
    load(1);c.emit(8);load(2);c.emit(16)
    if 'argv' in symbols and not own_argv:load(1);store(symbols['argv'])
    n(0);store(3)
    c.label(('boot','argument'))
    load(3);c.emit(8);load(2);c.emit(9,60);branch('ready')
    n(0);store(4)
    c.label(('boot','length'))
    call(32714,[('cell',3),('cell',4)]);branch('allocate')
    load(4);c.emit(4,1);store(4);c.emit(6,('boot','length'))
    c.label(('boot','allocate'))
    n(32715);c.emit(8);load(4);c.emit(4,2);c.emit(8);n(2);c.emit(9,47);c.emit(8);c.emit(10,1);store(5);branch('fail')
    load(1);c.emit(8);load(3);c.emit(4,1);c.emit(9,43);c.emit(8);load(5);c.emit(16)
    n(0);store(6)
    c.label(('boot','copy'))
    call(32714,[('cell',3),('cell',6)]);store(7)
    call(32707,[('cell',5),('cell',6),('cell',7)])
    load(7);branch('next-argument')
    load(6);c.emit(4,1);store(6);c.emit(6,('boot','copy'))
    c.label(('boot','next-argument'))
    load(3);c.emit(4,1);store(3);c.emit(6,('boot','argument'))
    c.label(('boot','ready'))
    n(('fn','main'));c.emit(8);load(2);c.emit(8);load(1);c.emit(4,1);c.emit(8);c.emit(10,2);c.emit(0)
    c.label(('boot','fail'));n(1);c.emit(0)
    function=None;enter_at=None;retlabel=None
    def lab(value):return ('L',int(value))
    def boolean(false,end):
        c.emit(7,lab(false));n(1);c.emit(6,lab(end));c.label(lab(false));n(0);c.label(lab(end))
    for index,row in enumerate(rows):
        tag,*f=row
        if tag=='pr':
            if function:raise ValueError('nested function')
            function=f[0];retlabel=int(f[2]);c.label(('fn',function))
            c.emit(11,0);enter_at=len(c.words)-1
        elif tag=='ep':
            if not function:raise ValueError('epilogue outside function')
            c.words[enter_at]=int(f[0]);c.label(lab(retlabel));c.emit(12);function=None
        elif tag=='rt':c.emit(6,lab(retlabel))
        elif tag=='n':n(int(f[0]))
        elif tag=='ps':c.emit(8)
        elif tag=='lc':c.emit(13,int(f[0]))
        elif tag=='ar':c.emit(14,int(f[0]))
        elif tag=='dr':c.emit(15)
        elif tag=='as':c.emit(16)
        elif tag=='bin':c.emit(9,int(f[0]))
        elif tag=='binc':c.emit(9,int(f[0]));boolean(f[1],f[2])
        elif tag=='cl':c.emit(10,int(f[0]))
        elif tag=='bf':c.emit(7,lab(f[0]))
        elif tag=='jm':c.emit(6,lab(f[0]))
        elif tag=='lb':c.label(lab(f[0]))
        elif tag=='ex':n(symbols[f[0]])
        elif tag=='st':n(lit_order[int(f[0])])
        elif tag=='Slit':n(literals[index])
        elif tag=='Glit':pass
        elif tag=='uo':c.emit(18,int(f[0]))
        elif tag=='uon':c.emit(18,33);boolean(f[0],f[1])
        elif tag=='ix':c.emit(9,43)
        elif tag=='po':c.emit(19,1 if int(f[0]) else -1)
        elif tag=='pi':c.emit(20,1 if int(f[0]) else -1)
        elif tag=='vi':c.emit(22,int(f[0]),int(f[1]))
        elif tag=='ca':c.emit(21,int(f[0]))
        elif tag=='cac':c.emit(21,int(f[0]));boolean(f[1],f[2])
        elif tag=='la':n(label_cells[int(f[0])])
        elif tag=='gor':c.emit(17)
        elif tag=='swb':c.emit(8);c.emit(6,lab(f[0]))
        elif tag=='swc':
            dispatch,next_case,value,body=f
            c.emit(6,lab(body));c.label(lab(dispatch))
            c.emit(23);c.emit(8);n(int(value));c.emit(9,100)
            c.emit(7,lab(next_case));c.emit(24);c.label(lab(body))
        elif tag=='swx':
            last,end=f
            c.emit(6,lab(end));c.label(lab(last));c.emit(24);c.label(lab(end))
        elif tag in ('gvb','gvp','gvc','gvn','gvl','gve','lv'):pass
        else:raise ValueError(f'unsupported record {row}')
    if function:raise ValueError('unfinished function')
    c.finish()
    for name,at in symbols.items():
        if ('fn',name) in c.labels:data[at]=c.labels['fn',name]
    for lid,at in label_cells.items():data[at]=c.labels['L',lid]
    c.words[payload:payload+len(data)-16]=data[16:]
    if len(c.words)>16384:raise ValueError(f'code exceeds VM range: {len(c.words)} words')
    return struct.pack('<'+'H'*len(c.words),*(word&65535 for word in c.words)),len(data),len(c.words)

if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('input',type=Path);parser.add_argument('output',type=Path)
    args=parser.parse_args();image,data,code=encode(args.input.read_text())
    args.output.write_bytes(image);print(f'data words={data}; code words={code}; image bytes={len(image)}')
