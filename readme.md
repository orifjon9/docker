## Deployment

### Build an image
docker build -t feedback:1 .

### Run the app on a container
docker run -d -p 3000:80 --name feedback-app feedback:1