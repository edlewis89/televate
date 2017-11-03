class CreateNetworkStates < ActiveRecord::Migration[5.1]
  def change
    create_table :network_states do |t|
      t.string :net

      t.timestamps
    end
  end
end
