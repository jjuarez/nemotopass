require 'yaml'
require 'singleton'


module NemoToPassword
  module Util
    
    class PasswordRules
      include Singleton
    
      class YAMLFileNotFound < Exception
      end

      def initialize()   
        @config = YAML.load_file( Choice.choices[:config] )
      rescue Exception => e
        raise YAMLFileNotFound.new e.message
      end

      def find_substitution( token )
      
        tw_key = token.upcase
        return @config[:words][tw_key] if @config[:words].include?( tw_key )

        tc_key = token[0..0].upcase
        return @config[:characters][tc_key] if @config[:characters].include?( tc_key ) 
        
        return token[0..0]
      end
    end
  end
end