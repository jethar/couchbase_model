require 'rails/generators/named_base'
require 'rails/generators/active_model'
require 'couchbase_model'

module CouchbaseModel
  module Generators
    class Base < Rails::Generators::NamedBase #:nodoc:
      
      # Set the current directory as base for the inherited generators.
      def self.base_root
        File.dirname(__FILE__)
      end
      
    end
  end
end
