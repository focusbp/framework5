<form id="wizard_table_create_form">
	<p style="font-size:13px;color:#374151;margin:0 0 10px 0;">テーブル新規追加の要件を入力すると、Codex Terminalに投入する実行プロンプトを生成します。</p>

	<div style="display:grid;grid-template-columns:1fr 1fr;gap:10px;">
		<div>
			<p style="font-weight:bold;margin:0 0 4px 0;">対象プロジェクト</p>
			<input type="text" name="project_name" value="{$row.project_name|escape}" style="width:100%;" />
		</div>
		<div>
			<p style="font-weight:bold;margin:0 0 4px 0;">テーブル名 *</p>
			<input type="text" name="table_name" value="{$row.table_name|escape}" placeholder="例: customer_inquiry" style="width:100%;" />
			<p class="error_message error_table_name"></p>
		</div>
	</div>

	<div style="margin-top:10px;">
		<p style="font-weight:bold;margin:0 0 4px 0;">メニュー名</p>
		<input type="text" name="menu_name" value="{$row.menu_name|escape}" placeholder="空の場合はテーブル名を使用" style="width:100%;" />
	</div>

	<div style="margin-top:10px;">
		<p style="font-weight:bold;margin:0 0 4px 0;">用途 * </p>
		<textarea name="purpose" rows="3" style="width:100%;" placeholder="例: 問い合わせ受付情報を管理したい">{$row.purpose|escape}</textarea>
		<p class="error_message error_purpose"></p>
	</div>

	<div style="margin-top:10px;">
		<p style="font-weight:bold;margin:0 0 4px 0;">入力したい項目（1行1項目）</p>
		<p style="margin:0 0 4px 0;font-size:12px;color:#6b7280;">形式例: field_name:type:label</p>
		<textarea name="fields_text" rows="6" style="width:100%;">{$row.fields_text|escape}</textarea>
	</div>

	<div style="display:flex;gap:8px;margin-top:12px;">
		<button type="button" class="ajax-link" invoke-function="build_table_create_prompt" data-form="wizard_table_create_form">実行プロンプトを作成</button>
		<button type="button" class="ajax-link" invoke-function="run">一覧へ戻る</button>
		<button type="button" class="ajax-link" invoke-function="close_dialog">閉じる</button>
	</div>
</form>
