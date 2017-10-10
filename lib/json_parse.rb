require 'json'
require_relative 'dsl'


def JSON.parse(source, opts = {})
  r = JSON.parser.new(source, opts).parse
  r = keys_to_symbol(r) if opts[:symbolize_names]
  return r
end

def keys_to_symbol(h)
  new_hash = {}
  h.each do |k,v|
    if v.class == String || v.class == Fixnum || v.class == Float || v.class == TrueClass || v.class == FalseClass
      new_hash[k.to_sym] = v
    elsif v.class == Hash
      new_hash[k.to_sym] = keys_to_symbol(v)
    elsif v.class == Array
      new_hash[k.to_sym] = keys_to_symbol_array(v)
    else
      raise ArgumentError, "Type not supported: #{v.class}"
    end
  end
  return new_hash
end

def keys_to_symbol_array(array)
  new_array = []
  array.each do |i|
    if i.class == Hash
      new_array << keys_to_symbol(i)
    elsif i.class == Array
      new_array << keys_to_symbol_array(i)
    else
      new_array << i
    end
  end
  return new_array
end



cellinfo='
[{"mCellIdentityLte":{"mCi":12529157,"mMcc":310,"mMnc":260,"mPci":375,"mTac":20241},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-117,"mRsrq":-13,"mRssnr":2147483647,"mSignalStrength":12,"mTimingAdvance":2147483647},"mRegistered":true,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPci":350,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-127,"mRsrq":-18,"mRssnr":2147483647,"mSignalStrength":7,"mTimingAdvance":2147483647},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPci":0,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":0,"mRsrq":0,"mRssnr":2147483647,"mSignalStrength":31,"mTimingAdvance":2147483647},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPci":288,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-123,"mRsrq":-13,"mRssnr":2147483647,"mSignalStrength":6,"mTimingAdvance":2147483647},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPci":340,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":-120,"mRsrq":-10,"mRssnr":2147483647,"mSignalStrength":7,"mTimingAdvance":2147483647},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityLte":{"mCi":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPci":0,"mTac":2147483647},"mCellSignalStrengthLte":{"mCqi":2147483647,"mRsrp":0,"mRsrq":0,"mRssnr":2147483647,"mSignalStrength":31,"mTimingAdvance":2147483647},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityGsm":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647},"mCellSignalStrengthGsm":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityWcdma":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPsc":179},"mCellSignalStrengthWcdma":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3},{"mCellIdentityWcdma":{"mCid":2147483647,"mLac":2147483647,"mMcc":2147483647,"mMnc":2147483647,"mPsc":455},"mCellSignalStrengthWcdma":{"mBitErrorRate":99,"mSignalStrength":0},"mRegistered":false,"mTimeStamp":88154959123033,"mTimeStampType":3}]'

Location='{"mAccuracy":4,"mAltitude":50,"mBearing":285,"mDistance":0,"mElapsedRealtimeNanos":297913762103831,"mExtras":{"mAllowFds":true,"mFdsKnown":true,"mHasFds":false,"mParcelledData":{"mNativePtr":-1205643840,"mNativeSize":0,"mOwnsNativeParcelObject":true}},"mHasAccuracy":true,"mHasAltitude":true,"mHasBearing":true,"mHasSpeed":true,"mInitialBearing":0,"mIsFromMockProvider":false,"mLat1":0,"mLat2":0,"mLatitude":39.0649336,"mLon1":0,"mLon2":0,"mLongitude":-77.44504723,"mProvider":"gps","mResults":[0,0],"mSpeed":3.56,"mTime":1507240624000}'


class CellInfoParser
  
  attr_accessor :results, :keys, :parsed
  
  def initialize(source, opts={})
    
    @parsed = JSON.parser.new(source, opts).parse
    #r = keys_to_symbol(r) if opts[:symbolize_names]
    @results = {}
    @results["device_id"] = @parsed["_id"]
    @results["revision"] = @parsed["_rev"]
    @results["cellinfo"] = {}
    json_to_cellinfo(@parsed)
    
  end
  
  def json_to_cellinfo(h, type = nil)
    #puts h["cellInfo"].size
    #new_hash = {}
    h.each do |k,v|
      if v.class == String || v.class == Fixnum || v.class == Float || v.class == TrueClass || v.class == FalseClass
        #puts "data found #{k} #{v}"
        if type
          #puts type
          #puts k
          #puts v
          
          @results["cellinfo"]["#{type}"][k] = v
        end
        
      elsif v.class == Hash
        #puts "Hash #{k} #{v}"
        json_to_cellinfo(v)
      elsif v.class == Array
        #puts "Array #{v}" 
        extract_array_data(v) 
        #@results["cellinfo"][k] = 
      end
    end
    # if v.class == String || v.class == Fixnum || v.class == Float || v.class == TrueClass || v.class == FalseClass
      # # if v.class == String && v.downcase.match(/_id/)
          # # #puts h
