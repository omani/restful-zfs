#!/usr/local/bin/bash

PERL5LIB=extlib/lib/perl5/
PATH=$PATH:extlib/bin

perl -I extlib/lib/perl5/ extlib/bin/mojo swagger2 edit api.yaml --listen http://0.0.0.0:4000
