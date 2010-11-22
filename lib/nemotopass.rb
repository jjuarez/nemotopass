$:.unshift File.join( File.dirname( __FILE__ ), 'nemotopass' )

begin
  %w[
    util/config
    util/logger
    util/password_rules 
    util/optparser 
    util/token_generator
    util/crypter
    model/system_password
    model/factory
    store/simple
    command_dispacher].each { |lib| require lib }
rescue LoadError => le
  fail le.message
end