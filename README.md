heroku app
==========

Heroku
------
http://shokai.herokuapp.com/


Install Dependencies
--------------------

    % gem install heroku foreman bundler
    % bundle install


Config
------

    % cp sample.config.yml config.yml

edit "config.yml".


Run
---

    % foreman start

=> http://localhost:5000


Deploy
------

    % heroku create --stack cedar
    % git branch deploy
    % git checkout deploy
    % git add config.yml
    % git commit -m 'add config.yml'
    % git push heroku deploy:master
