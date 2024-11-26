# Page Nook

## Running

1. Configure `MAVEN_OPTS` setting up:
    - `MYSQL_HOST` - host of the database (e.g. localhost:3306),
    - `MYSQL_DATABASE` - name of database,
    - `MYSQL_USER` - username,
    - `MYSQL_PASSWORD` - password.
2. Run the following command:

```shell
./mvnw jetty:run
```

or (if `MAVEN_OPTS` are not configured yet)

```shell
MAVEN_OPTS="-DMYSQL_HOST=localhost:3306 -DMYSQL_DATABASE=pagenookdb -DMYSQL_USER=mysql_user_username -DMYSQL_PASSWORD=mysql_user_password" ./mvnw jetty:run
```