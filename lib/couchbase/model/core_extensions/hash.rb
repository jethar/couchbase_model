# This file contains various hacks for Rails compatibility.
class Hash
  # Hack so that CouchBase::Document, which descends from Hash,
  # doesn't appear to Rails routing as a Hash of options
  def self.===(other)
    return false if self == Hash && other.is_a?(CouchBase::Document)
    super
  end
end
