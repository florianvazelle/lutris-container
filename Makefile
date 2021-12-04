install:
	git clone https://github.com/mviereck/x11docker.git .deps
	docker volume create lutris

build:
	docker build -f Dockerfile -t lutris .

run:
	.deps/x11docker --home=lutris --gpu --alsa --pulseaudio lutris:latest lutris

clean:
	docker volume rm lutris
	rm -rf .deps