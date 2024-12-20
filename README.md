# Page Nook

## Running Application

### Jetty

- Configure `MAVEN_OPTS` setting up:
    - `MYSQL_HOST` - host of the database (e.g. localhost),
    - `MYSQL_PORT` - port on which MySQL is running (the default is 3306),
    - `MYSQL_DATABASE` - name of database,
    - `MYSQL_USER` - username,
    - `MYSQL_PASSWORD` - password.
- Run the following command:

```shell
./mvnw jetty:run
```

Configuring `MAVEN_OPTS` and running Jetty can be done with single command:

```shell
MAVEN_OPTS="-DMYSQL_HOST=localhost -DMYSQL_PORT=3306 -DMYSQL_DATABASE=pagenook -DMYSQL_USER=username -DMYSQL_PASSWORD=password" ./mvnw jetty:run
```

### Docker

- Build Docker image:

```shell
docker build -t pagenook .
```

- Create Docker container:

```shell
docker create -p <PORT>:<PORT> -e CATALINA_OPTS="-DMYSQL_HOST=localhost -DMYSQL_PORT=3306 -DMYSQL_DATABASE=pagenook -DMYSQL_USER=username -DMYSQL_PASSWORD=password" --name pagenook pagenook
```

- Start the container:

```shell
docker start -ai pagenook
```

## Running Database Migration

1. Create `flyway.conf` (see: [flyway_example.conf](flyway_example.conf)) file with database connection details, set up:
    - `flyway.url`,
    - `flyway.user`,
    - `flyway.password`.
2. Run the following command:

```shell
./mvnw flyway:migrate
```