#!/usr/bin/env perl

package API::zpool;

use Backticks;
$Backticks::chomped = 1;
use Data::Dumper;
use Mojo::JSON qw(decode_json encode_json);

use base 'Mojolicious::Controller';

sub zpool_list {
	my ($self, $args, $cb) = @_;
  my $ret = _run_command(Backticks->new('zpool list'));

  if (ref $ret eq 'ARRAY') {
    return $self->$cb( { pools => $ret }, 200);
  } else {
    return $self->$cb( { error => { code => $ret->returncode, message => _prepare_error($ret) } }, 400) if $ret->returncode() > 0;
  }
}

sub zpool_create {
  my ($self, $args, $cb) = @_;
  my $params = decode_json $self->req->body;
  my @devices = @{ $params->{vdevs} };
  my $cmd;

  if ($params->{type}) {
    $cmd = Backticks->new("zpool create $params->{name} $params->{type} @devices");
  } else {
    $cmd = Backticks->new("zpool create $params->{name} @devices");
  }

  my $ret = _run_command($cmd);
  if (ref $ret eq 'ARRAY') {
    my $pool = _run_command(Backticks->new("zpool list $params->{name}"));
    return $self->$cb( { message => "Pool was created.", data => @{ $pool } }, 201);
  } else {
    return $self->$cb( { error => { code => $ret->returncode, message => _prepare_error($ret) } }, 400) if $ret->returncode() > 0;
  }

  
}

sub zpool_list_poolname {
  my ($self, $args, $cb) = @_;
  my $poolname = $self->stash('poolname');
  my $ret = _run_command(Backticks->new("zpool list $poolname"));

  if (ref $ret eq 'ARRAY') {
    return $self->$cb( { pool => @{ $ret } }, 200);
  } else {
    return $self->$cb( { error => { code => $ret->returncode, message => _prepare_error($ret) } }, 400) if $ret->returncode() > 0;
  }  
}


sub zpool_destroy {
  my ($self, $args, $cb) = @_;
  my $params = decode_json $self->req->body;
  my $ret = _run_command(Backticks->new("zpool destroy $params->{name}"));

  if (ref $ret eq 'ARRAY') {
    return $self->$cb( { message => "Pool was destroyed." }, 200);
  } else {
    return $self->$cb( { error => { code => $ret->returncode, message => _prepare_error($ret) } }, 400) if $ret->returncode() > 0;
  }  
}

# private methods
sub _run_command {
  my $cmd = shift->run();

  if ( $cmd->success() ) {
    if ($cmd) {
      my @lines = split('\n', $cmd);
      my @headers = split(/\s+/, shift @lines);
      my @data;

      foreach my $line ( @lines ) {
        my %entry;
        @entry{ @headers } = split /\s+/, $line;
        push @data, \%entry;
      }
      return \@data;
    }
    return [];
  } else {
    return $cmd;
  }
}

sub _prepare_error {
  my $error = shift;

  my ($err_str) = split '\n', $error->stderr();
  return $err_str;
}

1;