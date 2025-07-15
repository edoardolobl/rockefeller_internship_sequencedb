package SequencesDB;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application.
#
# Note that ORDERING IS IMPORTANT here as plugins are initialized in order,
# therefore you almost certainly want to keep ConfigLoader at the head of the
# list if you're using it.
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw/
    ConfigLoader
    Static::Simple
    Log::Log4perl
/;

extends 'Catalyst';

our $VERSION = '0.01';

# Configure the application.
#
# Note that settings in sequencesdb.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
    name => 'SequencesDB',
    # Disable deprecated behavior needed by old applications
    disable_component_resolution_regex_fallback => 1,
    enable_catalyst_header => 1, # Send X-Catalyst header
    
    # Log4perl configuration
    'Log::Log4perl' => {
        config => __PACKAGE__->path_to('..', 'config', 'log4perl.conf'),
        # Optional: disable builtin logging to avoid duplication
        disable_builtin_logging => 1,
    },
);

# Start the application
__PACKAGE__->setup();

=encoding utf8

=head1 NAME

SequencesDB - Bioinformatics sequence library management web application

=head1 SYNOPSIS

    # Start the development server
    script/sequencesdb_server.pl
    
    # Start with specific port
    script/sequencesdb_server.pl -p 8080
    
    # Production deployment with FastCGI
    script/sequencesdb_fastcgi.pl

=head1 DESCRIPTION

SequencesDB is a Catalyst-based web application for managing bioinformatics
sequence libraries. It provides a comprehensive interface for storing,
searching, and managing experimental metadata associated with sequence files.

B<Key Features:>

=over 4

=item * Library Management - Create, edit, and manage sequence library records

=item * Metadata Tracking - Store organism, tissue, cell, experiment, and method information

=item * File Management - Associate files with libraries and track file paths

=item * Search Interface - Advanced search across all library metadata

=item * SHA2 Integration - Track files using SHA2 hashes for integrity

=item * Paired-End Support - Handle paired-end sequencing data relationships

=back

B<Architecture:>

=over 4

=item * MVC Pattern - Model-View-Controller architecture using Catalyst

=item * Database Layer - DBIx::Class ORM for database operations

=item * Template Engine - Template Toolkit for view rendering

=item * Logging System - Log4perl for structured application logging

=item * Static Files - Catalyst::Plugin::Static::Simple for assets

=back

B<Configuration:>

The application uses Log4perl for structured logging with configuration
loaded from C<config/log4perl.conf>. Database configuration is handled
through DBIx::Class models with connection details in external config files.

B<Security Features:>

=over 4

=item * SQL Injection Prevention - Prepared statements throughout

=item * Input Validation - Comprehensive form validation

=item * Error Handling - Graceful error handling with user feedback

=item * Transaction Support - ACID compliance for data integrity

=back

=head1 PLUGINS

This application uses the following Catalyst plugins:

=over 4

=item * ConfigLoader - External configuration file support

=item * Static::Simple - Static file serving

=item * Log::Log4perl - Structured logging system

=back

=head1 CONFIGURATION

The application configuration includes:

=over 4

=item * disable_component_resolution_regex_fallback - Disable deprecated behavior

=item * enable_catalyst_header - Send X-Catalyst header for debugging

=item * Log4perl config path - Points to config/log4perl.conf

=item * disable_builtin_logging - Prevent log duplication

=back

=head1 DIRECTORY STRUCTURE

    SequencesDB/
    ├── lib/
    │   ├── SequencesDB.pm              # Main application module
    │   ├── SequencesDB/
    │   │   ├── Controller/             # Web controllers
    │   │   ├── Model/                  # Database models
    │   │   └── View/                   # Template views
    │   └── SequencesDB/
    ├── root/                           # Static files and templates
    ├── script/                         # Application scripts
    ├── t/                              # Test files
    └── config/                         # Configuration files

=head1 RELATED SCRIPTS

=over 4

=item * DATABASE/file_path_refactored.pl - Process SHA2 hash files

=item * DATABASE/sql_final_refactored.pl - Process experimental metadata

=back

=head1 SEE ALSO

L<SequencesDB::Controller::Library>, L<SequencesDB::Controller::Root>, L<Catalyst>, L<DBIx::Class>, L<Log::Log4perl>

=head1 AUTHOR

Edoardo (Refactored for security and maintainability)

=head1 VERSION

Version 0.01

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
