#
# Extend CouchBase's normal database delete! method to ensure any caches are
# also emptied. Given that this is a rare event, and the consequences are not 
# very severe, we just completely empty the cache.
#
CouchBase::Database.class_eval do

  def delete!
    Thread.current[:couchbase_design_cache] = { }
    CouchBase.delete @root
  end

end
