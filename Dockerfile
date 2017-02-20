FROM python:2.7.11
MAINTAINER liealberttriadrian <alberttri23@gmail.com>

# Install dependencies via apt
RUN apt-add-repository ppa:webupd8team/java && apt-get update && apt-get install -y \
	curl \
    git \
    oracle-java7-installer

# Initiate the project folder
RUN mkdir spark

# Download and install spark
RUN curl http://d3kbcqa49mib13.cloudfront.net/spark-2.0.2.tgz | tar xvz -C spark
RUN cd spark && ./build/mvn -DskipTests clean package

# Copy spark history server env
COPY spark-env.sh spark/conf

# Start the history server
RUN ./sbin/start-history-server.sh

# Start spark-shell
CMD ./bin/spark-shell