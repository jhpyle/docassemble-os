FROM ubuntu:22.04

LABEL MAINTAINER="Jonathan Pyle <jhpyle@gmail.com>"

# Change working directory
WORKDIR /tmp

# Environment Variables and Build VARs Used
ARG LOCALE=en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm

# Update container via apt.
RUN apt-get update --fix-missing
RUN apt-get install --yes apt-utils
RUN apt-get --yes upgrade

# Install Timezone.
RUN ln --force --symbolic /usr/share/zoneinfo/America/New_York /etc/localtime
RUN apt-get install --yes --no-install-recommends tzdata
RUN dpkg-reconfigure --frontend=noninteractive tzdata

# Set LOCALE
RUN apt-get install --yes locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANGUAGE $LOCALE
ENV LC_ALL $LOCALE
ENV LANG $LOCALE

# This installs correctly if done before the rext of the texlive installs.
RUN apt-get --quiet --yes install texlive-latex-extra

# Install packages
ARG APT_INSTALL_LIST=apt_install_list
COPY $APT_INSTALL_LIST .
RUN apt-get --quiet --yes install $(cat $APT_INSTALL_LIST)
RUN rm -rf $APT_INSTALL_LIST

# Remove unwanted packages
ARG APT_REMOVE_LIST=apt_remove_list
COPY $APT_REMOVE_LIST .
RUN apt-get --yes remove $(cat $APT_REMOVE_LIST)
RUN rm -rf $APT_REMOVE_LIST
RUN apt-get --yes autoremove

# Setup MS Core Fonts
RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
RUN apt-get --quiet --yes install ttf-mscorefonts-installer

# Install Node
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash
RUN apt-get --quiet --yes install nodejs

# Install needed Node packages
RUN npm install --global @mermaid-js/mermaid-cli

# Install Chrome
ARG INSTALL_CHROME_FILE=install_chrome.sh
COPY $INSTALL_CHROME_FILE .
RUN bash $INSTALL_CHROME_FILE
RUN rm -rf $INSTALL_CHROME_FILE

# Install Pandoc
ARG INSTALL_PANDOC_FILE=install_pandoc.sh
COPY $INSTALL_PANDOC_FILE .
RUN bash $INSTALL_PANDOC_FILE
RUN rm -rf $INSTALL_PANDOC_FILE

# Install Google Fonts
RUN wget -q -O google-fonts.tar.gz https://github.com/google/fonts/archive/main.tar.gz
RUN tar -zxf google-fonts.tar.gz
RUN rm google-fonts.tar.gz
RUN mkdir -p /usr/share/fonts/truetype/google-fonts
RUN find ./fonts-main/ -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/google-fonts/ \;
RUN rm -r ./fonts-main
RUN sed -i 's/<policy domain="coder" rights="none" pattern="PDF" \/>/<policy domain="coder" rights="read | write" pattern="PDF" \/>/' /etc/ImageMagick-6/policy.xml
RUN sed -i 's/^#PATH/PATH/' /etc/crontab

# Build docassemble file structure
RUN mkdir -p \
    /etc/ssl/docassemble \
    /usr/share/docassemble/local3.10 \
    /usr/share/docassemble/certs \
    /usr/share/docassemble/backup \
    /usr/share/docassemble/config \
    /usr/share/docassemble/webapp \
    /usr/share/docassemble/files \
    /usr/share/docassemble/cron \
    /usr/share/docassemble/syslogng \
    /var/www/.pip \
    /var/www/.cache \
    /var/run/uwsgi \
    /var/run/docassemble \
    /usr/share/docassemble/log \
    /tmp/docassemble \
    /var/www/html/log \
    /var/www/nascent

# Install AzureCLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Update puppeteer-config.json
RUN echo '{ \"args\": [\"--no-sandbox\"], \"executablePath\": \"/usr/bin/google-chrome\" }' > ~/puppeteer-config.json

# Setup directory ownerships
RUN chown -R www-data:www-data /var/www
RUN chown www-data:www-data /var/run/uwsgi
RUN chown www-data:www-data ~/puppeteer-config.json

# Do some postresql modifications
ARG CONFIG_POSTGRESQL_FILE=config_postgresql.sh
COPY $CONFIG_POSTGRESQL_FILE .
RUN bash $CONFIG_POSTGRESQL_FILE
RUN rm -rf $CONFIG_POSTGRESQL_FILE

# Set working directory
WORKDIR /
