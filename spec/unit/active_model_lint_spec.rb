# encoding: utf-8
require 'spec_helper'
require 'test/unit/assertions'
require 'active_model/lint'

class CompliantModel < CouchBase::Model::Base
end


describe CouchBase::Model::Base do
  include Test::Unit::Assertions
  include ActiveModel::Lint::Tests

  before :each do
    @model = CompliantModel.new
  end

  describe "active model lint tests" do
    ActiveModel::Lint::Tests.public_instance_methods.map{|m| m.to_s}.grep(/^test/).each do |m|
      example m.gsub('_',' ') do
        send m
      end
    end
  end

  def model
    @model
  end

end
