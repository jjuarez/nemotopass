require 'yaml'
require 'singleton'


module NemoToPassword
  module Util
    
    class PasswordRules

      def self.find_substitution( token )
      
        tw_key = token.upcase
        return Config.instance[:words][tw_key] if Config.instance[:words].include?( tw_key )

        tc_key = token[0..0].upcase
        return Config.instance[:characters][tc_key] if Config.instance[:characters].include?( tc_key ) 
        
        return token[0..0]
      end
    end
  end
end