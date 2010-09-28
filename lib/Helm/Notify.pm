package Helm::Notify;
use strict;
use warnings;
use Moose;
use Moose::Util::TypeConstraints qw(enum);
use namespace::autoclean;

enum NOTIFY_LEVEL => qw(debug info warn error);
has channels => (
    is      => 'ro',
    writer  => '_channels',
    isa     => 'ArrayRef[Helm::Notify::Channel]',
    default => sub { [] },
);
has notify_level => (
    is      => 'ro',
    writer  => '_notify_level',
    isa     => 'NOTIFY_LEVEL',
    default => 'info',
);

sub add_channel {
    my ($self, $channel) = @_;
    push(@{$self->channels}, $channel);
}

sub initialize {
    my ($self, $helm) = @_;
    $_->initialize($helm) foreach @{$self->channels};
}

sub finalize {
    my ($self, $helm) = @_;
    $_->finalize($helm) foreach @{$self->channels};
}

sub start_server {
    my ($self, $server) = @_;
    $_->start_server($server) foreach @{$self->channels};
}

sub end_server {
    my ($self, $server) = @_;
    $_->end_server($server) foreach @{$self->channels};
}

sub debug {
    my ($self, $msg) = @_;
    if( $self->notify_level eq 'debug' ) {
        $_->debug($msg) foreach @{$self->channels};
    }
}

sub info {
    my ($self, $msg) = @_;
    if($self->notify_level eq 'debug' || $self->notify_level eq 'info') {
        $_->info($msg) foreach @{$self->channels};
    }
}

sub warn {
    my ($self, $msg) = @_;
    my @channels = @{$self->channels};
    if( @channels ) {
        $_->warn($msg) foreach @channels;
    } else {
        # make sure something happens even if we don't have any channels.
        warn("Warning: $msg");
    }
}

sub error {
    my ($self, $msg) = @_;
    my @channels = @{$self->channels};
    if( @channels ) {
        $_->error($msg) foreach @channels;
    } else {
        # make sure something happens even if we don't have any channels.
        die("Error: $msg");
    }
}

__PACKAGE__->meta->make_immutable;

1;
