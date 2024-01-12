# Docker Selenium Grid

Selenium Grid via Docker Compose at HMRC.

## Usage

### Start

Set `PORTS` environment variable as follows:

```bash
export PORTS=$(sm2 --status | grep PASS | awk '{ print $8 }' | paste -sd "," -),11000,6010
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
