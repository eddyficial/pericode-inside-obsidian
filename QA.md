## Clean-install correction: September 11, 2026

The public listing's Add to Obsidian button opened Obsidian 1.13.7, but its
catalog returned No results found for pericode. The public GitHub catalog also
had no pericode entry at this check. A public listing and completed review did
not establish that in-app installation worked. Catalog availability timing is
unconfirmed.

The documented manual path passed: download the three 0.3.3 release assets,
verify their checksums, place them in a clean plugin folder, reload, and enable
PeriCode. First-run setup completed and the existing ChatGPT account returned
seven models. Old vault settings and conversations were kept in a separate
recovery backup. Installation instructions now lead with this verified path.

## Community publication: September 11, 2026

Release 0.3.3 was published at distribution commit 3e6415b and its downloaded
assets and all 12 ZIP entries matched the intended files. All 70 plugin tests
and installer/release checks passed. Installation succeeded in all five
registered vaults; the active vault loaded 0.3.3 with its provider/model preserved.

The Community review completed with no blocking errors and no vulnerable
dependencies reported. It warned about direct filesystem and process access,
CSS font compatibility, `!important` and `:has`. Recommendations covered missing
artifact attestations, additional release assets, vault enumeration, clipboard
access and dynamic code execution. A separate source build reproduction result
was not shown. These observations do not establish exhaustive security coverage.

The public listing is https://community.obsidian.md/plugins/pericode and shows
Add to Obsidian. Earlier paused/pending entries below are historical.

## 0.3.3 local model verification: September 11, 2026

The installed plugin passed two live turns with the existing
Qwen3-Coder-30B-A3B-Instruct-UD-IQ3_XXS model through its OpenAI-compatible
connection to a temporary loopback llama.cpp server. A plain chat returned the
expected reply; a guarded `read_file` returned a random code from a synthetic
vault note. No cloud inference was used. Context was 32,768 tokens and measured
generation throughput ranged from 73.75 to 114.30 tokens per second.

The synthetic note and test conversation were removed, original connection
settings and conversation were restored, and the temporary server was stopped.
This covers one model and two short turns, not a long-context or multi-model
benchmark. The local evidence is in
`security-reviews/2026-09-11/local-llm-test.json` in the parent workspace.

## 0.3.3 Grok subscription verification: September 11, 2026

Live testing used the installed Grok Build 1.0.13 runtime and an authorized
subscription in PeriCode's separate profile. The account returned Grok 4.5 and
Grok 4.6. Both models responded in the installed Obsidian chat and read a
temporary vault note through PeriCode's guarded `read_file`, returning its random
verification code. Temporary notes were removed and the original provider,
model and conversation were restored.

The tests found three defects in the published 0.3.2 integration:

- Grok's generated marketplace registration was rejected as custom configuration.
- ACP permission requests for the PeriCode bridge were cancelled before reaching
  the vault permission gate.
- Headless CLI tool filters did not restrict ACP sessions. A synthetic file was
  read through the native runtime without a PeriCode tool event.

The candidate accepts only the exact known generated configuration, disables
automatic marketplace registration, permits one-time dispatch only to registered
PeriCode tools, and places the tool allowlist in the ACP agent profile. It also
disables skill discovery, instruction-file discovery, default tool injection and
shared leader use. The bridge still checks vault permissions before execution.

After these fixes, both models failed a deliberate attempt to read a random-code
file with no MCP tools available. Neither returned the code or executed a
PeriCode tool. All 70 plugin tests and the installer/release checks passed.

The earlier Grok 4.5 discovery attempt triggered the output scanner and was
quarantined. The final tests used a verified absolute note path. Grok also tried
to read its own offloaded prompt outside the vault; the guard denied that read.
Long prompts and broad discovery therefore need further testing. These results
do not establish every workflow or cross-platform compatibility.

Version 0.3.3 packages these fixes for release and Community submission.
The installed candidate was verified in Session Portal Vault.
Raw test evidence is kept outside the repository under
`security-reviews/2026-09-11/grok-*` in the parent workspace.

## 0.3.2 product naming

The installed plugin, settings heading and chat brand all report PeriCode in
live Obsidian 1.13.7. The existing Codex provider/model and saved-conversation
selection were preserved during the upgrade. All 69 plugin tests, installer
fixtures and release checks pass. Website checks cover 12 pages, 192 internal
link occurrences, matching header/footer logos and desktop/mobile navigation.
Current website and app surfaces omit the old Inside name; historical release
notes below retain the names used when those versions shipped.

