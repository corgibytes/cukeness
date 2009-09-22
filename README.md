# Cukeness

## Contributing

### Dependencies for building source and running tests

#### Ruby environment
gem install rails
gem install cucmber
gem install rspec
gem install rspec-rails
gem install webrat
gem install culerity # todo update with actual gem name from
culerity github account

#### JRuby environment

Install jruby if it is not already installed. JRuby is required to run browser based tests using culerity/celerity. For celerity to run correctly both jruby and jgem must be accessible from your path. Test with jruby -v and jgem -v.

culerity install

### Running the tests

Unit, integration and functional tests are run with rake test.

To execute cucmber scenarios:

* Delete tmp/culerity.pid if it exists
* Start the culerity rails webserver with rake culerity:rails:start.   
* Finally run rake cucumber 
 

Getting the project setup