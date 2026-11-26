# Sourced after HERE is set to the native compiler directory.
# Keep the lock outside build/: make clean must not unlink a held lock.
if [ "${_BCC_NATIVE_LOCKED:-}" != 1 ]; then
    exec 9>"$HERE/.native-build.lock"
    flock 9
    _BCC_NATIVE_LOCKED=1
    export _BCC_NATIVE_LOCKED
fi
