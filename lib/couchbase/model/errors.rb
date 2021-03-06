# encoding: utf-8
module CouchBase
  module Model
    module Errors

      class CouchBaseModelError < StandardError; end

      # Raised when a persisence method ending in ! fails validation. The message
      # will contain the full error messages from the +Document+ in question.
      #
      # Example:
      #
      # <tt>Validations.new(person.errors)</tt>
      class Validations < CouchBaseModelError
        attr_reader :document
        def initialize(document)
          @document = document
          super("Validation Failed: #{@document.errors.full_messages.join(", ")}")
        end
      end
    end

    class DocumentNotFound < Errors::CouchBaseModelError; end
  end
end
