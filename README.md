# FastAPI kafka

Tuto from: https://ahmed-nafies.medium.com/fastapi-event-driven-development-with-kafka-zookeeper-and-docker-compose-a-step-by-step-guide-3e07151c3e4d

## run

```bash
docker compose up -d
```

## Create topic

switch to container shell

```bash
docker exec -it kafka bash
```

run

```bash
kafka-topics --create --topic test.events --bootstrap-server kafka:29092 --partitions 4 --replication-factor 1
```
