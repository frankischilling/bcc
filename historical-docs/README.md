# Historical reference archive

Start with Thompson's January 1972 *Users' Reference to B* for language
rules and the November 1971 Unix manual for the original system interfaces.
Use the PDP-11/20 processor documentation when implementing instruction
encoding, addressing, registers, traps or word arithmetic.

| Collection | Contents |
| --- | --- |
| [B language](b-language/README.md) | Original B manuals, tutorials, dialects and language history |
| [PDP-11](pdp-11/README.md) | DEC processor and instruction-set documents |
| [Unix](unix/README.md) | Early Unix manuals, implementation and toolchain references |
| [Unix V1 documents](unix-v1-docs/README.md) | Existing scans and working manual transcriptions |
| [Early C](early-c/README.md) | Existing renditions of Ritchie's 1974 C manual |
| [PDP-11 assembly notes](pdp-11/project-notes/NOTES_ASSEMBLY.md) | BCC's own assembly and executable conventions |
| [PDP-11 runtime notes](pdp-11/project-notes/NOTES_RUNTIME.md) | BCC's native startup, library and calling convention |

The last two entries are project notes, not historical DEC or Bell Labs
documents. The [source review](../wiki/SOURCE_REVIEW.md) and
[conformance notes](../wiki/HISTORICAL_CONFORMANCE.md) explain which sources
govern particular compiler behavior and where dialects disagree.

## Local originals

The archive keeps existing repository documents and catalog entries in Git.
Newly retrieved originals whose redistribution rights have not been confirmed
are stored locally in `downloads/`, which Git ignores. The source catalogs
record the download URLs and SHA-256 hashes of the retrieved files. To obtain
those exact copies in a fresh checkout, run:

```sh
python3 historical-docs/fetch.py
python3 historical-docs/fetch.py --check
```

Use `--group b-language`, `--group pdp-11`, or `--group unix` to select one
collection. `--check` verifies local copies without contacting the archives.
The fetcher rejects changed files and incomplete downloads. If an archive
replaces a document, review the new copy before updating its recorded hash.

The documents retain their original notices and permissions. A scan on an
open archive does not by itself establish permission to redistribute it.
Preserve the original bytes, label transcriptions and later editions, and
record the source URL for additions. Treat later PDP-11 models, Honeywell B,
and post-V1 Unix as comparison material unless the target specifically uses
those systems.
