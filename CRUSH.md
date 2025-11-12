# CRUSH.md

This file provides a summary of conventions for this repository.

## Build, Lint, and Test

- **Lint:** `luacheck .`
- **Style Check:** `stylua --check .`
- **Style Fix:** `stylua .`

## Code Style

- **Formatting:** Use `stylua` for automatic formatting.
- **Linting:** Adhere to `luacheck` rules.
- **Whitespace:** No trailing whitespace.
- **Files:** End files with a newline.
- **YAML:** Ensure YAML files have valid syntax.

## Naming Conventions

- **Variables:** Use `snake_case` for local variables and function parameters.
- **Functions:** Use `PascalCase` for public functions and `snake_case` for private functions.

## Error Handling

- Use `pcall` and `xpcall` for error handling in Lua.
