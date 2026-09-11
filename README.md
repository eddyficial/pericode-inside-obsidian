# PeriCode for Obsidian

This repository publishes the plugin releases and user documentation.
[Full source and build instructions](https://github.com/eddyficial/pericode/tree/release/open-source/plugins/obsidian) are in the public source repository.

**Free and open source. Every plugin feature included under MIT.**

Research your notes, keep conversations across sessions, and review suggested
revisions before changing a note. PeriCode runs its own agent loop in
Obsidian and connects to the model provider you choose.

**0.3.3 open-source preview · Desktop only · Obsidian 1.13.7 or newer**

## Install PeriCode

The public Community listing is live, but our September 11, 2026 clean-install
test returned **No results found** in Obsidian. Installation through **Add to
Obsidian** is not yet verified. Use the release-file instructions below if
PeriCode does not appear. We have not confirmed when the in-app catalog will
include it.

1. Open the [latest GitHub release](https://github.com/eddyficial/pericode-inside-obsidian/releases/latest).
2. Under **Assets**, download `main.js`, `manifest.json` and `styles.css`.
   Use these release assets, not the GitHub **Source code** ZIP.
3. Open your vault folder in your file manager. Show hidden files if needed,
   then create `.obsidian/plugins/pericode/` inside it.
4. Put the three downloaded files directly in that folder, with no extra nested folder.
5. Reload or restart Obsidian. Open **Settings → Community plugins** and enable
   **PeriCode**. Community plugins require Restricted mode to be off.
6. Open **Settings → PeriCode → AI connection**, choose a provider, connect it,
   click **Load models**, and select a model. Open the PeriCode sidebar to start.

Installation is per vault. Repeat these steps for each vault where you want
PeriCode. Requires Obsidian desktop 1.13.7 or newer.

## Settings and providers

Settings now use six focused sections: **AI connection**, **Privacy & safety**,
**Integrations**, **Vault**, **About**, and **Advanced**. The connection page
groups subscription providers, API providers, and local/custom servers. Only the
selected provider's credentials and address appear. Edit a field, then choose
Save or Cancel; **Load models** fetches the current account catalog.

For Grok, choose **AI connection → API keys → Grok**, save an xAI API key, then
load and select a model. This connects to `https://api.x.ai/v1` for model lookup
and streaming chat with tool calls. This API connection uses API credits. Create a key in the [xAI console](https://console.x.ai/).
Keys remain in this vault's unencrypted plugin `data.json`; request credentials
are scoped and restored after use. No xAI key is borrowed from another provider.
See xAI's [API guide](https://docs.x.ai/developers/quickstart).

Grok transport has automated fixture coverage. Live authenticated Grok inference
still requires connecting an eligible account or adding an API key.

## AI-provider subscription connections

In **AI connection → Subscriptions**, choose Claude, ChatGPT / Codex, GitHub
Copilot, Grok, or Ollama Cloud. API cards with a matching account connection
include **Use my subscription**, which resets the model selection without
moving or deleting API keys. Account limits apply; PeriCode does not silently
fall back to API billing.

- **Grok:** install [Grok Build](https://docs.x.ai/build/overview), select Grok,
  and click **Connect Grok → Sign in with Grok**. Grok owns browser sign-in and
  token refresh in `~/.pericode/grok-build`. Load models after sign-in. This
  profile is separate from terminal Grok configuration and stores native
  credentials, session history and logs; prompts and tool results reach Grok.
  PeriCode disables native file/terminal tools and exposes its guarded vault
  tools through an authenticated local MCP bridge. Do not add hooks, plugins,
  skills or custom configuration to this integration profile.
- **Ollama Cloud:** on your Ollama server, run `ollama signin`, then
  `ollama pull <cloud-model>`. Enter that server's address and load models.
  Only configured cloud models appear. The catalog is server inventory, not
  proof of a paid plan; Ollama checks account access and limits on use. See
  [Ollama authentication](https://docs.ollama.com/api/authentication).
- **OpenRouter:** uses its own account credits. External provider subscriptions
  do not transfer to OpenRouter.
- **Custom servers:** authentication and billing depend on that server; there
  is no universal subscription login.

## Everyday workflows

- **Research with sources.** Attach notes, folders or a selected passage. Use an
  evidence brief or contradiction-check prompt, then follow the source wikilinks.
- **Resume your work.** Conversations and text drafts save locally. Choose a saved
  conversation, start a new one, export it as Markdown, or delete it explicitly.
- **Review revisions.** Select text in a note and run *Revise selection with
  preview*. Inspect word-level additions and removals before accepting. A changed
  note invalidates the preview; accepted revisions support the editor's Undo.
- **Stop a request.** Press Stop or Escape in chat. Pending permission prompts are
  denied on cancellation. Closing the panel also cancels its active request.
  Completed actions are not rolled back; an already-running external tool may
  need to finish before cancellation completes.

## Two chat modes

**Research** is the default. The tool registry exposes an explicit set of built-in
readers. Shell commands, file writes, subagents, plugin API calls and MCP tools
are not registered in this mode. Chat persistence and explicit export still write
PeriCode's own conversation data and your requested export note.

**Agent** enables the configured PeriCode tool surface, subject to its permission
and security policy. Review actions before allowing them. The custom policy code
is an additional control, not a sandbox around Node.js, other plugins or a model.

Choose a mode before sending. Mode controls are disabled during an active request.

## Install the candidate

On Windows, extract the release ZIP and double-click **Install-PeriCode.cmd**.
It detects registered Obsidian vaults and asks you to choose when there is more
than one. It copies and verifies the plugin, preserves data.json and vault notes,
and backs up previous plugin files under `.obsidian/pericode-backups/`.
No administrator access, Node.js or SQL Server is required.

With `-Enable` (included by the Windows launcher), the installer adds PeriCode
to that vault's enabled plugin list while preserving other entries. If Obsidian
is running with its CLI enabled, it also attempts to load/reload the plugin.
Otherwise, the plugin loads when that vault next opens. It does not change
Restricted mode; turn that off in Obsidian if you want community plugins to run.
Choose your provider, model and credentials under Settings → PeriCode, then open
chat from the ribbon or command palette.

To install and enable the same build in **all currently registered vaults**, run
this command from the extracted release folder:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\Install-PeriCode.ps1 -AllVaults -Enable
```

Each vault gets its own ribbon button, configuration and conversations. Shared
Claude Code/Codex/Copilot credentials continue to use their existing account
stores. Optional `-InitialProvider claude-oauth -InitialModel default` seeds only
the provider/model choice in fresh installations; existing settings are untouched.
Normal OneDrive Cloud Files folders are supported; configuration symlinks and
junctions are rejected. This installer runs once and does not install a background
watcher. Run it again for vaults you register later.

For a manual install or another desktop OS, copy main.js, manifest.json and
styles.css into `<vault>/.obsidian/plugins/pericode/`, reload Obsidian, and enable
the plugin. The installer supports the standard `.obsidian` configuration folder.

The [Community listing](https://community.obsidian.md/plugins/pericode) is public,
but in-app installation returned **No results found** in the September 11 test.
Use the verified release-file steps above. No SQL Server or npm install is needed.

For development, from the PeriCode repository root:

```sh
npm ci
npm run build
cd plugins/obsidian
npm ci
npm run release
```

The candidate files and checksums are in `dist/community-0.3.3/`; the ZIP is in
`dist/pericode-obsidian-0.3.3.zip`. `npm run dev:install` requires an explicit
`PERICODE_OBSIDIAN_VAULT` environment variable so it never chooses a vault for you.

## Context and editing

Use **@ Add context**, or type `@` in the composer, to choose a Markdown note or
folder. Attachments are snapshots shown as removable chips. Limits are 24,000
characters per attachment, 60,000 total, and 20 items. Larger inputs are refused
with a message instead of silently losing evidence. Folders include Markdown notes
only; hidden directories are excluded. Policy exclusions and privacy filtering
apply. Attachments accompany the next message and are then cleared; unsent
attachments are not restored after closing or switching conversations.

To attach a passage reliably, select text in the editor and run **Attach selection
to chat** from the command palette. To revise it, run **Revise selection with
preview**. The revision request sends the selected passage and instruction to the
configured model, with no tools. It does not automatically send the entire note.

## Providers and accounts

Provider adapters include Anthropic, OpenAI, OpenRouter, Ollama, compatible local
endpoints, Copilot and OAuth integrations. Availability depends on the provider,
account and model. Configure and verify the lane you intend to use; the included
fixture-provider tests do not establish that every live authentication lane works.
OAuth credentials can also be read from PeriCode's shared local auth store.

**ChatGPT / Codex and GitHub Copilot:** select the subscription provider in
Settings → PeriCode, then click **Login**. If saved credentials stop working,
use **Sign in again** from the same basic settings screen. Credentials saved
does not guarantee account access; an expired or revoked refresh token requires
a fresh browser sign-in. API-key options use separate provider billing.

**Chat workspace:** use the header dropdown for saved chats, **+** for a new
conversation, and **…** for copying, exporting, workflows, settings and deletion.
The paperclip adds context; mode and model controls sit beneath the message box.
**Expand chat** fills the workspace without losing your draft or attachments;
press Escape or **Restore sidebar** to return. During a request, Escape stops it.

**Claude subscriptions:** choose **Claude subscription (Claude Code)** and click
**Connect Claude Code**. Install the official Claude Code runtime first if it is
missing. An existing Claude Code sign-in is reused; otherwise the Sign in button
runs `claude auth login` and Anthropic handles browser authentication. PeriCode
does not copy subscription tokens. Click the model button beneath the chat box
to load the models returned by your signed-in Claude Code account, including
the recommended subscription default and resolved model names. This replaces
the old direct paste-code flow.

Subscription model choices are loaded from the connected account, not a fixed
list of model names. Claude uses its native runtime initialization catalog;
ChatGPT/Codex uses the same account credentials as inference; Copilot lists
enabled chat models supported by the current chat-completions integration
(responses-only models are excluded). The sidebar picker refreshes on every
open, and chat/revision requests recheck the selected subscription model before
sending. A failed lookup or unavailable saved model shows a connection/selection
error instead of falling back to an unrelated model. Manual model IDs remain
available for API-key and local endpoints. Provider usage limits still apply.
Claude Code remains a separately installed provider runtime; this plugin does
not bundle or automatically download it.

Subscription requests run through Claude Code with its native tools disabled.
Only the current PeriCode registry is exposed through an authenticated loopback
MCP connection. PeriCode handles tool permission prompts, Research restrictions
and audit entries. Inline revisions expose no tools. Stop terminates the request's
Claude Code process. Account sign-in and subscription billing remain with Anthropic.

All PeriCode features are free under the MIT license. No PeriCode account, trial,
activation key or paid tier is required. AI providers may charge their own fees.
See [LICENSE](LICENSE).

## Data, network and filesystem access

- Prompts, attached content and tool results are sent to your configured model
  endpoint. A local endpoint can keep inference traffic on your machine.
- Claude subscription mode starts the locally installed Claude Code process and
  an ephemeral authenticated HTTP server bound to 127.0.0.1. System instructions
  temporarily reside in an OS temporary file, removed at request completion.
  Claude Code uses its own account configuration; PeriCode requests that it not
  persist these chat sessions. Its own networking and data policies still apply.
- OAuth flows contact the selected identity provider. PeriCode has no licensing
  service, trial enrollment or hardware fingerprinting for activation.

- API keys and provider settings are currently stored in the plugin's data.json.
  Conversations, tool history and drafts are stored unencrypted under
  `<vault>/.pericode/conversations/sessions.json`; audit and memory files also live
  below `.pericode`. They may contain sensitive task content. The plugin does not
  send telemetry, but configured external providers have their own data policies.
- Shared authentication may read `~/.pericode/`; Claude Code reads its own account
  configuration. Temporary system-prompt files and SDK recovery records can be
  written outside the vault. These are runtime bookkeeping, not agent-selected paths.
- Agent file tools are confined to canonical vault paths. Protected metadata,
  parent traversal and linked paths are refused. Generic shell, plugin API,
  arbitrary command execution, and web-fetch are not exposed. MCP servers are
  separate trusted programs, not an OS sandbox; their policy lane requires explicit
  approval and may grant their own external access.
- The plugin never changes the host's global fetch or working directory. Provider
  credentials still use request-scoped process environment variables, which does
  not isolate them from other trusted plugins sharing the process.

- Assistant Markdown is display-only: fences cannot invoke other plugins, raw HTML
  stays text, and remote images/embeds do not load automatically. HTTP(S) links open
  only when clicked. Wiki references open vault notes only on an explicit, policy-checked click.

## Security guardrails

Every tool requires a one-use authorization bound to its exact arguments, active
turn, cancellation signal and policy. Paths and quarantine are rechecked before
execution. Lockdown prompts on every call, including reads; MCP calls always
prompt. Dry-run executes nothing. Invalid policy files disable tools. Search and
listing filter descendants; search is literal and bounded. Reads are capped at
2 MB. Deletions require confirmation each time and use trash; only empty folders
can be trashed, and permanent deletion is unavailable. Flagged tool output is withheld and privacy filtering
applies before results reach the model. These controls do not isolate native
plugins or MCP programs at the OS level.

## Vault management tools

The essential vault tools are included without a paid PeriCode license and are
shared by every provider. Research mode exposes inspection and narrowly scoped
UI navigation; Agent mode also exposes file changes subject to the permission policy.

| Operation | Tools |
| --- | --- |
| Find and read | `list_dir`, `search_files`, `read_file`, `obsidian_list_notes` (folder/title/tag filters and pagination) |
| Inspect notes | `obsidian_get_note_info` (properties, headings, tags, task lines, resolved links and backlinks) |
| Create and edit | `obsidian_create_note`, `write_file`, `edit_file`, `obsidian_append_note`, `obsidian_update_properties` |
| Organize | `obsidian_create_folder`, `obsidian_move`, `obsidian_copy_file` |
| Trash | `delete_file`, `obsidian_delete_note`, `obsidian_delete_folder` (empty folders only) |
| Navigate | Open notes, inspect active views, list/close tabs, collapse/expand folders, inspect installed plugins and available commands |

`obsidian_open_view` opens or reveals the global graph, search, file explorer or
Settings in either mode, subject to permission. It verifies the resulting view;
it cannot run arbitrary commands. `obsidian_get_settings` detects a separate
Settings window and reports the selected tab and visible setting labels without
reading input values or credentials. Active-view inspection distinguishes those
windows from visible workspace context and ignores hidden historical tabs.

Native creation, appending, property updates, moves, copies and trash operations
use Obsidian APIs. New destinations never overwrite; create parent folders first.
Moves validate every descendant (maximum 1000) and **do not rewrite links**:
inspect backlinks first and approve separate edits to affected notes. Copies
support individual notes and attachments up to 20 MB. Metadata uses Obsidian's
cache and may lag current edits; inventories must follow `next_cursor` until null.
Templates can be read and passed to note creation; task checkboxes and link text
can be changed with exact `edit_file` edits. Property updates merge top-level keys;
a JSON null removes that key. Generic plugin API calls and command execution
remain unavailable to the model.

## Advanced tools

MCP integrations, persistent memory, audit records and heuristic background reports
remain available. SQL Server connections, queries and schema sync are not included.
MCP quick-add presets require separately installed servers: `npx --no --offline`
prevents package installation/downloads. Replace the example filesystem path
with the directory you explicitly want to expose. Imported/custom MCP commands
remain operator-configured external programs with their own behavior.
Legacy connection profiles are ignored and dropped on the next settings save.
Previously generated notes remain ordinary Markdown files in your vault.
Real-provider authentication remains a release validation requirement.

## Validation and contribution

Run `npm test`, `npm run build`, and `npm run release:check` in this directory.
See [QA](QA.md) for recorded functional evidence and [submission preparation](SUBMISSION.md)
for publication steps and remaining gates. No overall superiority or complete
feature parity with another plugin is claimed by a passing local test suite.

## Credits and license

Claudian demonstrated useful Obsidian agent integration patterns and inspired the
comparison that led to this release. Current Claudian supports multiple agent
runtimes; the old Anthropic-only description was incorrect. The new conversation,
context and revision code here was independently implemented, without copying
Claudian's implementation. Earlier project credits for vault working-directory
and spawn integration patterns are retained here.

Copyright 2026 Eddy Ogutu. MIT-licensed; see [LICENSE](LICENSE). Third-party runtime
components retain their own licenses and notices in the bundled distribution.
