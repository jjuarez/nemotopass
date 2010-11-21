module NemoToPassword

  class BadCommand < Exception
  end
  
  class ParameterNotFound < Exception
  end
  
  class ModelFactory
  
    def self.build( model_class=Model::SystemPassword )

      if( Choice.choices[:nemo].nil? )
        raise ParameterNotFound.new "Parameter not found building SystemPassword"
      else
        model_class.new( Choice.choices[:system], Choice.choices[:user], Choice.choices[:service], Choice.choices[:nemo] )
      end      
    end
  end
  
  class CommandDispacher
    
    private
    def generate_token
      Util::TokenGenerator.generate( Choice.choices[:system], Choice.choices[:user], Choice.choices[:service] )
    end
    
    def display( system_password )
      $stdout.puts( system_password )
    end
    
    public
    def create
      @store.create( ModelFactory.build( ) )
    end
    
    def recover
      
      if( system_password = @store.recover( generate_token ))
        
        Util::Logger.instance.debug system_password
        display system_password
      end
    end
    
    def update
      
      system_password = ModelFactory.build
      
      if( @store.update( system_password ) )
        Util::Logger.instance.debug "#{system_password.token} Updated"
      end
    rescue Store::TokenNotFound => e
      Util::Logger.instance.error e.message
    end
    
    def delete
      
      token = generate_token
      
      if( @store.delete( token ) )
        Util::Logger.instance.debug "#{token} Updated"
      end
   rescue Store::TokenNotFound => e
      Util::Logger.instance.error "Delete failed #{e.message}"
    end
    
    def method_missing
      raise BadCommand.new "Command unknown!!!"
    end
        
    def dispatch

      command = Choice.choices[:command].to_sym
      
      Util::Logger.instance.debug "Launching commmand: #{command}"
      self.send( command )
    rescue ParameterNotFound => e
      Util::Logger.instance.error e.message  
    end
    
    def initialize
      @store = Store::Simple.new( File.join( NemoToPassword::ROOT, 'db', 'store.db' ) )
    end
  end
end