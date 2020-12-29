# Deployment

## Container & Communicating to the Web (WWW)
Out of the box container can send the requests to WWW. So, a runnig container connects to internet and gets data fron 3rd party api when GET /movies OR /people endpoints get called. No, need to set any config

### Build an image
`docker build -t favorites:1 .`

### then run it. 
`docker run -d -p 3000:3000 --env-file ./.env --rm --name favorites-app favorites:1`

## Making Container to Host Communication Work
Just needs to get a right IP address. And how docker knows about Host IP. There is a solution. Use `host.docker.internal` as address If you put this domain in our code or config file then docker container forwards this call to host machine. You can usw it anywhere. So `localhost` doesn't work because it for services inside of a docker container

### Build an image
`docker build -t favorites:2 .`

### then run it. 
`docker run -d -p 3000:3000 --env-file ./.env --rm --name favorites-app favorites:2`

## Container to Container Communication (Base a solution):
Now, you can call GET and POST /favorites endpoints to save favorite movies in mongodb and get

### We need to run mongodb server on another container
`docker run -d --name mongodb mongo`
### Needs to get IP address in docker. There is a IPAddress field under NetworkSettings. Then put that IPAddress in config there MongoDB connection host
`docker container inspect mongodb`

### Build an image
`docker build -t favorites:3 .`

### then run it. 
`docker run -d -p 3000:3000 --env-file ./.env --rm --name favorites-app favorites:3`

##  Introducing Docker Networks: Elegant Container to Container Communication
Let's put all containers in a network and isolate from others. So, MongoDb and Api will in the same network. It will resolve IP issue that doesn't require find and set. So, two containers can't coomunicate each others unless a network

### Ypu need to have or create a docker netwprk if a it doesn't exist
`docker network create favorites-net`
### We need to create mongodb server on another container but inside of the created network
`docker run -d --name mongodb --network favorites-net mongo`


### Set mongodb service container name as address in the mongo db connection string. Containers know each others with names in they are in the same network and in build an image
`docker build -t favorites:4 .`

### then run it. 
`docker run -d -p 3000:3000 --env-file ./.env --rm --name favorites-app --network favorites-net favorites:4`


## Docker Network Drivers
Docker Networks actually support different kinds of "Drivers" which influence the behavior of the Network.

The default driver is the "bridge" driver - it provides the behavior shown in this module (i.e. Containers can find each other by name if they are in the same Network).

The driver can be set when a Network is created, simply by adding the --driver option.

`docker network create --driver bridge my-net`
Of course, if you want to use the "bridge" driver, you can simply omit the entire option since "bridge" is the default anyways.

Docker also supports these alternative drivers - though you will use the *"bridge"* driver in most cases:

*host*: For standalone containers, isolation between container and host system is removed (i.e. they share localhost as a network)

*overlay*: Multiple Docker daemons (i.e. Docker running on different machines) are able to connect with each other. Only works in "Swarm" mode which is a dated / almost deprecated way of connecting multiple containers

*macvlan*: You can set a custom MAC address to a container - this address can then be used for communication with that container

*none:* All networking is disabled.

Third-party plugins: You can install third-party plugins which then may add all kinds of behaviors and functionalities

As mentioned, the "bridge" driver makes most sense in the vast majority of scenarios.