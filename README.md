# Mission Control

## Getting started

These instructions will get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

1. Install [rbenv](https://github.com/rbenv/rbenv) to manage your Ruby versions.
2. Install the version of [Ruby](https://www.ruby-lang.org) specified in the Gemfile, e.g. `rbenv install 3.1.2`.
3. Run `gem install bundler`.
4. Install [PostgreSQL](https://www.postgresql.org/), e.g. `brew install postgresql` or [Postgress.app](https://postgresapp.com/).

### Local setup

1. `git clone https://github.com/nestauk/mission_control.git`
2. `cd mission_control`
3. `bundle install`
4. `rails db:setup`
5. Create an account an [Okta developer account](https://developer.okta.com/) and create a new app integration for a Web Application using OIDC. Change the 'Sign-in redirect URIs' to `http://localhost:3000/users/auth/okta/callback`, and the 'Sign-out redirect URIs' to `http://localhost:3000`.
6. Create `.env` file with the appropriate configuration:
   ```env
   OKTA_CLIENT_ID=<your_client_id>
   OKTA_CLIENT_SECRET=<your_secret>
   OKTA_URL=<your_okta_domain>.okta.com/oauth2/default
   ```
7. `bin/dev rails` to start a local development server. This will run [foreman](https://github.com/ddollar/foreman) which will run `rails server` and `rails tailwindcss:watch`.

### Running tests

- `rails test` to run unit tests.
- `rails test:system` to run system tests.

## Deployment

Assuming you have created a Heroku account, and been added to/set up an app on the platform, and configured your local environment you can run `git push heroku`. See the Heroku docs for more.

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
rake db:migrate
