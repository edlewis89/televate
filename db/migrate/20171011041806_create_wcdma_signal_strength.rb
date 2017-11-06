class CreateWcdmaSignalStrength < ActiveRecord::Migration[5.1]
  def change
    create_table :wcdma_signal_strengths do |t|
      #t.belongs_to :metric, index: { unique: true }, foreign_key: true
      t.integer :mbiterrorrate
      t.integer :msignalstrength, :limit => 8
      t.timestamps
    end
  end
end
