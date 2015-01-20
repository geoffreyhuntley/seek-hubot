FROM node:0.10.35

RUN apt-get update && apt-get install -y curl build-essential git python	

ENV DOCKER_USER_NAME dockeruser
ENV DOCKER_USER_GROUP dockeruser
ENV DOCKER_USER_HOME /home/dockeruser

RUN mkdir -p $DOCKER_USER_HOME

RUN mkdir /home/dockeruser/hubot
WORKDIR /home/dockeruser/hubot

RUN groupadd -r $DOCKER_USER_GROUP -g 433 && \
useradd -u 431 -r -g $DOCKER_USER_GROUP -d $DOCKER_USER_HOME -s /sbin/nologin -c "Docker user" $DOCKER_USER_NAME && \
chown -R $DOCKER_USER_NAME:$DOCKER_USER_GROUP $DOCKER_USER_HOME

USER dockeruser

WORKDIR /home/dockeruser/hubot
RUN git clone https://github.com/SEEK-Jobs/seek-hubot.git .
RUN npm install

CMD ["/home/dockeruser/hubot/bin/hubot", "--adapter", "slack"]
#CMD ["/home/dockeruser/hubot/bin/hubot"]
