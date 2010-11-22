require 'rubygems'
require 'singleton'
require 'crypt/rijndael'


module NemoToPassword
  module Util
    class CrypterException < Exception
    end
    
    class Crypter
      include Singleton
        
      DEFAULT_BLOCK_SIZE = 16
      DEFAULT_FILL_CHAR  = '|'
      
      def self.chunk( plain_data, block_size=DEFAULT_BLOCK_SIZE, fill_char=DEFAULT_FILL_CHAR )

        raise CrypterException.new( "The parameter must be an String" ) unless plain_data.instance_of?( String )

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

      def self.flatten( chunked_data )

        raise CrypterException.new( "The parameter must be an Array" ) unless chunked_data.instance_of?( Array )

        flat = ""
        chunked_data.collect do |chunk| 

          fail "Invalid chunk: '#{chunk}'" if chunk.length != block_size
          flat << chunk
        end

        flat
      end
     
      def encrypt( data )      

        return nil if( data.nil? || '' == data )
      
        result = ''
        Crypter.chunk( data ).each { |c| result << @crypter.encrypt_block( c ) }
        result
      end
    
      def decrypt( data )
        
        return nil if( data.nil? || '' == data )
      
        result = ''
        Crypter.chunk( data ).each { |c| result << @crypter.decrypt_block( c ) }
        result
      end    
      
      def initialize        
        @crypter = ::Crypt::Rijndael.new( Util::Config.instance[:seed] )
        self
      end
    end
  end
end