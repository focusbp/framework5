---
name: fbp-customer-demo
description: Use when creating the default FBP customer management demo/sample with fixed customer fields, staged CRUD, CSV import/export, PDF output, seed data, and FBP CLI verification.
---

# fbp-customer-demo

Use this skill when the user asks for a customer management demo, customer CRUD
sample, CRM sample, or an easy first FBP Codex Booster demo.

## Goal

Create the default customer management demo in stages:

1. Customer DB and CRUD screen
2. Seed data
3. CSV export/import
4. PDF output
5. FBP CLI verification

Do not ask the user to choose fields for the default demo. Use the fixed schema
below unless the user explicitly asks for a custom customer model.

## Companion Skills

Read these only when the stage needs them:

- `fbp-db` for DB/note definitions and data commands
- `fbp-original-screen` for the CRUD management screen
- `fbp-csv-media` for CSV export/import
- `fbp-pdf` for PDF output
- `fbp-cli` for verification commands

## Fixed Names

- Table/note name: `customers`
- CRUD class: `customers_original_management`
- CRUD entry function: `run`
- CSV class: `customers_csv`
- CSV functions: `download`, `upload_form`, `upload_exe`
- PDF class: `customers_pdf`
- PDF functions: `list_pdf`, `detail_pdf`
- Constant array: `customer_status`

## Fixed Customer Fields

Use exactly these default fields for the first demo:

| Field | Label | Type | Required | Usage |
| --- | --- | --- | --- | --- |
| `customer_code` | Customer Code | text | yes | list, search, form, CSV, PDF |
| `company_name` | Company Name | text | yes | list, search, form, CSV, PDF |
| `contact_name` | Contact Name | text | no | list, search, form, CSV, PDF |
| `email` | Email | text | no | list, search, form, CSV, PDF |
| `phone` | Phone | text | no | list, search, form, CSV, PDF |
| `postal_code` | Postal Code | text | no | form, CSV, detail PDF |
| `address` | Address | textarea | no | form, CSV, detail PDF |
| `status` | Status | dropdown | yes | list, search, form, CSV, PDF |
| `memo` | Memo | textarea | no | form, CSV, detail PDF |
| `created_at` | Created At | datetime | no | detail/PDF, set on insert |
| `updated_at` | Updated At | datetime | no | detail/PDF, set on insert/update |

For `email`, set email format validation when the FBP field definition supports it.
For `status`, default to `prospect`.

## Fixed Status Options

Use `customer_status`:

| Value | Label |
| --- | --- |
| `prospect` | Prospect |
| `active` | Active |
| `inactive` | Inactive |

Do not invent extra statuses for the default demo.

## Fixed CSV Columns

CSV import/export must use this column order:

```text
customer_code,company_name,contact_name,email,phone,postal_code,address,status,memo
```

Rules:

- Export UTF-8 by default.
- Import updates an existing row when `customer_code` already exists.
- Import inserts a new row when `customer_code` is new.
- Validate required `customer_code`, `company_name`, and `status`.
- Validate `status` against `prospect`, `active`, `inactive`.
- Return `res_error_message()` and immediately `return` on validation errors.

## Fixed PDF Output

Create two PDF flows:

- Customer list PDF:
  - `customer_code`
  - `company_name`
  - `contact_name`
  - `email`
  - `phone`
  - `status`
- Customer detail PDF:
  - all customer fields except internal IDs

PDF download buttons must use `download-link`, not `ajax-link`.

## Seed Data

If the `customers` table is empty after the CRUD stage, add these demo records:

| customer_code | company_name | contact_name | email | phone | postal_code | address | status | memo |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `CUST-001` | Acme Trading | Alice Johnson | alice@example.com | `03-0000-0001` | `100-0001` | Tokyo | active | Key account |
| `CUST-002` | Blue River Co. | Bob Smith | bob@example.com | `06-0000-0002` | `530-0001` | Osaka | prospect | Needs follow-up |
| `CUST-003` | Green Field LLC | Carol Lee | carol@example.com | `052-0000-0003` | `460-0001` | Nagoya | inactive | Past customer |

## Stage Workflow

### Stage 1: DB and CRUD

1. Read `fbp-db` and `fbp-original-screen`.
2. Create or update `customers` with the fixed fields.
3. Set the customer management screen to Original Screen.
4. Create `classes/app/customers_original_management/`.
5. Implement list/search/add/edit/delete/detail using existing Original Screen patterns.
6. Use helper APIs such as `fields_form_original`, `fields_form_direct`, and `fields_view_direct`.
7. Keep validation errors as `res_error_message()` followed by immediate `return`.

### Stage 2: Seed Data

1. Check existing customer rows.
2. Add the fixed seed data only if the table is empty.
3. Verify with `data_list`.

### Stage 3: CSV

1. Read `fbp-csv-media`.
2. Create `classes/app/customers_csv/`.
3. Add CSV export and import using the fixed CSV columns.
4. Add clear buttons or links from the customer management screen.
5. Verify export with `app_call` and an `output_file`.
6. Verify import with `app_call` using `files`, then confirm with `data_list`.

### Stage 4: PDF

1. Read `fbp-pdf`.
2. Create `classes/app/customers_pdf/`.
3. Add list PDF and detail PDF using the fixed PDF output.
4. Add PDF download links from the customer management screen.
5. Verify with `app_call` and an `output_file`.

### Stage 5: Verification Summary

Run or provide the equivalent checks:

```bash
php fbp/cli.php app_call --json='{"class":"customers_original_management","function":"run"}'
php fbp/cli.php data_list --json='{"table":"customers","max":20}'
php fbp/cli.php app_call --json='{"class":"customers_csv","function":"download","output_file":"/tmp/customers.csv"}'
php fbp/cli.php app_call --json='{"class":"customers_pdf","function":"list_pdf","output_file":"/tmp/customers.pdf"}'
```

If a check fails, fix that stage before moving to the next one.

## Constraints

- Keep the first demo predictable; do not add custom fields unless explicitly requested.
- Do not use direct URL string concatenation; use `$ctl->get_APP_URL()`.
- Do not redraw dialogs on validation errors.
- Do not use `ajax-link` for downloadable CSV/PDF responses.
- Do not introduce external services or database servers for the default demo.
- Prefer small, readable sample code over generalized abstractions.
