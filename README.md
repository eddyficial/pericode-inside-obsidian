# PeriCode Inside

An AI sidebar for Obsidian: research notes with sources, resume conversations,
review revisions, and manage your vault with permission-controlled tools.

**0.2.0 community preview · Desktop only · Obsidian 1.13.7 or newer**

This is the public distribution repository. Development source is private.
The plugin is not yet approved or installable from Obsidian's Community directory.
Its existing proprietary license permits personal, non-commercial evaluation;
use beyond that requires a paid subscription. See [LICENSE](LICENSE).

## Install

Download the assets from [Releases](https://github.com/eddyficial/pericode-inside-obsidian/releases).
Copy `main.js`, `manifest.json` and `styles.css` to
`<vault>/.obsidian/plugins/pericode/`, reload Obsidian, and enable PeriCode Inside
under Settings → Community plugins. Each vault needs its own installation.

On Windows, you can instead extract the release ZIP and run
`Install-PeriCode.cmd`. It prompts for a registered vault, preserves your settings
and notes, and backs up existing plugin files. It does not change Restricted mode.
For all currently registered vaults, run from the extracted folder:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\Install-PeriCode.ps1 -AllVaults -Enable
```

The optional installer runs once and does not watch for future vaults. Node.js,
SQL Server and a database are not required to install the plugin.

## Start using PeriCode

1. Open Settings → PeriCode and choose a provider.
2. Connect the corresponding account or enter an API key/local endpoint.
3. Open PeriCode from its ribbon icon or the command palette.
4. Attach notes or folders with the paperclip; choose a model and send a request.

Research mode allows note inspection and narrowly scoped UI navigation. Agent
mode also allows file changes subject to permission. Stop or Escape cancels the
request; completed changes are not automatically rolled back.

Conversations and drafts persist locally. Select a passage and run **Revise
selection with preview** to compare changes before applying them. Stale note
content prevents a revision from being applied to the wrong text.

## Vault tools

- Read, list and search files; discover notes by folder, title or tag.
- Inspect properties, headings, task lines, tags, links and backlinks.
- Create notes and folders; append text and update YAML properties.
- Edit note text, copy individual files, and move/rename notes and folders.
- Trash individual files and empty folders with confirmation on every deletion.
- Open notes, global graph, Search, File Explorer and Settings. Separate Settings
  windows are detected without reading password or other input values.

Moves never overwrite destinations and do not automatically rewrite backlinks.
Related link edits need separate approval. Metadata is bounded and reflects
Obsidian's current cache. Follow the inventory's pagination for complete results.

## Providers, accounts and payment

Claude subscriptions use your separately installed, unmodified Claude Code
runtime. PeriCode does not bundle, download or update it. Existing Claude Code
sign-in is reused; its native tools are disabled for PeriCode requests.

ChatGPT/Codex and GitHub Copilot have separate subscription sign-in controls.
The picker loads compatible models from the connected account rather than a
fixed catalog. API-key providers and compatible local endpoints are separate
options. Provider accounts, charges, terms and usage limits still apply.

Core chat and vault tools have no paid-plugin gate in the implementation;
advanced features are license-gated. This does not supersede the proprietary
evaluation/use terms in [LICENSE](LICENSE). Production commercial activation
and fresh sign-in with every supported provider have not completed release-wide
end-to-end QA in this preview.

## Data, network and access outside the vault

- Prompts, attached content and tool results go to your selected model endpoint.
  A local endpoint can keep inference traffic on your machine. External providers
  have their own privacy and retention policies.
- OAuth contacts the selected identity provider. Claude mode starts the installed
  Claude Code process and an authenticated temporary HTTP server on 127.0.0.1.
  System instructions temporarily reside in an OS temporary file, removed when
  the request finishes. Claude Code uses its own configuration and networking.
- License activation, validation and optional trial enrollment contact the
  configured PeriCode licensing service (default `api.pericode.dev`) and, where
  applicable, Lemon Squeezy. Explicit trial enrollment sends a hashed device
  identifier for eligibility. Configured administrator-policy URLs and MCP
  servers may also be contacted.
- MCP presets use `npx --no --offline` and require separately installed servers.
  Imported/custom MCP commands remain operator-configured external programs
  with their own behavior and permissions.
- API keys and provider settings are currently stored in plugin `data.json`.
  Conversations, drafts, tool history, audit records and memory are unencrypted
  under `<vault>/.pericode/`. These may contain sensitive task content.
- Shared authentication may read `~/.pericode/`; Claude Code uses its own account
  store. Temporary prompt files and SDK recovery records can be written outside
  the vault as runtime bookkeeping, not agent-selected paths.
- The plugin does not send usage telemetry or load dynamic ads. It does not
  install or update itself or its dependencies.
- The plugin does not replace global fetch or change the host working directory.
  Request-scoped environment variables and native plugins share the same process;
  this is not an isolation boundary between installed plugins.

## Permissions and limitations

Tool requests use one-use authorization bound to the active turn, exact arguments,
signal and policy. Canonical path checks reject protected paths, traversal and
links/junctions. Dry-run prevents execution; invalid policy files disable tools.
Deletions always prompt and use trash. MCP calls require explicit approval;
MCP servers are separate trusted programs with their own access.

Arbitrary shell commands, plugin API calls, generic command execution and web
fetch tools are not exposed. Assistant Markdown is display-only: raw HTML stays
text, code cannot invoke other plugins, and remote images do not load automatically.
Privacy filtering and injection-pattern checks are additional controls, not
comprehensive DLP or an OS sandbox.

See [QA](QA.md) and [release notes](RELEASE-NOTES.md) for tested behavior and remaining
review gates. Windows has live QA evidence; other desktop operating systems do not.

## Source and community review

This repository contains readable built artifacts and distribution documentation,
not the private development history. [BUILD-PROVENANCE.json](BUILD-PROVENANCE.json)
records the source revision and artifact hashes. Obsidian's private-source GitHub
App integration and community review remain pending. A public GitHub preview is
not an accepted Community directory listing.

## License and credits

Copyright 2026 Eddy Ogutu. Proprietary; see [LICENSE](LICENSE). Third-party
components retain their licenses in [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).
Claudian inspired the comparison and some integration concepts; this release's
conversation, context, revision and vault-management implementations were
independently developed. No claim of complete feature parity is made.
