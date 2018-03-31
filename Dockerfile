FROM ruby:2.5.0

RUN curl -sL https://deb.nodesource.com/setup_9.x | bash - \
  && apt-get update -qq \
  && apt-get install -y build-essential libpq-dev nodejs

RUN npm install -g yarn

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock /app/
RUN bundle install

COPY package.json yarn.lock /app/
RUN yarn install

COPY . /app
