module LogsHelper
  def auditable_name(audit)
    if audit.auditable.is_a? User
      audit.auditable.email
    elsif audit.auditable.is_a? Conference
      audit.auditable.name
    end
  end
end
