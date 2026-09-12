# PeriCode 0.3.7 community capability review

The production community bundle removes the four capabilities reported in the
0.3.6 Obsidian inspection:

| Reported capability | 0.3.7 change |
|---|---|
| Direct filesystem access | Vault, policy, memory, audit, conversation and scaffold storage use the Obsidian adapter; the bundle contains no Node filesystem import. |
| Shell execution | The community build refuses local process creation; executable MCP, Claude Code and Grok Build routes require a future localhost companion. |
| Vault enumeration | Note discovery uses a bounded adapter traversal that skips hidden folders; broad Vault enumeration APIs are absent. |
| Clipboard access | Message and device-code clipboard buttons were removed. Codes remain selectable. |

The release gate scans the built `main.js`, not only TypeScript source, and fails
if filesystem, child-process, clipboard, or broad Vault enumeration signatures
return. It also retains the existing checks for dynamic JavaScript execution,
commercial activation code, removed SQL tools, unbundled dependencies, CSS
compatibility, license notices and release metadata.

Verification on 2026-09-12: the production build completed, all 82 plugin tests
passed, installer preservation and rejection fixtures passed, and the release
check passed. Obsidian's hosted scan and human review remain external gates and
must be checked after publishing the 0.3.7 assets.
