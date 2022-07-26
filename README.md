# This is a test project for apollo

## setup project in Ubuntu
1. Install rvm with shell
```shell
  curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
  curl -L get.rvm.io | bash -s stable
```
2. Install ruby 2.6.3 with rvm
```shell
  rvm install 2.6.3
```
  After ruby 2.6.3 has installed, then execute `rvm use 2.6.3`

3. Install all gems the project need
```shell
bundle install
```
4. Create initial database tables 
```shell
rake db:migrate
```
5. Scrab museum data with curl
```shell
rake scrab_museum
```
6. Startup server 
```shell
rails s
````
7. Then open web browser and visit `http://localhost:3000`

## Setup project in Docker
Setup with docker is much more simpler then in ubuntu Linux.
There are two files in project that describes the docker container: <br>
[Dockerfile](https://github.com/liumingxing/apollo_museum/blob/main/Dockerfile) <br>
[docker-compose.yml](https://github.com/liumingxing/apollo_museum/blob/main/docker-compose.yml) <br>
Open the shell, switch to the project directory, execute following command
```
docker-compose -f docker-compose.yml up 
```
All steps will be executed automatically, Then open web browser and visit `http://localhost:3000`

it can also scab data from watir. 100% of museums data will be correctly crabbed.

6. install chrome browser and chromedriver in linux, then `rake watir_museum`

## Function instructions
1. Definition of database User, Trip etc.<br>
User [db](https://github.com/liumingxing/apollo_museum/blob/main/db/migrate/20220722083845_devise_create_users.rb) [model](https://github.com/liumingxing/apollo_museum/blob/main/app/models/user.rb) <br>
Trip [db](https://github.com/liumingxing/apollo_museum/blob/main/db/migrate/20220722104942_create_trips.rb) [model](https://github.com/liumingxing/apollo_museum/blob/main/app/models/trip.rb) <br>
Museum [db](https://github.com/liumingxing/apollo_museum/blob/main/db/migrate/20220722102323_create_museums.rb) [model](https://github.com/liumingxing/apollo_museum/blob/main/app/models/museum.rb) <br>
MuseumTrip [db](https://github.com/liumingxing/apollo_museum/blob/main/db/migrate/20220722105542_create_museum_trips.rb) [model](https://github.com/liumingxing/apollo_museum/blob/main/app/models/museum_trip.rb)<br>

2. Scraping: Get museums and parse HTML <br>
In this project, There are two ways to scrab museums data. <br>
`rake scrab_museum` scarb with curl, code is [here](https://github.com/liumingxing/apollo_museum/blob/main/lib/tasks/scrab_museum.rake)<br>
`rake watir_museum` scarb with watir, code is [here](https://github.com/liumingxing/apollo_museum/blob/main/lib/tasks/watir_museum.rake) <br>
Scrab with curl is very simple, but only a small part of data can be scrabbed due to the server-side session problem. To scrab all museum data, we should use watir (headless in linux shell). It's a bit complex to run watir scrab.
* install google-chrome in host <br>
* [download](https://chromedriver.storage.googleapis.com/index.html) chrome-driver (same version with chrome install in previous step) and put it into a `PATH` directory <br>
* Then we can execute `rake watir_museum` to 

3. UI & controllers: create trip, shows art museum list, save trip functionality

4. paginate to more museums <br>
Museums are paginating listed in Adding trip page. Paging and filtering are ajaxed.

5. Add a search box to filter museums <br>
There is a search box in museum list page. Filter by museum's city||name||description
