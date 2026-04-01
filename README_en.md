# app-framework5

`app-framework5` is a framework designed **specifically for AI coding (agent-driven development)**.  
It prioritizes safe implementation, verification, and operation by coding agents over manual workflows.

## Must Read First

Before starting development, always read:

- `docs/AGENTS.md`

This file defines requirement classification, UI/Ajax rules, completion criteria, and skill selection.  
When assigning work to an AI agent, **loading `docs/AGENTS.md` first is mandatory**.

## Framework Characteristics

- Structure optimized for AI-agent implementation and maintenance
- Standardized workflow by feature-based skills (`screen_fields`, `db_additionals`, `cron`, `webhook`, `embed_app`, `public_pages`, etc.)
- CLI-friendly verification flow
- Explicit implementation rules to reduce quality variance

## Recommended Workflow (with AI)

1. Classify the requirement (`screen_fields` / `post_action_class` / `db_additionals` / `cron` / `webhook` / `embed_app` / `public_pages`).
2. Select the corresponding skill according to `docs/AGENTS.md`.
3. Implement.
4. Verify until minimum completion criteria are satisfied.

## Minimum Completion Criteria

- `app_call` succeeds
- For update flows, verify reflection with `data_get` or `data_list`
- For public routes, verify major scenarios with `app_check`

## Implementation Rules (Key Points)

- Follow the allowlist in `_buttons_prompt_form.tpl`
- Generate URLs with `$ctl->get_APP_URL()` instead of string concatenation
- On validation errors, return `res_error_message()` and `return` immediately
- On errors, do not re-run `show_multi_dialog()` or redraw via `reload_area()`
- Prefer helpers for forms/views (`fields_form_direct`, `fields_form_original`, `fields_view_direct`)

## Notes

- Keep environment-specific procedures (local paths, deployment/sync steps) out of common rules; move them into the relevant skill.
- If you update specs or operational rules, update `docs/AGENTS.md` and related skills together.

## License

- See `fbp/LICENSE` for the framework's own license.
- See `THIRD_PARTY_LICENSES.md` for bundled third-party license inventory.
- For exact obligations, follow each bundled component's original license file.
