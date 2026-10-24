#!/usr/bin/env python3
"""Run the shell suite with Unix line endings, then the B72 regressions."""

from pathlib import Path
import shutil
import subprocess
import sys
import tempfile


def main():
    root = Path(__file__).resolve().parent.parent
    with tempfile.TemporaryDirectory(prefix="bcc-suite-") as directory:
        stage = Path(directory)
        shutil.copytree(root / "tests", stage / "tests")
        (stage / "bcc").symlink_to(root / "bcc")
        for path in (stage / "tests").rglob("*"):
            if path.is_file() and path.suffix in {".sh", ".b", ".out", ".exit", ".ast"}:
                path.write_bytes(path.read_bytes().replace(b"\r\n", b"\n"))
                if path.suffix == ".sh":
                    path.chmod(0o755)
        basic = subprocess.run(["bash", str(stage / "tests/run_all_tests.sh")])
        historical = subprocess.run([sys.executable, str(root / "tests/test_b72_conformance.py")])
    return bool(basic.returncode or historical.returncode)


if __name__ == "__main__":
    raise SystemExit(main())
