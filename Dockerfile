FROM python:3.6-jessie
MAINTAINER Tobias Oberrauch "tobias.oberrauch@aidriven.business"

# Set working directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install other dependencies
COPY requirements.txt /usr/src/app/
RUN pip3 install -r requirements.txt

ENTRYPOINT ["python3"]
CMD ["-u", "/usr/src/app/app.py"]
