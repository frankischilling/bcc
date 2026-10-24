#!/usr/bin/env python3
"""Executable regressions for kbman sections 2, 3, 4, 5, and 6."""

import argparse
from pathlib import Path
import subprocess
import tempfile


CASES = {
    "global_address_initializer": ("value 37; ref value; main(){extrn ref; return(*ref!=37);}", 0),
    "vector_address_initializer": ("value 37; refs[1] value; main(){extrn refs; return(*refs[0]!=37);}", 0),
    "empty_character": ("main(){return('');}", None),
    "overlong_character": ("main(){return('abc');}", None),
    "unclosed_character": ("main(){return('x", None),
    "function_value": ("f(){return(37);} main(){auto p; p=f; return(p()!=37);}", 0),
    "function_conditional": ("f(x){return(x+2);} g(x){return(x+3);} main(){return((1?f:g)(40)!=42);}", 0),
    "function_vector": ("f(x){return(x+2);} main(){auto v 2; v[0]=f; return(v[0](40)!=42);}", 0),
    "function_argument": ("f(x){return(x+2);} apply(p,x){return(p(x));} main(){return(apply(f,40)!=42);}", 0),
    "getchar_eof": ("main(){extrn getchar; return(getchar()!=004);}", 0),
    "getchar_value_eof": ("main(){auto f; extrn getchar; f=getchar; return(f()!=004);}", 0),
    "multiply_assignment": ("main(){auto x; x=6; x=*7; return(x!=42);}", 0),
    "spaced_dereference": ("main(){auto x,p,y; x=42; p= &x; y= *p; return(y!=42);}", 0),
    "brace_escapes": ("main(){return('*('!='{' | '*)'!='}');}", 0),
    "string_escapes": ('main(){auto p; p="*(*e"; if(char(p,0)!=\'{\' | char(p,1)!=004)return(1); p="*)"; return(char(p,0)!=\'}\');}', 0),
    "embedded_zero": ('main(){auto p,q; p="a*0b"; q="a*0c"; return(char(p,1)!=0 | char(p,2)!=\'b\' | char(q,2)!=\'c\' | char(p,3)!=004);}', 0),
    "quote_escape": ("main(){return('*''!=047);}", 0),
    "shift_precedence": ("main(){return((1<<2+1)!=8 | (16>>2-1)!=8);}", 0),
    "bitwise_order": ("main(){auto x,r; x=1; r=x++ & x++; if(x!=3 | r!=0)return(1); x=1; r=x++ | x++; return(x!=3 | r!=3);}", 0),
    "computed_goto": ("main(){auto p; p=done; goto p; return(1); done:return(0);}", 0),
    "conditional_goto": ("main(){goto (1?done:bad); bad:return(1); done:return(0);}", 0),
    "goto_call": ('choose(s,p){return(p);} main(){goto choose("ok",done); return(1); done:return(0);}', 0),
    "nested_label": ("main(){auto p; p=done; goto p; {done:return(0);} return(1);}", 0),
    "label_identifier": ("main(){goto next_1; next_1:return(0);}", 0),
    "function_label_scope": ("f(){goto done; done:return(7);} main(){goto done; done:return(f()!=7);}", 0),
    "historical_auto": ("main(){auto v 3; v[0]=7; v[2]=9; return(v[0]+v[2]!=16);}", 0),
    "strict_break": ("main(){while(1){break;} return(0);}", None),
    "strict_continue": ("main(){while(0){continue;} return(0);}", None),
    "strict_brackets": ("main(){auto v[3]; return(0);}", None),
    "strict_keyword_names": ("main(){auto break,continue,default; break=1; continue=2; default=3; return(break+continue+default!=6);}", 0),
    "strict_default_label": ("main(){switch 2 {case 1:return(1); default:return(2);} return(0);}", 0),
    "undeclared_internal": ("main(){return(missing);}", None),
    "duplicate_label": ("main(){same:; {same:;} return(0);}", None),
    "undefined_goto": ("main(){goto missing;}", None),
    "cross_function_label": ("f(){done:return(0);} main(){goto done;}", None),
}

