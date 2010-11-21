require 'rubygems'
require 'crypt/rijndael'
require 'util/string_chunker'


module NemoToPassword
  module Crypt
    
    class Crypter
    
      BLOCK_SIZE = 16
    
      def initialize( password )
        @crypter = Crypt::Rijndael.new( password )
      end
    
      def encrypt( data )      
      
        return nil if( data.nil? || '' == data )
      
        result = ''
        Util::StringChunker.chunk( data, BLOCK_SIZE, 'x' ).each { |chunk| result << @crypter.encrypt_block( chunk ) }
        result
      end
    
      def decrypt( data )
      
        return nil if( data.nil? || '' == data )
      
        result = ''
        Util::StringChunker.chunk( data, BLOCK_SIZE, 'x' ).each { |chunk| result << @crypter.decrypt_block( chunk ) }
        result
      end    
    end
  end
end