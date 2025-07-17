# Jitsi Meet Docker Local Installer

This project provides a Makefile to automate the setup, configuration, and management of a local [Jitsi Meet](https://jitsi.org/) instance using Docker Compose.

## Features

- **Automatic download** of the latest Jitsi Meet Docker release
- **Easy configuration** of required directories and environment files
- **One-command startup** for basic or advanced Jitsi Meet components
- **Component-specific startup** (Jigasi, Jibri, Etherpad, Transcriber)
- **Clean up** and restart utilities

## Prerequisites

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- [wget](https://eternallybored.org/misc/wget/) and [unzip](https://infozip.sourceforge.net/) available in your PATH
- [GNU Make](https://www.gnu.org/software/make/)

## Usage

Open a terminal in the `docker` directory and run:

### Setup and Start

1. **Download and prepare Jitsi Meet Docker:**
   ```sh
   make setup
   ```
   This will:
   - Download the latest Jitsi Meet Docker release
   - Extract and prepare the environment
   - Copy the example environment file and generate passwords

2. **Set up configuration directories:**
   ```sh
   make config
   ```
   This will create all required local configuration directories for Jitsi services.

3. **Start the basic Jitsi Meet services:**
   ```sh
   make up
   ```

You can also use the following commands to start additional components or manage your environment:
- `make up-jigasi` — Start with Jigasi (SIP gateway)
- `make up-jibri` — Start with Jibri (recording/streaming)
- `make up-etherpad` — Start with Etherpad (document sharing)
- `make up-transcriber` — Start with Transcriber (speech-to-text)
- `make up-all` — Start all components
- `make stop` — Stop all containers
- `make restart` — Restart services
- `make clean` — Clean up configuration and
## Directory Structure

- `.jitsi-meet-cfg/` — Local configuration for Jitsi services
- `jitsi-docker/` — Extracted Jitsi Meet Docker release
- `.env` — Environment file for Docker Compose

## Notes

- All commands must be run from the directory containing this Makefile.
- The Makefile is designed for Unix-like environments. On Windows, use WSL or ensure all required tools are available.

## License

See the [Jitsi Meet Docker repository](https://github.com/jitsi/docker-jitsi-meet)