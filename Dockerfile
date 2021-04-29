FROM ruby:2.7.2
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client chromium-driver
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - && \
    apt-get install nodejs
RUN apt-get install -y vim

RUN mkdir /patch-app
WORKDIR /patch-app
COPY Gemfile /patch-app/Gemfile
COPY Gemfile.lock /patch-app/Gemfile.lock
RUN bundle install
COPY . /patch-app
RUN mkdir /patch-app/tmp/sockets
RUN mkdir /patch-app/tmp/pids

CMD bundle exec puma -d && \
    /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf

