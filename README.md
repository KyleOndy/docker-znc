# ZNC #

[Docker Hub](https://hub.docker.com/r/kyleondy/znc/)

This is heavily based off of [Jimeh's docker-znc](https://github.com/jimeh/docker-znc).

I moved to alpine linux and added curl so I can use the [znc-push](https://github.com/jreese/znc-push) module.

## Todo
[ ] Make directories env variables
  [ ] znc-data
  [ ] configs
  [ ] moddata
  [ ] modules
  [ ] users
  [ ] cert path

## Organize these thoguhs

data dir in the container is `/znc-data`

Env vars:
- ZNC_DATA_DIR
- ZNC_MODULES_DIR
- ZNC_CONFIG_DIR
- NO_ZNC_PUSH
