class Location < ApplicationRecord
  #include ActiveModel::Serializers::JSON
  has_many :metrics, dependent: :destroy

  #attr_accessor :maccuracy, :maltitude, :mdistance, :mspeed, :mlongitude, :mlatitude
  # def initialize(subject)
    # subject.public_methods(false).each do |meth|
      # (class << self; self; end).class_eval do
        # define_method meth do |*args|
          # subject.send meth, *args
        # end
      # end
    # end
  # end
  # # Defining ghost methods using method_missing.
    # def method_missing(name, *args, &block)
        # return getter($1) if name.to_s =~ /^(\w*)$/ and self.instance_variables.include?("@#{$1}".to_sym)
        # return setter($1, *args)  if name.to_s =~ /^(\w*)=$/ and self.instance_variables.include?("@#{$1}".to_sym)
        # super
    # end

    # Naive getter method that is invoked by method_missing
    # def getter(method)
        # self.instance_variable_get("@#{method}")
    # end

    # Naive setter method that is invoked by method_missing
    # def setter(method, value)
        # self.instance_variable_set("@#{method}", value)
    # end

  # def attributes=(hash)
    # hash.each do |key, value|
      # #puts "#{key} #{value}"
      # send("#{key}=", value) if respond_to? key
    # end
  # end
# 
  # def attributes
    # instance_values
  # end
    
    
end
