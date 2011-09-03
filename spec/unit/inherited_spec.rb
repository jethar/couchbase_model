require 'spec_helper'

class PlainParent
  class_inheritable_accessor :foo
  self.foo = :bar
end

class PlainChild < PlainParent
end

class ExtendedParent < CouchBase::Model::Base
  class_inheritable_accessor :foo
  self.foo = :bar
end

class ExtendedChild < ExtendedParent
end

describe "Using chained inheritance without CouchBase::Model::Base" do
  it "should preserve inheritable attributes" do
    PlainParent.foo.should == :bar
    PlainChild.foo.should == :bar
  end
end

describe "Using chained inheritance with CouchBase::Model::Base" do
  it "should preserve inheritable attributes" do
    ExtendedParent.foo.should == :bar
    ExtendedChild.foo.should == :bar
  end
end


