install:
	git clone https://github.com/mviereck/x11docker.git .deps

build:
	docker build -f Dockerfile -t lutris .

run:
	.deps/x11docker --home --gpu --alsa --pulseaudio lutris:latest

clean:
	rm -rf .deps