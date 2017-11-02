module ApplicationHelper
  
  def display_collection_table(columns, collection = {})
    
   thead = content_tag :thead do
     content_tag :tr do
      columns.collect {|column|  concat content_tag(:th,column[:display_name])}.join().html_safe
     end
   end
  
   tbody = content_tag :tbody do
    collection.collect { |elem|
      content_tag :tr do
        columns.collect { |column|
            concat content_tag(:td, collection.attributes[column[:name]]) unless collection.nil?
        }.to_s.html_safe
      end
  
    }.join().html_safe
   end
  
   content_tag :table, thead.concat(tbody)
  
  end
  
  
  def display_single_table(columns, collection = {})
    

   thead = content_tag :thead do
     content_tag :tr do
      columns.collect {|column|  concat content_tag(:th,column[:display_name])}.join().html_safe
     end
   end
  
   tbody = content_tag :tbody do
    #collection.collect { |elem|
      content_tag :tr do
        columns.collect { |column|
            concat content_tag(:td, collection.attributes[column[:name]]) unless collection.nil?
        }.to_s.html_safe
      end
  
    #}.join().html_safe
   end
  
   content_tag :table, thead.concat(tbody)
  
  end
  
  
  def display_cell(collection)
    
    
    columns=[]
    columns = [
            { :name => 'cell_device_id', :display_name => 'Device Id' },
            { :name => 'line1number', :display_name => 'Line 1 Number' }
           
            
          ]
   
    display_single_table(columns,collection)
    
   
  end
  
  
  def display_metrics(metrics)
    columns=[]
    columns = [
            { :name => 'id', :display_name => 'Metric Id' }
           
            
          ]
   
    display_single_table(columns,metrics)
  end
  
  def display_location(location)
    
    columns=[]
    columns = [
            { :name => 'id', :display_name => 'Location Id' },
            { :name => 'maccuracy', :display_name => 'Accuracy' },
            { :name => 'maltitude', :display_name => 'Altitude' },
            { :name => 'mdistance', :display_name => 'Distance' },
            { :name => 'mspeed', :display_name => 'Speed' },
            { :name => 'mbearing', :display_name => 'Bearing' },
            { :name => 'mlongitude', :display_name => 'Longitude' },
            { :name => 'mlatitude', :display_name => 'Latitude' }
            
          ]
   
    display_single_table(columns,location)
  end
  
  def display_ping(ping)
    
    
    
    columns=[]
    columns = [
            { :name => 'id', :display_name => 'Ping Id' },
            { :name => 'ping_avg', :display_name => 'Avg' },
            { :name => 'ping_max', :display_name => 'Max' },
            { :name => 'ping_min', :display_name => 'Min' },
            { :name => 'host', :display_name => 'Host' },
            { :name => 'net', :display_name => 'Net' },
            { :name => 'output', :display_name => 'Output' },
            { :name => 'ping_percent_loss', :display_name => 'Percent Loss' }
            
          ]
   
    display_single_table(columns,ping)
  end
  
  def display_lte_identities(collecton)
    
    columns=[]
    columns = [
            { :name => 'mci', :display_name => 'Mci' },
            { :name => 'mmcc', :display_name => 'Mmcc' },
            { :name => 'mmnc', :display_name => 'Mmnc' },
            { :name => 'mpci', :display_name => 'Mpci' },
            { :name => 'mtac', :display_name => 'Mtac' },
            { :name => 'mregistered', :display_name => 'Registered' },
            { :name => 'mtimestamp', :display_name => 'Timestamp' }
           
            
          ]
   
    display_single_table(columns,collecton)
  end
  
  def display_lte_ss(collecton)
    
 
    columns=[]
    columns = [
            { :name => 'mcqi', :display_name => 'Mcqi' },
            { :name => 'mrsrp', :display_name => 'Mrsrp' },
            { :name => 'mrsrqc', :display_name => 'Mrsrqc' },
            { :name => 'mrssnr', :display_name => 'Mrssnr' },
            { :name => 'mrsrq', :display_name => 'Mrsrq' },
            { :name => 'msignalstrength', :display_name => 'SignalStrength' },
            { :name => 'mtimingadvance', :display_name => 'TimingAdvance' }
           
            
          ]
   
    display_single_table(columns,collecton)
  end
  
  
  def display_gsm_identities(collecton)
   
    
    columns=[]
    columns = [
            { :name => 'mcid', :display_name => 'Mcid' },
            { :name => 'mmcc', :display_name => 'Mmcc' },
            { :name => 'mmnc', :display_name => 'Mmnc' },
            { :name => 'mlac', :display_name => 'Mlac' },           
            { :name => 'mregistered', :display_name => 'Registered' },
            { :name => 'mtimestamp', :display_name => 'Timestamp' }
           
            
          ]
   
    display_single_table(columns,collecton)
  end
  
  def display_gsm_ss(collecton)
    
    columns=[]
    columns = [
            { :name => 'mbiterrorrate', :display_name => 'BitErrorRate' },
            { :name => 'msignalstrength', :display_name => 'SignalsStrength' }
 
          ]
   
    display_single_table(columns,collecton)
  end
  
  def display_raw_data(collecton)
    
    columns=[]
    columns = [
            { :name => 'name', :display_name => 'Type' },
            { :name => 'data', :display_name => 'Ingested' },
            { :name => 'created_at', :display_name => 'Created At' },
            { :name => 'updated_at', :display_name => 'Updated At' }
 
          ]
   
    display_single_table(columns,collecton)
  end
  
end
