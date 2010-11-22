module NemoToPassword
  module Model
    
    class ParameterNotFound < Exception
    end
  
    class Factory
  
      def self.build( model_class=SystemPassword )

        if( Util::Config.instance[:nemo].nil? )
          raise Model::ParameterNotFound.new "Parameter 'nemo' not found building SystemPassword"
        else
          model_class.new( 
            Util::Config.instance[:system], 
            Util::Config.instance[:user], 
            Util::Config.instance[:service],
            Util::Config.instance[:nemo] )
        end      
      end
    end
  end
end