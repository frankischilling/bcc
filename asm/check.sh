#!/usr/bin/env bash
set -u

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BCC="${BCC:-$ROOT/asm/bccasm}"
TMP="$(mktemp -d /tmp/bccasm_check_XXXXXX)"
trap 'rm -rf "$TMP"' EXIT

run_one() {
    local src="$1"
    local name exe input expected_exit expected_out rc
    name="$(basename "$src" .b)"
    exe="$TMP/$name"

    "$BCC" "$src" -o "$exe" >"$TMP/$name.compile.out" 2>"$TMP/$name.compile.err" || {
        echo "compile-fail $src"
        head -3 "$TMP/$name.compile.err"
        exit 1
    }

    input="${src%.b}.in"
    if [[ -f "$input" ]]; then
        "$exe" <"$input" >"$TMP/$name.out" 2>&1
    else
        "$exe" >"$TMP/$name.out" 2>&1
    fi
    rc=$?

    expected_exit="${src%.b}.exit"
    if [[ -s "$expected_exit" && "$rc" != "$(cat "$expected_exit")" ]]; then
        echo "exit-fail $src got $rc expected $(cat "$expected_exit")"
        exit 1
    fi

    expected_out="${src%.b}.out"
    if [[ -f "$expected_out" ]] && ! diff -q "$expected_out" "$TMP/$name.out" >/dev/null; then
        echo "out-fail $src"
        diff -u "$expected_out" "$TMP/$name.out" | head -40
        exit 1
    fi
}

for src in "$ROOT"/tests/compile/*.b; do
    name="$(basename "$src" .b)"
    "$BCC" "$src" -o "$TMP/compile_$name" >"$TMP/compile_$name.out" 2>"$TMP/compile_$name.err" || {
        echo "compile-fail $src"
        head -3 "$TMP/compile_$name.err"
        exit 1
    }
done

for dir in "$ROOT"/tests/run "$ROOT"/tests/programs "$ROOT"/tests/conformance; do
    for src in "$dir"/*.b; do
        [[ -f "$src" ]] || continue
        run_one "$src"
    done
done

for mode in host 16 32; do
    "$BCC" "--word=$mode" "$ROOT/tests/run/word_semantics.b" -o "$TMP/word_$mode"
    "$TMP/word_$mode" >"$TMP/word_$mode.out" 2>&1
done

for src in "$ROOT"/tests/ast/*.b; do
    name="$(basename "$src" .b)"
    "$BCC" "$src" --dump-ast >"$TMP/ast_$name" 2>&1
    diff -q "${src%.b}.ast" "$TMP/ast_$name" >/dev/null || {
        echo "ast-fail $src"
        exit 1
    }
done

"$BCC" --strict --pedantic "$ROOT/bootstrap/tests/strict-ok/expr.b" -o "$TMP/strict_expr"
"$TMP/strict_expr"

if "$BCC" --strict --pedantic "$ROOT/bootstrap/tests/strict-reject/hex.b" -o "$TMP/strict_hex" \
    >"$TMP/strict_hex.out" 2>"$TMP/strict_hex.err"; then
    echo "strict-reject-fail"
    exit 1
fi

cat >"$TMP/callf_ping.c" <<'C'
long ping_(void) { return 77; }
C
gcc -shared -fPIC "$TMP/callf_ping.c" -o "$TMP/libping.so"
cat >"$TMP/callf_ping.b" <<'B'
main() { extrn callf; if (callf("ping") != 77) return(1); return(0); }
B
"$BCC" "$TMP/callf_ping.b" -o "$TMP/callf_ping"
B_CALLF_LIB="$TMP/libping.so" "$TMP/callf_ping"

echo "asm check ok"
