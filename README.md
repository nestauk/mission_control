# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


rbenv install 3.1.2    
rbenv init    
rbenv global 3.1.2   
gem install bundler   
export PATH=~/.rbenv/shims:$PATH
Sets up your shims path. This is the only requirement for rbenv to function properly. You can do this by hand by prepending ~/.rbenv/shims to your $PATH.
brew install postgresql
brew services restart postgresql@14
sudo gem install rails
brew services start postgresql

docker run -d \
        --name rails-postgres \
        -p 5432:5432 \
        -v ~/apps/postgres:/var/lib/postgresql/data \
        -e POSTGRES_PASSWORD=<mypassword> \
        -e POSTGRES_USER=p_user \
        -e POSTGRES_DB=mission_control \
         postgres:14-alpine

in database.yml - adjust postgres connection details if necessary e.g. set localhost or username/password

rake db:create
rake db:migrate