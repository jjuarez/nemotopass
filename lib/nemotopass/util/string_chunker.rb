module NemoToPassword
  module Util
    
    class StringChunker
    
      DEFAULT_BLOCK_SIZE = 16
      DEFAULT_FILL_CHAR  = 'x'
    
      def self.chunk( plain_data, block_size=DEFAULT_BLOCK_SIZE, fill_char=DEFAULT_FILL_CHAR )
        fail "The parameter must be an String" unless plain_data.instance_of?( String )
      
        chunks = []
        max    = plain_data.length
        index  = 0
      
        while (index+block_size) <= max do 
        
          block = plain_data[index..index+block_size-1]
        
          if( block.length == block_size )
        
            chunks << block
            index+=block_size
          end        
        end
      
        if( index < max )
          chunks << (plain_data[index..max] + fill_char*(block_size-(max-index)))
        end
      
        chunks
      end
    
      def self.flatten( chunked_data, block_size=DEFAULT_BLOCK_SIZE )
      
        fail "The parameter must be an Array" unless chunked_data.instance_of?( Array )

        flat = ""
        chunked_data.collect do |chunk| 
        
          fail "Invalid chunk: '#{chunk}'" if chunk.length != block_size
          flat << chunk
        end
      
        flat
      end
    end
  end
end