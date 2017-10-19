require 'json'
require 'dsl'
require 'net/http'
require 'uri'
require 'mime/types'


namespace :televate do
  desc "Testing API"
  namespace :api do
    desc "Testing API"
    task :upload => :environment do    
      #puts "Made #{cups} cups of coffee. Shakes are gone."
      #cellinfo='[{"mCellIdentityLte":{"mCi":12529157,"mMcc":310,"mMnc":260,"mPci":375,"mTac":20241},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-117,"mRsrq":-13,"mRssnr":2147483647,"mSignalStrength":12,"mTimingAdvance":2147483647},"mRegistered":true,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPci":350,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-127,"mRsrq":-18,"mRssnr":2147483647,"mSignalStrength":7,"mTimingAdvance":2147483647},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPci":0,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":0,"mRsrq":0,"mRssnr":2147483647,"mSignalStrength":31,"mTimingAdvance":2147483647},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPci":288,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-123,"mRsrq":-13,"mRssnr":2147483647,"mSignalStrength":6,"mTimingAdvance":2147483647},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPci":340,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-120,"mRsrq":-10,"mRssnr":2147483647,"mSignalStrength":7,"mTimingAdvance":2147483647},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPci":0,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":0,"mRsrq":0,"mRssnr":2147483647,"mSignalStrength":31,"mTimingAdvance":2147483647},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityWcdma":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPsc":179},"mCellSignalStrengthWcdma":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityWcdma":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPsc":455},"mCellSignalStrengthWcdma":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3}]'
      device_id="1234"
      line1number="1234"
      cellinfo='{[{"mCellIdentityCdma":{"mBasestationId":8858,"mLatitude":562693,"mLongitude":-1115525,"mNetworkId":2,"mSystemId":22435},"mCellSignalStrengthCdma":{"mCdmaDbm":-89,"mCdmaEcio":-70,"mEvdoDbm":-2147483647,"mEvdoEcio":-2147483647,"mEvdoSnr":2147483647},"mRegistered":true,"mTimeStamp":47605396935995,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":50365467,"mMcc":310,"mMnc":120,"mPci":449,"mTac":6148},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-118,"mRsrq":-16,"mRssnr":2147483647,"mSignalStrength":14,"mTimingAdvance":2147483647},"mRegistered":true,"mTimeStamp":47605396935995,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPci":1,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-120,"mRsrq":-15,"mRssnr":2147483647,"mSignalStrength":9,"mTimingAdvance":2147483647},"mRegistered":false,"mTimeStamp":47605396935995,"mTimeStampType":3}]}'
      location='{"mAccuracy":46,"mAltitude":42,"mBearing":0,"mDistance":0,"mElapsedRealtimeNanos":517112701732695,"mExtras":{"mAllowFds":true,"mFdsKnown":true,"mHasFds":false,"mParcelledData":{"mNativePtr":-1193534592,"mNativeSize":0,"mOwnsNativeParcelObject":true}},"mHasAccuracy":true,"mHasAltitude":true,"mHasBearing":false,"mHasSpeed":true,"mInitialBearing":0,"mIsFromMockProvider":false,"mLat1":0,"mLat2":0,"mLatitude":39.06508509,"mLon1":0,"mLon2":0,"mLongitude":-77.4447808,"mProvider":"gps","mResults":[0,0],"mSpeed":0,"mTime":1507934558000}
'
      
      uri = URI.parse('http://ec2-54-213-12-229.us-west-2.compute.amazonaws.com:80/api/v1/upload')
      #port = 80
      #service = 'api/v1/upload'
      #params = "device_id=#{device_id} line1number=#{line1number} cellinfo={#{cellinfo}}"
  

      # Create the HTTP objects
      # Shortcut
      #response = Net::HTTP.post_form(uri, {"device_id" => "#{device_id}", "line1number" => "#{line1number}"})
      
     
      # Full control
      http = Net::HTTP.new(uri.host, uri.port)
      
      request = Net::HTTP::Post.new(uri.request_uri)
      #request.set_form_data({"device_id" => "#{device_id}", "line1number" => "#{line1number}", "cellinfo"=>"#{cellinfo}}", "location"=>"#{location}}"})
      request.set_form_data({"device_id" => "1234", "line1number" => "", "cellinfo"=>"#{cellinfo}", "location"=>"#{location}"})
      
      response = http.request(request)
      if response.code == 200
        puts "Posted Success ..."
      else
        response.body
      end
    end
  end
end
