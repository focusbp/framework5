Dear {$data.name},

Your account has been created. Please use the link below to set your password and activate your access.

Login ID: {$data.login_id}
Set Password Link:
{$data.reset_url nofilter}

This link expires on {$data.reset_expires_at}.

If you did not expect this email, please ignore it.

Best Regards,
{$setting.system_name}
