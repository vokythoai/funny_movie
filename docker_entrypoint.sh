#!/bin/sh
echo "Remove old pid"
rm -f /app/tmp/pids/server.pid
echo "Asset precompile"
bundle exec rake assets:precompile RAILS_ENV=production

echo "Run migration"
bundle exec rake db:migrate

echo "Run seed"
bundle exec rake db:seed

echo "Start Server"
rails server -b 0.0.0.0
