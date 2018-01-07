class AddMproviderToLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :mprovider, :string
  end
end
