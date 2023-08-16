
## Development oTree cluster setup
**N.B.** This docker setup does **not** use the official oTree source release but a development version found here (https://github.com/obeliss-nlesc/otree-core.git). This docker setup spins up 3 instances of oTree custom server with 3 accompanying Postgres databases. Its main use is for development and testing purposes. The instances are loaded with the demo apps by default.

### Running
Copy \_secrets.env to secrets.env and modify accordingly. 

To run a 3 oTree instance setup run:
```
make up
```
The 3 servers are accessed on localhost:9091 9092 9093
To run a single instance run:
```
make up-one
```

### Stopping

To stop the services run:
```
make down
```
or for the single instance run:
```
make down-one
```


