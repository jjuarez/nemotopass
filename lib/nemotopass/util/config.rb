require 'yaml'
require 'singleton'


module NemoToPassword
  module Util

    class YAMLFileNotFound < Exception
    end
    
    class Config
      include Singleton
      
      def initialize
        @config = YAML.load_file( Choice.choices[:config] )
      rescue Exception => e
        raise YAMLFileNotFound.new e.message
      end
      
      def []( key )
        @config[key.to_sym] if @config
      end
      
      def []=( key, value )
        @config[key.to_sym]=value if @config 
      end
    end
  end
end