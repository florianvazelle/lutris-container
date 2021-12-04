# Lutris

Lutris container

This container need to use [x11docker](https://github.com/mviereck/x11docker), to correctly perfoms ALSA and PulseAudio connection.

## Usage

### Setup

Clone the x11docker repository, with:
```
git clone https://github.com/mviereck/x11docker.git
```

### Build

Build the lutris container with:
```
docker build -f Dockerfile -t lutris .
```

### Run

Start the container with:
```
x11docker --alsa --pulseaudio lutris:latest lutris
```

### Options

Please refer you to the x11docker's [documentation](https://github.com/mviereck/x11docker#shared-folders-volumes-and-home-in-container) to know who to store the game data as you want.

## Reference

### Projects

- [Dockerized Lutris](https://github.com/agowa338/dockerized-lutris) by [agowa338](https://github.com/agowa338)
- [Docker PulseAudio Example](https://github.com/TheBiggerGuy/docker-pulseaudio-example) by [TheBiggerGuy](https://github.com/TheBiggerGuy)

### Articles

- [Audio In Docker](https://joonas.fi/2020/12/audio-in-docker-containers-linux-audio-subsystems-spotifyd/) by [joonas-fi](https://github.com/joonas-fi)