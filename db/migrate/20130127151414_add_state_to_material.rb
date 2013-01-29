class AddStateToMaterial < ActiveRecord::Migration
  def change
    add_column :materials, :state, :string
  end
end
