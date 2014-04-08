url_shortener_2
===============
## Local Setup
1. `bundle`
2. `createdb -U gschool_user url_shortener`
3. `createdb -U gschool_user url_shortener_test`
4. Edit `.env` to have your credentials
5. `rake db:migrate`
6. `rackup`

## Deployment
1. `git push <heroku app name> master`
2. `heroku run rake db:migrate -a <heroku app name>`
3. `heroku restart -a <heroku app name>`

## Running Specs
1. `rspec`

Note: The tests will automatically migrate the test database up to the latest version before running the tests.