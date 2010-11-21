module NemoToPassword
  module Model
    
    class ParameterNotFound < Exception
    end
  
    class Factory
  
      def self.build( model_class=SystemPassword )

        if( Choice.choices[:nemo].nil? )
          raise ParameterNotFound.new "Parameter 'nemo' not found building SystemPassword"
        else
          model_class.new( Choice.choices[:system], Choice.choices[:user], Choice.choices[:service], Choice.choices[:nemo] )
        end      
      end
    end
  end
end