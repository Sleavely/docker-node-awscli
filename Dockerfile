FROM node:10

RUN apt-get update && apt-get install -y python3
RUN curl -sO https://bootstrap.pypa.io/get-pip.py
RUN python3 get-pip.py

RUN pip install awscli

CMD ["node"]
