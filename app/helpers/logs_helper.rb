module LogsHelper
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
    t("admin.logs.actions.#{audit.action}")
  end

end
