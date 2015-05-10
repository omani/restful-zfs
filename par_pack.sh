#!/usr/local/bin/bash

pp -a extlib/lib/perl5/ -a API.pm -a api.yaml -I extlib/lib/perl5/ -a "extlib/lib/perl5/Mojolicious;Mojolicious"  -a "extlib/lib/perl5/Pod;Pod" --bundle restful-zfs
