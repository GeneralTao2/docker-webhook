[generaltao725/docker-webhook](https://hub.docker.com/repository/docker/generaltao725/docker-webhook/general) is a docker image that allows you to keep your docker compose projects up-to-date. It listens for DockerHub webhooks, and on an incoming webhook, it pulls an image, extracts a docker-compose file, and then starts/restarts the docker compose project.

The image is based on [thecatlady/webhook](https://hub.docker.com/r/thecatlady/webhook) image and wraps [adnanh/webhook](https://github.com/adnanh/webhook) application.

### Usage
An example of the usage of the image can be found in a [test](test/run-project-on-post-request/docker-compose.yml).

### Prerequiremnts 
 - Target images must have a docker compose project placed into `/docker` directory of the image
 - Docker compose yml file must be named as `docker-compose.yml`
 - Works only with public images from DockerHub
 - Is triggered only on an image being updated with `latest` tag
 - Requires a cache folder `/etc/webhook/cache` that should be mounted in the docker host filesystem.

### Configuration 
 - `WEBHOOK_SECRET` - you have to create a webhook with a secret placed into its URL `http://<server_ip>/hooks/<webhook_secret>/docker-webhook`. The secret can be then loaded as an environment variable `WEBHOOK_SECRET` in `docker-webhook` service. The secret is used for security purposes.
 - `DOCKER_USERNAME` - an env var that contains your DockerHub username.
 - `project-whitelist.list` - is a file with target image names being listed (without owner name). The tool will check if the list contains the image name from webhook details and will proceed         only on finding a match. Each image name should be written from the new line. The file should placed in `shared/config` folder and the `shared` folder should be mounted into `/etc/webhook/shared` of the container.
 - `envs` - a folder that loads env vars for each docker compose project. Envs should be stored in `.envs` file a placed in `shared/<image_name>/` folder. The `shared` folder should be mounted into `/etc/webhook/shared` of the container. This configuration is optional.

### Used in
 - [taonity/prodenv](https://github.com/taonity/prodenv)
