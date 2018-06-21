# Mediawiki 1.31 docker-compose

To run this installation, please make sure you have both docker and docker-compose installed. While these tools say they work on Windows, I do recommend using a Linux or macOS machine.

- https://docs.docker.com/install/
- https://docs.docker.com/compose/install/

## Run the wiki

Please execute folowing commands in this directory
```bash
docker-compose up --build
```
Now visit: http://localhost:8080/

## Cleanup

Please execute folowing commands in this directory
```bash
docker-compose rm -f
docker volume rm mediawiki131_db-data
```

### Example output

Main page:

![Main page](https://i.imgur.com/zKbxFD1.png)

Generate docbook:

![Generate docbook](https://i.imgur.com/QoDPkuP.png)
