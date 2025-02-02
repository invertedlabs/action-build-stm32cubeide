# Container image that runs your code
FROM invertedlabs/stm32cubeide:latest

# RUN apt-get -y update && \
#     apt-get -y install python3 python3-pip && \
#     ln -s $(which python3) /usr/bin/python

# The requirements.txt comes from the Middlewares\ST\STM32_Secure_Engine\Utilities\KeysAndImages\ directory
# in the sitehive-stm32-sbsfu repo
COPY requirements.txt .
RUN pip install -r requirements.txt

# Add erpcgen
RUN curl -L -o /tmp/erpcgen.zip https://github.com/EmbeddedRPC/erpc/releases/download/1.9.1/Linux_x64.zip && \
    unzip -p /tmp/erpcgen.zip > /usr/bin/erpcgen && \
    chmod a+x /usr/bin/erpcgen && \
    rm /tmp/erpcgen.zip

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
