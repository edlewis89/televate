class CreatePings < ActiveRecord::Migration[5.1]
  def change
    create_table :pings do |t|
      #t.belongs_to :metric, index: { unique: true }, foreign_key: true
      #t.belongs_to :metric, index: { unique: true }, foreign_key: true
      
      t.belongs_to :metric, foreign_key: true, index: { unique: true } 
      t.integer :ping_avg
      t.integer :ping_max
      t.integer :ping_min
      t.integer :ttl
      t.integer :time
      t.string :host
      t.string :net
      t.string :ip
      t.text :output
      t.datetime :ping_start_timestamp
      t.boolean :pinged
      t.decimal :ping_percent_loss, :precision => 2

      t.timestamps
    end
  end
end
