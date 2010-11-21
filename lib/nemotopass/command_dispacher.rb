module NemoToPassword

  class BadCommand < Exception
  end
  
  class CommandDispacher
    
    private
    def display( system_password )
      $stdout.puts( system_password )
    end
    
    public
    def create
      
      system_password = Model::Factory.build
       
      @store.create( system_password )
      Util::Logger.instance.info( system_password.password )
    end
    
    def recover
      
      token = Util::TokenGenerator.generate( Choice.choices[:system], Choice.choices[:user], Choice.choices[:service] )
      
      if( system_password = @store.recover( token ))
        
        Util::Logger.instance.debug system_password
        display system_password
      end
    end
    
    def update
      
      system_password = Model::Factory.build
      
      if( @store.update( system_password ) )
        Util::Logger.instance.info "#{system_password.token} Updated, nemo: '#{system_password.nemo}'"
      end
    rescue Store::TokenNotFound => e
      Util::Logger.instance.error e.message
    end
    
    def delete
      
      token = Util::TokenGenerator.generate( Choice.choices[:system], Choice.choices[:user], Choice.choices[:service] )
      
      if( @store.delete( token ) )
        Util::Logger.instance.info "#{token} Deleted"
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
      
    rescue Model::ParameterNotFound, Exception => e
      Util::Logger.instance.error e.message  
    end
    
    def initialize
      @store = Store::Simple.new( File.join( NemoToPassword::ROOT, 'db', 'store.db' ) )
    end
  end
end