package SequencesDB::Controller::Library;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head2 _get_logger

Private method to retrieve the logger instance from the Catalyst context.

B<Parameters:>

=over 4

=item * C<$self> - Controller instance

=item * C<$c> - Catalyst context object

=back

B<Returns:>

=over 4

=item * Logger instance from Catalyst context

=back

B<Complexity:> O(1) - Simple accessor method

B<Description:>

This is a utility method that provides access to the Catalyst logger instance.
It serves as a centralized way to access logging throughout the controller,
making it easier to maintain and potentially switch logging systems if needed.

B<Example Usage:>

    my $logger = $self->_get_logger($c);
    $logger->info("Processing request");

=cut

# Get logger instance
sub _get_logger {
    my ($self, $c) = @_;
    return $c->log;
}

=head1 NAME

SequencesDB::Controller::Library - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller for managing sequence library operations.

=head1 METHODS

=cut

=head2 search

Display the library search form page.

B<Path:> /search

B<Arguments:> None

B<Parameters:>

=over 4

=item * C<$self> - Controller instance

=item * C<$c> - Catalyst context object

=back

B<Returns:> None (renders template)

B<Complexity:> O(1) - Simple template rendering

B<Description:>

This action displays the search form page for library records. It sets up the
template to render the search interface where users can enter search criteria
for finding libraries in the database.

B<Template:> library/form_search.tt2

B<Example Usage:>

    GET /search
    # Displays the search form

=cut

sub search : Path('/search') : Args(0) {
    my ( $self, $c ) = @_;
    $c->stash( template => 'library/form_search.tt2' );
}

=head2 result_list

Process search requests and display paginated results.

B<Path:> /result

B<Arguments:> None

B<Parameters:>

=over 4

=item * C<$self> - Controller instance

=item * C<$c> - Catalyst context object

=back

B<Returns:> None (renders template with results)

B<Complexity:> O(n) where n is the number of search results

B<Description:>

This action processes search requests from the search form and displays paginated
results. It extracts search parameters from the request, builds a database resultset
based on the search criteria, applies pagination, and renders the results.

B<Workflow:>

=over 4

=item 1. Extract search parameters from request

=item 2. Build search resultset based on criteria

=item 3. Apply pagination settings

=item 4. Render results template

=back

B<Template:> library/result_list.tt2

B<Stash Variables:>

=over 4

=item * C<rs> - Database resultset with search results

=back

B<Example Usage:>

    POST /result
    # With search parameters in form data
    # Displays paginated search results

=cut

sub result_list : Path('/result') : Args(0) {
    my ( $self, $c ) = @_;
    
    my $search_params = $self->_extract_search_params($c);
    my $rs = $self->_build_search_resultset($c, $search_params);
    
    $rs = $rs->search(undef, {
        page => $search_params->{page_number},
        rows => $search_params->{entries_per_page},
    });
    
    $c->stash(
        rs       => $rs,
        template => 'library/result_list.tt2',
    );
}

=head2 create_new

Display the form for creating a new library record.

B<Path:> /new

B<Arguments:> None

B<Parameters:>

=over 4

=item * C<$self> - Controller instance

=item * C<$c> - Catalyst context object

=back

B<Returns:> None (renders template)

B<Complexity:> O(1) - Simple template rendering

B<Description:>

This action displays the form for creating a new library record. It renders
the form template where users can enter library metadata including organism,
tissue, cell type, experiment details, and file information.

B<Template:> library/form_new.tt2

B<Example Usage:>

    GET /new
    # Displays the new library creation form

=cut

sub create_new : Path('/new') : Args(0) {
    my ( $self, $c ) = @_;
    $c->stash( template => 'library/form_new.tt2' );
}

=head2 process_request

Process library creation and update requests with validation and error handling.

B<Path:> /new/library

B<Arguments:> None

B<Parameters:>

=over 4

=item * C<$self> - Controller instance

=item * C<$c> - Catalyst context object

=back

B<Returns:> None (redirects or renders template)

B<Complexity:> O(n) where n is the number of entity lookups required

B<Description:>

This is the main processing action for library creation and update requests.
It handles the complete workflow including form validation, duplicate checking,
entity creation, and database operations with comprehensive error handling.

B<Processing Workflow:>

=over 4

=item 1. Extract form parameters from request

=item 2. Validate all required fields and formats

=item 3. Check for existing records (duplicates)

=item 4. Process the library creation or update

