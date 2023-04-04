FROM python:3.10

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# hadolint ignore=DL4006
RUN groupadd terraform && useradd -m -g terraform terraform \
    && curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash

USER terraform
COPY ./docker/requirements.txt /tmp/
COPY ./docker/.bashrc /home/terraform/.bashrc

RUN pip3 --disable-pip-version-check --no-cache-dir install -r /tmp/requirements.txt \
    && rm -rf /tmp/pip-tmp \    
    && rm -rf /tmp/pip-tmp

ENTRYPOINT [ "/bin/bash" ]