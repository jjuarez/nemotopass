require 'util/password_rules'


module NemoToPassword
  module Model
    
    class SystemPassword
  
      attr_reader :user, :system, :key_token, :nemo
      
      private    
      def self.generate_password( nemo )

        password = ""
        nemo.split( ' ' ).each { |token| password << Util::PasswordRules.instance.find_substitution( token ) }
        password
      end
  
      public
      def initialize( user, system, nemo )

        @user      = user
        @system    = system
        @nemo      = nemo
        @key_token = Util::KeyGenerator.generate_key_token( user, system )
        @password  = SystemPassword.generate_password( nemo )
        
        self
      end
      
      def to_s()
        "system: -#{@user}/#{@system}- nemo: '#{@nemo}' token: #{@key_token} password: '*****'"
      end
    end
  end
end