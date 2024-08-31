#OS setup
FROM ubuntu:20.04
LABEL author="arila@axmsoftware.com"
LABEL version="1.0"

SHELL ["/bin/bash", "-xo", "pipefail", "-c"]
ENV LANG C.UTF-8
ARG TARGETARCH
ARG DEBIAN_FRONTEND=noninteractive
ARG PYTHON_VERSION=3.8


# Update the repository sources list and install gnupg2
RUN apt-get update && apt-get install -y gnupg2

# Add the package verification key
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10

# Install Git
RUN apt-get -y install sudo
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git

# Install GCC
RUN apt-get  install -y gcc
RUN apt-get install -y python${PYTHON_VERSION}-dev

# Get APIS Emulator
RUN git clone https://github.com/hyphae/apis-emulator.git
RUN apt-get install -yq --no-install-recommends python${PYTHON_VERSION}-venv
RUN apt-get install -yq --no-install-recommends python3-pip
WORKDIR /apis-emulator

# Activate Virtual Environment
ENV VIRTUAL_ENV=/opt/venv
ENV PYTHONPATH="${PYTHONPATH}:/apis-emulator"
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Install dependencies
COPY requirements.txt .
RUN which python
RUN pip install -r requirements.txt

# Run APIS Simulator with 4 instances
COPY startEmul.py .
EXPOSE 4390
#CMD . /opt/venv/bin/activate && exec python
CMD ["python3","startEmul.py","4"]
