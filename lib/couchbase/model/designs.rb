
#### NOTE Work in progress! Not yet used!

module CouchBase
  module Model

    # A design block in CouchBase Model groups together the functionality of CouchDB's
    # design documents in a simple block definition.
    #
    #   class Person < CouchBase::Model::Base
    #     property :name
    #     timestamps!
    #
    #     design do
    #       view :by_name
    #     end
    #   end
    #
    module Designs
      extend ActiveSupport::Concern

      module ClassMethods

        # Add views and other design document features
        # to the current model.
        def design(*args, &block)
          mapper = DesignMapper.new(self)
          mapper.create_view_method(:all)

          mapper.instance_eval(&block) if block_given?
        end

        # Override the default page pagination value:
        #
        #   class Person < CouchBase::Model::Base
        #     paginates_per 10
        #   end
        #
        def paginates_per(val)
          @_default_per_page = val
        end

        # The models number of documents to return
        # by default when performing pagination.
        # Returns 25 unless explicitly overridden via <tt>paginates_per</tt>
        def default_per_page
          @_default_per_page || 25
        end

      end

      # 
      class DesignMapper

        attr_accessor :model

        def initialize(model)
          self.model = model
        end

        # Define a view and generate a method that will provide a new 
        # View instance when requested.
        def view(name, opts = {})
          View.create(model, name, opts)
          create_view_method(name)
        end

        # Really simple design function that allows a filter
        # to be added. Filters are simple functions used when listening
        # to the _changes feed.
        #
        # No methods are created here, the design is simply updated.
        # See the CouchDB API for more information on how to use this.
        def filter(name, function)
          filters = (self.model.design_doc['filters'] ||= {})
          filters[name.to_s] = function
        end

        def create_view_method(name)
          model.class_eval <<-EOS, __FILE__, __LINE__ + 1
            def self.#{name}(opts = {})
              CouchBase::Model::Designs::View.new(self, opts, '#{name}')
            end
          EOS
        end

      end
    end
  end
end
