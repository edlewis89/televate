class CreateCdmaSignalStrength < ActiveRecord::Migration[5.1]
  def change
    create_table :cdma_signal_strengths do |t|
      #t.belongs_to :metric, index: { unique: true }, foreign_key: true
      #{"mCdmaDbm":-89,"mCdmaEcio":-70,"mEvdoDbm":-2147483647,"mEvdoEcio":-2147483647,"mEvdoSnr":2147483647}
      t.integer :mcdmadbm
      t.integer :mcdmaecio
      t.integer :mevdodbm
      t.integer :mevdoecio
      t.integer :mevdosnr
      t.timestamps
      
      
    end
  end
end
