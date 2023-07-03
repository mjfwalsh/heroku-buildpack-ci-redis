# Heroku CI buildpack: Redis

**Warning** this is an experimental buildpack and is provided as-is without any
-promise of support.

This is a fork of Heroku's official [redis buildpack](https://github.com/heroku/heroku-buildpack-ci-redis).

The only change is that this [buildpack](http://devcenter.heroku.com/articles/buildpacks)
doesn't try to run redis from the `.profile.d` directory.

This means that:

* You can run redis with your preferred settings, and

* The system doesn't try to run redis every time you ssh in to your dyno.

This buildpack is intended for use with Heroku CI or any other environment where data
retention is not important. Your Redis server will loose all data each time a dyno
restarts.

## Usage

The first run of this buildpack will take a while as Redis is downloaded and compiled.
Thereafter the compiled version will be cached. Redis is placed in the path. What you
do with them is up to you. `REDIS_URL` is **not** made as an environment variable.

By default Redis 7 is used, however you can specify a `REDIS_VERSION` in the `env` section of your
[app.json](https://devcenter.heroku.com/articles/heroku-ci#environment-variables-env-key)
to use a different major (e.g. "4" or "5") or exact (e.g. "6.0.16") version. This feature
is experimental and subject to change.
