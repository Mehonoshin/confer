class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string :file
      t.string :name
      t.integer :report_id

      t.timestamps
    end
  end
end
