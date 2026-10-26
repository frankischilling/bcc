#!/usr/bin/env python3
"""Exercise the real Make/shell lock entry points against shared scratch files."""
import os
from pathlib import Path
import signal
import subprocess
import tempfile

ROOT=Path(__file__).resolve().parents[1]
MARKER='else\nexport _BCC_NATIVE_LOCKED\n'
BODY='''
.PHONY: all
all:
	@mkdir active
	@printf '%s\\n' "$(_BCC_NATIVE_LOCKED)" >> events
	@HERE="$(CURDIR)" sh -c '. ./native-lock.sh; $(MAKE) --no-print-directory -f nested.mk'
	@rmdir active
endif
'''


def main():
    source=(ROOT/'Makefile').read_text()
    if MARKER not in source: raise RuntimeError('native Make lock entry point is missing')
    wrapper=source.split(MARKER,1)[0]+MARKER+BODY
    env=dict(os.environ)
    for name in ('_BCC_NATIVE_LOCKED','MAKEFLAGS','MFLAGS','MAKELEVEL'):
        env.pop(name,None)
    passed=failed=0
    with tempfile.TemporaryDirectory(prefix='bcc-build-lock-') as directory:
        for direct in (False,True):
            work=Path(directory)/str(direct);work.mkdir()
            (work/'Makefile').write_text(wrapper)
            (work/'native-lock.sh').write_bytes((ROOT/'tools/native-lock.sh').read_bytes())
            (work/'nested.mk').write_text('all:\n\t@test "$(_BCC_NATIVE_LOCKED)" = 1\n\t@sleep 0.1\n')
            make=['make','--no-print-directory','all']
            first=['sh','-c','. ./native-lock.sh; make --no-print-directory all'] if direct else make
            children=[subprocess.Popen(command,cwd=work,env=dict(env,HERE=str(work)),stdout=subprocess.PIPE,stderr=subprocess.PIPE,start_new_session=True)
                      for command in (first,make)]
            results=[]
            try:
                for child in children:
                    out,err=child.communicate(timeout=10)
                    results.append((child.returncode,out,err))
                events=(work/'events').read_text().splitlines() if (work/'events').exists() else []
                ok=all(status==0 for status,out,err in results) and events==['1','1'] and not (work/'active').exists()
            except subprocess.TimeoutExpired:
                ok=False
            finally:
                for child in children:
                    if child.poll() is None:
                        os.killpg(child.pid,signal.SIGKILL)
                        child.communicate()
            print(f'{"PASS" if ok else "FAIL"}: build-lock/{"script-and-make" if direct else "two-makes"}')
            if not ok: print(results)
            passed+=ok;failed+=not ok
    print(f'Results: {passed} passed, {failed} failed')
    return bool(failed)


if __name__=='__main__': raise SystemExit(main())
