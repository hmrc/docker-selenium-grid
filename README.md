# Docker Selenium Grid

Selenium Grid via Docker Compose at HMRC.

## Usage

### Start

Set `TARGET_PORTS` environment variable as follows:

```bash
export TARGET_PORTS=$(sm2 --status | grep PASS | awk -F '|' '{ print $5 }' | tr -d "[:blank:]" | paste -sd "," -),11000,6010
```

Start as follows:

```bash
docker compose up -d
```

Start as follows (ARM):

```bash
docker compose -f docker-compose.arm.yaml up -d
```

### Stop

Stop as follows:

```bash
docker compose down
```

## License

This code is open source software licensed under the [Apache 2.0 License]("http://www.apache.org/licenses/LICENSE-2.0.html").
