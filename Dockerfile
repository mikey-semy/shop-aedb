FROM ubuntu:latest

RUN apt-get update && apt-get install -y sudo wget

CMD ["bash", "-c", "wget -N https://raw.githubusercontent.com/Websoft9/StackHub/main/docker-installer.sh && bash docker-installer.sh -r opencart"]