# #   
        # # new_hash["device_id"] = v
      # # else
      # unless k.downcase.match(/_id/) || k.downcase.match(/_rev/)
        # new_hash[k] = v
      # end
#         
      # # end
#       
#       
    # elsif v.class == Hash
      # json_to_cellinfo(v)
    # elsif v.class == Array
      # new_hash[k] = keys_to_symbol_array(v)
    # else
      # raise ArgumentError, "Type not supported: #{v.class}"
    # end
  # end
  #return new_hash
end

def extract_array_data(array)
  #new_hash = {}
  array.each do |items|
    items.each do |item|
      if item.class == Hash
        item.each do |k, v|
          if k.downcase.match(/gsm/)
            #if v.class == String || v.class == Fixnum || v.class == Float || v.class == TrueClass || v.class == FalseClass
              
            if v.class == Hash
              @results["cellinfo"]["gsm"] = {}
              json_to_cellinfo(v, 'gsm')
            else
              puts "Data unknown #{v.class}"
            end
          elsif k.downcase.match(/lte/)
            #if v.class == String || v.class == Fixnum || v.class == Float || v.class == TrueClass || v.class == FalseClass
              #@results["cellinfo"]["lte"][k] = v
            if v.class == Hash
              @results["cellinfo"]["lte"] = {}
              json_to_cellinfo(v, 'lte')
            else
              puts "Data unknown #{v.class}"
            end
          elsif k.downcase.match(/wcdma/)
            #if v.class == String || v.class == Fixnum || v.class == Float || v.class == TrueClass || v.class == FalseClass
            #  @results["cellinfo"]["wcdma"][k] = v
            if v.class == Hash
              @results["cellinfo"]["wcdma"] = {}
              json_to_cellinfo(v, 'wcdma')
            else
              puts "Data unknown #{v.class}"
            end
          end
        
            
        end
      end
    end 
    #i.each do |k,v|
      
      # y.keys.each do |key|
        # if key.downcase.match(/gsm/)
           # y[key].keys.each do |v|
            # puts v.value
#             
          # end
        # end
      # end
    #end
    #json_to_cellinfo(i)
    #if i.class == Hash
    # json_to_cellinfo(i)
    #elsif i.class == Array
    # extract_array_data(i)
    #else
    #  i
    #end
    #return new_hash
  end
  
end
  
  def process_array(a)
    
  end
  
  def process_data(d)
    
  end
  
  def process_hash(h)
    
  end
  
  
  def keys
    
    @parsed["cellInfo"].each do |cell|
      cell.each do |k|
        k.keys.each do |v|
          puts v
        end
      end
      
    end      
  end
  
  def lookup(term, lookup)
    puts @parsed["_id"]
    puts @parsed["_rev"]
    @parsed["cellInfo"].each do |cell|
      cell.each do |info|
        info.keys.each do |k|
          if k.downcase.match(/#{term}/)
            #if k.downcase.match(/#{key}/) 
              #puts "#{type} - #{key}"   
              @results << info[k]        
            #end
          end
        end
      end     
    end 
  end
end


#apts = {}
#opts.merge!({:symbolize_names => false})
#cip = CellInfoParser.new(string, opts)
#puts cip.results


# json_object = JSON.parse(cellinfo, object_class: OpenStruct)
# 
# 
 # for i in 0..json_object.size - 1
  # puts i
  # cellinfo = json_object[i]
  # puts cellinfo.send('mCellIdentityLte')
  # puts cellinfo.send('mCellIdentityGsm')
  # puts cellinfo.send('mCellIdentityWcdma')
  # puts cellinfo.send('mCellIdentityCdma')
#   
  # puts cellinfo.send('mCellSignalStrengthLte')
  # puts cellinfo.send('mCellSignalStrengthGsm')
  # puts cellinfo.send('mCellSignalStrengthWcma')
  # puts cellinfo.send('mCellSignalStrengthCdma')
# end
dsl = CellInfo::Dsl.new('11234', cellinfo)
dsl.extract



