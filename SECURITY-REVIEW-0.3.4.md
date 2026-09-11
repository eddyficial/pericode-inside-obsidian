# PeriCode 0.3.4 security review

Scope: the Obsidian plugin and its bundled SDK code, reviewed locally on Windows.
This is a targeted source review and regression pass, not a security certification.

## High: MCP startup approval could be bypassed through synced configuration

Affected: src/pericodeMcp.ts (approval storage, identity hashing, start).
Root cause: missing approval files grandfathered every configured server;
approvals lived beside the configuration in the synced vault. Environment values
were excluded from the fingerprint. Policy-load failures fell through to launch.
An actor able to alter the vault configuration could cause an unreviewed command
or altered environment to start with the user's OS permissions.

Fixed with memory-only, per-session approvals covering all executable config,
including environment values and endpoints. Synced approval files are ignored;
policy errors and dry run refuse startup. Regression tests prove no client is
created for first load, forged approval files, changed environment, invalid
policy, dry run or allowlist rejection, and prove explicit approval works.
Confidence: high. Remaining risk: approval grants an external program the user's
OS access. A hostile process or plugin already running as the user is not isolated.

## Medium: MCP inherited unrelated host secrets and could substitute commands

Affected: ../../src/mcp/client.ts and src/pericodeMcp.ts.
Root cause: MCP processes inherited the complete parent environment, including
unrelated provider tokens and execution overrides, and connection failure could
select a different executable through CLI fallback logic.

The plugin now opts out of ambient inheritance and command fallback. Only the
transport's basic OS environment and explicit server variables are passed.
Regression coverage checks synthetic secret and execution variables are absent.
Confidence: high for the environment builder and startup configuration; no
external MCP service was contacted. Explicit environment values are still
sensitive, and approved servers can read host files using their OS permissions.

## Low: unnecessary CLI implementation in the plugin bundle

Affected: scripts/sdk-entry.mjs, src/main.ts and ../../src/tools/registry.ts.
Root cause: constructing the CLI default registry imported tools later discarded
by the plugin, retaining shell/web/desktop and raw file mutation code.

The registry core is now separate. Native file tools use Obsidian read, create,
process and trash APIs, behind the existing one-use permission gate. Release
checks reject the excluded CLI modules in emitted code. Tests cover guarded
paths, denied calls, stale writes, atomic multi-edits, paging and recoverable trash.
Confidence: high. Path canonicalization and private bookkeeping still use Node
filesystem APIs; same-user filesystem races are not an OS isolation boundary.

## Low: CSS compatibility and scope warnings

Affected: styles.css (brand font and settings layout).
Removed the extended-system font list, :has selector and !important padding.
The plugin now uses Obsidian's font variable and scoped settings layout rules.
These are compatibility/performance fixes rather than demonstrated exploits.

## Verification limits

All 77 plugin tests, installer fixtures and release checks passed. Live Obsidian
1.13.7 native file operations and stale-write refusal passed. The local static
scanner reported zero findings in 41 plugin source files; this narrow pattern
scanner did not detect the MCP logic flaws found by manual review. Both production
dependency audits reported zero known advisories. The published directory's
malware/network scans were unavailable. Required native runtime and MCP process
access will continue to generate capability disclosures.
