#!/bin/sh
# Keep stable check names as fail-closed gates for parallel test lanes.
set -eu
case "${1-}" in
    2|3) expected=$1; shift ;;
    *) echo 'expected a lane count of 2 or 3, followed by results' >&2; exit 2 ;;
esac
if [ "$#" -ne "$expected" ]; then
    printf 'expected %s lane results\n' "$expected" >&2
    exit 2
fi
for result in "$@"; do
    if [ "$result" != success ]; then
        printf 'lane did not finish successfully: %s\n' "$result" >&2
        exit 1
    fi
done
printf 'all %s lanes succeeded\n' "$expected"
