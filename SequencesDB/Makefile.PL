#!/usr/bin/env perl

=head1 NAME

Makefile.PL - Build configuration for SequencesDB bioinformatics application

=head1 DESCRIPTION

This file defines the build configuration, dependencies, and installation
requirements for the SequencesDB bioinformatics sequence library management
application. It uses Module::Install to manage the build process and 
dependency resolution.

=head1 DEPENDENCIES

=head2 Runtime Dependencies

=over 4

=item * Catalyst::Runtime (>= 5.90093) - Core Catalyst framework

=item * Catalyst::Plugin::ConfigLoader - External configuration support

=item * Catalyst::Plugin::Static::Simple - Static file serving

=item * Catalyst::Plugin::Log::Log4perl - Structured logging integration

=item * Catalyst::Action::RenderView - View rendering support

=item * Moose - Object-oriented programming framework

=item * namespace::autoclean - Automatic namespace cleaning

=item * Config::General - Configuration file parsing

=item * Log::Log4perl - Structured logging system

=item * DBI - Database interface

=item * Config::Tiny - Lightweight configuration parsing

=item * DBD::mysql - MySQL/MariaDB database driver

=item * Catalyst::Model::DBIC::Schema - Database model integration

=item * Catalyst::View::TT - Template Toolkit view engine

=item * MooseX::MarkAsMethods - Schema utility for method marking

=back

=head2 Test Dependencies

=over 4

=item * Test::More (>= 0.88) - Core testing framework

=item * Test::Mock::Guard - Mock object testing

=item * Test::DBIx::Class - Database testing utilities

=item * Test::WWW::Mechanize::Catalyst - Web application testing

=back

=head1 INSTALLATION

To install this application and its dependencies:

    perl Makefile.PL
    make
    make test
    make install

=head1 USAGE

After installation, the application can be started with:

    script/sequencesdb_server.pl

=head1 AUTHOR

Edoardo (Refactored for security and maintainability)

=cut

# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install 1.02;
use Module::Install::Catalyst; # Complain loudly if you don't have
                               # Catalyst::Devel installed or haven't said
                               # 'make dist' to create a standalone tarball.

name 'SequencesDB';
all_from 'lib/SequencesDB.pm';

requires 'Catalyst::Runtime' => '5.90093';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Plugin::Log::Log4perl';
requires 'Catalyst::Action::RenderView';
requires 'Moose';
requires 'namespace::autoclean';
requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats
requires 'Log::Log4perl';
requires 'DBI';
requires 'Config::Tiny';
requires 'DBD::mysql';
requires 'Catalyst::Model::DBIC::Schema';
requires 'Catalyst::View::TT';
requires 'MooseX::MarkAsMethods';
test_requires 'Test::More' => '0.88';
test_requires 'Test::Mock::Guard';
test_requires 'Test::DBIx::Class';
test_requires 'Test::WWW::Mechanize::Catalyst';
catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
