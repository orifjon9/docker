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