=item 5. Handle success/failure responses

=back

B<Validation Features:>

=over 4

=item * Required field validation

=item * Data type validation (numeric fields)

=item * Entity existence validation

=item * Duplicate record detection

=back

B<Error Handling:>

=over 4

=item * Validation errors → return to form with messages

=item * Duplicate records → prompt for action

=item * Database errors → log and display error

=back

B<Logging:>

=over 4

=item * Info: Request processing start/completion

=item * Debug: Extracted parameters

=item * Warn: Validation errors found

=item * Error: Operation failures

=back

B<Template:> library/form_new.tt2

B<Redirects:> /search on success

B<Example Usage:>

    POST /new/library
    # With form data containing library metadata
    # Processes and creates/updates library record

=cut

sub process_request : Path('/new/library') : Args(0) {
    my ( $self, $c ) = @_;
    
    my $logger = $self->_get_logger($c);
    $logger->info("Processing library creation request");
    
    $c->stash( template => 'library/form_new.tt2' );
    
    # Extract and validate parameters
    my $params = $self->_extract_form_params($c);
    $logger->debug("Extracted form parameters: " . join(', ', keys %$params));
    
    my $validation_errors = $self->_validate_form_params($params);
    
    if (@$validation_errors) {
        $logger->warn("Validation errors found: " . scalar(@$validation_errors) . " errors");
        $self->_set_validation_errors($c, $validation_errors);
        $c->go('create_new');
        return;
    }
    
    # Check for existing files/libraries
    my $existing_checks = $self->_check_existing_records($c, $params);
    if ($existing_checks->{should_return}) {
        return;
    }
    
    # Process the request
    my $result = $self->_process_library_request($c, $params);
    
    if ($result->{success}) {
        $logger->info("Library operation completed successfully: " . $result->{message});
        $c->stash(success => $result->{message});
        $c->go('search');
    } else {
        $logger->error("Library operation failed");
    }
}

=head2 edit

Load existing library data for editing.

B<Path:> /edit

B<Arguments:> None

B<Parameters:>

=over 4

=item * C<$self> - Controller instance

=item * C<$c> - Catalyst context object

=back

B<Request Parameters:>

=over 4

=item * C<file_id> - ID of the file record to edit

=back

B<Returns:> None (renders template with data)

B<Complexity:> O(1) - Single database lookup with joins

B<Description:>

This action loads existing library data for editing purposes. It retrieves
the library record associated with a specific file ID and populates the
form with the current values for modification.

B<Workflow:>

=over 4

=item 1. Extract file_id from request parameters

=item 2. Retrieve library data using helper method

=item 3. Populate form template with current values

=back

B<Template:> library/form_new.tt2 (reused for editing)

B<Stash Variables:>

=over 4

=item * All library fields (filename, sha2, path, etc.)

=item * C<file_id> - File ID for tracking the edit

=back

B<Example Usage:>

    GET /edit?file_id=123
    # Loads library data for editing

=cut

sub edit : Path('/edit') : Args(0) {
    my ( $self, $c ) = @_;
    
    my $file_id = $c->req->param('file_id');
    my $library_data = $self->_get_library_for_edit($c, $file_id);
    
    $c->stash(
        %$library_data,
        file_id  => $file_id,
        template => 'library/form_new.tt2',
    );
}

=head2 insert_file

Insert a new file record into an existing library.

B<Path:> /new/library/insert_file

B<Arguments:> None

B<Parameters:>

=over 4

=item * C<$self> - Controller instance

=item * C<$c> - Catalyst context object

=back

B<Request Parameters:>

=over 4

=item * C<library_id_validate> - Library ID to associate the file with

=item * C<filename_validate> - Name of the file to insert

=item * C<path_validate> - Path where the file is located

=back

B<Returns:> None (renders template with success message)

B<Complexity:> O(1) - Single database insert operation

B<Description:>

This action handles the insertion of a new file record into an existing library.
This is typically used when a duplicate SHA2 hash is detected and the user
chooses to add the file to the existing library rather than creating a new one.

B<Workflow:>

=over 4

=item 1. Extract validated parameters from request

=item 2. Create new file record in database

=item 3. Display success message

=back

B<Template:> library/form_search.tt2

B<Stash Variables:>

=over 4

=item * C<success> - Success message for user feedback

=back

B<Example Usage:>

    POST /new/library/insert_file
    # With validated library_id, filename, and path
    # Creates file record and shows success

