# PeriCode Inside 0.2.0 — community preview

PeriCode Inside brings a persistent AI sidebar and permission-controlled vault
management to Obsidian desktop. This preview is available for personal evaluation
under the included proprietary license; it is not yet listed in Obsidian's
Community directory.

- Saved conversations, explicit note/folder context and reviewed inline edits.
- Subscription model catalogs for Claude Code, ChatGPT/Codex and GitHub Copilot;
  separate API-key and local-model options remain available.
- Nine native vault tools for creation, organization, properties and metadata.
- Settings-window detection and verified graph/search/file-explorer navigation,
  including narrowly scoped navigation in Research mode.
- Mandatory permission checks, accurate blocked-tool errors, protected paths,
  trash-only deletion, inert assistant Markdown and cancellation controls.
- Optional Windows installer for one or all registered vaults. No SQL Server.

Validation: 350 SDK tests and 60 plugin tests pass; both dependency audits report
zero advisories. Native operations were exercised in Obsidian 1.13.7 on Windows,
and installed copies in five vaults match the tested bundle.

Install the attached main.js, manifest.json and styles.css into
`<vault>/.obsidian/plugins/pericode/`, or extract the ZIP and run the optional
Windows installer. Enable the plugin and configure a provider in Settings.

Limits: desktop only; other operating systems have not completed live QA.
Authentication and model availability depend on each provider. Fresh login for
every provider and paid-license activation have not completed a release-wide
end-to-end test. Folder trash requires an empty folder; moves do not rewrite
backlinks automatically. Metadata uses Obsidian's current cache.

The public repository contains release artifacts and documentation. Development
source remains private and requires Obsidian's private-source review integration.
Official listing, licensing review and source/build verification are pending.
