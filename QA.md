# Preview validation

Verified September 11, 2026 on Windows with Obsidian 1.13.7 and Node 24.14.1.

- 350 SDK tests passed.
- 60 plugin tests passed, plus installer preservation/rejection fixtures.
- SDK and plugin dependency audits reported zero advisories.
- TypeScript, production build, release structure and dependency notices passed.
- Live installed-plugin tests covered permission-gated read/write/edit/search,
  note and folder creation, append, properties, copy, move, metadata, backlinks,
  pagination and trash. Temporary fixture notes were removed afterwards.
- Protected paths, overwritten destinations and non-empty folder trash were
  refused. Cancellation, one-use approvals and Research restrictions have
  regression tests.
- Live view tests detected a separate Settings window and successfully opened
  graph, search, file explorer and Settings through the guarded registry.
- Five installed vault copies matched the tested build.

Remaining: directory acceptance, private-source scanner/build verification,
proprietary-license review, fresh sign-in/inference across every provider,
production paid activation and live QA on other desktop operating systems.
No security certification or universal provider compatibility is claimed.
