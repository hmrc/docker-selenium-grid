# Docker Selenium Grid

Selenium Grid via Docker Compose at HMRC.

## Usage

### Start

Start as follows:

```bash
./start.sh
```

#### Map ports to a different target

By default, we try to automatically work out the IP address where we can reach the docker host where services are running.

If browsers aren't able to reach your services, you might need to set this explicitly, by setting a TARGET_IP environment variable in a .env file.

What the correct IP should be will depend on how you are running docker.

```
TARGET_IP=192.168.5.2
```

#### Map extra ports not present in service manager config

By default, all ports from service manager config will be accessible by the selenium browsers.

If you need access to other ports on localhost you can add them as a comma separated list in a .env file via the EXTRA_PORTS environment variable

```
EXTRA_PORTS=1234,5678
```

#### Use something other than the docker cli to run docker compose

For example, some people run all their docker stuff through `lima nerdctl`

You can change the command we use to run docker compose by setting a DOCKER_COMPOSE environment variable in a .env file.

```
DOCKER_COMPOSE="lima nerdctl compose"
```

### Stop

Stop as follows:

```bash
./stop.sh
```

### Test inspection and debugging

Navigate to http://localhost:4444 to view the Selenium Grid dashboard. From there, view Sessions to inspect and debug test execution.

## License

This code is open source software licensed under the [Apache 2.0 License]("http://www.apache.org/licenses/LICENSE-2.0.html").
