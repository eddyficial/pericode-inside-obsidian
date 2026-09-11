# PeriCode 0.3.5 scorecard follow-up

## Dynamic code execution: removed

The MCP SDK used Ajv to compile tool output schemas into JavaScript functions.
The Obsidian build now uses the SDK's official CfWorkerJsonSchemaValidator
interpreter instead. The substitution applies only to the SDK validator module;
validation remains enabled. The CLI build is unchanged.

Regression tests run with Node's --disallow-code-generation-from-strings flag.
They cover nested references, required fields, additional properties, numeric
bounds, unions, conditional schemas and schema strings treated as data. A real
MCP client and in-memory server accept valid output and reject invalid output.
Release checks refuse Ajv implementation code, eval calls or Function constructors.
This removes the detected execution mechanism; it does not prove arbitrary MCP
schemas or external programs safe.

## Artifact attestations: release workflow

The distribution workflow checks out the full source commit recorded in
BUILD-PROVENANCE.json, installs locked dependencies, runs the SDK and plugin
suites, and rebuilds the plugin. It refuses to attest or package files if their
SHA-256 hashes differ from the reviewed distribution files. GitHub's attest
Action signs the rebuilt main.js, manifest.json and styles.css. Actions are
pinned to commit hashes. Publication is a separate step after verification.
The workflow and its run results are available in the distribution repository.

## Extra release assets: separate downloads

The community release contains only main.js, manifest.json and styles.css.
Required MIT and third-party license notices are included in main.js.
Documentation, checksums and the source pointer remain in the repository.
The optional Windows installer ZIP is published separately in the source
repository under obsidian-0.3.5, with its link in the installation guide.

## Capabilities that remain

- Filesystem access supports canonical path checks, private state, bounded
  searches, provider runtime bookkeeping and explicit imports. Standard note
  operations use Obsidian's APIs and the permission gate.
- Process access starts the user's Claude/Grok runtime or a session-approved
  MCP server. Those processes have user OS permissions; there is no OS sandbox.
- Vault enumeration supplies note discovery. Visibility is constrained by the
  plugin's permission and path policy before results reach the model.
- Clipboard writes support explicit Copy actions and the login-code flow. The
  inspected plugin bundle has no clipboard-reading calls.
- Network access is required for selected providers and configured services.

These are accurate capability disclosures. Removing their warnings would require
removing the corresponding functionality. Obsidian's unavailable malware and
network scans are controlled by its review service, not by this plugin. Local
dependency and regression checks do not replace an independent security audit.
