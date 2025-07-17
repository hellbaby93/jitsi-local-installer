# Makefile for Jitsi Meet Docker Setup

CONFIG_DIR=.jitsi-meet-cfg
ZIP_URL=$(shell curl -s https://api.github.com/repos/jitsi/docker-jitsi-meet/releases/latest | grep 'zip' | cut -d '"' -f4)
COMPOSE=docker compose
ENV=.env
JITSI_DIR=jitsi-docker

.PHONY: all setup config up up-jigasi up-jibri up-etherpad up-transcriber up-all clean stop restart

all: setup config up

setup:
	@echo "📦 Downloading latest Jitsi Meet Docker release..."
	rm -rf jitsi.zip jitsi-docker
	wget $(ZIP_URL) -O jitsi.zip
	@extracted_dir=$$(unzip -Z -1 jitsi.zip | head -n1 | cut -f1 -d/); \
	unzip -o jitsi.zip; \
	mv "$$extracted_dir" jitsi-docker; \
	cd jitsi-docker && cp env.example $(ENV) && ./gen-passwords.sh

config:
	@echo "🗂️ Setting up config directories..."
	mkdir -p $(CONFIG_DIR)/{web,transcripts,prosody/config,prosody/prosody-plugins-custom,jicofo,jvb,jigasi,jibri}

up:
	@echo "🚀 Starting basic services..."
	cd $(JITSI_DIR) && $(COMPOSE) up -d

up-jigasi:
	@echo "🔊 Starting with Jigasi (SIP gateway)..."
	cd $(JITSI_DIR) && $(COMPOSE) -f docker-compose.yml -f jigasi.yml up -d

up-jibri:
	@echo "📹 Starting with Jibri (recording/streaming)..."
	cd $(JITSI_DIR) && $(COMPOSE) -f docker-compose.yml -f jibri.yml up -d

up-etherpad:
	@echo "📄 Starting with Etherpad (document sharing)..."
	cd $(JITSI_DIR) && $(COMPOSE) -f docker-compose.yml -f etherpad.yml up -d

up-transcriber:
	@echo "📝 Starting with Transcriber (speech-to-text)..."
	cd $(JITSI_DIR) && $(COMPOSE) -f docker-compose.yml -f transcriber.yml up -d

up-all:
	@echo "🧩 Starting ALL components..."
	cd $(JITSI_DIR) && $(COMPOSE) -f docker-compose.yml \
			   -f jigasi.yml \
			   -f jibri.yml \
			   -f transcriber.yml up -d
stop:
	@echo "🛑 Stopping all containers..."
	cd $(JITSI_DIR) && $(COMPOSE) down


restart:
	@echo "🔁 Restarting services..."
	cd $(JITSI_DIR) && $(COMPOSE) down
	cd $(JITSI_DIR) && $(COMPOSE) up -d


clean: stop
	@echo "🧹 Cleaning configuration..."
	rm -rf $(CONFIG_DIR)
	rm -f $(ENV)
	rm -rf jitsi.zip jitsi-docker
	@echo "✅ Cleaned up configuration and stopped services."
