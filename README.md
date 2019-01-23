# Gift of Asynchronous Babble (GAB) Server

[![asciicast](https://asciinema.org/a/222966.svg)](https://asciinema.org/a/222966)

## Introduction
This repository is a "fork" of the original GAB server code designed by William Oropallo at the University of South Florida for CIS 4930: Advanced Javascript. This repository makes minimal changes to the original server code so that it can be deployed in a testing environment on [Heroku](https://gab-server.herokuapp.com/).

The original README bundled with the application was renamed to `README_original.md`.

## Connecting to the GAB Server
- **hostname**: gab-server.herokuapp.com
- **port**: 80

Therefore, when establishing a websocket connection from the client application, the WebSocket connection URL should look as follows:

`ws://gab-server.herokuapp.com:80/?username=<USERNAME>`

## Key Changes to GAB Server
- **When the application is run in a testing environment (where the TESTING environment variable is set), the server will automatically exit after 10 minutes**. This change was implemented so that, when the server is run with [pm2](https://www.npmjs.com/package/pm2), the server will automatically be restarted. This is valuable in a testing environment because it provides a clean testing environment every 10 minutes. Additionally, `pm2` should automatically restart the server in the event of a crash thereby minimizing downtime.

- **The server checks for BIND_ADDRESS and PORT environment variables when creating the webserver before using the original default bind address and port values**. This change is necessary because Heroku does not honor ports `EXPOSED` by the `Dockerfile`. Heroku instead sets a random `PORT` environment variable which is the ONLY port that can be bound to.

## Heroku Deployment Details
As per the build instructions identified in `heroku.yml`, Heroku builds the gab-server Docker image based on the instructions found in the `Dockerfile` before deploying the application.

## Additional Notes/Quirks
- **Problem**: Since a free Heroku instance was used to host this application, Heroku 'dynos' will idle after a long period of inactivity (no visitors); this means that you might not be able to connect to the server. 
- **Solution**: If this is the case, just open a web-browser and visit the site [https://gab-server.herokuapp.com/](https://gab-server.herokuapp.com/), and wait till you see the message: `Cannot GET /`. At this point, the application is now un-idled and your client should be able to connect normally.

## Resources
[Heroku - Docker Deployments and Runtime](https://devcenter.heroku.com/articles/container-registry-and-runtime)

[Heroku - heroku.yaml Documentation](https://devcenter.heroku.com/articles/build-docker-images-heroku-yml)