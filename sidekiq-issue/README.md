Steps for the repo:

 

bundle install

bundle exec rake db:create db:migrate

bundle exec rails s

Then visit - http://localhost:3000/ - the index page has a login link along with the default admin user created, and then the homepage updates with a link to the sidekiq UI after logging in.

