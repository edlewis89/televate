require "rails_helper"  
RSpec.describe API::V1::UploadController, :type => :controller  do
  render_views
  
  describe "POST #create" do
     
     #cdma_cellinfo='[{"mCellIdentityCdma":{"mBasestationId":8858,"mLatitude":562693,"mLongitude":-1115525,"mNetworkId":2,"mSystemId":22435},
     #"mCellSignalStrengthCdma":{"mCdmaDbm":-89,"mCdmaEcio":-70,"mEvdoDbm":-2147483647,"mEvdoEcio":-2147483647,"mEvdoSnr":2147483647},"mRegistered":true,"mTimeStamp":47605396935995,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":50365467,"mMcc":310,"mMnc":120,"mPci":449,"mTac":6148},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-118,"mRsrq":-16,"mRssnr":2147483647,"mSignalStrength":14,"mTimingAdvance":2147483647},"mRegistered":true,"mTimeStamp":47605396935995,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPci":1,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-120,"mRsrq":-15,"mRssnr":2147483647,"mSignalStrength":9,"mTimingAdvance":2147483647},"mRegistered":false,"mTimeStamp":47605396935995,"mTimeStampType":3}]'
    #cdma_location='{"mAccuracy":7,"mAltitude":45,"mBearing":169.2,"mDistance":0,"mElapsedRealtimeNanos":164442471042829,"mExtras":{"mAllowFds":true,"mFdsKnown":true,"mHasFds":false,"mParcelledData":{"mNativePtr":-1212817600,"mNativeSize":0,"mOwnsNativeParcelObject":true}},"mHasAccuracy":true,"mHasAltitude":true,"mHasBearing":true,"mHasSpeed":true,"mInitialBearing":0,"mIsFromMockProvider":false,"mLat1":0,"mLat2":0,"mLatitude":39.06504525,"mLon1":0,"mLon2":0,"mLongitude":-77.44477886,"mProvider":"gps","mResults":[0,0],"mSpeed":0.48,"mTime":1507939329000}'

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
    
    it "should create a Cell with an device_id and cell info" do
      json = { :format => 'json', :device_id => device_id, :line1number=>line1number, :cellinfo=>cell_info.to_json}
      post :create, params: json  
      expect(response.status).to eq(200)
      c = Cell.where(:cell_device_id => '1', :line1number => "7039692078").first
      expect(c).not_to be nil
      expect(c.line1number).to eq '7039692078'
      expect(c.cell_device_id).to eq '1'
    end
   end
 
  describe "update existing cell" do
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
    
  
    it "should update eisting cell metric by 1 and 2" do 
      post :create, params: json        
      post :create, params: json 
      
       
      c = Cell.where(:cell_device_id => '1', :line1number => "7039692078").first
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
    
  
    it "should mregisterd for the te identity" do 
      post :create, params: json 
      #expect(c.cell_device_id).to eq "1234"
      c = Cell.where(:cell_device_id => '1234', :line1number => "7039692078").first
     
      expect(c.metrics.count).to eq 1
      expect(c.metrics[0].lte_identities.count).to eq 1
      expect(c.metrics[0].lte_signal_strengths.count).to eq 1
      expect(c.metrics[0].gsm_identities.count).to eq 1
      expect(c.metrics[0].gsm_signal_strengths.count).to eq 1
      expect(c.metrics[0].gsm_identities[0].mregistered).to eq false
      expect(c.metrics[0].lte_identities[0].mregistered).to eq true
      
    end
  end
  describe "Creates new Cell if not found" do
  it "creates a new cell if id is not found"# do
  #    get :student, id: 10 , format: :json
  #    parsed_response = JSON.parse(response.body)
  ##    expect(parsed_response['error']).to eq("Student does not exist")
  #    expect(response).to be_not_found
  #  end
  end
  
  
end
 