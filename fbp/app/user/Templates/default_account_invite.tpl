{t key="user.email.account_invite_greeting" name=$data.name}

{t key="user.email.account_invite_intro"}

{t key="user.login_id"}: {$data.login_id}
{t key="user.email.account_invite_reset_link_label"}:
{$data.reset_url nofilter}

{t key="user.email.account_invite_expires" datetime=$data.reset_expires_at}

{t key="user.email.account_invite_ignore"}

{t key="user.email.account_invite_regards"}
{$setting.system_name}