=cut

sub insert_file : Path('/new/library/insert_file') : Args(0) {
    my ( $self, $c ) = @_;
    
    my $library_id = $c->req->param('library_id_validate');
    my $filename   = $c->req->param('filename_validate');
    my $path       = $c->req->param('path_validate');
    
    $c->model('DB::File')->create({
        file_name          => $filename,
        file_path          => $path,
        library_library_id => $library_id,
    });
    
    $c->stash(
        success  => "File created successfully!",
        template => 'library/form_search.tt2',
    );
}

# PRIVATE METHODS

=head2 _extract_search_params

Extract and organize search parameters from the request.

B<Parameters:>

=over 4

=item * C<$self> - Controller instance

=item * C<$c> - Catalyst context object

=back

B<Returns:>

=over 4

=item * Hash reference containing organized search parameters

=back

B<Complexity:> O(1) - Simple parameter extraction

B<Description:>

This private method extracts search parameters from the HTTP request and
organizes them into a consistent hash structure. It provides default values
for pagination settings to ensure proper functioning even when parameters
are not provided.

B<Extracted Parameters:>

=over 4

=item * C<entries_per_page> - Number of results per page (default: 10)

=item * C<field_value> - Search term entered by user

=item * C<advanced_search> - Field to search in (organism, tissue, etc.)

=item * C<search_options> - Search type (contains, equals, etc.)

=item * C<page_number> - Current page number (default: 1)

=back

B<Example Usage:>

    my $params = $self->_extract_search_params($c);
    # Returns: { entries_per_page => 25, field_value => 'brain', ... }

=cut

sub _extract_search_params {
    my ($self, $c) = @_;
    
    return {
        entries_per_page => $c->req->param('entries_per_page') || 10,
        field_value      => $c->req->param('field_value'),
        advanced_search  => $c->req->param('advanced_search'),
        search_options   => $c->req->param('search_options'),
        page_number      => $c->req->param('page') || 1,
    };
}

=head2 _build_search_resultset

Build a database resultset based on search parameters.

B<Parameters:>

=over 4

=item * C<$self> - Controller instance

=item * C<$c> - Catalyst context object

=item * C<$params> - Hash reference containing search parameters

=back

B<Returns:>

=over 4

=item * DBIx::Class::ResultSet object for library search results

=back

B<Complexity:> O(n) where n is the number of matching records

B<Description:>

This private method builds a database resultset based on the provided search
parameters. It handles different search scenarios including filtered searches,
unfiltered searches, and validation of search parameters.

B<Search Logic:>

=over 4

=item * With field_value and advanced_search: Perform filtered search

=item * With field_value but no advanced_search: Show error and redirect

=item * No field_value: Return all libraries

=back

B<Example Usage:>

    my $rs = $self->_build_search_resultset($c, $search_params);
    # Returns DBIx::Class::ResultSet for library records

=cut

sub _build_search_resultset {
    my ($self, $c, $params) = @_;
    
    if ($params->{field_value} && $params->{advanced_search}) {
        return $c->model('DB::Library')->search_library(
            $params->{field_value}, 
            $params->{advanced_search}, 
            $params->{search_options}
        );
    } elsif ($params->{field_value} && !$params->{advanced_search}) {
        $c->stash(
            field_value => $params->{field_value},
            error15     => "Select a search filter!"
        );
        $c->go('search');
    } else {
        return $c->model('DB::Library')->search_library();
    }
}

=head2 _extract_form_params

Extract and organize form parameters from the request.

B<Parameters:>

=over 4

=item * C<$self> - Controller instance

=item * C<$c> - Catalyst context object

=back

B<Returns:>

=over 4

=item * Hash reference containing all form parameters

=back

B<Complexity:> O(1) - Simple parameter extraction

B<Description:>

This private method extracts all form parameters from the HTTP request and
organizes them into a consistent hash structure. It handles both entity IDs
(when selecting from dropdowns) and entity names (when creating new entities).

B<Extracted Parameters:>

=over 4

=item * File information: filename, file_id, sha2, path

=item * Experimental metadata: repeat, replicate

=item * Entity IDs and names for all lookup tables

=back

B<Entity Handling:>

For each entity (organism, tissue, cell, etc.), extracts both:

=over 4

=item * entity_id - For selecting existing entities

=item * entity_name - For creating new entities

=back

