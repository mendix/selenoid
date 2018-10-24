FROM golang:latest
RUN apt install -y ca-certificates tzdata && rm -Rf /var/cache/apt/*

RUN mkdir /app
ADD . /app/
WORKDIR /app
RUN go build -o selenoid -tags='s3'
RUN cp selenoid /usr/bin

EXPOSE 4444
ENTRYPOINT ["/usr/bin/selenoid", "-listen", ":4444", "-conf", "/etc/selenoid/browsers.json", "-video-output-dir", "/opt/selenoid/video/"]
