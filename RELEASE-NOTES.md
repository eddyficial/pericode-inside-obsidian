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
