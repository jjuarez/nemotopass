require 'singleton'
require 'logger'


module NemoToPassword
  module Util
    class Logger
      include Singleton
    
      DEFAULT_LEVEL = ::Logger::DEBUG
    
      def initialize( level=DEFAULT_LEVEL )
      
        @log       = ::Logger.new( STDERR )
        @log.level = level
      end
    
      def fatal ( message )
        @log.fatal message
      end
      def error( message )
        @log.error message
      end
      def warn( message )
        @log.warn message
      end
      def info( message )
        @log.info message
      end
      def debug( message )
        @log.debug message
      end
    end
  end
end