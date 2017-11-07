#!/usr/bin/env ruby


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


output = "PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.\n64 bytes from 8.8.8.8: icmp_seq=1 ttl=54 time=187 ms\n\n--- 8.8.8.8 ping statistics ---\n1 packets transmitted, 1 received, 0% packet loss, time 0ms\nrtt min\/avg\/max\/mdev = 187.489\/123.489\/187.000\/0.000 ms\n"

pp = Ping::Parser.new(output)
puts pp.ping_avg
puts pp.ping_max
puts pp.ping_min
puts pp.pkt_loss
puts pp.ttl
puts pp.time

puts pp.to_h
