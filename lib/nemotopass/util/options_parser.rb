require 'rubygems'
require 'choice'

module NemoToPassword
  module Util
    Choice.options do
      header ''
      header '  Specific options:'

      option :config do
        short '-c'
        long  '--config=password-policy-settings.yml'
        desc  'The yaml config file'
        default '../config/settings.yml'
      end

      option :command, :required=>true do
        short '-c'
        long  '--command=value'
        desc  'The operation'
        valid %w[create recover update delete]
      end

      option :user, :required=>true do
        short '-u'
        long  '--user=value'
        desc  'The user of the system'
      end

      option :system, :required=>true do
        short '-s'
        long  '--system=value'
        desc  'The system'
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