FROM ruby:2.7.5
MAINTAINER Thoai Vo<vokythoai@gmail.com>

ENV TZ Asia/Ho_Chi_Minh
ENV LANG C.UTF-8

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client && \
    apt-get install -y build-essential git nodejs tzdata libncurses5-dev libncursesw5-dev imagemagick file && \
    rm -rf /var/cache/apk/*

RUN apt remove -y cmdtest

RUN mkdir /app
WORKDIR /app

COPY Gemfile /app/
COPY Gemfile.lock /app/

RUN gem install bundler -v 2.1.2
RUN bundle install --jobs 10

EXPOSE 3000
EXPOSE 7000
EXPOSE 443

COPY . /app

ENTRYPOINT ["./docker_entrypoint.sh"]
