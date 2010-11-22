require 'yaml'


module NemoToPassword
  module Model
    
    class SystemPassword
  
      attr_reader :system, :user, :service, :token, :nemo
      
      private    
      def self.generate( nemo )

        password = ''
        nemo.split( ' ' ).each { |token| password << Util::PasswordRules.find_substitution( token ) }
        password
      end
  
      public
      def initialize( system, user, service, nemo )

        @system    = system
        @user      = user
        @service   = service
        @nemo      = nemo
        @token     = Util::TokenGenerator.generate( system, user, service )
        @password  = Util::Crypter.instance.encrypt( SystemPassword.generate( @nemo ) )

        self
      end
      
      def password
        SystemPassword.generate( @nemo )
       #Util::Crypter.instance.decrypt( @password )
      end
      
      def to_s
        "[#{@system}/#{@user}@#{@service}] nemo:'#{@nemo}' token:#{@token} password:'*****'"
      end
    end
  end
end