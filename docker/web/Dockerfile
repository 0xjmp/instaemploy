FROM ruby:2.1.5

RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

MAINTAINER instaemploy.com <engineering@instaemploy.com>

# OS installs
RUN apt-get update && apt-get -qq -y install \
  nginx openssh-server git-core openssh-client \
  python build-essential git \
  curl libssl-dev sqlite3 libgdbm-dev \
  automake libtool bison libffi-dev vim libcurl3 \
  python-setuptools python-dev openssl libreadline6 \
  libreadline6-dev curl zlib1g zlib1g-dev \
  libyaml-dev libsqlite3-dev sqlite3 libxml2-dev \
  libxslt-dev autoconf libc6-dev ncurses-dev automake \
  libtool bison subversion pkg-config \
  software-properties-common python-software-properties \
  postgresql-client

# Setup nginx
ADD nginx.conf /usr/local/nginx/conf/nginx.conf
RUN add-apt-repository -y ppa:nginx/stable
RUN echo "\ndaemon off;" >> nginx.conf
RUN chown -R www-data:www-data /usr/local/nginx

RUN easy_install pip PyYAML Jinja2 httplib2

RUN pip install awscli
RUN pip install awsebcli --upgrade

# Set environment variables
ENV NODE_VERSION v0.10.35
ENV HOME /home/web
ENV RAILS_ENV staging

# Cache bundle - we do this 1st (slowest)
WORKDIR $HOME
COPY ./Gemfile $HOME/Gemfile
COPY ./Gemfile.lock $HOME/Gemfile.lock
RUN bundle install --without development test

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION v0.10.35
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/v$NODE_VERSION/bin:$PATH

EXPOSE 3000

WORKDIR $HOME
COPY ./config ./config
COPY ./app ./app
COPY ./bin ./bin
COPY ./db ./db
COPY ./public ./public
COPY ./Rakefile ./Rakefile
COPY ./config.ru ./config.ru
COPY ./Bowerfile ./Bowerfile
COPY ./vendor ./vendor

CMD /usr/local/bundle/bin/rails s thin -b 0.0.0.0