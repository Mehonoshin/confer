module LogsHelper
  AUDIT_ACTIONS = {
    "last_sign_in_at" => "sign_in",
    "phone" => "profile_updated",
    "confirmation_token" => "confirmed",
    "service_admin" => "made_admin",
    "state" => "state_changed"
  }
  def auditable_name(audit)
    if audit.auditable.present?
      link_to auditable_title(audit.auditable), url_for([:admin, audit.auditable])
    else
      t("admin.logs.types.#{audit.auditable_type.downcase}")
    end
  end

  def auditable_title(auditable)
    if auditable.is_a? User
      auditable.email
    elsif auditable.is_a? Conference
      auditable.name
    end
  end

  def audit_actor(audit)
    link_to audit.user.email, admin_user_path(audit.user) if audit.user.present?
  end

  def audit_action(audit)
    action = audit.audited_changes.first[0]
    if AUDIT_ACTIONS[action].present?
      t("admin.logs.actions.#{audit.auditable_type.downcase}.#{AUDIT_ACTIONS[action]}")
    else
      t("admin.logs.actions.#{audit.action}")
    end
  end

end
