$:.unshift File.join( File.dirname( __FILE__ ), 'nemotopass' )

begin
  %w[
    util/logger
    util/string_chunker 
    util/password_rules 
    util/options_parser 
    util/token_generator
    crypt/crypter
    model/system_password 
    store/simple_store 
    command_dispacher].each { |lib| require lib }
rescue LoadError => le
  fail le.message
end