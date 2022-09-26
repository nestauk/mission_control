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
5. Create `.env` file with the appropriate configuration:
   ```env
   GOOGLE_APP_ID=<your_app_id>
   GOOGLE_APP_SECRET=<your_app_secret>
   ```
   To generate these credentials visit https://console.developers.google.com to create a new project. Then configure the 'OAuth consent screen' and generate 'Credentials'. For the 'Authorised redirect URIs' use `http://localhost:3000/users/auth/google_oauth2/callback`.
6. `bin/dev rails` to start a local development server. This will run [foreman](https://github.com/ddollar/foreman) which will run `rails server` and `rails tailwindcss:watch`.

### Importing data

`lib/tasks/import.rake` provides a number of routines which can be run from the command line to import data from a file.

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
