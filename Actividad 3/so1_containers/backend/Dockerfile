## BUILD
# docker build --no-cache -t mibackend:0.1.0 .
## RUN
# docker run -d -p 3800:3800 -e ORACLE_USER=oracle -e ORACLE_PASS=mispass -e ORACLE_CONNSTR=localhost:1521/xepdb1 mibackend:0.1.0

FROM oraclelinux:8.7

LABEL developer="jesus guzman" \
      email="susguzman@gmail.com"

ENV ORACLE_USER=oracle \
    ORACLE_PASS=mispass \
    ORACLE_CONNSTR=localhost:1521/xepdb1 \
    SERVER_PORT=3800

# Install Oracle Client
RUN dnf install oracle-instantclient-release-el8 -y
RUN dnf install oracle-instantclient-basic -y

# Install Nodejs
RUN dnf module enable nodejs:16 -y
RUN dnf module install nodejs -y

# Copy app
COPY . /opt/app

WORKDIR /opt/app

# Npm install
RUN npm install

# Container Startup
CMD ["npm", "start"]
