require 'rubygems'
require 'choice'

module NemoToPassword
  module Util
    Choice.options do
      header ''
      header '  Specific options:'

      option :config do
        long  '--config=password-policy-settings.yml'
        desc  'The yaml config file'
        default '../config/settings.yml'
      end

      option :command, :required=>true do
        long  '--command=value'
        desc  'The operation: {create, recover, update, delete}'
        valid %w[create recover update delete]
      end

      option :system, :required=>true do
        long  '--system=value'
        desc  'The system'
      end

      option :user, :required=>true do
        long  '--user=value'
        desc  'The user of the system'
      end

      option :service, :required=>true do
        long  '--service=value'
        desc  'The service identificator'
      end
  
      option :nemo do
        short '-n'
        long  '--nemo=value'
        desc  'The nemotecnic phrase to remember'
      end

      separator ''
      separator '  Common options:'

      option :help do
        short '-h'
        long '--help'
        desc "Show this screen"
      end
  
      separator ''
    end
  end
end