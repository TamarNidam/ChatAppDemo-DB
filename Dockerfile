# set base image (host OS)
FROM python:3.8
ENV FLASK_ENV development
RUN update-ca-certificates


# set the working directory in the container
WORKDIR /code

# copy the dependencies file to the working directory
COPY requirements.txt .

# install dependencies
RUN pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org -r requirements.txt

COPY / .

# command to run on container start
CMD [ "python", "./chatApp.py" ]