# Planetary Annihilation in Docker optimized for Unraid

This Docker will download and install Planetary Annihilation.

This Docker supports the original version of Planetary Annihilation and the expansion Planetary Annihilation Titans.

**Update Notice:** Set the Variable 'Update on Start' to 'true' (without quotes) then the docker will check every restart if there is a newer version available otherwise leave it blank.

## Env params

| Name | Value | Example |
| --- | --- | --- |
| SERVER_DIR | Folder for gamefiles | /serverdata/serverfiles |
| PA_ACC_NAME | Your PA account name goes here, if you don't have one got to this link: https://service.planetaryannihilation.net/user/LinkSteam?TitleId=4 create an account and link your Steam account to it. | YOURPAACCOUNTNAME |
| PA_ACC_PWD | Your PA password goes here | YOURPAACCOUNTPASSWORD |
| GAME_STREAM | Choose between 'stable' and 'PTE' | stable |
| GAME_PARAMS | Extra startup parameters, if not needed leave it blank. | blank |
| SERVER_NAME | Here goes the name of you PA Server | DockerServer |
| SERVER_PWD | Here goes the Password of the Server | Docker |
| MAX_PLAYERS | Enter the maximum players on the server. | 12 |
| UPDATE_ON_START | Set to 'true' (withoute quotes) if you want to check for updates, otherwise leave it blank. | blank |
| GAME_MODE | For the standard Planetary Annihilation fill in 'lobby', for the extension Planetary Annihilation Titans fill in 'PAExpansion1:lobby' (without quotes). | lobby |
| GAME_PORT | The Game Port for the server | 20545 |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |

# Run example
```
docker run --name PlanetaryAnnihilation -d \
    -p 20545:20545 -p 8192:8192/udp \
    --env 'PA_ACC_NAME=YOURPAACCOUNTNAME' \
    --env 'PA_ACC_PWD=YOURPAACCOUNTPASSWORD' \
    --env 'GAME_STREAM=stable' \
    --env 'SERVER_NAME=DockerServer' \
    --env 'SERVER_PWD=Docker' \
    --env 'MAX_PLAYERS=12' \
    --env 'GAME_MODE=lobby' \
    --env 'GAME_PORT=20545' \
    --env 'UID=99' \
    --env 'GID=100' \
    --volume /path/to/planetaryannihilation:/serverdata/serverfiles \
    --restart=unless-stopped \
    ich777/planetaryannihilationserver
```

This Docker was mainly created for the use with Unraid, if you don’t use Unraid you should definitely try it!

#### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/