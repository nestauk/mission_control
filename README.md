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
5. Seed reference data to database using either:
    - remote url e.g. `rake import:impact_indicators'[https://drive.google.com/file/d/1093kU6XK9tGURo0psv5qM-20ODUaEB2J/view?usp=sharing]'` or
    - local file e.g. `rake RAILS_ENV=test import:impact_indicators_local\['./db/seed_data/impact_indicators_seed_data.json'\]`
   Repeat for each seed file, per environment
6. Create an account an [Okta developer account](https://developer.okta.com/) and create a new app integration for a Web Application using OICD. Change the 'Sign-in redirect URIs' to `http://localhost:3000/users/auth/okta/callback`, and the 'Sign-out redirect URIs' to `http://localhost:3000`.
7. Create `.env` file with the appropriate configuration:
   ```env
   OKTA_CLIENT_ID=<your_client_id>
   OKTA_CLIENT_SECRET=<your_secret>
   OKTA_URL=<your_okta_domain>.okta.com/oauth2/default
   ```
8. `bin/dev rails` to start a local development server. This will run [foreman](https://github.com/ddollar/foreman) which will run `rails server` and `rails tailwindcss:watch`.

<!-- TODO: importing data, rake tasks, etc. -->

### Running tests

- `rails test` to run unit tests.
- `rails test:system` to run system tests.

## Deployment

Assuming you have created a Heroku account, and been added to/set up an app on the platform, and configured your local environment you can run `git push heroku`. See the Heroku docs for more.

If you've made changes to the database you may need to run `heroku run rails db:migrate`

For production...
OKTA_URL=<your_okta_domain>.okta.com/oauth2

## Contributing

First of all, **thank you** for your help!

Be sure to check out the projects open [issues](https://github.com/nestauk/mission_control/issues) to see where help is needed - those labeled [good first issue](https://github.com/nestauk/mission_control/issues?q=is%3Aopen+is%3Aissue+label%3A%22good+first+issue%22) can be a good place to start.

### Bugs

If you've spotted a bug please file an [issue](https://github.com/nestauk/mission_control/issues) and apply the `bug` label. Even better, submit a [pull request](https://github.com/nestauk/mission_control/pulls) (details below) with a patch.

### Pull requests

If you want a feature added the best way to get it done is to submit a pull request that implements it...

1. Fork the repo
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Implement your changes
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to GitHub (`git push origin my-new-feature`)
6. Create a [pull request](https://github.com/nestauk/mission_control/compare/develop...my-new-feature) into the [develop](https://github.com/nestauk/mission_control/tree/develop) branch

Alternatively you can submit an [issue](https://github.com/nestauk/mission_control/issues) describing the feature.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/nestauk/mission_control/tags).
