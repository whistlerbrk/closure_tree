#!/bin/sh -ex
export BUNDLE_GEMFILE RMI DB

for RMI in 1.8.7-p370 1.9.3-p327
do
  rbenv local $RMI
  gem install bundler rake # < just to make sure
  rbenv rehash

  for BUNDLE_GEMFILE in ci/Gemfile.rails-3.0.x ci/Gemfile.rails-3.1.x ci/Gemfile.rails-3.2.x
  do
    bundle --quiet
    for DB in sqlite3 mysql pg
    do
      echo $BUNDLE_GEMFILE $DB `ruby -v`
      bundle exec rake specs_with_db_ixes
    done
  done
done