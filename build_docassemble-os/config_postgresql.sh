if [[ "$(dpkg --print-architecture)" == "arm64" ]]
then
  sed -i "s/scram-sha-256$/md5/" /etc/postgresql/14/main/pg_hba.conf
  echo "password_encryption = md5" >> /etc/postgresql/14/main/postgresql.conf
  echo "host   all   all  0.0.0.0/0   md5" >> /etc/postgresql/14/main/pg_hba.conf
else
  echo "host   all   all  0.0.0.0/0   scram-sha-256" >> /etc/postgresql/14/main/pg_hba.conf
fi
echo "listen_addresses = '*'" >> /etc/postgresql/14/main/postgresql.conf