B<Example Usage:>

    my $params = $self->_extract_form_params($c);
    # Returns: { filename => 'file.txt', organism_id => '1', ... }

=cut

sub _extract_form_params {
    my ($self, $c) = @_;
    
    return {
        filename        => $c->req->param('filename'),
        file_id         => $c->req->param('file_id'),
        sha2            => $c->req->param('sha2'),
        path            => $c->req->param('path'),
        repeat          => $c->req->param('repeat'),
        replicate       => $c->req->param('replicate'),
        
        # Entity IDs and names
        organism_id     => $c->req->param('organism'),
        organism_name   => $c->req->param('input_organism'),
        
        tissue_id       => $c->req->param('tissue'),
        tissue_name     => $c->req->param('input_tissue'),
        
        cell_id         => $c->req->param('cell'),
        cell_name       => $c->req->param('input_cell'),
        
        experiment_id   => $c->req->param('experiment'),
        experiment_name => $c->req->param('input_experiment'),
        
        background_id   => $c->req->param('background'),
        background_name => $c->req->param('input_background'),
        
        method_id       => $c->req->param('method'),
        method_name     => $c->req->param('input_method'),
        
        antibody_id     => $c->req->param('antibody'),
        antibody_name   => $c->req->param('input_antibody'),
        
        sequencer_id    => $c->req->param('sequencer'),
        sequencer_name  => $c->req->param('input_sequencer'),
    };
}

=head2 _validate_form_params

Validate form parameters and return list of validation errors.

B<Parameters:>

=over 4

=item * C<$self> - Controller instance

=item * C<$params> - Hash reference containing form parameters

=back

B<Returns:>

=over 4

=item * Array reference of hash references containing validation errors

=back

B<Complexity:> O(n) where n is the number of entity types to validate

B<Description:>

This private method performs comprehensive validation of form parameters
submitted for library creation or update. It checks required fields,
data types, and business logic constraints.

B<Validation Rules:>

=over 4

=item * Required fields: filename, sha2, path

=item * Entity validation: Each entity must have either ID or name

=item * Numeric validation: repeat and replicate must be integers

=back

B<Error Format:>

Each error is a hash with 'field' and 'message' keys:

    { field => 'filename', message => 'Insert filename!' }

B<Example Usage:>

    my $errors = $self->_validate_form_params($params);
    if (@$errors) {
        # Handle validation errors
    }

=cut

sub _validate_form_params {
    my ($self, $params) = @_;
    
    my @errors;
    
    # Required field validation
    push @errors, { field => 'filename', message => "Insert filename!" } 
        unless $params->{filename};
    
    push @errors, { field => 'sha2', message => "Insert a SHA2 key!" } 
        unless $params->{sha2};
    
    push @errors, { field => 'path', message => "Insert file path!" } 
        unless $params->{path};
    
    # Entity validation (must have either ID or name)
    my @entities = qw(organism tissue cell experiment background method sequencer);
    
    for my $entity (@entities) {
        my $id_field = "${entity}_id";
        my $name_field = "${entity}_name";
        
        unless ($params->{$id_field} || $params->{$name_field}) {
            push @errors, { 
                field => $entity, 
                message => "Select or insert a new $entity!" 
            };
        }
    }
    
    # Numeric validation
    if (!defined $params->{repeat} || $params->{repeat} !~ /^\d+$/) {
        push @errors, { field => 'repeat', message => "Insert the repeat number!" };
    }
    
    if (!defined $params->{replicate} || $params->{replicate} !~ /^\d+$/) {
        push @errors, { field => 'replicate', message => "Insert the replicate number!" };
    }
    
    return \@errors;
}

=head2 _set_validation_errors

Set validation errors in the template stash for display.

B<Parameters:>

=over 4

=item * C<$self> - Controller instance

=item * C<$c> - Catalyst context object

=item * C<$errors> - Array reference of error hash references

=back

B<Returns:> None (modifies stash)

B<Complexity:> O(n) where n is the number of errors

B<Description:>

This private method takes validation errors and sets them in the Catalyst
stash for display in the template. It assigns each error a sequential
number (error1, error2, etc.) for template rendering.

B<Stash Format:>

Errors are stored as:

=over 4

=item * error1 => "First error message"

=item * error2 => "Second error message"

=item * etc.

=back

B<Example Usage:>

    $self->_set_validation_errors($c, $errors);
    # Sets error1, error2, etc. in stash for template

=cut

