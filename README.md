## Supported tags and respective Dockerfile links
latest ([Dockerfile](https://github.com/alexanderschnitzler/docker-mysqldump/blob/master/Dockerfile))

The container is based on `alpine:3.18`, thus it is very small.


## What is schnitzler/mysqldump?

This container can be used in two ways. It is prepared to run `crond` by default, so you can integrate this container in your `docker-compose.yml` and do regularly backups defined by a `crontab` and backup `script`.

Additionaly you can use this container to create single backups. In this case scroll to the very bottom of this documentation.

## Use as cronjob container

Here is an example configuration for using the container with a crontab.

##### Directory structure:
```
.
├── backup
├── bin
│   ├── backup
│   └── crontab
└── docker-compose.yml
```

##### Directory listing of the `bin` folder:
```
$ ls -al
total 16
drwxrwxr-x 2 whoami whoami 4096 Feb 25 17:51 .
drwxrwxr-x 4 whoami whoami 4096 Feb 25 17:51 ..
-rwx------ 1 root       root        175 Feb 25 17:51 backup
-rw------- 1 root       root         69 Feb 25 17:51 crontab
```

Mind the file permissions!  
`chown 0:0 backup && chmod 700 backup`  
`chown 0:0 backup && chmod 600 crontab`

##### docker-compose.yml
```
version: '2'
services:
  db:
    image: mariadb:10.1
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: password
      MYSQL_USER: user
      MYSQL_PASSWORD: password
      MYSQL_DATABASE: database
  cron:
    image: schnitzler/mysqldump
    restart: always
    volumes:
      - ./bin/crontab:/var/spool/cron/crontabs/root
      - ./bin/backup:/usr/local/bin/backup
    volumes_from:
      - backup
    command: ["-l", "8", "-d", "8"]
    environment:
      MYSQL_HOST: db
      MYSQL_USER: user
      MYSQL_PASSWORD: password
      MYSQL_DATABASE: database
  backup:
    image: busybox
    volumes:
      - ./backup:/backup
```

##### bin/crontab
```
#minute hour    day     month   week    command
0       0       *       *       *       /usr/local/bin/backup
```

##### bin/backup
```
#!/bin/sh

now=$(date +"%s_%Y-%m-%d")
/usr/bin/mysqldump --opt -h ${MYSQL_HOST} -u ${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} > "/backup/${now}_${MYSQL_DATABASE}.sql"
```

## Use as cronjob container (without overwriting bin/crontab)

The container has a proper crontab by default:

```
# do daily/weekly/monthly maintenance
# min	hour	day	month	weekday	command
*/15	*	*	*	*	run-parts /etc/periodic/15min
0	*	*	*	*	run-parts /etc/periodic/hourly
0	2	*	*	*	run-parts /etc/periodic/daily
0	3	*	*	6	run-parts /etc/periodic/weekly
0	5	1	*	*	run-parts /etc/periodic/monthly
```

If these execution times suffice, you can simply mount your backup script into the proper folder:

```
version: '2'
services:
  ...
  cron:
    image: schnitzler/mysqldump
    restart: always
    volumes:
      - ./bin/backup:/etc/periodic/daily/backup
    volumes_from:
      - backup
    command: ["-l", "8", "-d", "8"]
    environment:
      MYSQL_HOST: db
      MYSQL_USER: user
      MYSQL_PASSWORD: password
      MYSQL_DATABASE: database
  ...
```

## Use for a single backup

In this case you simply empty the `entrypoint` and run the mysqlump `command`.

```
docker run \
    --rm --entrypoint "" \
    -v `pwd`/backup:/backup \
    --link="container:alias" \
    schnitzler/mysqldump \
    mysqldump --opt -h alias -u user -p"password" "--result-file=/backup/dumps.sql" database
```