## 0.3.1 chat branding

The chat header shows the PC logo and PeriCode name above the saved-conversation
selector. All 69 plugin tests and the installer/release checks pass. Live
Obsidian 1.13.7 verification confirms version 0.3.1 loads with the existing Codex
provider and conversation selection preserved. At a 300-pixel sidebar width,
the 52-pixel header displays the brand, conversation selector and all three
actions without overflow. The visible sidebar was inspected after upgrade.

The website header and footer logo styles match on all 12 pages, with browser
checks at desktop and mobile widths. Provider authentication coverage is
unchanged; the historical verification details below retain their original dates
and release scope. Community submission remains paused.

## 0.3.0 open-source release

PeriCode's commercial licensing layer has been removed. All features use the
same mandatory vault authorization and security policies. Settings migrate away
from old license keys, trial timestamps and hardware fingerprints without
contacting a licensing service. AI-provider subscription connections remain.

Validation for this release: 352 SDK tests and 69 plugin tests pass, including
settings migration and no-activation UI coverage. Installer fixtures, readable
bundle checks and the no-billing packaging assertions pass. The source snapshot
and all Git history pass Gitleaks 8.30.1 with no detected secrets. The SDK
production dependency audit reports zero vulnerabilities at this check.

Live upgrade verification in Obsidian 1.13.7 confirms version 0.3.0 loads, the
License tab is replaced by About, old activation data is removed from storage,
and the original Codex provider/model remain selected. The formerly paid memory
list tool executes after authorization and is blocked without it. Both production
dependency audits report zero advisories. Installed in all five registered vaults.

The sections below record earlier testing and product states; references to
paid licenses in historical reports do not describe version 0.3.0.

## Subscription settings candidate — September 11, 2026

- Added Grok Build account and Ollama Cloud server-account routes, plus subscription
  switches on Anthropic, OpenAI, Grok API and Ollama cards.
- 68 plugin tests pass, including account switching, key preservation, no manual
  subscription model bypass, Grok ACP host-operation rejection, bounded transport,
  environment isolation, and cloud-only Ollama catalogs. Installer fixtures pass.
- SDK and plugin builds pass; release packaging checks pass. Public preview unchanged.
- Installed Grok Build 1.0.13 returns the expected sign-in-required error with the
  new integration profile. No API credentials or vault contents are sent by this probe.
- Grok's empty tool list means inherit-all. The adapter instead uses the recognized
  `mcp__pericode__*` filter, supported by the official runtime builder, retaining only
  MCP dispatch. All bridge tool calls still use PeriCode's permission gate.
- Live Obsidian checks pass: all five account cards, Grok API-to-subscription switch,
  native sign-in-required message and Ollama setup controls. Original Codex provider
  and model restored. Screenshot: `security-reviews/2026-09-11/pericode-subscription-settings.png`
  in the parent workspace; `subscription-live-proof.json` records the checks.
- Authenticated Grok chat/tool round trips and Ollama Cloud inference still require
  user sign-in. These live paths are not marked verified by fixture tests.

# PeriCode Inside 0.2.0 QA

Local verification: September 10, 2026 America/Chicago (September 11 UTC).
Host: Windows, Node 24.14.1, Obsidian 1.13.7.

## Settings redesign and Grok candidate — September 11, 2026

- SDK suite: 352 passing tests; plugin suite: 62 passing tests and installer fixtures.
- Native Obsidian checks exercised all six section buttons, custom endpoint
  fields, Grok provider selection, password input focus/edit/cancel, missing-key
  model discovery, and restoration of the original provider/model.
- Automated tests verify explicit key saving, model choice persistence, cache
  clearing, xAI credential scoping/restoration, account model filtering, endpoint
  and authorization headers, streamed text/tool calls, and failure messages.
- Settings reflow in the separate Settings window. Override Obsidian's inline
  horizontal padding only inside PeriCode to preserve usable space when maximized.
- Screenshot: `security-reviews/2026-09-11/pericode-settings-grok.png` in the parent
  workspace. Live evidence: `settings-grok-live-proof.json` alongside it.
- No xAI key was configured. Live Grok authentication/inference is unverified.
  Public preview assets and Community submission remain unchanged.

