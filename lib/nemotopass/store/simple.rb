require 'yaml'


module NemoToPassword
  module Store
    class TokenNotFound < Exception
    end

    class TokenDuplicated < Exception
    end
    
    class Simple
      
      private
      def save
        File.open( @store_file, 'w' ) { |f| f.write( @data.to_yaml ) }
      end
      
      def find( token )
        @data.keys.include?( token )
      end

      public
      def initialize( store_file )
        
        @store_file = store_file        
        @data       = YAML.load_file( @store_file )
        
        if( @data.nil? )
        
          # Restore
          @data = Hash.new if @data.nil?
        end
      end
    
      def create( system_password )
  
        if( find( system_password.token ) && @data[system_password.token] )
          raise TokenDuplicated.new( "Token: #{system_password.token} duplicated" )
        end
        
        @data[system_password.token] = system_password
        save
      end
    
      def recover( token )
        
        unless( find( token ) )
          raise TokenNotFound.new( "Token: #{token} not found" )
        end
      
        @data[token]
      end

      def update( system_password )
        
        unless( find( system_password.token ) )
          raise TokenNotFound.new( "Token: #{system_password.token} not found" )
        end
      
        @data[system_password.token] = system_password
        save
      end

      def delete( token )
        
        unless( find( token ) )
          raise TokenNotFound.new( "Token: #{token} not found" )
        end
      
        @data[token]=nil
        save
      end
    end
  end
end