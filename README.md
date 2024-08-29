## Development oTree cluster setup

**N.B.** This docker setup does **not** use the official oTree source release but a development version found here (https://github.com/obeliss-nlesc/otree-core.git). This docker setup spins up 3 instances of oTree custom server with 3 accompanying Postgres databases. Its main use is for development and testing purposes. The instances are loaded with the demo apps by default.

### Running

Copy `_secrets.env` to `secrets.env` and modify accordingly.
Check `config.env` to change the default settings for the Docker images that will be built.
By default the Docker images will pull the oTree experiments from `GIT_EXP_URL` which is defined in `config.env` file.  
In a new terminal, go to the root of this project. To run a 3 oTree instance setup run:

```shell
make up
```

The 3 servers are accessed on http://localhost:9091, http://localhost:9092 and http://localhost:9093. You can log in with username `admin` and the password you assigned to `OTREE_ADMIN_PASSWORD` in your `secrets.env`.

### Stopping

To stop the services run:

```shell
make down
```

### Deleting data

To delete all otree docker containers, volumes, networks.

```shell
make clean
```
