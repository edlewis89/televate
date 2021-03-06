require 'json'
require 'dsl'
require 'net/http'
require 'uri'
require 'mime/types'


namespace :televate do
  desc "Testing API"
  namespace :api do
    desc "Testing Remote API"
    task :test_remote => :environment do    
      
      ping='{host:"8.8.8.8",net:"MOBILE",output:"PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.\\n64 bytes from 8.8.8.8: icmp_seq=1 ttl=54 time=30.5 ms=64 bytes from 8.8.8.8: icmp_seq=2 ttl=54 time=28.7 ms\\n\\n--- 8.8.8.8 ping statistics ---\\n2 packets transmitted, 2 received, 0% packet loss, time 1002ms\\nrtt min/avg/max/mdev \\u003d 28.726/29.644/30.562/0.918 ms\\n",ping_start_timestamp:1510064393916,pinged:true}'     
      network_state='{{network_type:"MOBILE",system_timestamp_millis:1510064393899}}'
      report_type='{"drive_mode":"Automatic_Mode","event_type":"","report_type":"Standard_Report"}'
      device_id="1234"
      line1number="1234"
      cellinfo='[{"mCellIdentityLte":{"mCi":29969686,"mEarfcn":0,"mMcc":311,"mMnc":480,"mPci":226,"mTac":29953},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-104,"mRsrq":-8,"mRssnr":2147483647,"mSignalStrength":19,"mTimingAdvance":-1},"mRegistered":true,"mTimeStamp":1614707895472,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mEarfcn":0,"mMcc":2147483647,"mMnc":2147483647,"mPci":227,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-110,"mRsrq":-12,"mRssnr":2147483647,"mSignalStrength":13,"mTimingAdvance":-1},"mRegistered":false,"mTimeStamp":1614707895472,"mTimeStampType":3}]'
     
      location='{"mAccuracy":46,"mAltitude":42,"mBearing":0,"mDistance":0,"mElapsedRealtimeNanos":517112701732695,"mExtras":{"mAllowFds":true,"mFdsKnown":true,"mHasFds":false,"mParcelledData":{"mNativePtr":-1193534592,"mNativeSize":0,"mOwnsNativeParcelObject":true}},"mHasAccuracy":true,"mHasAltitude":true,"mHasBearing":false,"mHasSpeed":true,"mInitialBearing":0,"mIsFromMockProvider":false,"mLat1":0,"mLat2":0,"mLatitude":39.06508509,"mLon1":0,"mLon2":0,"mLongitude":-77.4447808,"mProvider":"gps","mResults":[0,0],"mSpeed":0,"mTime":1507934558000}
