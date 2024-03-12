# Используем образ Jenkins LTS
FROM jenkins/jenkins:lts

# Устанавливаем переменную окружения для версии Node.js
ENV NODEJS_VERSION=14

# Установка необходимых плагинов Jenkins
RUN /usr/local/bin/install-plugins.sh \
    pipeline \
    pipeline-stage-view \
    pipeline-github-lib \
    git \
    nodejs

# Установка Node.js
USER root
RUN curl -sL https://deb.nodesource.com/setup_${NODEJS_VERSION}.x | bash -
RUN apt-get install -y nodejs

# Устанавливаем npm
RUN npm install -g npm@latest

# Возвращаемся в пользовательский режим Jenkins
USER jenkins
