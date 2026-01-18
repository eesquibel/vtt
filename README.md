### Foundry VTT Docker Image

Docker image and compose setup for running Foundry Virtual Tabletop. You must already own a valid Foundry VTT license to obtain the application archive.

- Docker Hub: https://hub.docker.com/repository/docker/jignate/vtt
- Default container port: 30000 (mapped in compose)
- Persistent data directory: mounted at `/data` inside the container

### Prerequisites
- Docker and Docker Compose v2
- A licensed copy of Foundry VTT (download the `FoundryVTT-Node-13.<build>.zip` archive from your Foundry account)

### Building the image locally
1. Place `FoundryVTT-Node-13.<build>.zip` in the repo root (next to the `Dockerfile`).
2. Build with your desired Foundry and Node versions:
   ```sh
   docker build . \
     --pull \
     --build-arg VERSION=Node-13.<build> \
     --build-arg NODE_VERSION=22-alpine \
     --tag vtt:13.<build> \
     --tag vtt:13
   ```
   - `VERSION` must match the archive name (e.g., `Node-13.351`).
   - `NODE_VERSION` defaults to `22-alpine`; override if you need a different base.
   - Add `--build-arg COPY_DIR=/resources/app` if building version 12 and under

### Running with Docker Compose
1. Copy `docker-compose.yml` to the directory where you want to run Foundry and rename to `compose.yml`.
2. For each service you enable:
   - Set a unique host port on the left side of `ports` (e.g., `30013:30000`).
   - Point `volumes` to a unique local data folder on the left side (e.g., `C:/path/to/vtt/13:/data`).
3. Start the stack:
   ```sh
   docker compose up --pull always --force-recreate --detach
   ```

### Running a single container without compose
```sh
docker run -d \
  -p 30013:30000 \
  -v C:/path/to/vtt/13:/data \
  --name vtt-13 \
  jignate/vtt:13
```

### Data and upgrades
- All worlds, modules, and configs live in the mounted `/data` volume; back this up before upgrading.
- To upgrade Foundry, rebuild (or pull) the image with the new `VERSION` and restart the container pointing at the same data directory.

### Notes
- Foundry VTT is proprietary; do not redistribute the archive.
- If you change the container port, also adjust the `EXPOSE`/`ports` mapping accordingly.
