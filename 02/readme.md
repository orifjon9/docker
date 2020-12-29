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