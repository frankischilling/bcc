# PDP-11 tests

The active test suite is in [`bcc-pdp/tests/`](../bcc-pdp/tests/).
It covers B expressions and statements, word addressing, runtime calls,
file and process operations, and compiler errors. The Unix V1 tests run
against the restored kernel; the fast runner uses an application emulator.

See the [test commands](../../docs/testing.md) and
[conformance notes](../bcc-pdp/CONFORMANCE.md) for coverage and limits.
