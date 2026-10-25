"""Exercise experimental VM arithmetic, paging, frames, I/O, and bad records."""
import os
import struct
import subprocess
import tempfile
import sys
from pathlib import Path
ROOT=Path(__file__).resolve().parent
NATIVE=ROOT.parent
sys.path.insert(0,str(ROOT/'tools'))
from build_vm import build

def w(n):
    n&=65535
    return n-65536 if n>=32768 else n

def result(x,y,op):
    if op in (47,37) and y==0:return None,22
    if op in (47,37):
        q=(abs(x)//abs(y))*(-1 if (x<0)!=(y<0) else 1)
        return w(q if op==47 else x-q*y),0
    f={43:lambda:x+y,45:lambda:x-y,42:lambda:x*y,38:lambda:x&y,
    124:lambda:x|y,94:lambda:x^y,60:lambda:x<y,62:lambda:x>y,
    100:lambda:x==y,101:lambda:x!=y,102:lambda:x<=y,103:lambda:x>=y,
    104:lambda:0 if y<0 or y>=16 else x<<y,105:lambda:0 if y<0 or y>=16 else (x&65535)>>y}
    return w(f[op]()),0
cases=[]
for op in (43,45,42,47,37,38,124,94,60,62,100,101,102,103,104,105):
    for x in (-32768,-1,0,1,32767):
        for y in (-32768,-1,0,1,15,16,32767):
            expected,status=result(x,y,op)
            cases.append((f'binary/{op}/{x}/{y}',[1,x,8,1,y,9,op,0],expected,status))
for x in (-32768,-1,0,1,32767):
    for op,expected in [(45,w(-x)),(33,int(x==0)),(126,w(~x))]:
        cases.append((f'unary/{op}/{x}',[1,x,18,op,0],expected,0))
    for delta in (-1,1):
        for op in (19,20):
            cases.append((f'increment/{op}/{x}/{delta}',[1,x,3,16,1,16,op,delta,0],x if op==19 else w(x+delta),0))
        cases.append((f'increment-store/{x}/{delta}',[1,x,3,16,1,16,19,delta,2,16,0],w(x+delta),0))
for op in (43,45,42,47,37,38,124,94,60,62,100,101,102,103,104,105):
    expected,status=result(-123,7,op)
    cases.append((f'compound/{op}',[1,-123,3,16,1,16,8,1,7,21,op,2,16,0],expected,status))
for name,code,status in [('pop-empty',[24],19),('peek-empty',[23],19),('read-null',[1,0,15],16),
    ('read-end',[1,8192,15],16),('store-null',[3,0],16),('call-null',[1,0,8,10,0],24),
    ('return-empty',[12],25),('negative-frame',[11,-1],18),('truncated',[1],14),
    ('bad-opcode',[-1],17),('negative-jump',[6,-1],11),('far-jump',[6,16384],11)]:
    cases.append((name,code,None,status))
# Recursive call fixture: one argument, one local frame, and explicit return.
rec=[1, 9, 8, 1, 5, 8, 10, 1, 0, 11, 1, 14, 0, 15, 8, 1, 0, 9, 100, 7, 24, 1, 0, 12, 1, 9, 8, 14, 0, 15, 8, 1, 1, 9, 45, 8, 10, 1, 8, 1, 1, 9, 43, 12]
for n in (0,1,5,100,200):
    code=rec.copy();code[4]=n
    cases.append((f'recursion/{n}',code,n,0))

class Program:
    def __init__(self):self.code=[];self.labels={};self.fix=[]
    def emit(self,op,*args):
        self.code.append(op)
        for a in args:
            if isinstance(a,str):self.fix.append((len(self.code),a));self.code.append(0)
            else:self.code.append(a)
    def label(self,name):self.labels[name]=len(self.code)
    def finish(self):
        for at,name in self.fix:self.code[at]=self.labels[name]
        return self.code
for count in (0,1,3,4):
    p=Program();p.emit(1,'fn');p.emit(8)
    for arg in range(1,count+1):p.emit(1,arg);p.emit(8)
    p.emit(10,count);p.emit(0);p.label('fn');p.emit(11,1);p.emit(14,0);p.emit(15)
    for arg in range(1,min(count,3)):
        p.emit(8);p.emit(1,10);p.emit(9,42);p.emit(8);p.emit(14,arg);p.emit(15);p.emit(9,43)
    p.emit(12);cases.append((f'argument-order/{count}',p.finish(),[0,1,0,123,123][count],0))
p=Program();p.emit(1,'old');p.emit(8);p.emit(1,'new');p.emit(3,16);p.emit(1,99);p.emit(8);p.emit(10,1);p.emit(0)
p.label('old');p.emit(11,0);p.emit(1,33);p.emit(12);p.label('new');p.emit(11,0);p.emit(1,44);p.emit(12)
cases.append(('saved-callee',p.finish(),33,0))
p=Program();p.emit(1,'fn');p.emit(8);p.emit(10,0);p.emit(0);p.label('fn');p.emit(11,4);p.emit(22,0,3)
p.emit(13,0);p.emit(15);p.emit(8);p.emit(1,42);p.emit(16);p.emit(13,3);p.emit(15);p.emit(12)
cases.append(('vector-frame',p.finish(),42,0))
p=Program();p.emit(1,4);p.emit(8);p.emit(23);p.emit(8);p.emit(1,4);p.emit(9,100);p.emit(7,'miss');p.emit(24);p.emit(1,42);p.emit(0)
p.label('miss');p.emit(24);p.emit(1,0);p.emit(0);cases.append(('switch-stack',p.finish(),42,0))
p=Program();p.emit(1,'label');p.emit(3,17);p.emit(2,17);p.emit(17);p.emit(1,0);p.emit(0);p.label('label');p.emit(1,42);p.emit(0)
cases.append(('label-cell',p.finish(),42,0))
cases.append(('assignment-result',[1,16,8,1,42,16,0],42,0))
cases.append(('last-cell',[1,42,3,3071,2,3071,0],42,0))
cases.append(('frame-overflow',[11,9000,0],None,18))
code=rec.copy();code[4]=1500;cases.append(('recursive-overflow',code,None,18))
code=[1,0,3,16,2,16,4,1,3,16,5,1000,7,255,6,4]
code.extend([0]*(255-len(code)));code.extend([2,16,0]);cases.append(('page-boundary',code,1000,0))

def call(p,op,*args):
    p.emit(1,32700+op);p.emit(8)
    for arg in args:
        if isinstance(arg,tuple):p.emit(2,arg[1])
        else:p.emit(1,arg)
        p.emit(8)
    p.emit(10,len(args))
def put(p,addr,value):p.emit(1,value);p.emit(3,addr)
for index in range(4):
    p=Program();put(p,16,0x4241);put(p,17,0x4443);call(p,6,16,index);p.emit(0)
    cases.append((f'char/{index}',p.finish(),65+index,0))
p=Program();put(p,16,0x4241);put(p,17,0x4443);call(p,6,17,-1);p.emit(0)
cases.append(('char-negative-index',p.finish(),66,0))
for value in (-1,256,4660):
    p=Program();put(p,16,0x4241);call(p,7,16,1,value);p.emit(0)
    cases.append((f'lchar-result/{value}',p.finish(),value,0))
    p=Program();put(p,16,0x4241);call(p,7,16,1,value);p.emit(2,16);p.emit(0)
    cases.append((f'lchar-storage/{value}',p.finish(),((value&255)<<8)|65,0))
for name,op,args in [('read-bad-fd',1,(999,16,1)),('read-null',1,(0,0,1)),
    ('read-negative',1,(0,16,-1)),('write-null',2,(1,0,1)),('write-negative',2,(1,16,-1)),
    ('close-bad-fd',5,(-1,)),('seek-bad-fd',10,(-1,0,0)),('seek-bad-origin',10,(0,0,77))]:
    p=Program();call(p,op,*args);p.emit(0);cases.append((name,p.finish(),-1,0))
p=Program();put(p,16,0x756f);put(p,17,0x0474);put(p,20,0x4241);put(p,21,67)
call(p,4,16,0o16);p.emit(3,30);call(p,2,('load',30),20,3);call(p,5,('load',30))
call(p,3,16,0);p.emit(3,30);call(p,1,('load',30),24,3);call(p,5,('load',30))
for addr,value in [(24,0x4241),(25,67)]:
    p.emit(2,addr);p.emit(8);p.emit(1,value);p.emit(9,100);p.emit(7,'io-fail')
p.emit(2,24);p.emit(0);p.label('io-fail');p.emit(1,-1);p.emit(0)
cases.append(('file-roundtrip',p.finish(),0x4241,0))

for n in (1000,1200):
    code=rec.copy();code[4]=n;cases.append((f'paged-recursion/{n}',code,n,0))
cases.append(('expanded-cell',[1,42,3,3072,2,3072,0],42,0))
cases.append(('paged-last-cell',[1,42,3,8191,2,8191,0],42,0))
p=Program()
for at,value in [(16,42),(300,99),(600,-1),(900,4660)]:put(p,at,value)
p.emit(2,16)
for at in (300,600,900):p.emit(8);p.emit(2,at);p.emit(9,43)
p.emit(0);cases.append(('heap-eviction',p.finish(),4800,0))
for index in range(4):
    p=Program();put(p,255,0x4241);put(p,256,0x4443);call(p,6,255,index);p.emit(0)
    cases.append((f'char-page-crossing/{index}',p.finish(),65+index,0))
p=Program();put(p,255,0x4241);put(p,256,0x4443);call(p,7,255,2,90);p.emit(2,256);p.emit(0)
cases.append(('lchar-page-crossing',p.finish(),0x445a,0))
p=Program();put(p,16,0x756f);put(p,17,0x0474);put(p,255,0x4241);put(p,256,67)
call(p,4,16,0o16);p.emit(3,30);call(p,2,('load',30),255,3);call(p,5,('load',30))
call(p,3,16,0);p.emit(3,30);call(p,1,('load',30),511,3);call(p,5,('load',30))
for addr,value in [(511,0x4241),(512,67)]:
    p.emit(2,addr);p.emit(8);p.emit(1,value);p.emit(9,100);p.emit(7,'io-fail')
p.emit(2,511);p.emit(0);p.label('io-fail');p.emit(1,-1);p.emit(0)
cases.append(('file-page-crossing',p.finish(),0x4241,0))

for name,code,expected,status in [
    ('reserve-min',[26,16,0],0,0),('reserve-max',[26,8191,0],0,0),
    ('reserve-zero',[26,0,0],None,18),('reserve-too-large',[26,8192,0],None,18),
    ('load-data',[28,16,4,42,-1,0x4241,4,2,16,0],42,0),
    ('load-negative',[28,16,2,42,-1,2,17,0],-1,0),
    ('load-truncated',[28,16,5,1],None,14),('load-null',[28,0,1,0],None,16),
    ('load-overflow',[28,8190,3,0,0,0],None,16),('load-negative-count',[28,16,-1],None,16)]:
    cases.append((name,code,expected,status))
for name,op,args,expected in [
    ('native-argv/count',13,(),3),('native-argv/program',14,(0,0),99),
    ('native-argv/first',14,(1,0),97),('native-argv/end',14,(1,5),0),
    ('native-argv/past-end',14,(1,100),0),('native-argv/bad-argument',14,(3,0),-1),
    ('native-argv/negative-index',14,(0,-1),-1),('allocate-zero',15,(0,),128),
    ('allocate-ten',15,(10,),128),('allocate-negative',15,(-1,),0),
    ('allocate-too-large',15,(8192,),0)]:
    p=Program();call(p,op,*args);p.emit(0);cases.append((name,p.finish(),expected,0))
p=Program();p.emit(26,512);call(p,15,10);call(p,15,3);p.emit(0)
cases.append(('allocate-sequence',p.finish(),522,0))
cases.append(('operand-cross-32',[6,31]+[0]*29+[1,42,0],42,0))
cases.append(('odd-code-tail',bytes([1,0,42]),None,14))
many_pages=[(16+64*i,[-32768,-1][i] if i<2 else i+1) for i in range(16)]
p=Program()
for address,value in many_pages:put(p,address,value)
p.emit(2,many_pages[0][0])
for address,_ in many_pages[1:]:p.emit(8);p.emit(2,address);p.emit(9,43)
p.emit(0)
cases.append(('many-page-eviction',p.finish(),w(sum(value for _,value in many_pages)),0))
p=Program();p.emit(1,3);p.emit(3,16);p.emit(6,'far')
p.label('near');p.emit(2,16);p.emit(7,'done');p.emit(6,'far')
p.label('done');p.emit(1,42);p.emit(0)
while len(p.code)<256:p.code.append(0)
p.label('far');p.emit(2,16);p.emit(4,-1);p.emit(3,16);p.emit(6,'near')
cases.append(('instruction-cache-conflict',p.finish(),42,0))
passed=failed=0
with tempfile.TemporaryDirectory(prefix='bcc-vm-core-') as d:
    work=Path(d)
    build(work/'native',main=ROOT/'tests/vm_runner.b')
    build(work/'host',host=NATIVE.parents[1]/'bcc',main=ROOT/'tests/vm_runner.b')
    for model,cmd in [('native',[str(NATIVE.parent/'unix-v1/tools/apout/apout'),str(work/'native')]),('host16',[str(work/'host')])]:
        env=dict(os.environ,APOUT_ROOT=str(NATIVE/'build/aroot'),APOUT_UNIX_VERSION='V2')
        for name,code,expected,status in cases:
            (work/'heap.vm').write_bytes(bytes(16384))
            (work/'code.vm').write_bytes((code if isinstance(code,bytes) else struct.pack('<'+'H'*len(code),*(x&65535 for x in code))))
            extra=['code.vm','alpha','beta'] if name.startswith('native-argv/') else []
            r=subprocess.run([*cmd,*extra],cwd=work,env=env,capture_output=True,timeout=5)
            output=(f'{expected&65535:04x}\n'.encode() if status==0 else b'')
            ok=r.returncode==status and r.stdout==output and not r.stderr
            if ok and name=='heap-eviction':
                data=(work/'heap.vm').read_bytes()
                ok=all(struct.unpack_from('<h',data,at*2)[0]==value for at,value in [(16,42),(300,99),(600,-1),(900,4660)])
            if ok and name=='many-page-eviction':
                data=(work/'heap.vm').read_bytes()
                ok=all(struct.unpack_from('<h',data,address*2)[0]==value for address,value in many_pages)
            if ok and name in ('file-roundtrip','file-page-crossing'):
                ok=(work/'out').read_bytes()==b'ABC'
            print(('PASS' if ok else 'FAIL')+': '+model+'/'+name,flush=True)
            if not ok:print('expected',status,output,'got',r.returncode,r.stdout,r.stderr,flush=True)
            passed+=ok;failed+=not ok
print(f'Results: {passed} passed, {failed} failed')
raise SystemExit(bool(failed))
