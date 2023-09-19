# Shortner

Shortener is a simple project built to demonstrate setting up a Phoenix project to run with Docker Compose. It has the following functionality:

1. Visiting "/" will bring up a form for entering a URL and getting a shortened URL alias.
1. Visiting any shortened link (e.g. "http://localhost:4000/aR6tZq") will redirect you to the original URL.
1. Visiting "/stats" will show a list of all URL aliases that have been created, the original URL, and the number of times they have been visited.
1. The "Export" link on the "/stats" page will download a CSV of all of the shortened URLs, the original URLs, and the number of times they have been visited.

## Installation

Shortener is designed to be easy to install. The only prerequisites are Docker and Docker Compose. Shortener was built with Docker 20.10.10 and Docker Compose v2.1.1. 

1. Clone this repository: `git clone git@github.com:philosodad/shortener.git`
1. Navigate to the "shortener" folder: `cd shortener`
1. Start the docker containers: `docker compose up` This may take some time as Docker downloads all necessary files and the application compiles.
1. Shortener should now be running and available on `http://localhost:4000`

## Running tests

In order to run the tests, you will need to connect to the container in your terminal.

1. Find the container name: `docker ps`
1. ssh into the container: `docker exec -it <container-name> /bin/bash`
1. create the test database: `MIX_ENV=test mix.ecto setup`
1. run the tests `MIX_ENV=test mix test`

## Development

To run Shortener in a more development friendly way, you may want to follow these steps:

1. Shut down the containers: `docker compose stop`
1. Edit line 10 of `docker-compose.yml` to read `command: bash`
1. Start the containers: `docker compose up`

Now you can connect to the container as described above and start the server manually. This will make development easier if you find you frequently need to restart the server. If you only restart the server occasionally you can skip this. Beyond that simply create and edit files on your host machine as you normally would. You will want to `docker exec` into the container to run any mix tasks, particularly db tasks.