'
      remote_uri = URI.parse('http://ec2-54-191-76-41.us-west-2.compute.amazonaws.com/api/v1/upload')
       
    
      # Full control
      http = Net::HTTP.new(remote_uri.host, remote_uri.port)
      
      request = Net::HTTP::Post.new(remote_uri.request_uri)
      request.set_form_data({"device_id" => "1234", "line1number" => "", "cellinfo"=>"#{cellinfo}", "location"=>"#{location}","ping"=>"#{ping}","network_state"=>"#{network_state}", "report_type"=>"#{report_type}"})
      
      response = http.request(request)
      if response.code == 200
        puts "Posted Success ..."
      else
        response.body
      end
    end
    
    desc "Testing Remote API"
    task :test_local => :environment do    
      #puts "Made #{cups} cups of coffee. Shakes are gone."
      #cellinfo='[{"mCellIdentityLte":{"mCi":12529157,"mMcc":310,"mMnc":260,"mPci":375,"mTac":20241},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-117,"mRsrq":-13,"mRssnr":2147483647,"mSignalStrength":12,"mTimingAdvance":2147483647},"mRegistered":true,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPci":350,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-127,"mRsrq":-18,"mRssnr":2147483647,"mSignalStrength":7,"mTimingAdvance":2147483647},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPci":0,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":0,"mRsrq":0,"mRssnr":2147483647,"mSignalStrength":31,"mTimingAdvance":2147483647},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPci":288,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-123,"mRsrq":-13,"mRssnr":2147483647,"mSignalStrength":6,"mTimingAdvance":2147483647},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPci":340,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-120,"mRsrq":-10,"mRssnr":2147483647,"mSignalStrength":7,"mTimingAdvance":2147483647},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPci":0,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":0,"mRsrq":0,"mRssnr":2147483647,"mSignalStrength":31,"mTimingAdvance":2147483647},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityWcdma":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPsc":179},"mCellSignalStrengthWcdma":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityWcdma":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPsc":455},"mCellSignalStrengthWcdma":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3}]'
      
      ping='{host:"8.8.8.8",net:"MOBILE",output:"PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.\\n64 bytes from 8.8.8.8: icmp_seq=1 ttl=54 time=30.5 ms\\n64 bytes from 8.8.8.8: icmp_seq=2 ttl=54 time=28.7 ms\\n\\n--- 8.8.8.8 ping statistics ---\\n2 packets transmitted, 2 received, 0% packet loss, time 1002ms\\nrtt min/avg/max/mdev \\u003d 28.726/29.644/30.562/0.918 ms\\n",ping_start_timestamp:1510064393916,pinged:true}'     
      network_state='{network_type:"MOBILE",system_timestamp_millis:1510064393899}'
      report_type='{"drive_mode":"Automatic_Mode","event_type":"","report_type":"Standard_Report"}'
      device_id="1234"
      line1number="1234"
      #cellinfo='{[{"mCellIdentityCdma":{"mBasestationId":8858,"mLatitude":562693,"mLongitude":-1115525,"mNetworkId":2,"mSystemId":22435},"mCellSignalStrengthCdma":{"mCdmaDbm":-89,"mCdmaEcio":-70,"mEvdoDbm":-2147483647,"mEvdoEcio":-2147483647,"mEvdoSnr":2147483647},"mRegistered":true,"mTimeStamp":47605396935995,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":50365467,"mMcc":310,"mMnc":120,"mPci":449,"mTac":6148},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-118,"mRsrq":-16,"mRssnr":2147483647,"mSignalStrength":14,"mTimingAdvance":2147483647},"mRegistered":true,"mTimeStamp":47605396935995,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPci":1,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-120,"mRsrq":-15,"mRssnr":2147483647,"mSignalStrength":9,"mTimingAdvance":2147483647},"mRegistered":false,"mTimeStamp":47605396935995,"mTimeStampType":3}]}'
      location='{"mAccuracy":46,"mAltitude":42,"mBearing":0,"mDistance":0,"mElapsedRealtimeNanos":517112701732695,"mExtras":{"mAllowFds":true,"mFdsKnown":true,"mHasFds":false,"mParcelledData":{"mNativePtr":-1193534592,"mNativeSize":0,"mOwnsNativeParcelObject":true}},"mHasAccuracy":true,"mHasAltitude":true,"mHasBearing":false,"mHasSpeed":true,"mInitialBearing":0,"mIsFromMockProvider":false,"mLat1":0,"mLat2":0,"mLatitude":39.06508509,"mLon1":0,"mLon2":0,"mLongitude":77.4447808,"mProvider":"gps","mResults":[0,0],"mSpeed":0,"mTime":1507934558000}'
      cellinfo='[{"mCellIdentityLte":{"mCi":29969686,"mEarfcn":0,"mMcc":311,"mMnc":480,"mPci":226,"mTac":29953},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-104,"mRsrq":-8,"mRssnr":2147483647,"mSignalStrength":19,"mTimingAdvance":-1},"mRegistered":true,"mTimeStamp":1614707895472,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mEarfcn":0,"mMcc":2147483647,"mMnc":2147483647,"mPci":227,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-110,"mRsrq":-12,"mRssnr":2147483647,"mSignalStrength":13,"mTimingAdvance":-1},"mRegistered":false,"mTimeStamp":1614707895472,"mTimeStampType":3}]'
      
      #remote_uri = URI.parse('http://ec2-54-191-76-41.us-west-2.compute.amazonaws.com/api/v1/upload')
      local_uri = URI.parse('http://localhost:3000/api/v1/upload') 
     
      # Full control
      http = Net::HTTP.new(local_uri.host, local_uri.port)
      
      request = Net::HTTP::Post.new(local_uri.request_uri)
      #request.set_form_data({"device_id" => "#{device_id}", "line1number" => "#{line1number}", "cellinfo"=>"#{cellinfo}}", "location"=>"#{location}}"})
      request.set_form_data({"device_id" => "1234", "line1number" => "", "cellinfo"=>"#{cellinfo}", "location"=>"#{location}","ping"=>"#{ping}","network_state"=>"#{network_state}", "report_type"=>"#{report_type}"})
      
      response = http.request(request)
      if response.code == 200
        puts "Posted Success ..."
      else
        response.body
      end
    end
    desc "Testing Remote API"
    task :post_null => :environment do    
      #puts "Made #{cups} cups of coffee. Shakes are gone."
      #cellinfo='[{"mCellIdentityLte":{"mCi":12529157,"mMcc":310,"mMnc":260,"mPci":375,"mTac":20241},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-117,"mRsrq":-13,"mRssnr":2147483647,"mSignalStrength":12,"mTimingAdvance":2147483647},"mRegistered":true,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPci":350,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-127,"mRsrq":-18,"mRssnr":2147483647,"mSignalStrength":7,"mTimingAdvance":2147483647},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPci":0,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":0,"mRsrq":0,"mRssnr":2147483647,"mSignalStrength":31,"mTimingAdvance":2147483647},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPci":288,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-123,"mRsrq":-13,"mRssnr":2147483647,"mSignalStrength":6,"mTimingAdvance":2147483647},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPci":340,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-120,"mRsrq":-10,"mRssnr":2147483647,"mSignalStrength":7,"mTimingAdvance":2147483647},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPci":0,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":0,"mRsrq":0,"mRssnr":2147483647,"mSignalStrength":31,"mTimingAdvance":2147483647},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityWcdma":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPsc":179},"mCellSignalStrengthWcdma":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityWcdma":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPsc":455},"mCellSignalStrengthWcdma":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3}]'
     
      ping='{"TEST":""}'     
      network_state='{"network_type":"MOBILE","system_timestamp_millis":1510064393899}'
      report_type='{"drive_mode":"Automatic_Mode","event_type":"NULL","report_type":"Standard_Report"}'
      device_id="1234"
      line1number="1234"
      #cellinfo='{[{"mCellIdentityCdma":{"mBasestationId":8858,"mLatitude":562693,"mLongitude":-1115525,"mNetworkId":2,"mSystemId":22435},"mCellSignalStrengthCdma":{"mCdmaDbm":-89,"mCdmaEcio":-70,"mEvdoDbm":-2147483647,"mEvdoEcio":-2147483647,"mEvdoSnr":2147483647},"mRegistered":true,"mTimeStamp":47605396935995,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":50365467,"mMcc":310,"mMnc":120,"mPci":449,"mTac":6148},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-118,"mRsrq":-16,"mRssnr":2147483647,"mSignalStrength":14,"mTimingAdvance":2147483647},"mRegistered":true,"mTimeStamp":47605396935995,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPci":1,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-120,"mRsrq":-15,"mRssnr":2147483647,"mSignalStrength":9,"mTimingAdvance":2147483647},"mRegistered":false,"mTimeStamp":47605396935995,"mTimeStampType":3}]}'
      location='{"mAccuracy":46,"mAltitude":42,"mBearing":0,"mDistance":0,"mElapsedRealtimeNanos":517112701732695,"mExtras":{"mAllowFds":true,"mFdsKnown":true,"mHasFds":false,"mParcelledData":{"mNativePtr":-1193534592,"mNativeSize":0,"mOwnsNativeParcelObject":true}},"mHasAccuracy":true,"mHasAltitude":true,"mHasBearing":false,"mHasSpeed":true,"mInitialBearing":0,"mIsFromMockProvider":false,"mLat1":0,"mLat2":0,"mLatitude":39.06508509,"mLon1":0,"mLon2":0,"mLongitude":77.4447808,"mProvider":"gps","mResults":[0,0],"mSpeed":0,"mTime":1507934558000}'
      cellinfo='[{"mCellIdentityLte":{"mCi":29969686,"mEarfcn":0,"mMcc":311,"mMnc":480,"mPci":226,"mTac":29953},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-104,"mRsrq":-8,"mRssnr":2147483647,"mSignalStrength":19,"mTimingAdvance":-1},"mRegistered":true,"mTimeStamp":1614707895472,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mEarfcn":0,"mMcc":2147483647,"mMnc":2147483647,"mPci":227,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-110,"mRsrq":-12,"mRssnr":2147483647,"mSignalStrength":13,"mTimingAdvance":-1},"mRegistered":false,"mTimeStamp":1614707895472,"mTimeStampType":3}]'
      
      #remote_uri = URI.parse('http://ec2-54-191-76-41.us-west-2.compute.amazonaws.com/api/v1/upload')
      local_uri = URI.parse('http://localhost:3000/api/v1/upload') 
     
      # Full control
      http = Net::HTTP.new(local_uri.host, local_uri.port)
      
      request = Net::HTTP::Post.new(local_uri.request_uri)
      #request.set_form_data({"device_id" => "#{device_id}", "line1number" => "#{line1number}", "cellinfo"=>"#{cellinfo}}", "location"=>"#{location}}"})
      request.set_form_data({"device_id" => "1234", "line1number" => "", "cellinfo"=>"#{cellinfo}", "location"=>"#{location}","ping"=>"#{ping}","network_state"=>"#{network_state}", "report_type"=>"#{report_type}"})
      
      response = http.request(request)
      if response.code == 200
        puts "Posted Success ..."
      else
        response.body
      end
    end
    
    desc ""
    task :latest => :environment do 
    
      report_type='{"drive_mode":"TestDriveMode","event_type":"","report_type":"Standard Report"}'
      cellinfo='[{"mCellIdentityLte":{"mCi":92055810,"mMcc":313,"mMnc":100,"mPci":133,"mTac":23379},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-110,"mRsrq":-12,"mRssnr":2147483647,"mSignalStrength":18,"mTimingAdvance":2147483647},"mRegistered":true,"mTimeStamp":46191017149010,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPci":53,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-117,"mRsrq":-16,"mRssnr":2147483647,"mSignalStrength":11,"mTimingAdvance":2147483647},"mRegistered":false,"mTimeStamp":46191017149010,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPci":201,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-111,"mRsrq":-11,"mRssnr":2147483647,"mSignalStrength":11,"mTimingAdvance":2147483647},"mRegistered":false,"mTimeStamp":46191017149010,"mTimeStampType":3}]'
      location='{"mAccuracy":9,"mAltitude":264,"mBearing":0,"mDistance":0,"mElapsedRealtimeNanos":78241053258287,"mExtras":{"mAllowFds":true,"mFdsKnown":true,"mHasFds":false,"mParcelledData":{"mNativePtr":-1198028888,"mOwnsNativeParcelObject":true}},"mHasAccuracy":true,"mHasAltitude":true,"mHasBearing":false,"mHasSpeed":true,"mInitialBearing":0,"mIsFromMockProvider":false,"mLat1":0,"mLat2":0,"mLatitude":34.16907969,"mLon1":0,"mLon2":0,"mLongitude":-1188.13232889,"mProvider":"gps","mResults":[0,0],"mSpeed":0,"mTime":1513293334000}'
      network_state='{"network_type":"MOBILE","system_timestamp_millis":1513293334619}'


      ping='{"host":"8.8.8.8","net":"MOBILE","output":"PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.\n64 bytes from 8.8.8.8: icmp_seq=1 ttl=56 time=76.0 ms\n64 bytes from 8.8.8.8: icmp_seq=2 ttl=56 time=74.4 ms\n\n--- 8.8.8.8 ping statistics ---\n2 packets transmitted, 2 received, 0% packet loss, time 1001ms\nrtt min\/avg\/max\/mdev = 74.404\/75.250\/76.097\/0.889 ms\n","ping_start_timestamp":1513293334653,"pinged":true}'
      
      device_id="1234"
      line1number="1234"
      
      remote_uri = URI.parse('http://ec2-54-191-76-41.us-west-2.compute.amazonaws.com/api/v1/upload')
       
    
      # Full control
      http = Net::HTTP.new(remote_uri.host, remote_uri.port)
      
      request = Net::HTTP::Post.new(remote_uri.request_uri)
      request.set_form_data({"device_id" => "#{device_id}", "line1number" => "#{line1number}", "cellinfo"=>"#{cellinfo}", "location"=>"#{location}","ping"=>"#{ping}","network_state"=>"#{network_state}", "report_type"=>"#{report_type}"})
      
      response = http.request(request)
      if response.code == 200
        puts "Posted Success ..."
      else
        response.body
      end
    
    end
  end
end