## Community preview packaging — September 11, 2026

Final preflight: 350 SDK tests and 60 plugin tests pass; both dependency audits
report zero advisories. The public asset check found and removed a developer
home-directory example from MCP presets. Presets and blank server forms now use
`npx --no --offline`; a regression test prevents download consent flags and
developer home paths from returning. The public distribution contains only
explicitly selected artifacts and sanitized documentation. Original private
repository history, internal QA records and user vault content are excluded.

## Workspace and Settings regression — September 11, 2026

- 59 plugin tests pass. Five new tests cover detached Settings, stale hidden
  graph tabs, foreground versus visible workspace context, modal overlays,
  omission of settings input values, permission-gated Research navigation,
  arbitrary-command rejection, cancellation and unavailable-view failures.
- Active-view/file/inspection tools now share a live surface resolver with the
  path guard. A historical leaf is considered only if currently visible; open
  Settings windows are reported separately. Settings tab names come from the
  rendered selection because the host's activeTab id was observed to be stale.
- `obsidian_open_view` is narrowly limited to graph, search, file explorer and
  Settings. Research admits this tool and open-note navigation while retaining
  their mutating annotations and normal permission guard. Arbitrary commands,
  plugin API calls and file writes remain unavailable in Research.
- Live installed-registry QA in Session Portal Vault correctly detected the
  separate Settings window, General tab and visible labels without values.
  The permission-guarded opener verified all four supported views; graph was
  created once and reused on repeat. Periphery independently reported the main
  window title as Graph view and the separate Settings window still present.
- The graph was left open, the existing Settings window was preserved, and no
  note contents or settings values were changed. Installed in all five vaults.
  Evidence: `security-reviews/2026-09-11/workspace-tools-live-proof.json` beside
  the repository. These are native tool/host checks, not a new provider inference test.

## Vault management verification — September 11, 2026

- 54 plugin tests pass, including seven new guarded native-vault test cases.
  Coverage includes the note/folder lifecycle, overwrite refusal, paginated
  Research inventory, protected backlinks, source/destination descendants,
  junctions, frontmatter merge and unsafe keys, cancellation during reads,
  dry-run, direct-call refusal and fresh consent for each empty-folder deletion.
- Production TypeScript/bundle and release checks pass. A real renderer failure
  in `delete_file` exposed an unsupported dynamic `node:path` import. The import
  is now static; bundling lowers dynamic imports to CommonJS and release checks
  reject external dynamic host imports, including lazy SDK paths.
- Live functional QA in Session Portal Vault used the installed plugin registry
  and its real permission guard with an allow callback restricted to disposable
  fixture paths. All nine new tools appeared in the provider's coding registry.
  Existing write/edit/read/search/list tools also executed successfully.
- Native creation, atomic append and YAML properties preserved unrelated
  properties and the note body. Obsidian's actual cache returned heading/task
  lines and backlinks. Paginated tag search found the correct note; native copy
  preserved its content; file and folder moves updated the vault cache.
- Overwrites, non-empty folder trash and protected destinations were refused.
  Individual-file and empty-folder trash succeeded through guarded tools.
  All fixtures, including those from the first failed run, were cleaned up.
- Installed and enabled in all five registered vaults, preserving settings and
  conversations. The active Session Portal Vault plugin was reloaded while idle.
  Live evidence is stored in `security-reviews/2026-09-11/vault-tools-live-proof.json`
  beside the repository. This verifies local dispatch, not new inference runs
  against every subscription provider.
- Deliberate boundaries: folder deletion requires an empty folder; copy is
  individual-file only; moves do not rewrite links without separate note edits;
  metadata is bounded and reflects the current Obsidian cache.

## Automated verification

- Parent runtime TypeScript build and all 347 parent-runtime tests: passed.
- Plugin TypeScript check and bundled production build: passed, no build warnings.
- 29 Node tests: storage roundtrip and serialized writes, corrupt-store protection,
  malformed sessions, interrupted tool history, transcript export, bounded context,
  folder boundaries, word diff, stale edits, read-only registry restrictions,
  HTTP aborts before headers and during streaming, and DOM interactions covering
  send/resume, Stop, permission cancellation, context, deletion and edit review.
  The four-step onboarding test covers forward/back navigation and completion
  without database setup. All 22 passed again after SQL removal on September 11.
  Three additional Claude Code bridge tests passed: authenticated IPC and research
  scope, denied/cancelled actions, and isolated runtime settings and child environment.
  Three subscription regressions cover reconnect controls for stale credentials,
  provider/model changes during onboarding, and visible failed-request recovery.
