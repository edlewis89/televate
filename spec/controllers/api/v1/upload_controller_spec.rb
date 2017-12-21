require "rails_helper"  
RSpec.describe API::V1::UploadController, :type => :controller  do
  render_views
  
  describe "POST #create" do
     
    #cdma_cellinfo='[{"mCellIdentityCdma":{"mBasestationId":8858,"mLatitude":562693,"mLongitude":-1115525,"mNetworkId":2,"mSystemId":22435},
    #"mCellSignalStrengthCdma":{"mCdmaDbm":-89,"mCdmaEcio":-70,"mEvdoDbm":-2147483647,"mEvdoEcio":-2147483647,"mEvdoSnr":2147483647},"mRegistered":true,"mTimeStamp":47605396935995,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":50365467,"mMcc":310,"mMnc":120,"mPci":449,"mTac":6148},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-118,"mRsrq":-16,"mRssnr":2147483647,"mSignalStrength":14,"mTimingAdvance":2147483647},"mRegistered":true,"mTimeStamp":47605396935995,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPci":1,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-120,"mRsrq":-15,"mRssnr":2147483647,"mSignalStrength":9,"mTimingAdvance":2147483647},"mRegistered":false,"mTimeStamp":47605396935995,"mTimeStampType":3}]'
    #cdma_location='{"mAccuracy":7,"mAltitude":45,"mBearing":169.2,"mDistance":0,"mElapsedRealtimeNanos":164442471042829,"mExtras":{"mAllowFds":true,"mFdsKnown":true,"mHasFds":false,"mParcelledData":{"mNativePtr":-1212817600,"mNativeSize":0,"mOwnsNativeParcelObject":true}},"mHasAccuracy":true,"mHasAltitude":true,"mHasBearing":true,"mHasSpeed":true,"mInitialBearing":0,"mIsFromMockProvider":false,"mLat1":0,"mLat2":0,"mLatitude":39.06504525,"mLon1":0,"mLon2":0,"mLongitude":-77.44477886,"mProvider":"gps","mResults":[0,0],"mSpeed":0.48,"mTime":1507939329000}'

    let(:network_state){{network_type:"MOBILE",system_timestamp_millis:1510064393899}}
    let(:report){{report_type:"Report",event_type:"Event", drive_mode:"Auto"}}
  
    let(:cellSignalStrengthCdma) {{mCdmaDbm:2147483647,mCdmaEcio:-117,mEvdoDbm:-13,mEvdoEcio:2147483647,mEvdoSnr:12}}
    let(:cellIdentityCdma) {{mBasestationId:12529157,mLatitude:310,mLongitude:260,mNetworkId:375,mSystemId:20241}}
    let(:cellSignalStengthLte) {{mCqi:2147483647,mRsrp:-117,mRsrq:-13,mRssnr:2147483647,mSignalStrength:12,mTimingAdvance:2147483647}}
    let(:cellIdentityLte) {{mCi:12529157,mMcc:310,mMnc:260,mPci:375,mTac:20241}}
    let(:cell_info) {[{mCellIdentityLte: cellIdentityLte, mCellSignalStrengthLte: cellSignalStengthLte, mCellIdentityCdma: cellIdentityCdma, mCellSignalStrengthCdma: cellSignalStrengthCdma}]}
    let(:device_id) {'1'}
   
    let(:line1number) {'7039692078'}
   
    subject { cellinfo }
    subject { device_id }
    it "should return an error if there is no cell info but there is a device_id" do
      json = { :format => 'json',:device_id => device_id}
      post :create, params: json  
      
      expect(response.status).to eq(422)
      expect(Cell.count).to eq 0
    end
 
  
    it "should return an error if there is no cell info and no device_id" do
      json = { :format => 'json'}
      post :create, params: json  
      
      expect(response.status).to eq(422)
      expect(Cell.count).to eq 0
    end
    
    it "should create a Cell with a device_id. line1number and cell info" do
      json = {  :device_id => device_id, :line1number=>line1number, :cellinfo=>cell_info.to_json, :format => 'json'}
      post :create, params: json  
      expect(response.status).to eq(200)
      c = Cell.where(:cell_device_id => '1', :line1number => "7039692078").first
      expect(c).not_to be nil
      expect(c.line1number).to eq '7039692078'
      expect(c.cell_device_id).to eq '1'
    end
    it "should create a Cell with only a device_id and cell info" do
      json = {  :device_id => device_id, :line1number=>"", :cellinfo=>cell_info.to_json, :format => 'json'}
      post :create, params: json  
      expect(response.status).to eq(200)
      c = Cell.where(:cell_device_id => '1', :line1number => nil).first
      expect(c).not_to be nil
      expect(c.line1number).to eq nil
      expect(c.cell_device_id).to eq '1'
    end
  end
 
  describe "update existing cell" do
    let(:report){{report_type:"Report",event_type:"Event", drive_mode:"Auto"}}
    let(:network_state){{network_type:"MOBILE",system_timestamp_millis:1510064393899}}
    let(:cellSignalStrengthCdma) {{mCdmaDbm:2147483647,mCdmaEcio:-117,mEvdoDbm:-13,mEvdoEcio:2147483647,mEvdoSnr:12}}
    let(:cellIdentityCdma) {{mBasestationId:12529157,mLatitude:310,mLongitude:260,mNetworkId:375,mSystemId:20241}}
    let(:cellSignalStengthLte) {{mCqi:2147483647,mRsrp:-117,mRsrq:-13,mRssnr:2147483647,mSignalStrength:12,mTimingAdvance:2147483647}}
    let(:cellIdentityLte) {{mCi:12529157,mMcc:310,mMnc:260,mPci:375,mTac:20241}}
    let(:cell_info) {[{mCellIdentityLte: cellIdentityLte, mCellSignalStrengthLte: cellSignalStengthLte, mCellIdentityCdma: cellIdentityCdma, mCellSignalStrengthCdma: cellSignalStrengthCdma}]}
    
    let(:device_id) {'1'}
    let(:line1number) {'7039692078'}
    let(:json){{:format => 'json', :device_id => device_id, :line1number=>line1number, :cellinfo=>cell_info.to_json}}    
   
    subject { cellinfo }
    subject { device_id }
    subject {json}
    
  
    it "should update existing cell metric by 1 and 2" do 
      post :create, params: json        
      post :create, params: json 
      
       
      c = Cell.where(:cell_device_id => '1', :line1number => "7039692078").first
      expect(c.metrics.count).to eq 2
      expect(c.metrics[1].lte_identities.count).to eq 1
    end
    
    it "should update existing cell when no line1number present" do 
     
      
      post :create, params: json.reject{ |k| k.to_sym == :line1number }        
      post :create, params: json.reject{ |k| k.to_sym == :line1number } 
      
       
      c = Cell.where(:cell_device_id => '1', :line1number => nil).first
      expect(c.metrics.count).to eq 2
      expect(c.metrics[1].lte_identities.count).to eq 1
    end
  end
  
  describe "parsing mregistered" do
    let(:cell_hash){
      
      [{
       
        mCellIdentityLte:{mCi:13560323,mMcc:310,mMnc:260,mPci:340,mTac:20241},
        mCellSignalStrengthLte:{mCqi:2147483647,mRsrp:-122,mRsrq:-15,mRssnr:2147483647,mSignalStrength:13,mTimingAdvance:2147483647},
        mRegistered:true,
        mTimeStamp:142910044198654,
        mTimeStampType:3
     },
     {
     
        mCellIdentityGsm:{mCid:2147483647,mLac:2147483647,mMcc:2147483647,mMnc:2147483647},
        mCellSignalStrengthGsm:{mBitErrorRate:99,mSignalStrength:0},
        mRegistered:false,
        mTimeStamp:142910044198654,
        mTimeStampType:3
     }]
     
     }
      #{
        #mCellIdentityGsm:{mCid:2147483647,mLac:2147483647,mMcc:2147483647,mMnc:2147483647},mCellSignalStrengthGsm:{mBitErrorRate:99,mSignalStrength:0},mRegistered:false,mTimeStamp:142910044198654,mTimeStampType:3},{mCellIdentityGsm:{mCid:2147483647,mLac:2147483647,mMcc:2147483647,mMnc:2147483647},mCellSignalStrengthGsm:{mBitErrorRate:99,mSignalStrength:0},mRegistered:false,mTimeStamp:142910044198654,mTimeStampType:3},{mCellIdentityGsm:{mCid:2147483647,mLac:2147483647,mMcc:2147483647,mMnc:2147483647},mCellSignalStrengthGsm:{mBitErrorRate:99,mSignalStrength:0},mRegistered:false,mTimeStamp:142910044198654,mTimeStampType:3},{mCellIdentityGsm:{mCid:2147483647,mLac:2147483647,mMcc:2147483647,mMnc:2147483647},mCellSignalStrengthGsm:{mBitErrorRate:99,mSignalStrength:0},mRegistered:false,mTimeStamp:142910044198654,mTimeStampType:3},{mCellIdentityGsm:{mCid:2147483647,mLac:2147483647,mMcc:2147483647,mMnc:2147483647},mCellSignalStrengthGsm:{mBitErrorRate:99,mSignalStrength:0},mRegistered:false,mTimeStamp:142910044198654,mTimeStampType:3},{mCellIdentityGsm:{mCid:2147483647,mLac:2147483647,mMcc:2147483647,mMnc:2147483647},mCellSignalStrengthGsm:{mBitErrorRate:99,mSignalStrength:0},mRegistered:false,mTimeStamp:142910044198654,mTimeStampType:3},{mCellIdentityGsm:{mCid:2147483647,mLac:2147483647,mMcc:2147483647,mMnc:2147483647},mCellSignalStrengthGsm:{mBitErrorRate:99,mSignalStrength:0},mRegistered:false,mTimeStamp:142910044198654,mTimeStampType:3},{mCellIdentityGsm:{mCid:2147483647,mLac:2147483647,mMcc:2147483647,mMnc:2147483647},mCellSignalStrengthGsm:{mBitErrorRate:99,mSignalStrength:0},mRegistered:false,mTimeStamp:142910044198654,mTimeStampType:3},{mCellIdentityGsm:{mCid:2147483647,mLac:2147483647,mMcc:2147483647,mMnc:2147483647},mCellSignalStrengthGsm:{mBitErrorRate:99,mSignalStrength:0},mRegistered:false,mTimeStamp:142910044198654,mTimeStampType:3},{mCellIdentityWcdma:{mCid:2147483647,mLac:2147483647,mMcc:2147483647,mMnc:2147483647,mPsc:179},mCellSignalStrengthWcdma:{mBitErrorRate:99,mSignalStrength:7},mRegistered:false,mTimeStamp:142910044198654,mTimeStampType:3},{mCellIdentityWcdma:{mCid:2147483647,mLac:2147483647,mMcc:2147483647,mMnc:2147483647,mPsc:152},mCellSignalStrengthWcdma:{mBitErrorRate:99,mSignalStrength:3},mRegistered:false,mTimeStamp:142910044198654,mTimeStampType:3},{mCellIdentityWcdma:{mCid:2147483647,mLac:2147483647,mMcc:2147483647,mMnc:2147483647,mPsc:455},mCellSignalStrengthWcdma:{mBitErrorRate:99,mSignalStrength:4},mRegistered:false,mTimeStamp:142910044198654,mTimeStampType:3}}
    let(:cell_info){cell_hash}    
    let(:device_id){"1234"}
    let(:line1number) {'7039692078'}
    let(:json){{:format => 'json', :device_id => device_id, :line1number=>line1number, :cellinfo=>cell_info.to_json}}    
    
  
    it "should mregisterd for the lte identity" do 
      post :create, params: json 
      #expect(c.cell_device_id).to eq "1234"
      c = Cell.where(:cell_device_id => '1234', :line1number => "7039692078").first
     
      expect(c.metrics.count).to eq 1
      expect(c.metrics[0].lte_identities.count).to eq 1
      #expect(c.metrics[0].lte_signal_strengths.count).to eq 1
      expect(c.metrics[0].gsm_identities.count).to eq 1
      #expect(c.metrics[0].gsm_signal_strengths.count).to eq 1
      expect(c.metrics[0].gsm_identities[0].mregistered).to eq false
      expect(c.metrics[0].lte_identities[0].mregistered).to eq true
      
    end
  end
  describe "update raw ping data " do
    
    let(:report){{report_type:"Report",event_type:"Event", drive_mode:"Auto"}}
    let(:network_state){{network_type:"MOBILE",system_timestamp_millis:1510064393899}}
    let(:cellpinginfo) {{host:"8.8.8.8",net:"MOBILE",output:"PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.\n64 bytes from 8.8.8.8: icmp_seq=1 ttl=54 time=187 ms\n\n--- 8.8.8.8 ping statistics ---\n1 packets transmitted, 1 received, 0% packet loss, time 0ms\nrtt min\/avg\/max\/mdev = 187.489\/187.489\/187.489\/0.000 ms\n",pinged:true}}
    #let(:cellpinginfo) {{host:"",net:"",output:"",pinged:true}}
    let(:location) {{mAccuracy:329.189,mAltitude:133.0,mBearing:0.0,mElapsedRealtimeNanos:96183916307734,mExtras:{mFlags:1537,mParcelledData:{mNativePtr:540096934048,mNativeSize:0,mOwnsNativeParcelObject:true}},mFieldsMask:11,mLatitude:38.91507764,mLongitude:-77.23140876,mProvider:"gps",mSpeed:0.0,mTime:1510064183000}}
    

    let(:cellSignalStrengthCdma) {{mCdmaDbm:2147483647,mCdmaEcio:-117,mEvdoDbm:-13,mEvdoEcio:2147483647,mEvdoSnr:12}}
    let(:cellIdentityCdma) {{mBasestationId:12529157,mLatitude:310,mLongitude:260,mNetworkId:375,mSystemId:20241}}
    let(:cellSignalStengthLte) {{mCqi:2147483647,mRsrp:-117,mRsrq:-13,mRssnr:2147483647,mSignalStrength:12,mTimingAdvance:2147483647}}
    let(:cellIdentityLte) {{mCi:12529157,mMcc:310,mMnc:260,mPci:375,mTac:20241}}
    let(:cell_info) {[{mCellIdentityLte: cellIdentityLte, mCellSignalStrengthLte: cellSignalStengthLte, mCellIdentityCdma: cellIdentityCdma, mCellSignalStrengthCdma: cellSignalStrengthCdma}]}    
    let(:device_id) {'1'}
    let(:line1number) {'7039692078'}
    let(:json){{:format => 'json', :device_id => device_id, :line1number=>line1number, :cellinfo=>cell_info.to_json, :location=>location.to_json, :ping=>cellpinginfo.to_json}}    
   
    subject { cellinfo }
    subject { device_id }
    subject {json}
    
  
    it "should create raw ping info" do 
      post :create, params: json        
      c = Cell.where(:cell_device_id => '1').first
      expect(c.metrics.count).to eq 1
      expect(c.metrics[0].ingested_datum[2].name).to eq "cell_ping"
    end
    
    
  end
  
  describe "update network state data " do
    let(:report){{report_type:"Report",event_type:"Event", drive_mode:"Auto"}}
    let(:network_state){{network_type:"MOBILE",system_timestamp_millis:1510064393899}} 
    let(:location) {{mAccuracy:329.189,mAltitude:133.0,mBearing:0.0,mElapsedRealtimeNanos:96183916307734,mExtras:{mFlags:1537,mParcelledData:{mNativePtr:540096934048,mNativeSize:0,mOwnsNativeParcelObject:true}},mFieldsMask:11,mLatitude:38.91507764,mLongitude:-77.23140876,mProvider:"gps",mSpeed:0.0,mTime:1510064183000}}
     
    let(:cellpinginfo) {{host:"8.8.8.8",net:"MOBILE",output:"PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.\n64 bytes from 8.8.8.8: icmp_seq=1 ttl=54 time=187 ms\n\n--- 8.8.8.8 ping statistics ---\n1 packets transmitted, 1 received, 0% packet loss, time 0ms\nrtt min\/avg\/max\/mdev = 187.489\/187.489\/187.489\/0.000 ms\n",pinged:true}}
    let(:cellSignalStrengthCdma) {{mCdmaDbm:2147483647,mCdmaEcio:-117,mEvdoDbm:-13,mEvdoEcio:2147483647,mEvdoSnr:12}}
    let(:cellIdentityCdma) {{mBasestationId:12529157,mLatitude:310,mLongitude:260,mNetworkId:375,mSystemId:20241}}
    let(:cellSignalStengthLte) {{mCqi:2147483647,mRsrp:-117,mRsrq:-13,mRssnr:2147483647,mSignalStrength:12,mTimingAdvance:2147483647}}
    let(:cellIdentityLte) {{mCi:12529157,mMcc:310,mMnc:260,mPci:375,mTac:20241}}
    let(:cell_info) {[{mCellIdentityLte: cellIdentityLte, mCellSignalStrengthLte: cellSignalStengthLte, mCellIdentityCdma: cellIdentityCdma, mCellSignalStrengthCdma: cellSignalStrengthCdma}]}    
    let(:device_id) {'1'}
    let(:line1number) {'7039692078'}
    let(:json){{:format => 'json', :device_id => device_id, :line1number=>line1number, :cellinfo=>cell_info.to_json, :location=>location.to_json, :ping=>cellpinginfo.to_json, :network_state=>network_state.to_json, :report_type=>report.to_json}}    
   
    #dsl = CellInfo::Dsl.new(conditions[:device_id], conditions[:line1number], conditions[:cellinfo], conditions[:location], conditions[:ping], conditions[:network_state], conditions[:report], conditions[:timestamp])      
      
   
    #subject { cellinfo }
    #subject { device_id }
    #subject {json}
    
  
    it "should create raw ping info" do 
      post :create, params: json        
      c = Cell.where(:cell_device_id => '1').first
      expect(c.metrics.count).to eq 1
      expect(c.metrics[0].ingested_datum[2].name).to eq "cell_ping"
    end
    it "should create 5 ingested datum" do 
      post :create, params: json        
      c = Cell.where(:cell_device_id => '1').first
      expect(c.metrics.count).to eq 1
      expect(c.metrics[0].ingested_datum.count).to eq 5
    end
    
  end
  
  describe "all cell info " do
    
    let(:report){{report_type:"Report",event_type:"Event", drive_mode:"Auto"}}
    let(:network_state){{network_type:"MOBILE",system_timestamp_millis:1510064393899}} 
    let(:location) {{mAccuracy:329.189,mAltitude:133.0,mBearing:0.0,mElapsedRealtimeNanos:96183916307734,mExtras:{mFlags:1537,mParcelledData:{mNativePtr:540096934048,mNativeSize:0,mOwnsNativeParcelObject:true}},mFieldsMask:11,mLatitude:38.91507764,mLongitude:-77.23140876,mProvider:"gps",mSpeed:0.0,mTime:1510064183000}}
     
    let(:cellpinginfo) {{host:"8.8.8.8",net:"MOBILE",output:"PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.\n64 bytes from 8.8.8.8: icmp_seq=1 ttl=54 time=187 ms\n\n--- 8.8.8.8 ping statistics ---\n1 packets transmitted, 1 received, 0% packet loss, time 0ms\nrtt min\/avg\/max\/mdev = 187.489\/187.489\/187.489\/0.000 ms\n",pinged:true}}
    let(:cellSignalStrengthCdma) {{mCdmaDbm:2147483647,mCdmaEcio:-117,mEvdoDbm:-13,mEvdoEcio:2147483647,mEvdoSnr:12}}
    let(:cellIdentityCdma) {{mBasestationId:12529157,mLatitude:310,mLongitude:260,mNetworkId:375,mSystemId:20241}}
    let(:cellSignalStengthLte) {{mCqi:2147483647,mRsrp:-117,mRsrq:-13,mRssnr:2147483647,mSignalStrength:12,mTimingAdvance:2147483647}}
    let(:cellIdentityLte) {{mCi:12529157,mMcc:310,mMnc:260,mPci:375,mTac:20241}}
    let(:cell_info) {[{mCellIdentityLte: cellIdentityLte, mCellSignalStrengthLte: cellSignalStengthLte, mCellIdentityCdma: cellIdentityCdma, mCellSignalStrengthCdma: cellSignalStrengthCdma}]}    
    let(:device_id) {'355300071073642'}
    let(:line1number) {'7039692078'}
    let(:json){{:format => 'json', :device_id => device_id, :line1number=>line1number, :cellinfo=>cell_info.to_json, :location=>location.to_json, :ping=>cellpinginfo.to_json, :network_state=>network_state.to_json, :report_type=>report.to_json}}    
   
   
    subject {json}
    
  
    it "should create a cell with device id = '355300071073642'" do 
      post :create, params: json        
      c = Cell.where(:cell_device_id => '355300071073642').first
      expect(c).not_to be nil
      #expect(c.metrics[0].ping.ping_avg).to eq 29.644
    end
   
  end
  
  describe "add report " do
    
     let(:report){{report_type:"Report",event_type:"Event", drive_mode:"Auto"}}
     let(:cellinfo){[{mCellIdentityLte:{mCi:30025238,mEarfcn:0,mMcc:311,mMnc:480,mPci:271,mTac:29952},mCellSignalStrengthLte:{mCqi:2147483647,mRsrp:-91,mRsrq:-8,mRssnr:2147483647,mSignalStrength:26,mTimingAdvance:4},mRegistered:true,mTimeStamp:52807148360559,mTimeStampType:3}]}     
     let(:ping){{host:"8.8.8.8",net:"MOBILE",output:"PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.\\n64 bytes from 8.8.8.8: icmp_seq=1 ttl=54 time=30.5 ms\\n64 bytes from 8.8.8.8: icmp_seq=2 ttl=54 time=28.7 ms\\n\\n--- 8.8.8.8 ping statistics ---\\n2 packets transmitted, 2 received, 0% packet loss, time 1002ms\\nrtt min/avg/max/mdev \\u003d 28.726/29.644/30.562/0.918 ms\\n",ping_start_timestamp:1510064393916,pinged:true}}     
     let(:network_state){{network_type:"MOBILE",system_timestamp_millis:1510064393899}}
     let(:location) {{mAccuracy:329.189,mAltitude:133.0,mBearing:0.0,mElapsedRealtimeNanos:96183916307734,mExtras:{mFlags:1537,mParcelledData:{mNativePtr:540096934048,mNativeSize:0,mOwnsNativeParcelObject:true}},mFieldsMask:11,mLatitude:38.91507764,mLongitude:-77.23140876,mProvider:"gps",mSpeed:0.0,mTime:1510064183000}}
     let(:line1number){'7034051467'}
     let(:device_id) {'355300071073642'}
    
      
    
   
    let(:json){{:format => 'json', :device_id => device_id, :line1number=>line1number, :location=>location.to_json, :cellinfo=>cellinfo.to_json, :ping=>ping.to_json, :network_state=>network_state.to_json, :report_type=>report.to_json}}    
   
  
    it "should create a report type" do 
      post :create, params: json        
      c = Cell.where(:cell_device_id => '355300071073642').first
      expect(c.metrics.count).to eq 1
      expect(c.metrics[0].report.report_type).to eq "Report"
    end
   
  end
  
  
  describe "add multiple cell infos and we should never get a report that is null" do
    
    let(:report){{report_type:"Report",event_type:"Event", drive_mode:"Auto"}}
    let(:network_state){{network_type:"MOBILE",system_timestamp_millis:1510064393899}} 
    let(:location) {{mAccuracy:329.189,mAltitude:133.0,mBearing:0.0,mElapsedRealtimeNanos:96183916307734,mExtras:{mFlags:1537,mParcelledData:{mNativePtr:540096934048,mNativeSize:0,mOwnsNativeParcelObject:true}},mFieldsMask:11,mLatitude:38.91507764,mLongitude:-77.23140876,mProvider:"gps",mSpeed:0.0,mTime:1510064183000}}
     
    let(:cellpinginfo) {{host:"8.8.8.8",net:"MOBILE",output:"PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.\n64 bytes from 8.8.8.8: icmp_seq=1 ttl=54 time=187 ms\n\n--- 8.8.8.8 ping statistics ---\n1 packets transmitted, 1 received, 0% packet loss, time 0ms\nrtt min\/avg\/max\/mdev = 187.489\/187.489\/187.489\/0.000 ms\n",pinged:true}}
    let(:cellSignalStrengthCdma) {{mCdmaDbm:2147483647,mCdmaEcio:-117,mEvdoDbm:-13,mEvdoEcio:2147483647,mEvdoSnr:12}}
    let(:cellIdentityCdma) {{mBasestationId:12529157,mLatitude:310,mLongitude:260,mNetworkId:375,mSystemId:20241}}
    let(:cellSignalStengthLte) {{mCqi:2147483647,mRsrp:-117,mRsrq:-13,mRssnr:2147483647,mSignalStrength:12,mTimingAdvance:2147483647}}
    let(:cellIdentityLte) {{mCi:12529157,mMcc:310,mMnc:260,mPci:375,mTac:20241}}
    let(:cell_info) {[{mCellIdentityLte: cellIdentityLte, mCellSignalStrengthLte: cellSignalStengthLte, mCellIdentityCdma: cellIdentityCdma, mCellSignalStrengthCdma: cellSignalStrengthCdma}]}    
    let(:device_id) {'355300071073642'}
    let(:line1number) {'7039692078'}
    let(:json){{:format => 'json', :device_id => device_id, :line1number=>line1number, :cellinfo=>cell_info.to_json, :location=>location.to_json, :ping=>cellpinginfo.to_json, :network_state=>network_state.to_json, :report_type=>report.to_json}}    
   
    it "should create a cell with device id = '355300071073642'" do 
      post :create, params: json   
         
      c = Cell.where(:cell_device_id => '355300071073642').first
      expect(c).not_to be nil
      
      post :create, params: json
      post :create, params: json
      post :create, params: json
      post :create, params: json
      post :create, params: json
      post :create, params: json
      post :create, params: json  
      
      c = Cell.where(:cell_device_id => '355300071073642').first
      expect(c).not_to be nil
      expect(c.metrics.count).to eq 8
      expect(c.metrics[0].report_id).not_to be nil
      expect(c.metrics[1].report_id).not_to be nil
      expect(c.metrics[2].report_id).not_to be nil
      expect(c.metrics[3].report_id).not_to be nil
      expect(c.metrics[4].report_id).not_to be nil
      expect(c.metrics[5].report_id).not_to be nil
      expect(c.metrics[6].report_id).not_to be nil
      expect(c.metrics[7].report_id).not_to be nil
      expect(c.metrics[8]).to be nil
      
    end
   
  end
  
  describe "can have event_type of null " do
    
     let(:report){{report_type:"Report",event_type:"", drive_mode:"Auto"}}
     let(:cellinfo){[{mCellIdentityLte:{mCi:30025238,mEarfcn:0,mMcc:311,mMnc:480,mPci:271,mTac:29952},mCellSignalStrengthLte:{mCqi:2147483647,mRsrp:-90,mRsrq:-9,mRssnr:2147483647,mSignalStrength:26,mTimingAdvance:4},mRegistered:true,mTimeStamp:183467365739448,mTimeStampType:3},{mCellIdentityLte:{mCi:2147483647,mEarfcn:0,mMcc:2147483647,mMnc:2147483647,mPci:195,mTac:2147483647},mCellSignalStrengthLte:{mCqi:2147483647,mRsrp:-96,mRsrq:-13,mRssnr:2147483647,mSignalStrength:20,mTimingAdvance:4},mRegistered:false,mTimeStamp:183467365739448,mTimeStampType:3},{mCellIdentityLte:{mCi:2147483647,mEarfcn:0,mMcc:2147483647,mMnc:2147483647,mPci:107,mTac:2147483647},mCellSignalStrengthLte:{mCqi:2147483647,mRsrp:-103,mRsrq:-19,mRssnr:2147483647,mSignalStrength:20,mTimingAdvance:4},mRegistered:false,mTimeStamp:183467365739448,mTimeStampType:3}]}
     let(:ping){{host:"8.8.8.8",net:"MOBILE",output:"PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.\\n64 bytes from 8.8.8.8: icmp_seq=1 ttl=54 time=30.5 ms\\n64 bytes from 8.8.8.8: icmp_seq=2 ttl=54 time=28.7 ms\\n\\n--- 8.8.8.8 ping statistics ---\\n2 packets transmitted, 2 received, 0% packet loss, time 1002ms\\nrtt min/avg/max/mdev \\u003d 28.726/29.644/30.562/0.918 ms\\n",ping_start_timestamp:1510064393916,pinged:true}}     
     let(:network_state){{network_type:"MOBILE",system_timestamp_millis:1510064393899}}
     let(:location) {{mAccuracy:329.189,mAltitude:133.0,mBearing:110.00,mElapsedRealtimeNanos:96183916307734,mExtras:{mFlags:1537,mParcelledData:{mNativePtr:540096934048,mNativeSize:0,mOwnsNativeParcelObject:true}},mFieldsMask:11,mLatitude:38.91507764,mLongitude:-77.23140876,mProvider:"gps",mSpeed:0.0,mTime:1510064183000}}
     let(:line1number){'7034051467'}
     let(:device_id) {'355300071073642'}
    
      
    
   
    let(:json){{:format => 'json', :device_id => device_id, :line1number=>line1number, :location=>location.to_json, :cellinfo=>cellinfo.to_json, :ping=>ping.to_json, :network_state=>network_state.to_json, :report_type=>report.to_json}}    
   
  
    it "should create a report type" do 
      post :create, params: json        
      c = Cell.where(:cell_device_id => '355300071073642').first
      expect(c.metrics.count).to eq 1
      expect(c.metrics[0].report.event_type).to eq ""
    end
   
  end
  
  
  
  
end
 