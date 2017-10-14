require "rails_helper"  
RSpec.describe API::V1::UploadController, :type => :controller  do
  render_views
  
  describe "POST #create" do
         
    let(:cellSignalStengthLte) {{mCqi:2147483647,mRsrp:-117,mRsrq:-13,mRssnr:2147483647,mSignalStrength:12,mTimingAdvance:2147483647}}
    let(:cellIdentityLte) {{mCi:12529157,mMcc:310,mMnc:260,mPci:375,mTac:20241}}
    let(:cell_info) {[{mCellIdentityLte: cellIdentityLte, mCellSignalStrengthLte: cellSignalStengthLte}]}
    let(:device_id) {1}
  
    subject { cellinfo }
    subject { device_id }
    it "should return an error if there is no cell info but there is a device_id" do
      json = { :format => 'json'}
      post :create, params: json  
       
      expect(Cell.count).to eq 0
    end
    
    it "should create a Cell with an device_id and cell info" do
      json = { :format => 'json', :device_id => device_id, :cellinfo=>cell_info.to_json}
      post :create, params: json  
       
      expect(Cell.count).to eq 1
    end
   end
 
  describe "update existing cell" do
    let(:cellSignalStengthLte) {{mCqi:2147483647,mRsrp:-117,mRsrq:-13,mRssnr:2147483647,mSignalStrength:12,mTimingAdvance:2147483647}}
    let(:cellIdentityLte) {{mCi:12529157,mMcc:310,mMnc:260,mPci:375,mTac:20241}}
    let(:cell_info) {[{mCellIdentityLte: cellIdentityLte, mCellSignalStrengthLte: cellSignalStengthLte}]}
    let(:device_id) {1}
    
    let(:json){{:format => 'json', :device_id => device_id, :cellinfo=>cell_info.to_json}}    
    let(:c) {Cell.last}
    subject { cellinfo }
    subject { device_id }
    subject {json}
    subject {c}
  
    it "should update eisting cell metric by 1 and 2" do 
      post :create, params: json 
      expect(c.metrics.count).to eq 1
    
      post :create, params: json  
      expect(c.metrics.count).to eq 2
    end
  end
end
 