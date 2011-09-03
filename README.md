# CouchBase Model: CouchBase, working on the new CouchBase Server

CouchBase Models, built from CouchBase Model is an effort to provide model interface on the offical ruby gem for couchbase - couchbase-ruby-client.

## Documentation

General API: [http://rdoc.info/projects/jethar/couchbase_model](http://rdoc.info/projects/couchbase/couchbase_model)

See the [update history](https://github.com/jethar/couchbase_model/blob/master/history.md) for an up to date list of all the changes we've been working on recently.

## Notes on CouchRest Model

Originally called ExtendedDocument, the new Model structure uses ActiveModel, part of Rails 3, 
for validations and callbacks.

If your project is still running Rails 2.3, you'll have to continue using ExtendedDocument as 
it is not possible to load ActiveModel into programs that do not use ActiveSupport 3.0.

CouchRest Model is only properly tested on CouchDB version 1.0 or newer.

*WARNING:* As of April 2011 and the release of version 1.1.0, the default model type key is 'type' instead of 'couchbase-type'. Simply updating your project will not work unless you migrate your data or set the configuration option in your initializers:

    CouchBase::Model::Base.configure do |config|
      config.model_type_key = 'couchbase-type'
    end

This is because CouchBase Model's are not couchbase specific and may be used in any other systems such as Javascript, the model type should reflect this. Also, we're all used to `type` being a reserved word in ActiveRecord.

## Install

### Gem

    $ sudo gem install couchbase_model

### Bundler

If you're using bundler, define a line similar to the following in your project's Gemfile:

    gem 'couchbase_model'

### Configuration

CouchBase Model is configured to work out the box with no configuration as long as your CouchDB instance is running on the default port (8091) on localhost. The default name of the database is either the name of your application as provided by the `Rails.application.class.to_s` call (with /application removed) or just 'couchbase' if none is available.

The library will try to detect a configuration file at `config/couchbase.yml` from the Rails root or `Dir.pwd`. Here you can configuration your database connection in a Rails-like way:

    development:
      protocol: 'https'
      host: sample.cloudant.com
      port: 443
      prefix: project
      suffix: test
      username: test
      password: user

Note that the name of the database is either just the prefix and suffix combined or the prefix plus any text you specifify using `use_database` method in your models with the suffix on the end.

The example config above for example would use a database called "project_test". Heres an example using the `use_database` call:

    class Project < CouchBase::Model::Base
      use_database 'sample'
    end

    # The database object would be provided as:
    Project.database     #=> "https://test:user@sample.cloudant.com:443/project_sample_test"


## Generators

### Configuration

    $ rails generate couchbase_model:config

### Model

    $ rails generate model person --orm=couchbase_model

## General Usage 

    require 'couchbase_model'

    class Cat < CouchBase::Model::Base

      property :name,      String
      property :lives,     Integer, :default => 9

      property :nicknames, [String]

      timestamps!

      view_by :name

    end

    @cat = Cat.new(:name => 'Felix', :nicknames => ['so cute', 'sweet kitty'])

    @cat.new?   # true
    @cat.save

    @cat['name']   # "Felix"

    @cat.nicknames << 'getoffdamntable'

    @cat = Cat.new
    @cat.update_attributes(:name => 'Felix', :random_text => 'feline')
    @cat.new? # false
    @cat.random_text  # Raises error!

## Development

### Preparations

CouchBase Model now comes with a Gemfile to help with development. If you want to make changes to the code, download a copy then run:

    bundle install

That should set everything up for `rake spec` to be run correctly. Update the couchbase_model.gemspec if your alterations
use different gems.

### Testing

The most complete documentation is the spec/ directory. To validate your CouchBase install, from the project root directory run `bundle install` to ensure all the development dependencies are available and then `rspec spec` or `bundle exec rspec spec`.

We will not accept pull requests to the project without sufficient tests.

## Contact

Please post bugs, suggestions and patches to the bug tracker at [http://github.com/couchbase/couchbase_model/issues](http://github.com/couchbase/couchbase_model/issues).

Follow us on Twitter: [http://twitter.com/couchbase](http://twitter.com/couchbase)

Also, check [http://twitter.com/#search?q=%23couchbase](http://twitter.com/#search?q=%23couchbase)


