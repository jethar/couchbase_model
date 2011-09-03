class KeyChain < CouchBase::Model::Base
  use_database(DB)

  property(:keys, Hash)
end
