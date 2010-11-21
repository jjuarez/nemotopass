require 'base64'
require 'sha1'


module NemoToPassword
  module Util
    
    class TokenError < Exception
    end
    
    class TokenGenerator
    
      def self.generate( system, user, service )
        
        raise TokenError.new "System/User@Service can not be blank" if( system.nil? || user.nil? || service.nil? )
        
        Base64.encode64( Digest::SHA1.digest( "#{system}/#{user}@#{service}".strip ) ).chomp 
      end
    end
  end
end