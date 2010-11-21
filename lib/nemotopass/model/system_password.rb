require 'yaml'


module NemoToPassword
  module Model
    
    class SystemPassword
  
      attr_reader :system, :user, :service, :token, :nemo
      
      private    
      def self.generate_password( nemo )

        password = ""
        nemo.split( ' ' ).each { |token| password << Util::PasswordRules.instance.find_substitution( token ) }
        password
      end
  
      public
      def initialize( system, user, service, nemo )

        @system    = system
        @user      = user
        @service   = service
        @nemo      = nemo
        @token     = Util::TokenGenerator.generate( system, user, service )
        @password  = SystemPassword.generate_password( nemo )
        self
      end
      
      def to_s()
        "\n#{@system}/#{@user}@#{@service}:\nnemo:     '#{@nemo}'\ntoken:    #{@token}\npassword: '#{@password}'"
      end
    end
  end
end