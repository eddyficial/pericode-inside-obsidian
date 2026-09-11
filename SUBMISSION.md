## 0.3.5 completed review and native installation

Obsidian's review of distribution commit ed3ae70 completed on September 11,
2026. The public listing reports version 0.3.5, Health: Excellent and Review:
Satisfactory. There are no blocking errors. Build verification, artifact
attestations for main.js and styles.css, dependency checks and unobfuscated
code checks pass. Remaining findings disclose filesystem/process capabilities,
vault enumeration and clipboard access. Obsidian's unavailable malware and
network scans remain outside this verification.

The public Add to Obsidian link now opens the correct catalog entry. Obsidian
1.13.7's native plugin installer downloaded and reinstalled 0.3.5 in the existing
Session Portal test installation. Settings were preserved byte for byte. The
manifest and stylesheet match the release; main.js matches with Obsidian's
standard nosourcemap marker appended. The enabled plugin then passed create,
read, stale-write refusal, edit and trash checks. This was a native reinstall,
not a new empty-vault installation. The earlier catalog failure is historical.

The GitHub release build passed 352 SDK tests and 81 plugin tests, reproduced
all three assets and signed their attestations. No binary changes were needed
for this documentation update. Build source remains pinned in BUILD-PROVENANCE.json.

## Clean-install correction: September 11, 2026

The public listing's Add to Obsidian button opened Obsidian 1.13.7, but its
catalog returned No results found for pericode. The public GitHub catalog also
had no pericode entry at this check. A public listing and completed review did
not establish that in-app installation worked. Catalog availability timing is
unconfirmed.

The documented manual path passed: download the three 0.3.3 release assets,
verify their checksums, place them in a clean plugin folder, reload, and enable
PeriCode. First-run setup completed and the existing ChatGPT account returned
seven models. Old vault settings and conversations were kept in a separate
recovery backup. Installation instructions now lead with this verified path.

# PeriCode community listing

Version 0.3.5 is free and MIT-licensed, with no PeriCode paid tier or activation.
The full source is in https://github.com/eddyficial/pericode and release assets
are in https://github.com/eddyficial/pericode-inside-obsidian.

The plugin is desktop-only and requires Obsidian 1.13.7 or newer. Its ID is
`pericode`; its display name is `PeriCode`. Keep manifest.json and
versions.json synchronized with the source plugin before publishing releases.

Build from the source repository with `npm ci` and `npm run build`, then run
`npm ci` and `npm run release` in `plugins/obsidian`. The output includes readable
main.js, manifest.json, styles.css, MIT license, third-party notices and hashes.

Published September 11, 2026:
https://community.obsidian.md/plugins/pericode

The portal recognized release 0.3.3 at distribution commit 3e6415b, completed its
review with no blocking errors, and exposed an Add to Obsidian button after
publication. Dependencies reported no vulnerabilities. Remaining warnings cover
filesystem/process access and CSS; recommendations include artifact attestations,
additional release assets and other detected capabilities. This is not a complete
security audit or proof that the separate source build was reproduced.

The listing uses Optional payment because external providers can charge, as
required by Obsidian's directory classification. PeriCode itself remains free.


AI-provider accounts and charges are separate. See README.md for data flows,
QA.md for verified behavior and remaining provider checks, and
SECURITY-COMPLIANCE.md for the security boundary and its limitations.
