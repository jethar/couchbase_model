class Project < CouchBase::Model::Base
  use_database DB
  property :name,   String
  timestamps!
  view_by :name
end
