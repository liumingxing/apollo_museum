# This is a test project for apollo


## install in ubuntu
1. `rvm use 2.6.3`
2. `bundle install`
3. `rake db:migrate`
4. scrab data from curl, `rake scrab_museum`
5. `rails s`

it can also scab data from watir. 100% of museums data will be correctly crabbed.

6. install chrome browser and chromedriver in linux, then `rake watir_museum`

run in docker

7. `docker-compose -f docker-compose.yml up`