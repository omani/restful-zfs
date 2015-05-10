# restful-zfs
A JSON REST API for the ZFS cli

## Provides a RESTful API for ZFS

## Goal
Our goal is to have a working JSON API for the whole ZFS cli (currently tested under FreeBSD).
Please have a look at the **Features** section for more information about what is currently supported.

*This API will be help us to build some beautiful web UIs for the ZFS tools on FreeBSD.*

## Features (currently)
* List ZFS pools
* Create ZFS pools
* and many more soon...

## Dependencies
The following perl modules are required:
* Mojolicious (https://metacpan.org/pod/Mojolicious)
* YAML (https://metacpan.org/pod/distribution/YAML/lib/YAML.pod)
* Mojolicious::Plugin::Swagger2 (https://metacpan.org/pod/Mojolicious::Plugin::Swagger2)
* Backticks (https://metacpan.org/pod/Backticks)

## Getting Started
Get cpanminus

```
curl -L https://cpanmin.us | perl - App::cpanminus
```

## Install dependencies

```
git clone https://github.com/omani/restful-zfs.git
cd restful-zfs
cpanm -L extlib Mojolicious YAML Mojolicious::Plugin::Swagger2 Backticks
```

### Start API on localhost (port 3000)
```
./start.sh
```

### To work with the Swagger2 UI editor (web UI listening on port 4000)
```
./start_swaggerUI.sh
```

## Documentations
* Swagger2 spec (https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md)
* The excellent Mojolicious Documentation (http://mojolicio.us/perldoc)

## Contributions
Feel free to contribute
* Fork repository
* Change files
* Commit
* Start pull request
* Get your name into the list of contributors

## Maintainer
Hasan Pekdemir
hpekdemir.smart@googlemail.com

## License
See LICENSE file
