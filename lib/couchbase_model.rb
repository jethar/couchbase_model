require 'active_model'
require "active_model/callbacks"
require "active_model/conversion"
require "active_model/errors"
require "active_model/naming"
require "active_model/serialization"
require "active_model/translation"
require "active_model/validator"
require "active_model/validations"
require "active_model/dirty"

require 'active_support/core_ext'
require 'active_support/json'

require 'mime/types'
require "enumerator"
require "time"
require 'digest/md5'

require 'bigdecimal' # used in typecast
require 'bigdecimal/util' # used in typecast

require 'couchbase'

require 'couchbase/model'
require 'couchbase/model/errors'
require "couchbase/model/persistence"
require "couchbase/model/typecast"
require "couchbase/model/casted_by"
require "couchbase/model/dirty"
require "couchbase/model/property"
require "couchbase/model/property_protection"
require "couchbase/model/properties"
require "couchbase/model/casted_array"
require "couchbase/model/casted_hash"
require "couchbase/model/validations"
require "couchbase/model/callbacks"
require "couchbase/model/document_queries"
require "couchbase/model/views"
require "couchbase/model/design_doc"
require "couchbase/model/extended_attachments"
require "couchbase/model/class_proxy"
require "couchbase/model/proxyable"
require "couchbase/model/collection"
require "couchbase/model/associations"
require "couchbase/model/configuration"
require "couchbase/model/connection"
require "couchbase/model/designs"
require "couchbase/model/designs/view"

# Monkey patches applied to couchbase
require "couchbase/model/support/couchbase_design"
require "couchbase/model/support/couchbase_database"

# Core Extensions
require "couchbase/model/core_extensions/hash"
require "couchbase/model/core_extensions/time_parsing"

# Base libraries
require "couchbase/model/embeddable"
require "couchbase/model/base"

# Add rails support *after* everything has loaded
if defined?(Rails)
  require "couchbase/railtie"
end
