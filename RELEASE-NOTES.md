## 0.3.6

PeriCode 0.3.6 makes setup and your first vault questions easier.

- Connect your provider and choose a model from its returned list before finishing setup. Keys and server addresses save only when you choose Save connection.
- Set up later is remembered. Setup no longer imports or archives files or opens extra workspace views.
- Find a note, Summarize notes and Review a note prepare editable Research drafts without sending a request. Existing drafts are preserved.
- Sending without a model keeps your draft and attachments and opens connection settings.

Validation: 86 plugin tests, 352 SDK tests, installer fixtures and release checks passed. Live Obsidian testing loaded seven models from the saved ChatGPT/Codex account and verified vault create, read, stale-write refusal, edit and trash. Model discovery does not establish successful inference for every provider or account.

The release workflow rebuilds the pinned source, checks all three plugin files and issues artifact attestations. Filesystem, process, clipboard and network capability disclosures remain. The earlier 0.3.5 community review does not cover this update.

The optional Windows installer is available in the [separate installer release](https://github.com/eddyficial/pericode/releases/tag/obsidian-0.3.6).


## 0.3.5

MCP schema validation now uses an interpreter, removing dynamic JavaScript
compilation from the plugin. Validation remains enabled, with regressions run
under Node's code-generation restriction.

The release workflow rebuilds the pinned source, runs tests, compares the three
plugin files byte for byte, and creates GitHub artifact attestations. Community
assets now contain only main.js, manifest.json and styles.css. License notices
are embedded in main.js. The optional [Windows installer](https://github.com/eddyficial/pericode/releases/tag/obsidian-0.3.5)
has a separate download. See SECURITY-REVIEW-0.3.5.md for remaining capabilities.

# PeriCode 0.3.4

MCP startup now requires explicit approval for the current plugin session.
Approval includes environment values; synced approval files and first-load
configuration cannot approve themselves. Invalid policies and dry run prevent
startup. MCP connections no longer inherit ambient provider credentials or use
automatic command fallbacks.

File reads, writes, exact edits and trash now use Obsidian APIs with existing
vault permission checks. Unused CLI shell, web-fetch, filesystem and desktop
implementations are excluded from the bundle. The three reported CSS patterns
were removed: extended system fonts, :has and !important.

MCP users must approve servers again after reloading PeriCode. Creating a file
requires an existing parent folder. Read/write size limits are 2 MB and reads
return up to 500 lines. Secret-like filenames remain unavailable to the model.
Provider runtimes and MCP servers still have OS-level capabilities; this release
does not claim to eliminate filesystem/process disclosures or replace the
unavailable malware/network scans. See SECURITY-REVIEW-0.3.4.md for findings.

# PeriCode 0.3.3

Grok subscription sessions now accept the runtime's known generated configuration
and dispatch registered vault tools through PeriCode's permission gate. ACP
sessions explicitly restrict native tools, inherited skills and instruction
files. This fixes an isolation defect in 0.3.2; upgrading is recommended.

Grok 4.5 and 4.6 passed installed chat and guarded vault reads. Both rejected
native file access in the isolation check. One local Qwen3 Coder 30B model passed
chat and a guarded vault read without cloud inference. All 70 plugin tests and
installer/release checks passed for the tested candidate.

Grok long prompts and broad discovery, Ollama Cloud sign-in and cross-platform
workflows still need further verification. See QA.md for the test scope.
Community directory review and publication remain pending.

# PeriCode 0.3.2 - one clear name

The plugin is now called PeriCode in Obsidian, including settings, onboarding,
installation messages and report headings. The website describes it as PeriCode
for Obsidian, with PeriCode CLI remaining a planned separate product.

Existing installations upgrade in place. The plugin ID, saved settings, provider
connections, conversation storage and permission controls are unchanged.
Community submission remains paused.

# PeriCode Inside 0.3.1 - chat branding

The chat session header now shows the PeriCode name and PC logo alongside the
saved-conversation selector. New chat, expand and menu controls remain compact.
The website footer now uses the same logo treatment as its header.

This update preserves provider settings, conversations and permission controls.
The plugin remains a free MIT-licensed desktop preview. Community submission
remains paused; existing live-provider verification limits still apply.

# PeriCode Inside 0.3.0 — free and open source

All PeriCode project-owned code is now available under the MIT license.
Every plugin feature is included without a PeriCode account, payment, activation
key, trial or hardware fingerprint. Existing provider connections and vault data
are preserved; obsolete plugin license state is dropped on upgrade.

- Paid tool gates and license-service traffic removed; required security and
  permission checks retained.
- Settings now have AI connection, Privacy & safety, Integrations, Vault,
  About and Advanced sections.
- Grok API and Grok Build account connections, Ollama Cloud account routing,
  and Use my subscription shortcuts added.
- Full CLI, agent runtime, desktop engine, SDK and host adapter source published.
- Source, contributor documentation and third-party notices available on GitHub.

AI-provider subscriptions/API charges remain separate. Grok Build and Ollama
Cloud need sign-in before live inference can be verified. Desktop only;
Community-directory approval and broad cross-platform QA remain pending.

Download main.js, manifest.json and styles.css into your vault's
`.obsidian/plugins/pericode/` directory, or extract the ZIP and run its optional
Windows installer. Enable PeriCode in Community plugins, then configure a provider.
