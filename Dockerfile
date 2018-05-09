FROM python:3 AS base

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY openapi/ /usr/src/app/openapi
COPY ./python/README.pypi.rst ./python/requirements.txt ./python/constraints.txt /usr/src/app/python/
COPY ./setup.py /usr/src/app/

RUN mkdir -p python/ga4gh/dos
RUN python setup.py develop

COPY . /usr/src/app

EXPOSE 8080

ENTRYPOINT ["python3"]

CMD [ "python/ga4gh/dos/server.py" ]

FROM base as dev

# COPY ./python/dev-requirements.txt /usr/src/app/python/

RUN pip install -r python/dev-requirements.txt
