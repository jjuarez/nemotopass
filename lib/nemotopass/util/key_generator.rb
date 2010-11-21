require 'base64'
require 'sha1'


module NemoToPassword
  module Util
    class KeyGenerator
    
      def self.generate_key_token( user, system )

        if user.nil? || system.nil?
          fail "User/System can not be nil"
        end

        Base64.encode64( "{SHA}#{Digest::SHA1.digest( "#{user}/#{system}".strip )}" ).chomp 
      end
    end
  end
end