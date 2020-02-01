# Dwarves and Giants Server

## Building the Docker Image
This only needs to be done the first time, and any subsequent time if ANY of the files or options change.
```sh
docker image build -f Dockerfile -t dwarvesandgiants:0.1 .
```
Note, the `0.1` can be any number, you may want to increment that with each new build

## Creating a Container
To run the server, you need to use the image we created above to now create a container. You can decide to either run the server locally (only access from host computer) or as a network device (access from external computers, but NOT the host).

### Running the server locally (access from host computer only) or
To run the server locally, do so with the following command 
```sh
docker container run -it --name dng -h realmserver dwarvesandgiants:0.1
```

### Running as a network device (access from any computer, EXCEPT host)
To run as if the docker where a regular network device, you first need to setup a docker macvlan network. This works on linux only!
The easier way to set this up is to ensure you have `net-tools` installed. If you do not, run `sudo apt install net-tools`

Then, run `netstat -r -n` and pay attention to a few numbers:
1. You should see a few values in the `Iface` category. choose the interface you want to create the macvlan network on. DON'T choose the `docker0` Iface. Typically, you will want to find the Iface with the `Destination` column value which matches your internal (LAN) ip address. In my case, the Iface value is `enp8s0`
2. Now, look through all the rows and find the row with a `Gateway` value for the Iface you want; mine is `192.168.1.1`
3. Then run the `ip a` command and find the interface name that you selected above (i.e `enp8s0`) Under that interface, you will see an `inet ` row, followed by an ip/number. this is the subnet of the interface, and you will need to take a note of it. mine is `192.168.1.193/24`

Ok, so we have all the numbers. Now run the following command, filling in your values from above:
`docker network create -d macvlan --subnet=$SUBNET --gateway=$GATEWAY -o parent=$IFACE realm_net`

`realm_net` is the name of the network, and can be whatever you want.

Lastly, now that we have the docker network, we need to run the container and select that network with the following command
`docker container run -it --name dng -h realmserver --net realm_net dwarvesandgiants:0.1`

- Again, the version can be any number, so long as you have previously created a corresponding image.
The above command with bring you INTO the docker. You will now be in a new containerized system.


## Starting the servers
Once the container starts, you should already find the servers running.

BELOW NEEDS UPDATE
, you should already be in the /opt/streborn directory. From the current directory, run:
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


