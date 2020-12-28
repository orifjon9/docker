# Deployment

## Build an image
docker build -t feedback:1 .

### Run the app on a container
docker run -d -p 3000:80 --name feedback-app --rm feedback:1

## Add volumes
#### Anonynous volume and lose files if a container removes
docker run -d -p 3000:80 --name feedback-app -v /app/feedback feedback:1 

#### Named volume and keeps if a container removes
docker run -d -p 3000:80 --name feedback-app -v feedback:/app/feedback feedback:1 

#### Bind Mount if you want to sync files between a docker and pc and see changes live mode
docker run -d -p 3000:80 --name feedback-app -v "{FOLDER_PATH_PC}":/app feedback:1 


## ENVironment varibales
### Set environment variables through cli commad
docker run -d -p 3000:8000 --name feedback2-app --env PORT 8000 --env FILE feedback:2

### Set environment file
docker run -d -p 3000:8000 --name feedback2-app --env-file ./.env --name feedback:2

## ARGument variables
### it applies only on build images time and you can't change when you run
docker build -t feedback:dev --build-arg DEFAULT_PORT 8000 .