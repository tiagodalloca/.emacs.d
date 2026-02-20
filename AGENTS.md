# AGENTS

## Core preferences
- Follow patterns laid out in existing files.
- Prefer updated packages and modern defaults when safe.
- Assume Emacs 29+ (tree-sitter, built-in ts/tsx modes).
- Keep config portable across Unix-like systems (no hard-coded paths).
- Prefer concise code; avoid unnecessary abstractions.
- Use MCP servers to find up-to-date documentation before changes.

## Workflow
- Read relevant files first; make minimal, focused edits.
- Avoid large config refactors unless explicitly requested.
- Prefer project-local versions when tools support it.
- Document non-obvious decisions briefly.

## Safety
- Do not introduce secrets or credentials in config.
- Avoid destructive commands or irreversible changes without explicit request.