sub _set_validation_errors {
    my ($self, $c, $errors) = @_;
    
    my $error_num = 1;
    for my $error (@$errors) {
        $c->stash("error$error_num" => $error->{message});
        $error_num++;
    }
}

=head2 _check_existing_records

Check for existing records to prevent duplicates.

B<Parameters:>

=over 4

=item * C<$self> - Controller instance

=item * C<$c> - Catalyst context object

=item * C<$params> - Hash reference containing form parameters

=back

B<Returns:>

=over 4

=item * Hash reference with 'should_return' flag

=back

B<Complexity:> O(1) - Database index lookups

B<Description:>

This private method checks for existing records in the database to prevent
duplicate entries. It performs two main checks: existing files and existing
SHA2 hashes. For updates (when file_id is present), it skips the checks.

B<Duplicate Detection:>

=over 4

=item * File duplicates: Same filename and path combination

=item * SHA2 duplicates: Same SHA2 hash (offers to add file to existing library)

=back

B<Return Values:>

=over 4

=item * should_return => 0: No duplicates found, continue processing

=item * should_return => 1: Duplicates found, stop processing

=back

B<Logging:>

=over 4

=item * Warn: Duplicate records found

=item * Debug: No duplicates found

=back

B<Example Usage:>

    my $check = $self->_check_existing_records($c, $params);
    return if $check->{should_return};

=cut

sub _check_existing_records {
    my ($self, $c, $params) = @_;
    
    my $logger = $self->_get_logger($c);
    
    return { should_return => 0 } if $params->{file_id};
    
    # Check for existing SHA2
    my $sha2_validate = $c->model('DB::Library')->find({ sha2 => $params->{sha2} });
    
    # Check for existing file
    my $filename_validate = $c->model('DB::File')->find({
        file_name => $params->{filename},
        file_path => $params->{path},
    });
    
    if ($filename_validate) {
        $logger->warn("Duplicate file found: $params->{filename} at $params->{path}");
        $c->stash(error14 => "File $params->{filename} already exists at $params->{path}");
        return { should_return => 1 };
    }
    
    if ($sha2_validate) {
        $logger->warn("Duplicate SHA2 found: " . $params->{sha2} . " for library ID " . $sha2_validate->library_id);
        $c->stash(
            library_id_validate => $sha2_validate->library_id,
            filename_validate   => $params->{filename},
            path_validate       => $params->{path},
            error15             => "Library ID " . $sha2_validate->library_id . 
                                 " already exists! SHA-key: " . $sha2_validate->sha2 .
                                 " <br><p> Insert file to the current library?</p>"
        );
        return { should_return => 1 };
    }
    
    $logger->debug("No existing records found for SHA2: " . $params->{sha2});
    return { should_return => 0 };
}

=head2 _process_library_request

Process library creation or update request.

B<Parameters:>

=over 4

=item * C<$self> - Controller instance

=item * C<$c> - Catalyst context object

=item * C<$params> - Hash reference containing form parameters

=back

B<Returns:>

=over 4

=item * Hash reference with success flag and message

=back

B<Complexity:> O(n) where n is the number of entity operations

B<Description:>

This private method orchestrates the library creation or update process.
It first ensures all required entities exist (creating them if necessary),
then delegates to the appropriate handler based on whether this is a
creation or update operation.

B<Process Flow:>

=over 4

=item 1. Get or create entity IDs for all relationships

=item 2. Determine operation type (create vs update)

=item 3. Delegate to appropriate handler method

=back

B<Operation Types:>

=over 4

=item * Create: When file_id is not present

=item * Update: When file_id is present

=back

B<Example Usage:>

    my $result = $self->_process_library_request($c, $params);
    if ($result->{success}) {
        # Handle success
    }

=cut

sub _process_library_request {
    my ($self, $c, $params) = @_;
    
    # Get or create entity IDs
    my $entity_ids = $self->_get_or_create_entity_ids($c, $params);
    
    if ($params->{file_id}) {
        return $self->_update_existing_library($c, $params, $entity_ids);
    } else {
        return $self->_create_new_library($c, $params, $entity_ids);
    }
}

=head2 _get_or_create_entity_ids

Get existing entity IDs or create new entities as needed.

B<Parameters:>

=over 4

=item * C<$self> - Controller instance

=item * C<$c> - Catalyst context object

=item * C<$params> - Hash reference containing form parameters

=back

B<Returns:>

=over 4

=item * Hash reference containing entity IDs

=back

