FROM frolvlad/alpine-mono:5.20-glibc

ARG USER=windward
ARG GROUP=windward
ARG PUID=1000
ARG PGID=1000

ENV WINDWARD_SERVER_NAME="Windward Horizon Server" \
    WINDWARD_SERVER_WORLD="World" \
    WINDWARD_SERVER_PORT=5123 \
    WINDWARD_SERVER_PUBLIC=0

RUN apk --update --no-cache add bash curl unzip

RUN mkdir -p /windward && \
    chmod ugo=rwx /windward && \
	addgroup -g $PGID -S $GROUP && \
	adduser -u $PUID -G $GROUP -s /bin/sh -SD $USER && \
    chown -R $USER:$GROUP /windward /home/windward && \
	ln -s /windward /home/windward/Windward
	
VOLUME /windward

EXPOSE $WINDWARD_SERVER_PORT

COPY ./windward.sh /

USER $USER

CMD ["/windward.sh"]
