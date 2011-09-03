require 'rails/generators/couchbase_model'

module CouchbaseModel
  module Generators
    class ConfigGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def app_name
        Rails::Application.subclasses.first.parent.to_s.underscore
      end

      def copy_configuration_file
        template 'couchbase.yml', File.join('config', "couchbase.yml")
      end

    end
  end
end