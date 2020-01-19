FROM python:3.7

WORKDIR /app

# copy repo contents
COPY setup.py README.md ./
COPY optimade ./optimade
COPY providers/src/links/v1/providers.json ./optimade/server/data/
RUN pip install -e .[server]

# Use MaterialsCloud data
COPY mcloud ./mcloud
ENV OPTIMADE_INDEX_LINKS_PATH /app/mcloud/index_links.json

ARG PORT=5000
EXPOSE ${PORT}

COPY .docker/run.sh ./

ARG CONFIG_FILE=optimade_config.json
ENV OPTIMADE_CONFIG_FILE /app/${CONFIG_FILE}

CMD ["/app/run.sh"]
