See [the 0.3.5 scorecard follow-up](SECURITY-REVIEW-0.3.5.md) for interpreted schema validation, signed release builds and current capability disclosures.

# Security remediation and submission checks

## 0.3.4 access changes

MCP servers require explicit approval in Settings for each plugin session.
Reloading PeriCode clears approvals. Approval covers the command, arguments,
endpoint and environment values; editing any of these requires approval again.
Old vault approval files are ignored. Invalid policy and dry-run policy prevent
MCP startup. MCP processes receive the transport's basic OS environment plus
explicitly configured variables, without inheriting the host's provider tokens
or execution overrides. Automatic command fallbacks are disabled in the plugin.

The standard read_file, write_file, edit_file and delete_file tools now use
Obsidian's APIs. Writes refuse stale content when expected_old_content is set;
text replacements run atomically. Parent folders must exist before creating a
file. Reads and writes are limited to 2 MB, reads return up to 500 lines, and
secret-like filenames cannot be read through read_file. Trash stays recoverable;
there is no permanent-delete option. CLI rollback files and syntax-check
subprocesses are not used by these tools.

Direct filesystem access remains for canonical path checks, bounded vault
search, private plugin metadata, auth/runtime bookkeeping and explicit import
operations. Process access remains for separately installed Claude/Grok
runtimes and approved MCP servers. These run with the user's OS permissions;
PeriCode is not an OS sandbox. The removed CLI shell, network-fetch and desktop
tool implementations are excluded from the shipping bundle.

Obsidian's unavailable malware and network scans remain unavailable. Local
static checks and dependency audits do not substitute for those scans or an
independent security audit.


Checked on 2026-09-11 for PeriCode (original 0.2.0 review; updated for 0.3.0). This covers the three findings in
the local PeriCode/Claudian comparison and the published Obsidian requirements.
It is not a claim of SOC 2, GDPR, or other independently audited certification.

## Remediation

| Finding | Change | Verification |
|---|---|---|
| P1 — High: policy bypass | One-use approval at the registry execution boundary; canonical vault paths; no shell/plugin-API/command/web-fetch escape tools; descendant checks during search/listing | Unit fixtures and installed-plugin checks deny direct calls, protected paths, replay and cancelled execution; valid authorized calls work |
| P2 — High: executable Markdown processors | Independent display-only Markdown DOM renderer; no Obsidian postprocessors, raw HTML execution or automatic image loads | Inert processor invocation is zero in the installed plugin; code and bold text still display; source links require clicks and policy checks |
| P3 — Medium: OAuth callback cancellation/exposure | IPv4/IPv6 loopback only; state validation for success and errors; invalid requests ignored; cancellation/timeouts close listeners | Invalid callbacks followed by a valid synthetic callback, explicit bind-host assertions, timeout/cancellation and port reuse tests |

Additional controls: invalid policy files disable tools; policy changes invalidate
approvals; lockdown never caches “always”; deletions require consent each time
and use trash; raw SDK tools no longer bypass dry-run or output filtering. MCP
allowlisting uses the actual registered server identity and every MCP call prompts.
Prompt-injection-pattern matches withhold the result before model consumption.
These are application controls, not an OS sandbox for other plugins or MCP servers.

The plugin no longer changes global fetch or the process working directory. The
Node HTTP transport is injected only into its own bundle. Commercial license
checks, trial enrollment and activation fingerprinting are removed in 0.3.0.

## Obsidian requirements checked

| Requirement | Local status |
|---|---|
| Readable source; no obfuscation | Pass: readable production bundle and source |
| No plugin self-installation/dependency downloads | Pass: community bundle is self-contained; the optional external installer is user-run; Claude Code is installed separately |
| No usage telemetry or dynamic ads | No such collection/ad path found in the reviewed plugin source; model and provider sign-in requests are disclosed |
| Accounts, payments, network and external-file disclosures | Updated plugin and root README; no PeriCode payment or trial collection remains |
| Licensing and attribution | MIT license for project-owned code; third-party terms preserved; bundled third-party notices include the Markdown parser's MIT license; no Claudian implementation copied |
| Manifest and release structure | Automated release check passes: desktop-only, tested minimum 1.13.7, matching versions, valid description, readable bundle, hashes and assets |
| Security regressions in CI | Plugin job runs tests, build, packaging checks and both dependency audits on pull requests/pushes; hosted execution awaits publication |

Sources: [Developer policies](https://docs.obsidian.md/community-directory/developer-policies),
[Submission requirements](https://docs.obsidian.md/community-directory/submission-requirements-for-plugins),
[Submission process](https://docs.obsidian.md/Plugins/Releasing/Submit%20your%20plugin).

## Evidence and limits

- Plugin suite: **39 passed**, including security, UI, storage, bridge, cancellation
  and transport tests; installer preservation/rejection fixtures passed.
- Full SDK suite: **347 passed**.
- Installed-plugin verification: all assertions passed, including host isolation,
  authorization, protected paths, cancellation and inert Markdown rendering.
- Plugin and SDK dependency audits: **zero advisories** at review time.
- Plugin build and release checks passed. The original audit and remediation logs
  are retained under `security-reviews/2026-09-11/` beside the source checkout.

Official directory acceptance is pending. Source publication is separate from
Obsidian approval. Some fresh provider sign-ins and live inference paths still
require account verification; fixture tests do not prove provider availability.

Privacy filtering is not comprehensive DLP. Other installed native plugins share
the host process; remote HTTP MCP servers remain separately trusted software.
Review configurations before enabling them. Local filesystem races caused by a
separate malicious same-user process require OS isolation, not just path checks.

## Reproduce

From the repository root run `npm run build`. In `plugins/obsidian`, run `npm test`,
`npm run build`, `npm run release:check`, and `npm audit --ignore-scripts`.
`npm run release` includes tests, build, checks, notices and ZIP packaging. The
security fixtures create only temporary synthetic data and local listeners.
