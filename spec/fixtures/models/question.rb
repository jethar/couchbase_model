class Question
  include ::CouchBase::Model::Embeddable

  property :q
  property :a

end
