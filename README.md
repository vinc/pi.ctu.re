Picture
=======

[![Build Status](https://api.travis-ci.org/vinc/pi.ctu.re.svg?branch=master)](http://travis-ci.org/vinc/pi.ctu.re)
[![Code Climate](https://codeclimate.com/github/vinc/pi.ctu.re.svg)](https://codeclimate.com/github/vinc/pi.ctu.re)
[![Code Coverage](https://codecov.io/gh/vinc/pi.ctu.re/branch/master/graph/badge.svg)](https://codecov.io/gh/vinc/pi.ctu.re)

Picture (https://pi.ctu.re) is a website where you can share your pictures
and pay for the data stored and transferred. The code is open source so you
can also host your own instance.

[![Picture](/app/assets/images/home_bg.jpg?raw=true)](https://pi.ctu.re)


Development
-----------

All the data is contained in a PostgreSQL database.

The main website is a [rails app](https://github.com/vinc/pi.ctu.re):

    $ git clone https://github.com/vinc/pi.ctu.re
    $ cd pi.ctu.re
    $ cp .env.sample .env
    $ yarn install
    $ bundle install
    $ rails db:setup
    $ rails generate admin
    $ rails server

And images are delivered by a [node app](https://github.com/vinc/infra.stru.ctu.re):

    $ git clone https://github.com/vinc/infra.stru.ctu.re
    $ cd infra.stru.ctu.re
    $ cp .env.sample .env
    $ yarn install
    $ yarn start

A local instance can also be run using Docker:

    $ git clone --recursive https://github.com/vinc/stru.ctu.re
    $ cd stru.ctu.re
    $ docker-compose up
    $ docker-compose exec web rails db:setup
    $ docker-compose exec web rails generate admin

In all cases a web server is listening at http://localhost:3000


License
-------

Copyright (c) 2011-2018 Vincent Ollivier. Released under MIT.
