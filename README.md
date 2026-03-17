# Dockerized CHDMAN

A lightweight Docker container for running `chdman` (from the MAME tools suite). This is particularly useful for environments where installing the latest `mame-tools` natively is difficult, such as Unraid, or when you specifically need features from modern versions like `createdvd`.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- Optional: [Docker Compose](https://docs.docker.com/compose/install/)

## Installation

The easiest way to get started is to pull the pre-built image directly from Docker Hub:

```bash
docker pull laromicas/docker-chdman
```

*(Optional) To build the image manually:*
```bash
git clone https://github.com/laromicas/docker-chdman.git
cd docker-chdman
docker build -t docker-chdman .
```

---

## Execution Instructions

The container is configured with `chdman` as the entrypoint. All arguments passed to the container are directly passed to `chdman`. You need to mount the directory containing your disk images (e.g., `.bin`/`.cue` or `.iso` files) into the container so `chdman` can read them and write the resulting `.chd` files.

### Standard Docker Command

This command mounts your current directory (`$PWD`) to `/app` inside the container, sets `/app` as the working directory, and runs `chdman`:

```bash
docker run --rm -v "$PWD":/app -w /app laromicas/docker-chdman createcd -i game.cue -o game.chd
```

### Using an Alias (Recommended for ease of use)

To save typing the long Docker command every time, you can create a temporary or permanent alias in your shell:

```bash
alias chdman='docker run --rm -v "$PWD":/app -w /app laromicas/docker-chdman'
```

Now you can use `chdman` exactly as if it was installed natively:
```bash
chdman createcd -i game.cue -o game.chd
```

### Docker Compose

If you use Docker Compose and have a `compose.yaml`, you can simply run:

```bash
docker compose run --rm chdman createcd -i game.cue -o game.chd
```

---

## Unraid Instructions

Running `chdman` on an Unraid server is a great way to batch convert your ROMs directly on the NAS without transferring files over the network. Since the image is on Docker Hub, no building on Unraid is required.

### Method 1: Using the Unraid Terminal (Recommended)

The easiest way to use this on Unraid is via the built-in terminal.

1. Open the Unraid web GUI and click the **>_ (Terminal)** icon in the top right.
2. **Convert Files:**
   Navigate to the directory containing your games (e.g., your ROMs share) and run the container, mounting that specific directory:
   ```bash
   cd /mnt/user/isos/ps1_games
   docker run --rm -v "$PWD":/app -w /app laromicas/docker-chdman createcd -i "Final Fantasy VII (Disc 1).cue" -o "Final Fantasy VII (Disc 1).chd"
   ```

### Method 2: Batch Conversion Script on Unraid

To convert a whole directory of `.cue` files in Unraid, open the terminal, navigate to your games folder, and use a standard bash `for` loop combined with the docker command:

```bash
cd /mnt/user/isos/my_games
for file in *.cue; do
    docker run --rm -v "$PWD":/app -w /app laromicas/docker-chdman createcd -i "$file" -o "${file%.*}.chd"
done
```
