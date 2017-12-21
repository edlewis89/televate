class CreateLteIdentity < ActiveRecord::Migration[5.1]
  def change
    create_table :lte_identities do |t|
      #t.belongs_to :metric, index: { unique: true }, foreign_key: true
      t.integer :mci
      t.integer :mmcc
      t.integer :mmnc
      t.integer :mpci
      t.integer :mtac
      t.integer :mearfcn
      t.boolean :mregistered
      t.integer :mcqi
      t.integer :mrsrp
      t.integer :mrsrqc
      t.integer :mrssnr
      t.integer :mrsrq
      t.integer :msignalstrength, :limit => 8
      t.integer :mtimingadvance, :limit => 8      
      t.datetime :mtimestamp
     
     [{"mCellIdentityLte":{"mCi":30025238,"mEarfcn":0,"mMcc":311,"mMnc":480,"mPci":271,"mTac":29952},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-90,"mRsrq":-9,"mRssnr":2147483647,"mSignalStrength":26,"mTimingAdvance":4},"mRegistered":true,"mTimeStamp":183467365739448,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mEarfcn":0,"mMcc":2147483647,"mMnc":2147483647,"mPci":195,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-96,"mRsrq":-13,"mRssnr":2147483647,"mSignalStrength":20,"mTimingAdvance":4},"mRegistered":false,"mTimeStamp":183467365739448,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mEarfcn":0,"mMcc":2147483647,"mMnc":2147483647,"mPci":107,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-103,"mRsrq":-19,"mRssnr":2147483647,"mSignalStrength":20,"mTimingAdvance":4},"mRegistered":false,"mTimeStamp":183467365739448,"mTimeStampType":3}]

     
      t.timestamps
    end
  end
end
