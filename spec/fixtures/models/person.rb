require 'cat'

class Person
  include ::CouchBase::Model::Embeddable
  property :pet, Cat
  property :name, [String]
  
  def last_name
    name.last
  end
end
