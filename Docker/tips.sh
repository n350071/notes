# delete all no tag images
docker rmi $(docker images | grep '<none>' | awk '{print$3}')
