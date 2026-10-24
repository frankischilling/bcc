#!/usr/bin/env bash
set -u

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BBC="$ROOT/build/stage2/bbc"
BBC3="$ROOT/build/stage3/bbc"
TMP="$(mktemp -d /tmp/bbc_boot_tests_XXXXXX)"
trap 'rm -rf "$TMP"' EXIT

pass=0
fail=0

ok() {
  echo "PASS: $1"
  pass=$((pass + 1))
}

bad() {
  echo "FAIL: $1"
  shift || true
  if [[ $# -gt 0 ]]; then echo "  $*"; fi
  fail=$((fail + 1))
}

run_ok() {
  local name="$1"
  local src="$ROOT/tests/strict-ok/$name.b"
  local exe="$TMP/$name"
  if ! "$BBC" --strict --pedantic "$src" -o "$exe" >"$TMP/$name.compile.out" 2>&1; then
    bad "$name compile" "$(head -1 "$TMP/$name.compile.out")"
    return
  fi
  "$exe" >"$TMP/$name.out" 2>&1
  local rc=$?
  local expected="$ROOT/tests/strict-ok/$name.exit"
  if [[ -f "$expected" ]]; then
    local exp
    exp="$(cat "$expected")"
    if [[ "$rc" != "$exp" ]]; then
      bad "$name run" "expected exit $exp got $rc"
      return
    fi
  elif [[ "$rc" != 0 ]]; then
    bad "$name run" "exit $rc"
    return
  fi
  ok "$name"
}

run_reject() {
  local name="$1"
  local src="$ROOT/tests/strict-reject/$name.b"
  if "$BBC" --strict --pedantic -S "$src" >"$TMP/$name.c" 2>"$TMP/$name.err"; then
    bad "$name reject" "compiled successfully"
  else
    ok "$name reject"
  fi
}

run_default_ext() {
  local name="$1"
  local src="$ROOT/tests/default-ext/$name.b"
  local exe="$TMP/$name"
  if ! "$BBC" "$src" -o "$exe" >"$TMP/$name.compile.out" 2>&1; then
    bad "$name default extension compile" "$(head -1 "$TMP/$name.compile.out")"
    return
  fi
  "$exe" >"$TMP/$name.out" 2>&1
  if [[ "$?" == 0 ]]; then ok "$name default extension"; else bad "$name default extension run"; fi
}

for f in "$ROOT"/tests/strict-ok/*.b; do
  case "$(basename "$f" .b)" in
    libadd|multifile_main) ;;
    *) run_ok "$(basename "$f" .b)" ;;
  esac
done

if "$BBC" "$ROOT/tests/strict-ok/libadd.b" "$ROOT/tests/strict-ok/multifile_main.b" -o "$TMP/multifile" >"$TMP/multifile.compile.out" 2>&1; then
  "$TMP/multifile" >"$TMP/multifile.out" 2>&1
  if [[ "$?" == 0 ]]; then ok "multifile"; else bad "multifile run"; fi
else
  bad "multifile compile" "$(head -1 "$TMP/multifile.compile.out")"
fi

for f in "$ROOT"/tests/strict-reject/*.b; do
  run_reject "$(basename "$f" .b)"
done

for f in "$ROOT"/tests/default-ext/*.b; do
  run_default_ext "$(basename "$f" .b)"
done

for stage in 1 2 3; do
  if "$ROOT/build/stage$stage/bbc" -S "$ROOT/src/bbc.b" >"$TMP/stage$stage.c" 2>"$TMP/stage$stage.emit.log" && [[ -s "$TMP/stage$stage.c" ]]; then
    ok "stage$stage emits C"
  else
    bad "stage$stage emits C"
  fi
done
for pair in "1 2" "2 3"; do
  read -r left right <<<"$pair"
  if [[ -s "$TMP/stage$left.c" && -s "$TMP/stage$right.c" ]] && cmp -s "$TMP/stage$left.c" "$TMP/stage$right.c"; then
    ok "stage$left/stage$right generated C match"
  else
    bad "stage$left/stage$right generated C match"
  fi
done

mkdir -p "$TMP/path with spaces and 'quotes'"
cp "$ROOT/tests/strict-ok/expr.b" "$TMP/path with spaces and 'quotes'/input.b"
if "$BBC" --libdir "$ROOT/../lib" "$TMP/path with spaces and 'quotes'/input.b" -o "$TMP/path with spaces and 'quotes'/output" && "$TMP/path with spaces and 'quotes'/output"; then
  ok "quoted input and output paths"
else
  bad "quoted input and output paths"
fi

if "$BBC3" "$ROOT/tests/default-ext/extensions.b" -o "$TMP/stage3_ext" >"$TMP/stage3_ext.compile.out" 2>&1; then
  "$TMP/stage3_ext" >"$TMP/stage3_ext.out" 2>&1
  if [[ "$?" == 0 ]]; then ok "stage3 compiler runs programs"; else bad "stage3 compiler runs programs"; fi
else
  bad "stage3 compiler compiles programs" "$(head -1 "$TMP/stage3_ext.compile.out")"
fi

echo "Results: $pass passed, $fail failed"
if [[ "$fail" -ne 0 ]]; then exit 1; fi
