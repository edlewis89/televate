class CreatePings < ActiveRecord::Migration[5.1]
  def change
    create_table :pings do |t|
      #t.belongs_to :metric, index: { unique: true }, foreign_key: true
      #t.belongs_to :metric, index: { unique: true }, foreign_key: true
      
      t.belongs_to :metric, foreign_key: true, index: { unique: true } 
      t.decimal :ping_avg, :precision => 6, :scale => 3
      t.decimal :ping_max, :precision => 6, :scale => 3
      t.decimal :ping_min, :precision => 6, :scale => 3
      t.decimal :ttl, :precision => 4, :scale => 2
      t.decimal :time, :precision => 4, :scale => 2
      t.string :host
      t.string :net
      t.string :ip
      t.text :output
      t.integer :ping_start_timestamp, :limit => 8
      t.boolean :pinged
      t.decimal :pkt_loss, :precision => 6, :scale=>3

      t.timestamps
    end
  end
end
