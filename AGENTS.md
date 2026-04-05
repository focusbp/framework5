# AGENTS.md

## NetBeansProjects environment
- In a `NetBeansProjects` environment, unless the user explicitly names a specific app project, Codex should treat `NetBeansProjects/app-framework5` as the implementation target.
- For framework features such as `wizard/run`, `public_pages`, `webhook`, and shared templates, start from `app-framework5` and do not search deployed app directories first.
- Do not infer the edit source from `web/*`, `templates_c`, or compiled output when the request is about framework behavior. Confirm framework-side source files in `NetBeansProjects/app-framework5` first.
- Only switch to a project-specific app under `NetBeansProjects/*` when the user clearly specifies that app or the request is explicitly about app-specific `classes/` content.
