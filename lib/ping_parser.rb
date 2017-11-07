module Ping
  class Parser
    attr_accessor :output, :ping_min, :ping_avg, :ping_max, :pkt_loss, :ttl, :time
    
    def initialize(input)     
      @output = input
      parse 
    end
    
    def to_h
      h = {}
      instance_variables.each{|a|
        s = a.to_s
        n = s[1..s.size]
        v = instance_variable_get a
        h[n] = v
      }
      h
    end
    
    private 
    def parse
                      
      @ping_min = @output.match('([\d]*\.[\d]*)/([\d]*\.[\d]*)/([\d]*\.[\d]*)/([\d]*\.[\d]*)')[1]
      @ping_avg = @output.match('([\d]*\.[\d]*)/([\d]*\.[\d]*)/([\d]*\.[\d]*)/([\d]*\.[\d]*)')[2]
      @ping_max = @output.match('([\d]*\.[\d]*)/([\d]*\.[\d]*)/([\d]*\.[\d]*)/([\d]*\.[\d]*)')[3]            
      @pkt_loss = @output.match('(\d*)% packet loss')[1]
      @ttl = @output.match('ttl=(\d*)')[1]
      @time = @output.match('time=(\d*) ms')[1]
      
    end  
  end
end
         
      