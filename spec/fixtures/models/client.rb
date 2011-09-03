class Client < CouchBase::Model::Base
  use_database DB

  property :name
  property :tax_code
end