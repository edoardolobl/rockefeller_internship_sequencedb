# SequencesDB - Bioinformatics Sequence Library Management System

A comprehensive web-based application for managing bioinformatics sequence libraries with advanced metadata tracking, file integrity verification, and experimental data organization.

## 📜 Project Background

This project was developed during a summer internship at the **Laboratory of Molecular Immunology** at **The Rockefeller University** under the supervision of **Michel C. Nussenzweig, M.D., Ph.D.** The internship was part of the **Brazilian Scientific Mobility Program (BSMP)**, following studies at Siena College (Albany, NY).

**Thiago Y. Oliveira** ([stratust](https://github.com/stratust)) served as the direct advisor, teaching programming fundamentals from scratch and guiding the development of this final internship project. The system was designed to address real laboratory needs for managing bioinformatics sequence data and experimental metadata.

*This repository represents the evolution of that original 10-year-old project, now refactored with modern security practices, comprehensive testing, and production-ready deployment capabilities.*

## 🧬 Overview

SequencesDB is a Catalyst-based web application designed for researchers and bioinformatics professionals to efficiently manage sequence libraries, track experimental metadata, and maintain data integrity through SHA2 hash verification. The system provides a complete solution for organizing biological samples, sequencing experiments, and associated file management.

## ✨ Key Features

- **🔬 Library Management** - Create, edit, and organize sequence library records
- **🧪 Metadata Tracking** - Store comprehensive experimental metadata (organism, tissue, cell type, methods)
- **📁 File Management** - Associate files with libraries and track file paths with integrity checking
- **🔍 Advanced Search** - Search across all library metadata with flexible filtering
- **🔐 SHA2 Integration** - File integrity verification using SHA2 hashes
- **👥 Paired-End Support** - Handle paired-end sequencing data relationships
- **📊 Data Import** - Bulk import from tab-delimited experimental data files
- **🛡️ Security Features** - SQL injection prevention, input validation, transaction support
- **📈 Logging System** - Comprehensive structured logging with Log4perl
- **✅ Test Coverage** - Complete test suite with unit and integration tests

## 🏗️ Architecture

### Technology Stack
- **Backend**: Perl with Catalyst MVC framework
- **Database**: MySQL/MariaDB with DBIx::Class ORM
- **Frontend**: Template Toolkit (TT2) templating
- **Logging**: Log4perl structured logging
- **Testing**: Test::More, Test::DBIx::Class, Test::Mock::Guard

### System Components
```
SequencesDB/
├── lib/
│   ├── SequencesDB.pm                    # Main application module
│   └── SequencesDB/
│       ├── Controller/                   # Web controllers
│       │   └── Library_refactored.pm    # Library management controller
│       ├── Model/                        # Database models
│       ├── Schema/                       # DBIx::Class schema
│       │   └── Result/                  # Database result classes
│       └── View/                        # Template views
├── DATABASE/
│   ├── file_path_refactored.pl         # SHA2 hash file processing
│   └── sql_final_refactored.pl         # Experimental metadata processing
├── config/
│   ├── database.conf                    # Database configuration
│   └── log4perl.conf                   # Logging configuration
├── t/                                   # Test suite
├── root/                                # Static files and templates
└── script/                              # Application scripts
```

## 🚀 Quick Start

### Prerequisites
- Perl 5.10+ with CPAN
- MySQL/MariaDB database server
- Web server (Apache/Nginx) for production deployment

### Installation

> **⚠️ Important**: This installation guide reflects real-world setup challenges. The original Makefile.PL is incomplete and several code fixes are required for proper operation.

#### **Step 1: Clone and Initial Setup**
```bash
git clone <repository-url>
cd rockefeller-master/SequencesDB
```

#### **Step 2: Install Dependencies**

**✅ UPDATE**: The Makefile.PL has been corrected to include all dependencies discovered during real-world deployment.

```bash
# Install all dependencies automatically
cpanm --installdeps .

# Alternative: Install dependencies manually if needed
# cpanm DBD::mysql Catalyst::Model::DBIC::Schema Catalyst::View::TT MooseX::MarkAsMethods
# cpanm Test::Mock::Guard Test::DBIx::Class
```

#### **Step 3: Database Setup (The Complete Guide)**

**⚠️ Common Issue**: If you encounter database access errors, follow this complete reset procedure:

##### **3a. Fresh MariaDB Installation (Recommended)**
```bash
# If you have MySQL/MariaDB issues, completely remove and reinstall
sudo systemctl stop mysql
sudo apt-get purge mysql-server mysql-client mysql-common 'mysql-server-core-*' 'mysql-client-core-*'
sudo rm -rf /etc/mysql /var/lib/mysql /var/log/mysql
sudo apt-get autoremove && sudo apt-get autoclean

# Install MariaDB (more reliable than MySQL)
sudo apt-get update
sudo apt-get install mariadb-server
```

##### **3b. Secure Configuration**
```bash
sudo mysql_secure_installation
```
**Critical Settings**:
- Enter current password: Press Enter (no password initially)
- **Switch to unix_socket authentication: Answer 'n' (No)** ← This is crucial!
- Change root password: Answer 'Y' and set a memorable password
- All other questions: Answer 'Y'

##### **3c. Create Database Schema**
```bash
# Create the database
mysql -u root -p -e "CREATE DATABASE sequences_dtb;"

# Create the deploy_schema.pl script in DATABASE/ directory
# This script is missing from the original project
```

Create `DATABASE/deploy_schema.pl`:
```perl
#!/usr/bin/env perl
use strict;
use warnings;
use lib '../SequencesDB/lib';
use SequencesDB::Schema;

my $schema = SequencesDB::Schema->connect('dbi:mysql:sequences_dtb', 'root', 'your_password');
$schema->deploy();
print "Database schema deployed successfully!\n";
```

```bash
# Deploy the schema
cd DATABASE
perl deploy_schema.pl
```

#### **Step 4: Fix Critical Code Bugs**

The original scripts have several bugs that must be fixed:

##### **4a. Fix sql_final_refactored.pl**
The foreign key column naming is incorrect. This is already fixed in the current version.

##### **4b. Fix file_path_refactored.pl** 
The transaction handling causes errors. This is already fixed in the current version.

#### **Step 5: Resolve File Naming Conflicts**

The application has both original and refactored files that conflict:

```bash
cd SequencesDB/lib/SequencesDB

# Rename original files to avoid conflicts
mv Controller/Library.pm Controller/Library.pm.old
mv Model/DB.pm Model/DB.pm.old

# Rename refactored files to official names
mv Controller/Library_refactored.pm Controller/Library.pm
mv Model/DB_refactored.pm Model/DB.pm
```

#### **Step 6: Configure Application Routing**

Edit `SequencesDB/lib/SequencesDB/Controller/Root.pm` to redirect the homepage:

```perl
sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $c->response->redirect($c->uri_for('/search'));
}
```

#### **Step 7: Update Configuration**

Update `config/database.conf` with your actual credentials:
```ini
[database]
dsn = dbi:mysql:sequences_dtb
user = root
password = your_actual_password
host = localhost
port = 3306
```

#### **Step 8: Load Sample Data**

```bash
cd DATABASE

# Load experimental metadata
perl sql_final_refactored.pl Book1.txt

# Load file paths and SHA2 hashes
perl file_path_refactored.pl list_fastq_files.txt
```

#### **Step 9: Start the Application**

```bash
cd ../SequencesDB
perl script/sequencesdb_server.pl
```

**Access the application**: http://localhost:3000

### Troubleshooting Common Issues

#### **Database Connection Errors**
- **Error**: `Access denied for user 'root'@'localhost'`
  - **Solution**: Reset MySQL root password using the complete reinstallation guide above

#### **Missing Module Errors**
- **Error**: `Can't locate [ModuleName]`
  - **Solution**: Run `cpanm --installdeps .` to install all dependencies automatically
  - **Fallback**: Install individual modules as needed (see Step 2)

#### **Transaction Errors**
- **Error**: `Already in a transaction`
  - **Solution**: The code fixes in Step 4 resolve this issue

#### **Immutable Instance Errors**
- **Error**: `Cannot call method on an immutable instance`
  - **Solution**: Resolve file naming conflicts as shown in Step 5

#### **Schema Deployment Issues**
- **Error**: Database tables don't exist
  - **Solution**: Create and run the deploy_schema.pl script from Step 3c

### Database Schema Setup

The application expects the following database tables:
- `Library` - Main library records
- `File` - File associations
- `Organism`, `Tissue`, `Cell` - Biological entities
- `Experiment`, `Method`, `Background` - Experimental metadata
- `Antibody`, `Sequencer` - Technical metadata
- `Read_Type` - Paired-end read relationships

## 📖 Usage Guide

### Web Interface

1. **Library Management**:
   - Navigate to `/search` to search existing libraries
   - Use `/new` to create new library records
   - Edit existing records through the search results

2. **Data Entry**:
   - Fill in biological metadata (organism, tissue, cell)
   - Add experimental details (method, background, antibody)
   - Specify technical information (sequencer, repeats, replicates)
   - Associate files with SHA2 hashes for integrity

3. **Search Features**:
   - Search across all metadata fields
   - Filter by specific criteria
   - Paginated results with customizable page size

### Command Line Scripts

1. **SHA2 File Processing**:
```bash
cd DATABASE
perl file_path_refactored.pl /path/to/sha2_checksums.txt
```

2. **Metadata Import**:
```bash
cd DATABASE
perl sql_final_refactored.pl /path/to/metadata.txt
```

Expected file format for metadata import:
```
#Organism	Tissue	Cell	Experiment	Background	Method	Antibody	Sequencer	Repeat	Library	Read Type
Homo sapiens	Brain	Neurons	RNA-seq	Control	TruSeq	Anti-H3K4me3	Illumina HiSeq	repeat1	lib001	paired-end-1
```

## 🔒 Security Features

- **SQL Injection Prevention**: All database queries use prepared statements
- **Input Validation**: Comprehensive form validation with error handling
- **Transaction Support**: ACID compliance for data integrity
- **Error Handling**: Graceful error handling with user feedback
- **Logging**: Security event logging and monitoring
- **Configuration Security**: Secure credential management

## 🧪 Testing

The application includes comprehensive test coverage:

```bash
# Run all tests
make test

# Run specific test suites
prove -l t/database_file_path.t
prove -l t/controller_library_validation.t
prove -l t/integration_database.t
```

### Test Coverage:
- **Unit Tests**: Individual function testing with mocks
- **Integration Tests**: End-to-end workflow testing
- **Controller Tests**: Web interface validation
- **Schema Tests**: Database model testing

## 📊 Monitoring and Logging

### Log Files (Development):
- `/tmp/sequencesdb.log` - Main application log
- `/tmp/sequencesdb_database.log` - Database operations
- `/tmp/sequencesdb_controller.log` - Web controller actions
- `/tmp/sequencesdb_scripts.log` - Script execution logs
- `/tmp/sequencesdb_errors.log` - Error consolidation
- `/tmp/sequencesdb_performance.log` - Performance metrics
- `/tmp/sequencesdb_security.log` - Security events

### Production Considerations:
- Move log files to `/var/log/sequencesdb/`
- Implement log rotation
- Set up monitoring and alerting
- Configure proper file permissions

## 🔧 Configuration

### Database Configuration (`config/database.conf`):
```ini
[database]
dsn = dbi:mysql:sequences_dtb
user = sequences_user
password = your_secure_password
host = localhost
port = 3306
```

### Logging Configuration (`config/log4perl.conf`):
- Customizable log levels and outputs
- Separate logs for different components
- Console and file appenders
- Performance and security logging

## 🤝 Contributing

1. **Development Setup**:
   - Follow installation instructions
   - Run tests to ensure functionality
   - Use the development server for testing

2. **Code Standards**:
   - Follow Perl best practices
   - Add POD documentation for all functions
   - Include tests for new features
   - Use prepared statements for database queries

3. **Testing**:
   - Write unit tests for new functions
   - Add integration tests for workflows
   - Ensure all tests pass before submitting

## 📚 API Documentation

All functions and methods are documented with POD (Plain Old Documentation):

```bash
# View documentation
perldoc lib/SequencesDB.pm
perldoc DATABASE/file_path_refactored.pl
perldoc lib/SequencesDB/Controller/Library_refactored.pm
```

## 🐛 Troubleshooting

### Common Issues:

1. **Database Connection Errors**:
   - Check `config/database.conf` credentials
   - Ensure MySQL/MariaDB is running
   - Verify database and user exist

2. **Permission Errors**:
   - Check log directory permissions
   - Ensure web server has access to application files

3. **Dependency Issues**:
   - Run `perl Makefile.PL` to check dependencies
   - Install missing modules with CPAN

### Debug Mode:
```bash
# Enable debug logging
export CATALYST_DEBUG=1
script/sequencesdb_server.pl
```

## 📄 License

This library is free software. You can redistribute it and/or modify it under the same terms as Perl itself.

## 👨‍💻 Authors & Contributors

**Original Development (2015):**
- **Edoardo** - Primary developer during summer internship
- **Thiago Y. Oliveira** ([stratust](https://github.com/stratust)) - Direct advisor and programming mentor
- **Michel C. Nussenzweig, M.D., Ph.D.** - Research supervisor, Laboratory of Molecular Immunology, The Rockefeller University

**Modern Refactoring (2025):**
- **Edoardo** - Security improvements, comprehensive testing, production deployment, and documentation

**Special Thanks:**
- The Rockefeller University Laboratory of Molecular Immunology
- Brazilian Scientific Mobility Program (BSMP)
- Siena College

## 📞 Support

For issues and questions:
- Check the troubleshooting section above
- Review the comprehensive documentation in each module
- Examine the test files for usage examples
- Check log files for error details

## 🔄 Version History

- **v1.0 (2015)** - Original version developed during Rockefeller University internship
- **v2.0 (2025)** - Complete modernization with security improvements, comprehensive logging, full test coverage, and production deployment capabilities

---

*This README provides a comprehensive overview of the SequencesDB bioinformatics application. For detailed technical documentation, please refer to the POD documentation within each module.*