WORD_CASES = {
    "pointer_add_zero": "main(){auto x,p; x=7; p= &x; p=p+0; return(*p!=7);}",
    "pointer_index": "main(){auto v 4,p; p=v; v[0]=3; v[1]=7; p=p+1; return(*p!=7 | &v[1]!=p);}",
    "pointer_roundtrip": "main(){auto x,p; x=9; p= &x; return(&*p!=p | *&x!=9);}",
    "pointer_compound": "main(){auto v 4,p; v[1]=9; p=v; p=+1; return(*p!=9);}",
    "pointer_parameter": "f(p){return(*(p+1));} main(){auto v 3; v[1]=11; return(f(v)!=11);}",
    "word_literal": "main(){auto x; x=0177777; return(x!=-1 | 0177777!=-1);}",
    "exact_signed_division": "main(){auto x; x= -6; x=/2; return(x!=-3 | 6/-2!=-3 | -6/-2!=3);}",
    "packed_word": "main(){auto v 2; v[0]='ab'; v[1]='cd'; return(char(v,0)!='b' | char(v,1)!='a' | char(v,2)!='d' | char(v,3)!='c');}",
    "packed_string": "main(){auto p; p=\"abcd\"; return(char(p,2)!='c' | *(p+1)!='dc');}",
    "write_character": "main(){auto v 2; v[0]=0; v[1]=0; lchar(v,2,'z'); return(v[1]!='z' | char(v,2)!='z');}",
    "mutable_string": 'main(){auto p; p="abcd"; lchar(p,2,\'z\'); return(char(p,2)!=\'z\' | *(p+1)!=\'dz\');}',
    "embedded_zero_word": 'main(){auto p; p="a*0b"; return(char(p,1)!=0 | char(p,2)!=\'b\' | char(p,3)!=004);}',
    "computed_goto_word": "main(){auto p; p=done; p=p+0; goto p; return(1); done:return(0);}",
    "global_vector": "v[3] 1,2,3; main(){extrn v; auto p; p=v+1; return(*p!=2 | &v[1]!=p);}",
    "high_address": "main(){auto large,p; large=alloc(32760); p=alloc(20); *p=7; *(p+1)=9; if(p>=0)return(1); if(*p!=7 | *(p+1)!=9)return(2); free(p); free(large); return(0);}",
    "frame_reuse": "f(n){auto v 3; v[0]=n; if(n>0)f(n-1); return(v[0]!=n);} main(){auto i; i=0; while(i++<200){if(f(40))return(1);} return(0);}",
    "heap_reuse": "main(){auto i,p; i=0; while(i++<1000){p=alloc(100); *(p+99)=7; if(*(p+99)!=7)return(1); free(p);} return(0);}",
    "word_file_io": 'main(){auto fd,v 4; fd=creat("packed.tmp",0600); if(fd<0)return(1); if(write(fd,"abcd",4)!=4)return(2); close(fd); fd=open("packed.tmp",0); if(fd<0)return(3); v[0]=v[1]=0; if(read(fd,v,4)!=4)return(4); close(fd); unlink("packed.tmp"); return(v[0]!=\'ba\' | v[1]!=\'dc\');}',
}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--bcc", type=Path, default=Path(__file__).resolve().parent.parent / "bcc")
    parser.add_argument("--filter", default="")
    args = parser.parse_args()
    compiler = args.bcc.resolve()
    failed = passed = 0
    with tempfile.TemporaryDirectory(prefix="bcc-b72-") as directory:
        tmp = Path(directory)
        for inline in (False, True):
            runtime = "inline" if inline else "shared"
            for bits, cases in (("host", CASES), ("16", WORD_CASES)):
                for name, case in cases.items():
                    key = f"{runtime}/{bits}/{name}"
                    if args.filter not in key:
                        continue
                    source, expected = case if isinstance(case, tuple) else (case, 0)
                    path = tmp / "case.b"
                    path.write_text(source + "\n")
                    command = [str(compiler), "--strict", "--pedantic", f"--word={bits}"]
                    if inline:
                        command.append("--inline-runtime")
                    try:
                        result = subprocess.run(command + [str(path), "-o", str(tmp / "case")], capture_output=True, text=True, timeout=20)
                        if expected is None:
                            ok = result.returncode > 0 and result.stderr and "gcc failed" not in result.stderr
                            detail = "expected a compiler diagnostic"
                        elif result.returncode:
                            ok, detail = False, result.stderr[-1500:]
                        else:
                            run = subprocess.run([str(tmp / "case")], cwd=tmp, input="", capture_output=True, text=True, timeout=5)
                            ok = run.returncode == expected
                            detail = f"exit {run.returncode}, expected {expected}: {run.stderr}"
                    except subprocess.TimeoutExpired:
                        ok, detail = False, "timed out"
                    if ok:
                        passed += 1
                    else:
                        failed += 1
                        print(f"FAIL: {key}: {detail}")
        key = "shared/16/multifile_pointer"
        if args.filter in key:
            (tmp / "lib.b").write_text("data[3] 3,7,9; get(){extrn data; return(data);} set(p){*(p+1)=11; return(0);}\n")
            (tmp / "main.b").write_text("main(){extrn get,set; auto p; p=get(); set(p); return(*(p+1)!=11 | *(p+2)!=9);}\n")
            command = [str(compiler), "--strict", "--pedantic", "--word=16", str(tmp / "lib.b"), str(tmp / "main.b"), "-o", str(tmp / "multi")]
            result = subprocess.run(command, capture_output=True, text=True, timeout=20)
            ok = result.returncode == 0
            if ok:
                run = subprocess.run([str(tmp / "multi")], capture_output=True, timeout=5)
                ok = run.returncode == 0
            if ok:
                passed += 1
            else:
                failed += 1
                print(f"FAIL: {key}: {result.stderr[-1500:]}")
    print(f"Results: {passed} passed, {failed} failed")
    return bool(failed)


if __name__ == "__main__":
    raise SystemExit(main())