- Plugin and parent-runtime dependency audits: zero reported vulnerabilities after
  compatible lockfile updates resolved six parent-runtime advisories.
- SQL Server support removed on September 11: driver, tools, sync schedulers,
  connection settings, onboarding step and database-specific instructions removed.
  Release checks reject SQL driver code or removed tool names in the bundle.
  The readable bundle decreased from 4,941,301 to approximately 1,588,000 bytes
  (68% smaller); the ZIP is approximately 344 KiB. Dependency audit: zero findings.

## Actual Obsidian functional verification

Before SQL removal, the compiled production plugin was loaded into the running Obsidian app.
Testing used synthetic notes and a deterministic HTTP provider bound exclusively
to 127.0.0.1. No cloud model credentials were needed and no model quality benchmark
was performed. These checks passed:

1. Send from a focused composer; render streamed headings, a table and a source link.
2. Stop an actual HTTP request; return the composer to a usable state.
3. Start a conversation and resume a different saved conversation.
4. Attach selected editor text through the registered command callback; verify
   its source and content enter the request.
5. Open the native context picker, search for the synthetic note and select it.
6. Export the transcript as a new Markdown note.
7. Generate an inline revision with additions/removals while leaving the note unchanged.
8. Accept the revision, then restore the original through native editor Undo.
9. Change the note after preview generation; acceptance refuses the stale revision.
10. Close and recreate the chat panel; restore the same conversation and history.
11. Cancel a deletion, then confirm deletion; the source note remains intact.
12. Unload the final plugin bundle during a streaming request; the request slot
    is released and edit modals are closed.

The consolidated live runner returned PASS for its nine grouped checks. Context
picker and deletion checks were also exercised directly. A 276-pixel sidebar
reported equal clientWidth and scrollWidth (276), with a rendered Markdown table.

Live QA identified and fixed an HTTP cancellation race. A later deletion check
also led to clearing pending attachments when deleting a conversation; that case
is covered by the automated UI suite. The QA runner explicitly passes its captured
editor to registered command callbacks because this desktop has multiple Obsidian
windows, including detached settings, and a global active-editor query can target
another window. Input focus is verified before filling any field.

## Claude subscription fix — September 11, 2026

Using the installed, unmodified Claude Code 2.1.268 with the user's existing Max
sign-in, a synthetic tool returned the expected verification phrase. In actual
Obsidian, the rebuilt plugin then passed a native subscription chat, read_file
through the restricted Research registry, Stop cancellation and a tool-free inline
revision preview. The synthetic note was removed. No subscription tokens were
read or copied by PeriCode, and no fresh browser login was required. The signed-out
browser login path still needs a separate account-level test.

## Subscription sweep — September 11, 2026

Tests sent synthetic prompts from the actual Obsidian composer:

| Subscription | Model | Result |
| --- | --- | --- |
| Claude Max through Claude Code | sonnet | Passed response, restricted read_file and follow-up context |
| GitHub Copilot | gpt-4o | Passed response, restricted read_file and follow-up context |
| ChatGPT / Codex | gpt-5.4 | Blocked: HTTP 401 refresh_token_reused; fresh sign-in required |

The basic settings now expose Login/Sign in again for Copilot and Codex. Saved
credentials are no longer presented as proof of a working account. The wizard
provides sign-in controls and resets the model when changing providers. A failed
request keeps an explicit failure status and offers reconnection guidance.
Synthetic note content was removed after the live tool checks. Fresh Claude and
Copilot browser sign-ins, other models and other provider plans were not tested.

## Compact chat panel — September 11, 2026

The native 300-pixel sidebar header shrank from 220.8 to 40 pixels. With no
attachments, the conversation area grew from 358.8 to 600.8 pixels in the same
window. The layout now uses a single toolbar, an overflow actions menu, an
auto-growing composer with mode/model controls, and a workspace expansion toggle.
Account errors expose details on demand. Obsidian's own rendered screenshots
were inspected after repaint, because another application covered its window.

