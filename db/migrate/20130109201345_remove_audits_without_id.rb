class RemoveAuditsWithoutId < ActiveRecord::Migration
  def up
    Audited.audit_class.where(user_id: nil).destroy_all
  end

  def down
  end
end
