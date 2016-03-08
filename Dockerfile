FROM instructure/ruby-passenger:2.3

USER root

ENV APP_HOME /usr/src/app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile Gemfile.lock $APP_HOME/
RUN chown -R docker:docker $APP_HOME

USER docker
RUN bundle install --quiet --jobs 8
USER root

COPY . $APP_HOME
RUN chown -R docker:docker $APP_HOME

USER docker
