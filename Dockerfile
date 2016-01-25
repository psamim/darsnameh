FROM ruby:2.2
WORKDIR /usr/src/app
COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install
CMD ["/usr/local/bundle/bin/foreman","start","--root","/usr/src/app"]
