# AGENTS.md - AstroNvim Configuration Guidelines

## Build/Lint/Test Commands

### Formatting
- Format code: `stylua .`
- Check formatting: `stylua --check .`

### Linting
- Lint Lua code: `luacheck`

### Spell Checking
- Check spelling: `typos`

### Docker
- Build image: `make build-image` or `docker build -t nvim-config .`
- Run image: `make run-image` or `docker run -it nvim-config /bin/bash`

### Pre-commit Hooks
- Run pre-commit: `pre-commit run --all-files`

## Code Style Guidelines

### Formatting (StyLua)
- Indent: 2 spaces
- Column width: 120 characters
- Line endings: Unix
- Quote style: Auto (prefer double quotes)
- Call parentheses: None (omit when possible)
- Collapse simple statements: Always

### Linting (Luacheck)
- Globals: `astronvim`, `astronvim_installation`, `vim`, `bit`
- Ignore: max_line_length (631), unused args with "_" prefix (212/_.*)
- Self: false (don't report unused self args)

### Selene Rules
- Allow: global_usage, if_same_then_else, incorrect_standard_library_use, mixed_table, multiple_statements

### Naming Conventions
- Functions: camelCase or snake_case (follow existing patterns)
- Variables: snake_case
- Constants: UPPER_SNAKE_CASE
- Files: snake_case.lua

### Imports and Dependencies
- Use lazy.nvim plugin specification format
- Group related plugins together
- Include version constraints when necessary
- Add descriptive comments for complex configurations

### Error Handling
- Use LSP diagnostics for code analysis
- Leverage vim.notify for user feedback
- Handle version compatibility checks (e.g., vim.version().minor)

### Commit Messages
- Follow Conventional Commits: `fix:`, `feat:`, `docs:`, `refactor:`, `chore:`
- Include scope for module-specific changes: `fix(lsp): typo in mappings`
- Mark breaking changes with `!`: `feat!: breaking change description`</content>
<parameter name="filePath">/home/gmatheu/.dotfiles/stow-files/astronvim/AGENTS.md