B<Complexity:> O(n) where n is the number of entities requiring creation

B<Description:>

This private method handles the lookup-or-create pattern for all entity
types. For each entity, it either uses an existing ID (if selected from
a dropdown) or creates a new entity record (if a new name was entered).

B<Entity Processing:>

For each entity type (organism, tissue, cell, etc.):

=over 4

=item * If entity_id is present: Use existing ID

=item * If entity_name is present: Create new entity and use new ID

=back

B<Supported Entities:>

=over 4

=item * Organism, Tissue, Cell, Experiment, Background, Method, Antibody, Sequencer

=back

B<Example Usage:>

    my $ids = $self->_get_or_create_entity_ids($c, $params);
    # Returns: { organism_id => 1, tissue_id => 2, ... }

=cut

sub _get_or_create_entity_ids {
    my ($self, $c, $params) = @_;
    
    my $ids = {};
    
    # Entity mapping
    my %entity_map = (
        organism  => { model => 'DB::Organism',  field => 'organism_name' },
        tissue    => { model => 'DB::Tissue',    field => 'tissue_name' },
        cell      => { model => 'DB::Cell',      field => 'cell_name' },
        experiment=> { model => 'DB::Experiment',field => 'experiment_name' },
        background=> { model => 'DB::Background',field => 'background_name' },
        method    => { model => 'DB::Method',    field => 'method_name' },
        antibody  => { model => 'DB::Antibody',  field => 'antibody_name' },
        sequencer => { model => 'DB::Sequencer', field => 'sequencer_name' },
    );
    
    for my $entity (keys %entity_map) {
        my $id_field = "${entity}_id";
        my $name_field = "${entity}_name";
        
        if ($params->{$id_field}) {
            $ids->{$id_field} = $params->{$id_field};
        } elsif ($params->{$name_field}) {
            my $record = $c->model($entity_map{$entity}{model})->create({
                $entity_map{$entity}{field} => $params->{$name_field}
            });
            $ids->{$id_field} = $record->id;
        }
    }
    
    return $ids;
}

=head2 _create_new_library

Create a new library record with associated file.

B<Parameters:>

=over 4

=item * C<$self> - Controller instance

=item * C<$c> - Catalyst context object

=item * C<$params> - Hash reference containing form parameters

=item * C<$entity_ids> - Hash reference containing entity IDs

=back

B<Returns:>

=over 4

=item * Hash reference with success flag and message

=back

B<Complexity:> O(1) - Two database insert operations

B<Description:>

This private method creates a new library record in the database along with
its associated file record. It uses the provided entity IDs to establish
all the necessary relationships.

B<Database Operations:>

=over 4

=item 1. Create Library record with all entity relationships

=item 2. Create File record linked to the new library

=back

B<Library Fields:>

=over 4

=item * All entity foreign keys (organism_organism_id, etc.)

=item * Experimental metadata (repeat_id, replicate_id)

=item * SHA2 hash for identification

=back

B<Example Usage:>

    my $result = $self->_create_new_library($c, $params, $entity_ids);
    # Returns: { success => 1, message => "Library created successfully!" }

=cut

sub _create_new_library {
    my ($self, $c, $params, $entity_ids) = @_;
    
    my $library = $c->model('DB::Library')->create({
        organism_organism_id     => $entity_ids->{organism_id},
        tissue_tissue_id         => $entity_ids->{tissue_id},
        cell_cell_id             => $entity_ids->{cell_id},
        experiment_experiment_id => $entity_ids->{experiment_id},
        background_background_id => $entity_ids->{background_id},
        method_method_id         => $entity_ids->{method_id},
        antibody_antibody_id     => $entity_ids->{antibody_id},
        sequencer_sequencer_id   => $entity_ids->{sequencer_id},
        repeat_id                => $params->{repeat},
        replicate_id             => $params->{replicate},
        sha2                     => $params->{sha2},
    });
    
    $c->model('DB::File')->create({
        file_name          => $params->{filename},
        file_path          => $params->{path},
        library_library_id => $library->id,
    });
    
    return {
        success => 1,
        message => "Library created successfully!"
    };
}

=head2 _update_existing_library

Update an existing library record and its associated file.

B<Parameters:>

=over 4

=item * C<$self> - Controller instance

=item * C<$c> - Catalyst context object

=item * C<$params> - Hash reference containing form parameters

=item * C<$entity_ids> - Hash reference containing entity IDs

=back

