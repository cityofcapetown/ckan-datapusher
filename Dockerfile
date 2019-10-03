FROM ubuntu:18.04
MAINTAINER Gordon Inggs 

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
 && apt-get install -y python-dev \
                       python-pip \
                       build-essential \
                       libxslt1-dev \
                       libxml2-dev \
                       git \
                       libffi-dev
RUN pip install --upgrade pip
RUN pip install -e git+https://github.com/ckan/datapusher.git@0.0.15#egg=datapusher \
 && pip install gunicorn
RUN pip install -r /src/datapusher/requirements.txt

ENV JOB_CONFIG /src/datapusher/deployment/datapusher_settings.py

EXPOSE 8800

CMD ["python", "/src/datapusher/datapusher/main.py", "/src/datapusher/deployment/datapusher_settings.py"]
