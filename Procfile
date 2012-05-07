web: bundle exec rails server thin -p $PORT
#http://grosser.it/2012/04/14/resque-scheduler-on-heroku-without-extra-workers/
worker: bundle exec rake environment schedule_and_work QUEUE=*
