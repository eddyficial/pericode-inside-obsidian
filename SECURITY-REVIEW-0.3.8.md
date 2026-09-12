# PeriCode 0.3.8 community capability review

Version 0.3.8 restores Claude Code and Grok Build subscription connections.

| Capability | Status | Reason |
| --- | --- | --- |
| Shell execution | Required and disclosed | PeriCode launches the user-installed Claude Code or Grok Build program only after that subscription provider is selected. The child environment excludes provider credentials and execution overrides. |
| Direct filesystem access | Removed from the production bundle | Vault content uses Obsidian adapter APIs. |
| Broad vault enumeration | Removed | Discovery uses bounded adapter traversal and excludes hidden folders. |
| Clipboard access | Removed | PeriCode does not read or write the system clipboard. |

The executable routes inherit the provider application's account limits and sign-in. API-key connections remain separate. Local process execution also supports explicitly approved stdio MCP servers; HTTP MCP does not require it.
