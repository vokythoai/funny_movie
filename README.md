## Funny Movie app

### Tech stacks:
  - Ruby 2.7.5
  - Rails 7
  - Sidekiq
  - Redis
  - Docker compose

## Run app
  - Pull code and run `bundle intall`
  - Run redis
  - Run `bundle exec sidekiq -C config/sidekiq.yml` for starting sidekiq
  - Run `rails s`
  - Via docker: `.env.docker-compose` for your environment and run `docker-compose up` for starting all stacks.
