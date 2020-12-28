# Deployment

## Container & Communicating to the Web (WWW)
Out of the box container can send the requests to WWW. So, a runnig container connects to internet and gets data fron 3rd party api when GET /movies OR /people endpoints get called. No, need to set any config
Build an image
`docker build -t favorites:1 .`

then run it. 
`docker run -d -p 3000:3000 --env-file ./.env --rm --name favorites-app favorites:1`