B<Returns:>

=over 4

=item * Hash reference with success flag and message

=back

B<Complexity:> O(1) - Database lookups and updates

B<Description:>

This private method updates an existing library record and its associated
file. It includes conflict detection for SHA2 changes to prevent duplicate
hashes in the database.

B<Update Process:>

=over 4

=item 1. Update file record with new filename and path

=item 2. Find associated library record

=item 3. Check for SHA2 conflicts if hash is changing

=item 4. Update library record with new metadata

=back

B<Conflict Detection:>

=over 4

=item * If SHA2 is changing, check for existing libraries with new hash

=item * Return error if conflict detected

=back

B<Example Usage:>

    my $result = $self->_update_existing_library($c, $params, $entity_ids);
    # Returns: { success => 1, message => "Library updated successfully!" }

=cut

sub _update_existing_library {
    my ($self, $c, $params, $entity_ids) = @_;
    
    my $file = $c->model('DB::File')->find({ file_id => $params->{file_id} });
    $file->update({
        file_name => $params->{filename},
        file_path => $params->{path},
    });
    
    my $library = $c->model('DB::Library')->find({ 
        library_id => $file->library_library_id 
    });
    
    # Check for SHA2 conflicts
    if ($library->sha2 ne $params->{sha2}) {
        my $sha2_conflict = $c->model('DB::Library')->find({ 
            sha2 => $params->{sha2} 
        });
        
        if ($sha2_conflict) {
            $c->stash(
                file_id => $params->{file_id},
                error14 => "Library ID " . $library->id . 
                          " already exists! Search for SHA2-key: " . $params->{sha2} .
                          " to obtain file info."
            );
            return { success => 0 };
        }
    }
    
    $library->update({
        organism_organism_id     => $entity_ids->{organism_id},
        tissue_tissue_id         => $entity_ids->{tissue_id},
        cell_cell_id             => $entity_ids->{cell_id},
        experiment_experiment_id => $entity_ids->{experiment_id},
        background_background_id => $entity_ids->{background_id},
        method_method_id         => $entity_ids->{method_id},
        antibody_antibody_id     => $entity_ids->{antibody_id},
        sequencer_sequencer_id   => $entity_ids->{sequencer_id},
        repeat_id                => $params->{repeat},
        replicate_id             => $params->{replicate},
        sha2                     => $params->{sha2},
    });
    
    return {
        success => 1,
        message => "Library updated successfully!"
    };
}

=head2 _get_library_for_edit

Retrieve library data for editing based on file ID.

B<Parameters:>

=over 4

=item * C<$self> - Controller instance

=item * C<$c> - Catalyst context object

=item * C<$file_id> - ID of the file to retrieve library data for

=back

B<Returns:>

=over 4

=item * Hash reference containing library data for form population

=back

B<Complexity:> O(1) - Database search with joins

B<Description:>

This private method retrieves library data for editing purposes. It uses
the file ID to find the associated library record and extracts all the
necessary information for populating the edit form.

B<Retrieved Data:>

=over 4

=item * File information: filename, path

=item * Library metadata: sha2, repeat, replicate

=item * All entity IDs for form dropdowns

=back

B<Database Operations:>

=over 4

=item * Search library by file ID using custom search method

=item * Retrieve library and file records with relationships

=back

B<Example Usage:>

    my $data = $self->_get_library_for_edit($c, $file_id);
    # Returns: { filename => 'file.txt', sha2 => 'abc123', ... }

=cut

sub _get_library_for_edit {
    my ($self, $c, $file_id) = @_;
    
    my $rs = $c->model('DB::Library')->search_library(
        $file_id, "files_inner.file_id", "equal"
    );
    my $library = $rs->first;
    my $file = $library->files_inner->first;
    
    return {
        filename      => $file->file_name,
        sha2          => $library->sha2,
        path          => $file->file_path,
        organism_id   => $library->organism_organism_id,
        tissue_id     => $library->tissue_tissue_id,
        cell_id       => $library->cell_cell_id,
        experiment_id => $library->experiment_experiment_id,
        background_id => $library->background_background_id,
        method_id     => $library->method_method_id,
        antibody_id   => $library->antibody_antibody_id,
        sequencer_id  => $library->sequencer_sequencer_id,
        repeat        => $library->repeat_id,
        replicate     => $library->replicate_id,
    };
}

=encoding utf8

=head1 AUTHOR

Edoardo (Refactored)

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;