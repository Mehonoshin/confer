class AddDomainToConference < ActiveRecord::Migration
  def change
    add_column :conferences, :domain, :string
  end
end
