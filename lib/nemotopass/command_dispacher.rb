module NemoToPassword

  class BadCommand < Exception
  end
  
  class CommandDispacher
    
    def self.error_handler( e )
      Util::Logger.instance.error( e.message )
    end
    
    def create  
      sp = Model::Factory.build
    
      @store.create( sp )
      Util::Logger.instance.info( sp.password )
    end
    
    def recover
      t = Util::TokenGenerator.generate( 
        Util::Config.instance[:system], 
        Util::Config.instance[:user], 
        Util::Config.instance[:service] )
      
      sp = @store.recover( t )
      
      if( sp  )
        Util::Logger.instance.info( "#{sp.to_s}" )
      end
    rescue Store::TokenNotFound => e
      CommandDispacher.error_handler( e )
    end
    
    def update
      sp = Model::Factory.build
      Util::Logger.instance.info( "Updated: #{sp.to_s}" ) if @store.update( sp )
    rescue Store::TokenNotFound => e
      CommandDispacher.error_handler( e )
    end
    
    def delete
      t = Util::TokenGenerator.generate( 
        Util::Config.instance[:system],
        Util::Config.instance[:user], 
        Util::Config.instance[:service] )
        
      Util::Logger.instance.info( "Deleted: #{t}" ) if @store.delete( t )
    rescue Store::TokenNotFound => e
      CommandDispacher.error_handler( e )
    end

    def list
      @store.list.each do |token,sp|
        Util::Logger.instance.info( "T:#{token} #{sp.to_s}" )
      end
    rescue Store::TokenNotFound => e
      CommandDispacher.error_handler( e )
    end
    
    def dispatch

      Util::Logger.instance.debug( "Launching #{Util::Config.instance[:command]}" )
      self.send( Util::Config.instance[:command] )
#   rescue Model::ParameterNotFound, Exception => e      
    rescue Model::ParameterNotFound => e      
      CommandDispacher.error_handler( e )
    end
    
    def initialize      
      @store = Store::Simple.new( File.join( NemoToPassword::ROOT, 'db', 'store.db' ) )
    end

    def method_missing
      raise BadCommand.new "Command unknown, WTF!!!"
    end
  end
end