Live checks passed: expand/restore and Escape preserve draft and attachments;
240/300/420-pixel widths have no horizontal overflow; Send/Stop cancel a real
loopback HTTP request; workflow selection fills without sending; streamed
Markdown renders; menu export creates a note; the context menu opens the native
note/folder picker. Synthetic chats and exported notes were removed. Expansion
moves the same panel outside Obsidian's sidebar CSS containment and restores its
original DOM location, avoiding duplicate conversations or reloads.

## Remaining release limits

The Windows installer was exercised with Windows PowerShell 5.1 using temporary
vaults: fresh install, automatic single-vault selection, upgrade backup, settings
and note preservation, invalid-vault rejection and incomplete-package rejection
passed. Native installation into Operynth was subsequently verified: after plugin
discovery refresh, Obsidian's CLI enabled version 0.2.0, the runtime reported it
loaded and enabled, and the chat panel and first-run setup wizard opened. No
model credentials were configured or provider request sent during installation.

- This is not a claim of overall superiority to Claudian, cross-platform parity,
  or readiness of every pre-existing integration.
- Other live cloud-provider API keys, fresh subscription sign-ins,
  administrator policy service, and paid-license activation were not validated.
- The existing proprietary license and commercial service terms need owner review
  before public distribution. No source or release was published and no Community
  directory submission was made.
- The candidate targets the tested Obsidian version rather than claiming older
  versions or mobile compatibility.

Temporary QA plugin files, state and synthetic notes were removed from the user's
live vault after testing. Local evidence is retained under ignored qa-artifacts/.
The SQL-removal follow-up used automated DOM interaction tests and release checks;
it did not repeat the earlier native Obsidian session.
# Security remediation — 2026-09-11

The plugin suite passes 39 tests plus installer fixtures. New tests cover exact
request approvals, protected and linked paths, lockdown, dry-run, quarantine,
policy changes, cancellation, MCP identity/permissions, inert Markdown and OAuth
callback validation/lifecycle. Installed-plugin checks passed for direct-call
denial, protected paths, one-use approval, cancellation, inert code processors,
safe formatting and unchanged host fetch/cwd. The sidebar was restored after
installation. No provider tokens or real vault content were used in the probes.
See [security and compliance](SECURITY-COMPLIANCE.md) for scope and remaining gates.


## Subscription model selection and native tool regression — September 11, 2026

The model control now opens an account catalog directly in the chat panel's
own document, including detached Obsidian windows. Catalogs refresh on opening;
subscription requests validate the saved selection before inference. Missing
credentials, unavailable models and discovery failures cannot substitute static
model lists. Manual IDs remain limited to API-key/local endpoints.

Live account discovery returned five Claude Max choices (including the native
recommended default and resolved model names), seven visible Codex choices, and
five enabled Copilot models compatible with chat completions. Copilot models
requiring the Responses endpoint are excluded until that lane supports them.
These counts describe this account at verification time, not fixed plan limits.

The installed plugin successfully selected an account model from the menu, sent
a real Claude request, read a synthetic vault note through the permission gate
and authenticated MCP bridge, and returned the note's unique marker. The fixture
was trashed and the original conversation, attachments and selection restored.
The cancellation-signal identity regression is fixed without removing one-use
authorization, path checks, quarantine or cancellation protection.

Automated coverage includes subscription catalog parsing, disabled/hidden model
filtering, unavailable saved selections, reconnect errors, menu selection and
window ownership, plus a Claude bridge-to-guarded-registry read regression.
Existing security, Markdown, installer and UI checks remain in the release gate.
Live discovery does not certify inference with every listed model or provider
billing limits; only the Claude synthetic-note turn was rerun for this change.


## Directory defaults and permission reporting — September 11, 2026

Reproduced the reported list_dir and search_files failures with provider tool
inputs containing an empty path. These read-only directory operations now treat
omitted, null and empty roots as the vault root. Empty read_file paths and paths
outside the vault remain blocked. Permission-check failures propagate the actual
gate reason to the UI and model instead of attributing every rejection to the
user. Missing-file reads report a path-not-found error.

Verification: 47 plugin tests and 350 SDK tests passed. In the installed plugin
in Knowledge_Vault, the exact empty-path listing and search requests both passed
without any permission prompt. Protected configuration reads remained blocked
with a security-policy reason. The rebuilt bundle was installed in all five
registered vaults, and the active Knowledge_Vault plugin was reloaded. Existing
transcripts retain the errors recorded before this fix.
