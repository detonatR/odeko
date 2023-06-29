FROM ruby:3.2.2-alpine

ARG APP_PATH=/app
ARG APP_USER=docker
ARG APP_GROUP=docker
ARG APP_UID=7084
ARG APP_GID=2001

WORKDIR $APP_PATH

RUN apk add --update --virtual \
  runtime-deps \
  bash \
  postgresql-client \
  build-base \
  libxml2-dev \
  libxslt-dev \
  libffi-dev \
  readline \
  build-base \
  postgresql-dev \
  sqlite-dev \
  libc-dev \
  linux-headers \
  readline-dev \
  file \
  imagemagick \
  git \
  tzdata \
  && rm -rf /var/cache/apk/*

RUN addgroup -g $APP_GID -S $APP_GROUP \
    && adduser -S -s /sbin/nologin -u $APP_UID -G $APP_GROUP $APP_USER \
    && chown $APP_USER:$APP_GROUP $APP_PATH

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

COPY --chown=$APP_USER:$APP_GROUP Gemfile* $APP_PATH

ENV BUNDLE_PATH /gems
RUN gem update --system && \
    gem install bundler && \
    bundle install

USER $APP_USER

COPY --chown=$APP_USER:$APP_GROUP . $APP_PATH
COPY --chown=$APP_USER:$APP_GROUP bin/ ./bin
RUN chmod 0755 bin/*

ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000