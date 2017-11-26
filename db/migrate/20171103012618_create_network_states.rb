class CreateNetworkStates < ActiveRecord::Migration[5.1]
  def change
    create_table :network_states do |t|
      t.string :network_type
      #t.integer :system_timestamp_millis, :limit=>8
      t.datetime :system_timestamp_millis
      t.string :network_state

      t.timestamps
    end
  end
end
