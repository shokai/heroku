heroku app
==========

Heroku
------
http://shokai.herokuapp.com/


Install Dependencies
--------------------

    % gem install heroku foreman bundler
    % bundle install


Run
---

    % foreman start -f Procfile.development


Deploy
------

    % heroku create --stack cedar
    % git push heroku master