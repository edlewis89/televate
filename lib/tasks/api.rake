require 'json'
require 'dsl'

namespace :televate do
  desc "Testing API"
  task :api => :environment do    
    #puts "Made #{cups} cups of coffee. Shakes are gone."
    cellinfo='[{"mCellIdentityLte":{"mCi":12529157,"mMcc":310,"mMnc":260,"mPci":375,"mTac":20241},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-117,"mRsrq":-13,"mRssnr":2147483647,"mSignalStrength":12,"mTimingAdvance":2147483647},"mRegistered":true,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPci":350,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-127,"mRsrq":-18,"mRssnr":2147483647,"mSignalStrength":7,"mTimingAdvance":2147483647},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPci":0,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":0,"mRsrq":0,"mRssnr":2147483647,"mSignalStrength":31,"mTimingAdvance":2147483647},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPci":288,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-123,"mRsrq":-13,"mRssnr":2147483647,"mSignalStrength":6,"mTimingAdvance":2147483647},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPci":340,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-120,"mRsrq":-10,"mRssnr":2147483647,"mSignalStrength":7,"mTimingAdvance":2147483647},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPci":0,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":0,"mRsrq":0,"mRssnr":2147483647,"mSignalStrength":31,"mTimingAdvance":2147483647},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityWcdma":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPsc":179},"mCellSignalStrengthWcdma":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityWcdma":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPsc":455},"mCellSignalStrengthWcdma":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3}]'
    location='{"mAccuracy":4,"mAltitude":50,"mBearing":285,"mDistance":0,"mElapsedRealtimeNanos":297913762103831,"mExtras":{"mAllowFds":true,"mFdsKnown":true,"mHasFds":false,"mParcelledData":{"mNativePtr":-1205643840,"mNativeSize":0,"mOwnsNativeParcelObject":true}},"mHasAccuracy":true,"mHasAltitude":true,"mHasBearing":true,"mHasSpeed":true,"mInitialBearing":0,"mIsFromMockProvider":false,"mLat1":0,"mLat2":0,"mLatitude":39.0649336,"mLon1":0,"mLon2":0,"mLongitude":-77.44504723,"mProvider":"gps","mResults":[0,0],"mSpeed":3.56,"mTime":1507240624000}'
    device_id="1234"
    line1number="1234"
    ping={}
    dsl = CellInfo::Dsl.new(device_id, line1number, cellinfo, location, ping)   
    puts "DEVICE ID #{dsl.device_id.nil?} #{dsl.device_id.empty?}" 
    if extract(dsl) 
      puts "success"   
    else
      raise "failed"
    end
  end
  
  def extract(dsl)
    begin
      if dsl.device_id && !dsl.device_id.empty?
        ####################################################
        #  CELL
        #
        ####################################################  
        c = Cell.new({:cell_device_id => dsl.device_id})
        if c.valid?
          c.save
          puts "...Initialized Cell Object #{c.cell_device_id}"
          ####################################################
          #  METRIC
          #
          ####################################################   
          m = Metric.new({:ingest_timestamp => DateTime.now()})
          m.save
          puts "...Initialized Metric Object #{m.ingest_timestamp}"
          
          m.ingested_datum << IngestedDatum.new({:name => 'cell_info', :data => dsl.cell_info_object})
          m.ingested_datum << IngestedDatum.new({:name => 'cell_location', :data => dsl.cell_location_object}) 
          puts "...added raw data #{m.ingested_datum.size}"
          
          ####################################################
          #  PING
          #
          ####################################################         
          ping = Ping.new()
          ingest_ping_hash ={}
          ping_hash = {}
          ping_hash = dsl.cell_ping_object.each_pair.map{|k, v| [k.downcase, v]}.to_h unless dsl.cell_ping_object.nil?
          ingest_ping_hash=ping_hash.select{|k, v| ingest_ping_hash[k.downcase.to_sym]=v if ping.respond_to?k.downcase} unless ping_hash       
          #puts ingest_ping_hash
          m.create_ping(ingest_ping_hash)
          ####################################################
          #  LOCATION
          #
          #################################################### 
          
          puts "...adding location data #{dsl.cell_location_object}" unless dsl.cell_location_object.nil?
          location = Location.new()
          ingest_location_hash ={}
          location_hash={}
          location_hash = dsl.cell_location_object.each_pair.map{|k, v| [k.downcase, v]}.to_h unless dsl.cell_location_object.nil?
          puts "...location parse #{location_hash}" unless location_hash.nil?
          ingest_location_hash = location_hash.select{|k, v| ingest_location_hash[k.downcase]=v if location.respond_to?k.downcase.to_s} unless location_hash.nil? 
          puts "...ingest_location_hash parse #{ingest_location_hash}" unless location_hash.nil?
          location.update_attributes(ingest_location_hash)
          m.location_id = location.id
          puts "...ingest location data"
          ####################################################
          #  CELL INFO
          #
          #################################################### 
          
          dsl.cell_info_object.each do |cell_info|
            #puts cell_info
          
            ####################################################
            #  LTE IDENTITY
            #  
            #################################################### 
            if cell_info.mCellIdentityLte
            lte_identity = LteIdentity.new({:mregistered => cell_info.mRegistered, :mtimestamp => cell_info.mTimeStamp}) 
            ingest_lte_identity_hash ={}            
            ingest_lte_identity_hash = cell_info.mCellIdentityLte.each_pair.map{|k,v| [k.downcase, v] if lte_identity.respond_to?k.downcase.to_s}.to_h       
            lte_identity.update_attributes(ingest_lte_identity_hash) 
            m.lte_identities << lte_identity 
            end
            
            ####################################################
            #  GSM IDENTITY
            #  
            ####################################################
            #puts cell_info.inspect
            if cell_info.mCellIdentityGsm
            gsm_identity = GsmIdentity.new({:mregistered => cell_info.mRegistered, :mtimestamp => cell_info.mTimeStamp}) 
            ingest_gsm_identity_hash ={}            
            ingest_gsm_identity_hash = cell_info.mCellIdentityGsm.each_pair.map{|k,v| [k.downcase, v] if gsm_identity.respond_to?k.downcase.to_s}.to_h           
            gsm_identity.update_attributes(ingest_gsm_identity_hash) 
            m.gsm_identities << gsm_identity 
            end
            
            
            ####################################################
            #  WCDMA IDENTITY
            #  
            ####################################################
            #puts cell_info.inspect
            if cell_info.mCellIdentityWcdma
            wcdma_identity = WcdmaIdentity.new({:mregistered => cell_info.mRegistered, :mtimestamp => cell_info.mTimeStamp}) 
            ingest_wcdma_identity_hash ={}            
            ingest_wcdma_identity_hash = cell_info.mCellIdentityWcdma.each_pair.map{|k,v| [k.downcase, v] if wcdma_identity.respond_to?k.downcase.to_s}.to_h           
            wcdma_identity.update_attributes(ingest_wcdma_identity_hash) 
            m.wcdma_identities << wcdma_identity 
            end
            
            ####################################################
            #  CDMA IDENTITY
            #  
            ####################################################
            #puts cell_info.inspect
            if cell_info.mCellIdentityCdma
            cdma_identity = CdmaIdentity.new({:mregistered => cell_info.mRegistered, :mtimestamp => cell_info.mTimeStamp}) 
            ingest_cdma_identity_hash ={}            
            ingest_cdma_identity_hash = cell_info.mCellIdentityCdma.each_pair.map{|k,v| [k.downcase, v] if cdma_identity.respond_to?k.downcase.to_s}.to_h           
            cdma_identity.update_attributes(ingest_cdma_identity_hash) 
            m.cdma_identities << cdma_identity 
            end
            
            ####################################################
            #  LTE Signal Strength 
            #  
            ####################################################
            puts cell_info.mCellSignalStrengthLte
            if cell_info.mCellSignalStrengthLte
            lte_sig_strength = LteSignalStrength.new({}) 
            lte_sig_strength_hash ={}            
            lte_sig_strength_hash = cell_info.mCellSignalStrengthLte.each_pair.map{|k,v| [k.downcase, v] if lte_sig_strength.respond_to?k.downcase.to_s}.to_h           
            lte_sig_strength.update_attributes(lte_sig_strength_hash) 
            m.lte_signal_strengths << lte_sig_strength 
            end
            
            ####################################################
            #  GSM Signal Strength 
            #  
            ####################################################
            puts cell_info.mCellSignalStrengthGsm
            if cell_info.mCellSignalStrengthGsm
            gsm_sig_strength = GsmSignalStrength.new({}) 
            gsm_sig_strength_hash ={}            
            gsm_sig_strength_hash = cell_info.mCellSignalStrengthGsm.each_pair.map{|k,v| [k.downcase, v] if gsm_sig_strength.respond_to?k.downcase.to_s}.to_h           
            gsm_sig_strength.update_attributes(gsm_sig_strength_hash) 
            m.gsm_signal_strengths << gsm_sig_strength 
            end
            
            ####################################################
            #  WCDMA Signal Strength 
            #  
            ####################################################
            #puts cell_info.inspect
            if cell_info.mCellSignalStrengthWcdma
            wcdma_sig_strength = WcdmaSignalStrength.new({}) 
            wcdma_sig_strength_hash ={}            
            wcdma_sig_strength_hash = cell_info.mCellSignalStrengthWcdma.each_pair.map{|k,v| [k.downcase, v] if wcdma_sig_strength.respond_to?k.downcase.to_s}.to_h           
            wcdma_sig_strength.update_attributes(wcdma_sig_strength_hash) 
            m.wcdma_signal_strengths << wcdma_sig_strength 
            end
            
            ####################################################
            #  CDMA Signal Strength 
            #  
            ####################################################
            #puts cell_info.inspect
            if cell_info.mCellSignalStrengthCdma
            cdma_sig_strength = CdmaSignalStrength.new({}) 
            cdma_sig_strength_hash ={}            
            cdma_sig_strength_hash = cell_info.mCellSignalStrengthCdma.each_pair.map{|k,v| [k.downcase, v] if cdma_sig_strength.respond_to?k.downcase.to_s}.to_h           
            cdma_sig_strength.update_attributes(cdma_sig_strength_hash) 
            m.cdma_signal_strengths << cdma_sig_strength 
            end
            
           
          end #for loop
          c.metrics<<m
          end #c.save          
        else #if valid Cell
          puts "no device_id"        
        end
      rescue StandardError => e
        puts "Error: #{e}"
        return false
      end
  end
end
