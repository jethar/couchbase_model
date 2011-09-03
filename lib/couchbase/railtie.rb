require "rails"
require "active_model/railtie"

module CouchBase
  class ModelRailtie < Rails::Railtie
    def self.generator
      config.respond_to?(:app_generators) ? :app_generators : :generators
    end

    config.send(generator).orm :couchbase_model
    config.send(generator).test_framework  :test_unit, :fixture => false

    initializer "couchbase_model.configure_default_connection" do
      CouchBase::Model::Base.configure do |conf|
        conf.environment = Rails.env
        conf.connection_config_file = File.join(Rails.root, 'config', 'couchbase.yml')
        conf.connection[:prefix] =
          Rails.application.class.to_s.underscore.gsub(/\/.*/, '')
      end
    end
  end

end

