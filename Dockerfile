FROM ruby:2.6.3

RUN git clone https://github.com/liumingxing/apollo_museum.git /home/museum_apollo
WORKDIR /home/museum_apollo

RUN apt update \
 && apt install libnss3-dev -y \
 && apt install nodejs -y \
 && bundle install \
 && rake db:migrate \
 && rake scrab_museum 

CMD rails s -b 0.0.0.0
