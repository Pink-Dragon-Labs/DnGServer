# Dwarves and Giantes Server

## Building the Docker Image
This only needs to be done the first time, and any subsequent time if ANY of the files or options change.
```sh
docker image build -f Dockerfile -t dwarvesandgiants:0.1 .
```
Note, the `0.1` can be any number, you may want to increment that with each new build

## Creating a Container
To run the server, you need to use the image we created above to now create a container. Do so with the following command 
```sh
docker container run -it --name dng --entrypoint /bin/bash -h realmserver dwarvesandgiants:0.1
```
Again, the version can be any number, so long as you have previously created a corresponding image.
The above command with bring you INTO the docker. You will now be in a new containerized system.


## Starting the servers
Once inside the container, you should already be in the /opt/streborn directory. From the current directory, run:
```sh
./startrealm.sh
```
This will seem to do nothing, but it is creating a new tmux session in the background, and starting 4 windows, one for each of the servers.
To view the servers, type the command:L
```sh
tmux a
```
which stands for `tmux attach` since we are attaching to the tmux session.

Again, tmux is like a containerized bash shell, whith multiple windows. To switch windwos, find the number of the window you want at the bottom, and type `ctrl-b` followed immediately by the corresponding number.

To exit tmux altogether, press `ctrl-d` for `dettach`. This will keep the servers running in the background, and you can always re-attach with `tmux a`

## Exiting the docker
To exit the docker container, type `ctrl-d`. This will SHUT DOWN the container, and any servers it is running.

## Deleting the container
To delete the container you created, use the following 
```sh
docker rm dng
```
where `dng` matches the value you specified for `--name ...` in the `docker container run ... ` command above.

## Restarting a container that you have left
This will restart a container. Think of this as turning on a computer.
```sh
docker start dng
```
where `dng` is the name

Then, to enter the container, use:
```sh
docker attach dng
```


