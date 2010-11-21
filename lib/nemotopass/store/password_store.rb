module NemoToPassword
  module Store
  
    class SystemPasswordNotFound < Exception
    end
  
    class PasswordStore
    
      # CRUD  
      def self.create( system_password )
        puts "create"
        system_password
      end
    
      def self.recover( key )
        puts "recover"
        nil
      end

      def self.update( new_system_password )
        puts "update"
        new_system_password
      end

      def self.delete( key )
        puts "delete"
        true
      end        
  
      # Extended CRUD
      def self.keys()
        puts "keys"
        nil
      end  
    end
  end
end