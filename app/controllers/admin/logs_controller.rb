class Admin::LogsController < Admin::BaseController

  def index
    @type = params[:type].present? ? params[:type] : "user"
    @audits = Audited.audit_class.where(auditable_type: @type.capitalize).order("created_at DESC")
  end
end
