FROM python:3.11-slim AS builder

ENV POETRY_VERSION=1.3.2 \
    POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_IN_PROJECT=true \
    POETRY_HOME="/opt/poetry"

ENV PATH="$POETRY_HOME/bin:$PATH"
WORKDIR /build

# Add docker-compose-wait tool -------------------
COPY --from=ghcr.io/ufoscout/docker-compose-wait:latest /wait /wait

COPY poetry.lock pyproject.toml  ./

RUN pip install poetry

RUN poetry export \
    --without-hashes \
    -f requirements.txt \
    --output requirements.txt \
    --only main

RUN pip install --prefix /local --no-cache-dir pip && \
    pip install --prefix /local -I --no-cache-dir -r requirements.txt


FROM python:3.11-slim
ENV PYTHONUNBUFFERED=1
RUN useradd -d /app --create-home app
COPY --from=builder /local/ /usr/local
COPY --from=builder /wait /app
COPY --chown=app:app . /app
USER app
WORKDIR /app
