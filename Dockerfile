FROM ruby:2.6.3

COPY . /home/museum_apollo
WORKDIR /home/museum_apollo

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
  && apt-get update \
  && apt-get install google-chrome-stable -y

RUN apt update

ADD https://chromedriver.storage.googleapis.com/103.0.5060.134/chromedriver_linux64.zip .
RUN unzip chromedriver_linux64.zip \
  && cp chromedriver /usr/local/bin/

RUN apt install libnss3-dev -y \
 && apt install nodejs -y \
 && bundle install \
 && rake db:migrate \
 && rake watir_museum 

CMD rails s

#RUN rake watir_museum 