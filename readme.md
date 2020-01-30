docker image build -f Dockerfile -t dwarvesandgiants:0.6 .
docker container run -it --name dng --entrypoint /bin/bash -h realmserver dwarvesandgiants:0.6
docker rm dng
