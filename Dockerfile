FROM ubuntu:26.04
USER root
RUN mkdir -p /etc/dpkg/dpkg.cfg.d \
&& printf 'path-exclude /usr/share/doc/*\npath-include /usr/share/doc/*/copyright\npath-exclude /usr/share/man/*\npath-exclude /usr/share/groff/*\npath-exclude /usr/share/info/*\npath-exclude /usr/share/lintian/*\npath-exclude /usr/share/linda/*\n' > /etc/dpkg/dpkg.cfg.d/01_nodoc
RUN DEBIAN_FRONTEND=noninteractive TERM=xterm \
apt-get -q -y -o Acquire::Retries=3 update \
&& apt-get -q -y -o Acquire::Retries=3 upgrade \
&& apt-get -q -y -o Acquire::Retries=3 dist-upgrade  \
&& ln -snf /usr/share/zoneinfo/America/New_York /etc/localtime \
&& echo America/New_York > /etc/timezone \
&& echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections \
&& apt-get -q -y -o Acquire::Retries=3 install language-pack-en \
&& apt-get -q -y -o Acquire::Retries=3 install \
apt-utils \
tzdata \
wget \
unzip \
git \
locales \
nginx \
apache2 \
apache2-utils \
apache2-dev \
postgresql \
libapache2-mod-xsendfile \
gcc \
supervisor \
s4cmd \
make \
perl \
libinline-perl \
libparallel-forkmanager-perl \
autoconf \
automake \
libjpeg-dev \
libpq-dev \
logrotate \
npm \
cron \
libxml2-16 \
libxslt1.1 \
libvulkan1 \
libxml2-dev \
libxslt1-dev \
libcurl4-openssl-dev \
libssl-dev \
redis-server \
rabbitmq-server \
libtool \
libtool-bin \
syslog-ng \
rsync \
curl \
dnsutils \
build-essential \
fonts-liberation \
fonts-dejavu-core \
libsvm3 \
libsvm-dev \
liblinear4 \
liblinear-dev \
libzbar-dev \
libzbar0 \
libgs-dev \
default-libmysqlclient-dev \
libgmp-dev \
python3-passlib \
python3-pip \
python3-venv \
python3-dev \
python3-scipy \
libsasl2-dev \
libldap2-dev \
exim4-daemon-heavy \
imagemagick \
pdftk \
pacpl \
pandoc \
texlive \
texlive-luatex \
texlive-xetex \
texlive-latex-recommended \
texlive-latex-extra \
texlive-font-utils \
texlive-lang-all \
texlive-extra-utils \
poppler-utils \
libaudio-flac-header-perl \
libaudio-musepack-perl \
libmp3-tag-perl \
libogg-vorbis-header-pureperl-perl \
libvorbis-dev \
libcddb-perl \
libcddb-get-perl \
libmp3-tag-perl \
libaudio-scan-perl \
libaudio-flac-header-perl \
ffmpeg \
tesseract-ocr-all \
libtesseract-dev \
ghostscript \
qpdf \
wamerican \
libreoffice \
zlib1g-dev \
libncurses5-dev \
libncursesw5-dev \
libreadline-dev \
libsqlite3-dev \
liblapack-dev \
libblas-dev \
gfortran \
unixodbc-dev \
libaugeas0 \
libaugeas-dev \
busybox \
libdbus-1-dev \
libopenblas-dev \
pkg-config \
cmake \
ninja-build \
meson \
libhighs-dev \
&& apt-get -q -y -o Acquire::Retries=3 install \
libgdbm-dev \
libdb5.3-dev \
libbz2-dev \
libexpat1-dev \
liblzma-dev \
libffi-dev \
uuid-dev \
whiptail \
&& cd /tmp \
&& apt-get -q -y remove libreoffice-report-builder \
&& wget https://github.com/relvinarsenio/ttf-mscorefonts-installer/releases/download/release-uw11/ttf-mscorefonts-installer_uw11_all.deb \
&& dpkg -i ttf-mscorefonts-installer_uw11_all.deb \
&& rm ttf-mscorefonts-installer_uw11_all.deb \
&& apt-get -q -y remove nodejs \
&& apt-get -q -y remove nodejs-doc \
&& curl -fsSL https://deb.nodesource.com/setup_current.x | bash \
&& apt-get -q -y -o Acquire::Retries=3 install nodejs \
&& npm install -g @mermaid-js/mermaid-cli \
&& npm cache clean --force \
&& curl -sL https://aka.ms/InstallAzureCLIDeb | bash \
&& apt-get -q -y autoremove \
&& apt-get -q clean \
&& rm -rf /var/lib/apt/lists/* \
&& bash -c \
'cd /tmp && if [[ "$(dpkg --print-architecture)" == "amd64" ]]; then wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && dpkg -i ./google-chrome-stable_current_amd64.deb && rm ./google-chrome-stable_current_amd64.deb && wget -q https://github.com/jgm/pandoc/releases/download/3.12.1/pandoc-3.12.1-1-amd64.deb && dpkg -i pandoc-3.12.1-1-amd64.deb && rm pandoc-3.12.1-1-amd64.deb; elif [[ "$(dpkg --print-architecture)" == "arm64" ]]; then wget -q https://github.com/jgm/pandoc/releases/download/3.12.1/pandoc-3.12.1-1-arm64.deb && dpkg -i pandoc-3.12.1-1-arm64.deb && rm pandoc-3.12.1-1-arm64.deb; fi;'
RUN DEBIAN_FRONTEND=noninteractive TERM=xterm \
cd /tmp \
&& sed -i 's|</policymap>|  <policy domain="coder" rights="read \| write" pattern="PDF" />\n</policymap>|' /etc/ImageMagick-7/policy.xml \
&& sed -i 's/^#PATH/PATH/' /etc/crontab
RUN DEBIAN_FRONTEND=noninteractive TERM=xterm \
cd /tmp \
&& mkdir -p /etc/ssl/docassemble \
   /usr/share/docassemble/local3.14 \
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
   /var/www/nascent \
&& chown -R www-data:www-data /var/www \
&& chown www-data:www-data /var/run/uwsgi \
&& chsh -s /bin/bash www-data \
&& echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
&& locale-gen \
&& update-locale
RUN DEBIAN_FRONTEND=noninteractive TERM=xterm \
bash -c \
"printf '[global]\ndisable-pip-version-check = True\n' > /usr/share/docassemble/local3.14/pip.conf \
&& python3 -m venv --copies /usr/share/docassemble/local3.14 \
&& source /usr/share/docassemble/local3.14/bin/activate \
&& pip install --upgrade pip==26.2.2 \
&& pip install --upgrade mod_wsgi==6.0.5 \
&& pip install --upgrade \
   certbot==5.7.0 \
   certbot-apache==5.7.0 \
   certbot-nginx==5.7.0 \
   minio==7.2.20 \
   uWSGI==2.0.31 \
&& pip install --no-cache-dir \
   docassemble.base \
   docassemble.demo \
   docassemble.webapp \
&& pip cache purge \
&& { if [[ \"$(dpkg --print-architecture)\" == \"amd64\" ]]; then cp /usr/share/docassemble/local3.14/lib/python3.14/site-packages/mod_wsgi/server/mod_wsgi-py314.cpython-314-x86_64-linux-gnu.so /usr/lib/apache2/modules/mod_wsgi.so-3.14; else cp /usr/share/docassemble/local3.14/lib/python3.14/site-packages/mod_wsgi/server/mod_wsgi-py314.cpython-314-aarch64-linux-gnu.so /usr/lib/apache2/modules/mod_wsgi.so-3.14; fi; } \
&& rm -f /usr/lib/apache2/modules/mod_wsgi.so \
&& ln -s /usr/lib/apache2/modules/mod_wsgi.so-3.14 /usr/lib/apache2/modules/mod_wsgi.so \
&& rm -f /etc/cron.daily/apt-compat \
&& sed -i -e 's/^\(daemonize\s*\)yes\s*$/\1no/g' -e 's/^bind 127.0.0.1/bind 0.0.0.0/g' /etc/redis/redis.conf \
&& sed -i -e 's/#APACHE_ULIMIT_MAX_FILES/APACHE_ULIMIT_MAX_FILES/' -e 's/ulimit -n 65536/ulimit -n 8192/' /etc/apache2/envvars \
&& sed -i '/session    required     pam_loginuid.so/c\#session    required   pam_loginuid.so' /etc/pam.d/cron \
&& LANG=en_US.UTF-8 \
&& { a2dismod ssl \
; a2enmod rewrite \
; a2enmod xsendfile \
; a2enmod proxy \
; a2enmod proxy_http \
; a2enmod proxy_wstunnel \
; a2enmod headers \
; a2enconf docassemble \
; echo 'export TERM=xterm' >> /etc/bash.bashrc; } \
&& ln -s /var/mail/mail /var/mail/root \
&& chmod 755 /etc/ssl/docassemble \
&& cd /tmp \
&& /usr/bin/pip3 install --break-system-packages unoserver==3.6 \
&& /usr/bin/pip3 cache purge \
&& cp /usr/local/bin/unoserver /usr/bin/unoserver \
&& cp /usr/local/bin/unoconvert /usr/bin/unoconvert"

USER www-data
RUN --mount=type=bind,source=.,target=/tmp/nltk \
bash -c \
"echo '{ \"args\": [\"--no-sandbox\"], \"executablePath\": \"/usr/bin/google-chrome\" }' > ~/puppeteer-config.json \
&& cd /tmp \
&& source /usr/share/docassemble/local3.14/bin/activate \
&& python /tmp/nltk/nltkdownload.py \
&& cd /var/www/nltk_data/corpora \
&& if [ ! -d wordnet ]; then unzip -o wordnet.zip; fi \
&& if [ ! -d omw-1.4 ]; then unzip -o omw-1.4.zip; fi \
&& if [ ! -d wordnet_ic ]; then unzip -o wordnet_ic.zip; fi \
&& if [ ! -d sentiwordnet ]; then unzip -o sentiwordnet.zip; fi \
&& if [ ! -d stopwords ]; then unzip -o stopwords.zip; fi \
&& rm -f wordnet.zip omw-1.4.zip wordnet_ic.zip sentiwordnet.zip stopwords.zip \
&& cd /var/www/nltk_data/tokenizers \
&& if [ ! -d punkt ]; then unzip -o punkt.zip; fi \
&& rm -f punkt.zip \
&& cd /tmp \
&& mkdir -p /tmp/conv \
&& pandoc --pdf-engine=lualatex -M latextmpdir=./conv -M pdfa=false /usr/share/docassemble/local3.14/lib/python3.14/site-packages/docassemble/base/data/templates/Legal-Template.yml --template=/usr/share/docassemble/local3.14/lib/python3.14/site-packages/docassemble/base/data/templates/Legal-Template.tex --from=markdown+raw_tex-latex_macros -s -o /tmp/temp.pdf /usr/share/docassemble/local3.14/lib/python3.14/site-packages/docassemble/base/data/templates/hello.md \
&& rm /tmp/temp.pdf \
&& pandoc --pdf-engine=lualatex -M latextmpdir=./conv -M pdfa=false --template=/usr/share/docassemble/local3.14/lib/python3.14/site-packages/docassemble/base/data/templates/Legal-Template.rtf -s -o /tmp/temp.rtf /usr/share/docassemble/local3.14/lib/python3.14/site-packages/docassemble/base/data/templates/hello.md \
&& rm /tmp/temp.rtf"

USER root
RUN bash -c "\
if [[ \"$(dpkg --print-architecture)\" == \"arm64\" ]]; then \
  sed -i \"s/scram-sha-256$/md5/\" /etc/postgresql/18/main/pg_hba.conf \
  && echo \"password_encryption = md5\" >> /etc/postgresql/18/main/postgresql.conf; \
  echo \"host   all   all  0.0.0.0/0   md5\" >> /etc/postgresql/18/main/pg_hba.conf; \
else \
  echo \"host   all   all  0.0.0.0/0   scram-sha-256\" >> /etc/postgresql/18/main/pg_hba.conf; \
fi; \
echo \"listen_addresses = '*'\" >> /etc/postgresql/18/main/postgresql.conf;"

USER ubuntu
CMD ["bash"]
