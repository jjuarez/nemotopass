

module NemoToPassword
  class BadCommand < Exception
  end
  
  class CommandDispacher

    private
    def self.build_system_password( )
      
      Model::SystemPassword.new( 
        Choice.choices[:user],
        Choice.choices[:system],
        Choice.choices[:nemo] )
    end
    
    public
    def self.create
    
      if( Choice.choices[:nemo] )
        sp = build_system_password
        Store::PasswordStore.create( sp )
      end
    end
    
    def self.recover
      
      key = Util::KeyGenerator.generate_key_token( Choice.choices[:user], Choice.choices[:system] )
      Store::PasswordStore.recover( key )
    end
    
    def self.update
      
      sp = build_system_password
      Store::PasswordStore.update( sp )
    end
    
    def self.delete
      
      key = Util::KeyGenerator.generate_key_token( Choice.choices[:user], Choice.choices[:system] )
      Store::PasswordStore.delete( key )
    end
    
    ##
    # ::RUN::
    def self.dispatch
      case Choice.choices[:command]
        when 'create' : create()
        when 'recover': recover()
        when 'update' : update()
        when 'delete' : delete()
        else raise BadCommand.new( "The command: #{Choice.choices[:command]} is unknown!!!" )          
      end
    end
  end
end