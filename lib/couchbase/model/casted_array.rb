#
# Wrapper around Array so that the casted_by attribute is set in all
# elements of the array.
#

module CouchBase::Model
  class CastedArray < Array
    include CouchBase::Model::CastedBy
    include CouchBase::Model::Dirty
    attr_accessor :casted_by_property

    def initialize(array, property, parent = nil)
      self.casted_by_property = property
      self.casted_by = parent unless parent.nil?
      super(array)
    end

    # Adding new entries

    def << obj
      super(instantiate_and_cast(obj))
    end

    def push(obj)
      super(instantiate_and_cast(obj))
    end

    def unshift(obj)
      super(instantiate_and_cast(obj))
    end

    def []= index, obj
      value = instantiate_and_cast(obj, false)
      couchbase_parent_will_change! if use_dirty? && value != self[index]
      super(index, value)
    end

    def pop
      couchbase_parent_will_change! if use_dirty? && self.length > 0
      super
    end

    def shift
      couchbase_parent_will_change! if use_dirty? && self.length > 0
      super
    end

    def clear
      couchbase_parent_will_change! if use_dirty? && self.length > 0
      super
    end

    def delete(obj)
      couchbase_parent_will_change! if use_dirty? && self.length > 0
      super(obj)
    end

    def delete_at(index)
      couchbase_parent_will_change! if use_dirty? && self.length > 0
      super(index)
    end

    def build(*args)
      obj = casted_by_property.build(*args)
      self.push(obj)
      obj
    end

    protected

    def instantiate_and_cast(obj, change = true)
      property = casted_by_property
      couchbase_parent_will_change! if change && use_dirty?
      if casted_by && property && obj.class != property.type_class
        property.cast_value(casted_by, obj)
      else
        obj.casted_by = casted_by if obj.respond_to?(:casted_by)
        obj.casted_by_property = casted_by_property if obj.respond_to?(:casted_by_property)
        obj
      end
    end
  end
end
