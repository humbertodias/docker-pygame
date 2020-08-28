build:
	docker build . -t hldtux/pygame

xhost:
	xhost +	

run-linux:	xhost
	docker run -it --rm -u 1000:1000
	-e DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v ~/Downloads:/home/docker \
	hldtux/pygame xterm

run-mac:	xhost
	docker run --privileged -it --rm -u 1000:1000 \
	--cap-add=SYS_PTRACE \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-e DISPLAY=docker.for.mac.host.internal:0 \
	-v ~/.config/pulse:/run/user/1000/pulse \
	-v ~/Downloads:/home/docker \
	hldtux/pygame xterm

run-windows:
	docker run --privileged -it --rm --cap-add=SYS_PTRACE -u 1000:1000 -e DISPLAY=127.0.0.1:0.0 -v %userprofile%\Downloads:/home/docker hldtux/pygame
