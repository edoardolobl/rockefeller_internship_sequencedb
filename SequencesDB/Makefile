# This Makefile is for the SequencesDB extension to perl.
#
# It was generated automatically by MakeMaker version
# 7.70 (Revision: 77000) from the contents of
# Makefile.PL. Don't edit this file, edit Makefile.PL instead.
#
#       ANY CHANGES MADE HERE WILL BE LOST!
#
#   MakeMaker ARGV: ()
#

#   MakeMaker Parameters:

#     ABSTRACT => q[Bioinformatics sequence library management web application]
#     AUTHOR => [q[Edoardo (Refactored for security and maintainability)]]
#     BUILD_REQUIRES => { ExtUtils::MakeMaker=>q[6.36], Test::DBIx::Class=>q[0], Test::Mock::Guard=>q[0], Test::More=>q[0.88], Test::WWW::Mechanize::Catalyst=>q[0] }
#     CONFIGURE_REQUIRES => {  }
#     DISTNAME => q[SequencesDB]
#     EXE_FILES => [q[script/sequencesdb_cgi.pl], q[script/sequencesdb_create.pl], q[script/sequencesdb_fastcgi.pl], q[script/sequencesdb_server.pl], q[script/sequencesdb_test.pl]]
#     LICENSE => q[perl]
#     NAME => q[SequencesDB]
#     NO_META => q[1]
#     PREREQ_PM => { Catalyst::Action::RenderView=>q[0], Catalyst::Plugin::ConfigLoader=>q[0], Catalyst::Plugin::Log::Log4perl=>q[0], Catalyst::Plugin::Static::Simple=>q[0], Catalyst::Runtime=>q[5.90093], Config::General=>q[0], Config::Tiny=>q[0], DBI=>q[0], ExtUtils::MakeMaker=>q[6.36], Log::Log4perl=>q[0], Moose=>q[0], Test::DBIx::Class=>q[0], Test::Mock::Guard=>q[0], Test::More=>q[0.88], Test::WWW::Mechanize::Catalyst=>q[0], namespace::autoclean=>q[0] }
#     TEST_REQUIRES => {  }
#     VERSION => q[0.01]
#     VERSION_FROM => q[lib/SequencesDB.pm]
#     dist => {  }
#     realclean => { FILES=>q[MYMETA.yml] }
#     test => { TESTS=>q[t/01app.t t/02pod.t t/03podcoverage.t t/controller_Library.t t/controller_library_validation.t t/database_file_path.t t/database_sql_final.t t/integration_database.t t/model_DB.t t/schema_library.t t/view_TT.t] }

# --- MakeMaker post_initialize section:


# --- MakeMaker const_config section:

# These definitions are from config.sh (via /usr/lib/x86_64-linux-gnu/perl-base/Config.pm).
# They may have been overridden via Makefile.PL or on the command line.
AR = ar
CC = x86_64-linux-gnu-gcc
CCCDLFLAGS = -fPIC
CCDLFLAGS = -Wl,-E
CPPRUN = x86_64-linux-gnu-gcc  -E
DLEXT = so
DLSRC = dl_dlopen.xs
EXE_EXT = 
FULL_AR = /usr/bin/ar
LD = x86_64-linux-gnu-gcc
LDDLFLAGS = -shared -L/usr/local/lib -fstack-protector-strong
LDFLAGS =  -fstack-protector-strong -L/usr/local/lib
LIBC = /lib/x86_64-linux-gnu/libc.so.6
LIB_EXT = .a
OBJ_EXT = .o
OSNAME = linux
OSVERS = 6.1.0
RANLIB = :
SITELIBEXP = /usr/local/share/perl/5.38.2
SITEARCHEXP = /usr/local/lib/x86_64-linux-gnu/perl/5.38.2
SO = so
VENDORARCHEXP = /usr/lib/x86_64-linux-gnu/perl5/5.38
VENDORLIBEXP = /usr/share/perl5


# --- MakeMaker constants section:
AR_STATIC_ARGS = cr
DIRFILESEP = /
DFSEP = $(DIRFILESEP)
NAME = SequencesDB
NAME_SYM = SequencesDB
VERSION = 0.01
VERSION_MACRO = VERSION
VERSION_SYM = 0_01
DEFINE_VERSION = -D$(VERSION_MACRO)=\"$(VERSION)\"
XS_VERSION = 0.01
XS_VERSION_MACRO = XS_VERSION
XS_DEFINE_VERSION = -D$(XS_VERSION_MACRO)=\"$(XS_VERSION)\"
INST_ARCHLIB = blib/arch
INST_SCRIPT = blib/script
INST_BIN = blib/bin
INST_LIB = blib/lib
INST_MAN1DIR = blib/man1
INST_MAN3DIR = blib/man3
MAN1EXT = 1p
MAN3EXT = 3pm
MAN1SECTION = 1
MAN3SECTION = 3
INSTALLDIRS = site
INSTALL_BASE = /home/edoardolobl/perl5
DESTDIR = 
PREFIX = $(INSTALL_BASE)
INSTALLPRIVLIB = $(INSTALL_BASE)/lib/perl5
DESTINSTALLPRIVLIB = $(DESTDIR)$(INSTALLPRIVLIB)
INSTALLSITELIB = $(INSTALL_BASE)/lib/perl5
DESTINSTALLSITELIB = $(DESTDIR)$(INSTALLSITELIB)
INSTALLVENDORLIB = $(INSTALL_BASE)/lib/perl5
DESTINSTALLVENDORLIB = $(DESTDIR)$(INSTALLVENDORLIB)
INSTALLARCHLIB = $(INSTALL_BASE)/lib/perl5/x86_64-linux-gnu-thread-multi
DESTINSTALLARCHLIB = $(DESTDIR)$(INSTALLARCHLIB)
INSTALLSITEARCH = $(INSTALL_BASE)/lib/perl5/x86_64-linux-gnu-thread-multi
DESTINSTALLSITEARCH = $(DESTDIR)$(INSTALLSITEARCH)
INSTALLVENDORARCH = $(INSTALL_BASE)/lib/perl5/x86_64-linux-gnu-thread-multi
DESTINSTALLVENDORARCH = $(DESTDIR)$(INSTALLVENDORARCH)
INSTALLBIN = $(INSTALL_BASE)/bin
DESTINSTALLBIN = $(DESTDIR)$(INSTALLBIN)
INSTALLSITEBIN = $(INSTALL_BASE)/bin
DESTINSTALLSITEBIN = $(DESTDIR)$(INSTALLSITEBIN)
INSTALLVENDORBIN = $(INSTALL_BASE)/bin
DESTINSTALLVENDORBIN = $(DESTDIR)$(INSTALLVENDORBIN)
INSTALLSCRIPT = $(INSTALL_BASE)/bin
DESTINSTALLSCRIPT = $(DESTDIR)$(INSTALLSCRIPT)
INSTALLSITESCRIPT = $(INSTALL_BASE)/bin
DESTINSTALLSITESCRIPT = $(DESTDIR)$(INSTALLSITESCRIPT)
INSTALLVENDORSCRIPT = $(INSTALL_BASE)/bin
DESTINSTALLVENDORSCRIPT = $(DESTDIR)$(INSTALLVENDORSCRIPT)
INSTALLMAN1DIR = $(INSTALL_BASE)/man/man1
DESTINSTALLMAN1DIR = $(DESTDIR)$(INSTALLMAN1DIR)
INSTALLSITEMAN1DIR = $(INSTALL_BASE)/man/man1
DESTINSTALLSITEMAN1DIR = $(DESTDIR)$(INSTALLSITEMAN1DIR)
INSTALLVENDORMAN1DIR = $(INSTALL_BASE)/man/man1
DESTINSTALLVENDORMAN1DIR = $(DESTDIR)$(INSTALLVENDORMAN1DIR)
INSTALLMAN3DIR = $(INSTALL_BASE)/man/man3
DESTINSTALLMAN3DIR = $(DESTDIR)$(INSTALLMAN3DIR)
INSTALLSITEMAN3DIR = $(INSTALL_BASE)/man/man3
DESTINSTALLSITEMAN3DIR = $(DESTDIR)$(INSTALLSITEMAN3DIR)
INSTALLVENDORMAN3DIR = $(INSTALL_BASE)/man/man3
DESTINSTALLVENDORMAN3DIR = $(DESTDIR)$(INSTALLVENDORMAN3DIR)
PERL_LIB =
PERL_ARCHLIB = /usr/lib/x86_64-linux-gnu/perl/5.38
PERL_ARCHLIBDEP = /usr/lib/x86_64-linux-gnu/perl/5.38
LIBPERL_A = libperl.a
FIRST_MAKEFILE = Makefile
MAKEFILE_OLD = Makefile.old
MAKE_APERL_FILE = Makefile.aperl
PERLMAINCC = $(CC)
PERL_INC = /usr/lib/x86_64-linux-gnu/perl/5.38/CORE
PERL_INCDEP = /usr/lib/x86_64-linux-gnu/perl/5.38/CORE
PERL = "/usr/bin/perl" "-Iinc"
FULLPERL = "/usr/bin/perl" "-Iinc"
ABSPERL = $(PERL)
PERLRUN = $(PERL)
FULLPERLRUN = $(FULLPERL)
ABSPERLRUN = $(ABSPERL)
PERLRUNINST = $(PERLRUN) "-I$(INST_ARCHLIB)" "-Iinc" "-I$(INST_LIB)"
FULLPERLRUNINST = $(FULLPERLRUN) "-I$(INST_ARCHLIB)" "-Iinc" "-I$(INST_LIB)"
ABSPERLRUNINST = $(ABSPERLRUN) "-I$(INST_ARCHLIB)" "-Iinc" "-I$(INST_LIB)"
PERL_CORE = 0
PERM_DIR = 755
PERM_RW = 644
PERM_RWX = 755

MAKEMAKER   = /usr/share/perl/5.38/ExtUtils/MakeMaker.pm
MM_VERSION  = 7.70
MM_REVISION = 77000

# FULLEXT = Pathname for extension directory (eg Foo/Bar/Oracle).
# BASEEXT = Basename part of FULLEXT. May be just equal FULLEXT. (eg Oracle)
# PARENT_NAME = NAME without BASEEXT and no trailing :: (eg Foo::Bar)
# DLBASE  = Basename part of dynamic library. May be just equal BASEEXT.
MAKE = make
FULLEXT = SequencesDB
BASEEXT = SequencesDB
PARENT_NAME = 
DLBASE = $(BASEEXT)
VERSION_FROM = lib/SequencesDB.pm
OBJECT = 
LDFROM = $(OBJECT)
LINKTYPE = dynamic
BOOTDEP = 

# Handy lists of source code files:
XS_FILES = 
C_FILES  = 
O_FILES  = 
H_FILES  = 
MAN1PODS = script/sequencesdb_cgi.pl \
	script/sequencesdb_create.pl \
	script/sequencesdb_fastcgi.pl \
	script/sequencesdb_server.pl \
	script/sequencesdb_test.pl
MAN3PODS = lib/SequencesDB.pm \
	lib/SequencesDB/Controller/Library.pm \
	lib/SequencesDB/Controller/Library_refactored.pm \
	lib/SequencesDB/Controller/Root.pm \
	lib/SequencesDB/Model/DB.pm \
	lib/SequencesDB/Model/DB_refactored.pm \
	lib/SequencesDB/Schema/Result/Antibody.pm \
	lib/SequencesDB/Schema/Result/Background.pm \
	lib/SequencesDB/Schema/Result/Cell.pm \
	lib/SequencesDB/Schema/Result/Experiment.pm \
	lib/SequencesDB/Schema/Result/File.pm \
	lib/SequencesDB/Schema/Result/Library.pm \
	lib/SequencesDB/Schema/Result/Method.pm \
	lib/SequencesDB/Schema/Result/Organism.pm \
	lib/SequencesDB/Schema/Result/ReadType.pm \
	lib/SequencesDB/Schema/Result/Sequencer.pm \
	lib/SequencesDB/Schema/Result/Tissue.pm \
	lib/SequencesDB/View/HTML.pm

# Where is the Config information that we are using/depend on
CONFIGDEP = $(PERL_ARCHLIBDEP)$(DFSEP)Config.pm $(PERL_INCDEP)$(DFSEP)config.h

# Where to build things
INST_LIBDIR      = $(INST_LIB)
INST_ARCHLIBDIR  = $(INST_ARCHLIB)

INST_AUTODIR     = $(INST_LIB)/auto/$(FULLEXT)
INST_ARCHAUTODIR = $(INST_ARCHLIB)/auto/$(FULLEXT)

INST_STATIC      = 
INST_DYNAMIC     = 
INST_BOOT        = 

# Extra linker info
EXPORT_LIST        = 
PERL_ARCHIVE       = 
PERL_ARCHIVEDEP    = 
PERL_ARCHIVE_AFTER = 


TO_INST_PM = lib/SequencesDB.pm \
	lib/SequencesDB/Controller/Library.pm \
	lib/SequencesDB/Controller/Library_refactored.pm \
	lib/SequencesDB/Controller/Root.pm \
	lib/SequencesDB/Model/DB.pm \
	lib/SequencesDB/Model/DB_refactored.pm \
	lib/SequencesDB/Schema.pm \
	lib/SequencesDB/Schema/Result/Antibody.pm \
	lib/SequencesDB/Schema/Result/Background.pm \
	lib/SequencesDB/Schema/Result/Cell.pm \
	lib/SequencesDB/Schema/Result/Experiment.pm \
	lib/SequencesDB/Schema/Result/File.pm \
	lib/SequencesDB/Schema/Result/Library.pm \
	lib/SequencesDB/Schema/Result/Library.pm.bk \
	lib/SequencesDB/Schema/Result/Library.pm.bk2 \
	lib/SequencesDB/Schema/Result/Method.pm \
	lib/SequencesDB/Schema/Result/Organism.pm \
	lib/SequencesDB/Schema/Result/ReadType.pm \
	lib/SequencesDB/Schema/Result/Sequencer.pm \
	lib/SequencesDB/Schema/Result/Tissue.pm \
	lib/SequencesDB/Schema/ResultSet/Library.pm \
	lib/SequencesDB/View/HTML.pm


# --- MakeMaker platform_constants section:
MM_Unix_VERSION = 7.70
PERL_MALLOC_DEF = -DPERL_EXTMALLOC_DEF -Dmalloc=Perl_malloc -Dfree=Perl_mfree -Drealloc=Perl_realloc -Dcalloc=Perl_calloc


# --- MakeMaker tool_autosplit section:
# Usage: $(AUTOSPLITFILE) FileToSplit AutoDirToSplitInto
AUTOSPLITFILE = $(ABSPERLRUN)  -e 'use AutoSplit;  autosplit($$$$ARGV[0], $$$$ARGV[1], 0, 1, 1)' --



# --- MakeMaker tool_xsubpp section:


# --- MakeMaker tools_other section:
SHELL = /bin/sh
CHMOD = chmod
CP = cp
MV = mv
NOOP = $(TRUE)
NOECHO = @
RM_F = rm -f
RM_RF = rm -rf
TEST_F = test -f
TOUCH = touch
UMASK_NULL = umask 0
DEV_NULL = > /dev/null 2>&1
MKPATH = $(ABSPERLRUN) -MExtUtils::Command -e 'mkpath' --
EQUALIZE_TIMESTAMP = $(ABSPERLRUN) -MExtUtils::Command -e 'eqtime' --
FALSE = false
TRUE = true
ECHO = echo
ECHO_N = echo -n
UNINST = 0
VERBINST = 0
MOD_INSTALL = $(ABSPERLRUN) -MExtUtils::Install -e 'install([ from_to => {@ARGV}, verbose => '\''$(VERBINST)'\'', uninstall_shadows => '\''$(UNINST)'\'', dir_mode => '\''$(PERM_DIR)'\'' ]);' --
DOC_INSTALL = $(ABSPERLRUN) -MExtUtils::Command::MM -e 'perllocal_install' --
UNINSTALL = $(ABSPERLRUN) -MExtUtils::Command::MM -e 'uninstall' --
WARN_IF_OLD_PACKLIST = $(ABSPERLRUN) -MExtUtils::Command::MM -e 'warn_if_old_packlist' --
MACROSTART = 
MACROEND = 
USEMAKEFILE = -f
FIXIN = $(ABSPERLRUN) -MExtUtils::MY -e 'MY->fixin(shift)' --
CP_NONEMPTY = $(ABSPERLRUN) -MExtUtils::Command::MM -e 'cp_nonempty' --


# --- MakeMaker makemakerdflt section:
makemakerdflt : all
	$(NOECHO) $(NOOP)


# --- MakeMaker dist section:
TAR = tar
TARFLAGS = cvf
ZIP = zip
ZIPFLAGS = -r
COMPRESS = gzip --best
SUFFIX = .gz
SHAR = shar
PREOP = $(NOECHO) $(NOOP)
POSTOP = $(NOECHO) $(NOOP)
TO_UNIX = $(NOECHO) $(NOOP)
CI = ci -u
RCS_LABEL = rcs -Nv$(VERSION_SYM): -q
DIST_CP = best
DIST_DEFAULT = tardist
DISTNAME = SequencesDB
DISTVNAME = SequencesDB-0.01


# --- MakeMaker macro section:


# --- MakeMaker depend section:


# --- MakeMaker cflags section:


# --- MakeMaker const_loadlibs section:


# --- MakeMaker const_cccmd section:


# --- MakeMaker post_constants section:


# --- MakeMaker pasthru section:

PASTHRU = LIBPERL_A="$(LIBPERL_A)"\
	LINKTYPE="$(LINKTYPE)"\
	LD="$(LD)"\
	PREFIX="$(PREFIX)"\
	INSTALL_BASE="$(INSTALL_BASE)"\
	PASTHRU_DEFINE='$(DEFINE) $(PASTHRU_DEFINE)'\
	PASTHRU_INC='$(INC) $(PASTHRU_INC)'


# --- MakeMaker special_targets section:
.SUFFIXES : .xs .c .C .cpp .i .s .cxx .cc $(OBJ_EXT)

.PHONY: all config static dynamic test linkext manifest blibdirs clean realclean disttest distdir pure_all subdirs clean_subdirs makemakerdflt manifypods realclean_subdirs subdirs_dynamic subdirs_pure_nolink subdirs_static subdirs-test_dynamic subdirs-test_static test_dynamic test_static



# --- MakeMaker c_o section:


# --- MakeMaker xs_c section:


# --- MakeMaker xs_o section:


# --- MakeMaker top_targets section:
all :: pure_all manifypods
	$(NOECHO) $(NOOP)

pure_all :: config pm_to_blib subdirs linkext
	$(NOECHO) $(NOOP)

subdirs :: $(MYEXTLIB)
	$(NOECHO) $(NOOP)

config :: $(FIRST_MAKEFILE) blibdirs
	$(NOECHO) $(NOOP)

help :
	perldoc ExtUtils::MakeMaker


# --- MakeMaker blibdirs section:
blibdirs : $(INST_LIBDIR)$(DFSEP).exists $(INST_ARCHLIB)$(DFSEP).exists $(INST_AUTODIR)$(DFSEP).exists $(INST_ARCHAUTODIR)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists $(INST_SCRIPT)$(DFSEP).exists $(INST_MAN1DIR)$(DFSEP).exists $(INST_MAN3DIR)$(DFSEP).exists
	$(NOECHO) $(NOOP)

# Backwards compat with 6.18 through 6.25
blibdirs.ts : blibdirs
	$(NOECHO) $(NOOP)

$(INST_LIBDIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_LIBDIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_LIBDIR)
	$(NOECHO) $(TOUCH) $(INST_LIBDIR)$(DFSEP).exists

$(INST_ARCHLIB)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_ARCHLIB)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_ARCHLIB)
	$(NOECHO) $(TOUCH) $(INST_ARCHLIB)$(DFSEP).exists

$(INST_AUTODIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_AUTODIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_AUTODIR)
	$(NOECHO) $(TOUCH) $(INST_AUTODIR)$(DFSEP).exists

$(INST_ARCHAUTODIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_ARCHAUTODIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_ARCHAUTODIR)
	$(NOECHO) $(TOUCH) $(INST_ARCHAUTODIR)$(DFSEP).exists

$(INST_BIN)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_BIN)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_BIN)
	$(NOECHO) $(TOUCH) $(INST_BIN)$(DFSEP).exists

$(INST_SCRIPT)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_SCRIPT)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_SCRIPT)
	$(NOECHO) $(TOUCH) $(INST_SCRIPT)$(DFSEP).exists

$(INST_MAN1DIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_MAN1DIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_MAN1DIR)
	$(NOECHO) $(TOUCH) $(INST_MAN1DIR)$(DFSEP).exists

$(INST_MAN3DIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_MAN3DIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_MAN3DIR)
	$(NOECHO) $(TOUCH) $(INST_MAN3DIR)$(DFSEP).exists



# --- MakeMaker linkext section:

linkext :: dynamic
	$(NOECHO) $(NOOP)


# --- MakeMaker dlsyms section:


# --- MakeMaker dynamic_bs section:

BOOTSTRAP =


# --- MakeMaker dynamic section:

dynamic :: $(FIRST_MAKEFILE) config $(INST_BOOT) $(INST_DYNAMIC)
	$(NOECHO) $(NOOP)


# --- MakeMaker dynamic_lib section:


# --- MakeMaker static section:

## $(INST_PM) has been moved to the all: target.
## It remains here for awhile to allow for old usage: "make static"
static :: $(FIRST_MAKEFILE) $(INST_STATIC)
	$(NOECHO) $(NOOP)


# --- MakeMaker static_lib section:


# --- MakeMaker manifypods section:

POD2MAN_EXE = $(PERLRUN) "-MExtUtils::Command::MM" -e pod2man "--"
POD2MAN = $(POD2MAN_EXE)


manifypods : pure_all config  \
	lib/SequencesDB.pm \
	lib/SequencesDB/Controller/Library.pm \
	lib/SequencesDB/Controller/Library_refactored.pm \
	lib/SequencesDB/Controller/Root.pm \
	lib/SequencesDB/Model/DB.pm \
	lib/SequencesDB/Model/DB_refactored.pm \
	lib/SequencesDB/Schema/Result/Antibody.pm \
	lib/SequencesDB/Schema/Result/Background.pm \
	lib/SequencesDB/Schema/Result/Cell.pm \
	lib/SequencesDB/Schema/Result/Experiment.pm \
	lib/SequencesDB/Schema/Result/File.pm \
	lib/SequencesDB/Schema/Result/Library.pm \
	lib/SequencesDB/Schema/Result/Method.pm \
	lib/SequencesDB/Schema/Result/Organism.pm \
	lib/SequencesDB/Schema/Result/ReadType.pm \
	lib/SequencesDB/Schema/Result/Sequencer.pm \
	lib/SequencesDB/Schema/Result/Tissue.pm \
	lib/SequencesDB/View/HTML.pm \
	script/sequencesdb_cgi.pl \
	script/sequencesdb_create.pl \
	script/sequencesdb_fastcgi.pl \
	script/sequencesdb_server.pl \
	script/sequencesdb_test.pl
	$(NOECHO) $(POD2MAN) --section=$(MAN1EXT) --perm_rw=$(PERM_RW) -u \
	  script/sequencesdb_cgi.pl $(INST_MAN1DIR)/sequencesdb_cgi.pl.$(MAN1EXT) \
	  script/sequencesdb_create.pl $(INST_MAN1DIR)/sequencesdb_create.pl.$(MAN1EXT) \
	  script/sequencesdb_fastcgi.pl $(INST_MAN1DIR)/sequencesdb_fastcgi.pl.$(MAN1EXT) \
	  script/sequencesdb_server.pl $(INST_MAN1DIR)/sequencesdb_server.pl.$(MAN1EXT) \
	  script/sequencesdb_test.pl $(INST_MAN1DIR)/sequencesdb_test.pl.$(MAN1EXT) 
	$(NOECHO) $(POD2MAN) --section=$(MAN3EXT) --perm_rw=$(PERM_RW) -u \
	  lib/SequencesDB.pm $(INST_MAN3DIR)/SequencesDB.$(MAN3EXT) \
	  lib/SequencesDB/Controller/Library.pm $(INST_MAN3DIR)/SequencesDB::Controller::Library.$(MAN3EXT) \
	  lib/SequencesDB/Controller/Library_refactored.pm $(INST_MAN3DIR)/SequencesDB::Controller::Library_refactored.$(MAN3EXT) \
	  lib/SequencesDB/Controller/Root.pm $(INST_MAN3DIR)/SequencesDB::Controller::Root.$(MAN3EXT) \
	  lib/SequencesDB/Model/DB.pm $(INST_MAN3DIR)/SequencesDB::Model::DB.$(MAN3EXT) \
	  lib/SequencesDB/Model/DB_refactored.pm $(INST_MAN3DIR)/SequencesDB::Model::DB_refactored.$(MAN3EXT) \
	  lib/SequencesDB/Schema/Result/Antibody.pm $(INST_MAN3DIR)/SequencesDB::Schema::Result::Antibody.$(MAN3EXT) \
	  lib/SequencesDB/Schema/Result/Background.pm $(INST_MAN3DIR)/SequencesDB::Schema::Result::Background.$(MAN3EXT) \
	  lib/SequencesDB/Schema/Result/Cell.pm $(INST_MAN3DIR)/SequencesDB::Schema::Result::Cell.$(MAN3EXT) \
	  lib/SequencesDB/Schema/Result/Experiment.pm $(INST_MAN3DIR)/SequencesDB::Schema::Result::Experiment.$(MAN3EXT) \
	  lib/SequencesDB/Schema/Result/File.pm $(INST_MAN3DIR)/SequencesDB::Schema::Result::File.$(MAN3EXT) \
	  lib/SequencesDB/Schema/Result/Library.pm $(INST_MAN3DIR)/SequencesDB::Schema::Result::Library.$(MAN3EXT) \
	  lib/SequencesDB/Schema/Result/Method.pm $(INST_MAN3DIR)/SequencesDB::Schema::Result::Method.$(MAN3EXT) \
	  lib/SequencesDB/Schema/Result/Organism.pm $(INST_MAN3DIR)/SequencesDB::Schema::Result::Organism.$(MAN3EXT) \
	  lib/SequencesDB/Schema/Result/ReadType.pm $(INST_MAN3DIR)/SequencesDB::Schema::Result::ReadType.$(MAN3EXT) \
	  lib/SequencesDB/Schema/Result/Sequencer.pm $(INST_MAN3DIR)/SequencesDB::Schema::Result::Sequencer.$(MAN3EXT) \
	  lib/SequencesDB/Schema/Result/Tissue.pm $(INST_MAN3DIR)/SequencesDB::Schema::Result::Tissue.$(MAN3EXT) \
	  lib/SequencesDB/View/HTML.pm $(INST_MAN3DIR)/SequencesDB::View::HTML.$(MAN3EXT) 




# --- MakeMaker processPL section:


# --- MakeMaker installbin section:

EXE_FILES = script/sequencesdb_cgi.pl script/sequencesdb_create.pl script/sequencesdb_fastcgi.pl script/sequencesdb_server.pl script/sequencesdb_test.pl

pure_all :: $(INST_SCRIPT)/sequencesdb_cgi.pl $(INST_SCRIPT)/sequencesdb_create.pl $(INST_SCRIPT)/sequencesdb_fastcgi.pl $(INST_SCRIPT)/sequencesdb_server.pl $(INST_SCRIPT)/sequencesdb_test.pl
	$(NOECHO) $(NOOP)

realclean ::
	$(RM_F) \
	  $(INST_SCRIPT)/sequencesdb_cgi.pl $(INST_SCRIPT)/sequencesdb_create.pl \
	  $(INST_SCRIPT)/sequencesdb_fastcgi.pl $(INST_SCRIPT)/sequencesdb_server.pl \
	  $(INST_SCRIPT)/sequencesdb_test.pl 

$(INST_SCRIPT)/sequencesdb_cgi.pl : script/sequencesdb_cgi.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/sequencesdb_cgi.pl
	$(CP) script/sequencesdb_cgi.pl $(INST_SCRIPT)/sequencesdb_cgi.pl
	$(FIXIN) $(INST_SCRIPT)/sequencesdb_cgi.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/sequencesdb_cgi.pl

$(INST_SCRIPT)/sequencesdb_create.pl : script/sequencesdb_create.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/sequencesdb_create.pl
	$(CP) script/sequencesdb_create.pl $(INST_SCRIPT)/sequencesdb_create.pl
	$(FIXIN) $(INST_SCRIPT)/sequencesdb_create.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/sequencesdb_create.pl

$(INST_SCRIPT)/sequencesdb_fastcgi.pl : script/sequencesdb_fastcgi.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/sequencesdb_fastcgi.pl
	$(CP) script/sequencesdb_fastcgi.pl $(INST_SCRIPT)/sequencesdb_fastcgi.pl
	$(FIXIN) $(INST_SCRIPT)/sequencesdb_fastcgi.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/sequencesdb_fastcgi.pl

$(INST_SCRIPT)/sequencesdb_server.pl : script/sequencesdb_server.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/sequencesdb_server.pl
	$(CP) script/sequencesdb_server.pl $(INST_SCRIPT)/sequencesdb_server.pl
	$(FIXIN) $(INST_SCRIPT)/sequencesdb_server.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/sequencesdb_server.pl

$(INST_SCRIPT)/sequencesdb_test.pl : script/sequencesdb_test.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/sequencesdb_test.pl
	$(CP) script/sequencesdb_test.pl $(INST_SCRIPT)/sequencesdb_test.pl
	$(FIXIN) $(INST_SCRIPT)/sequencesdb_test.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/sequencesdb_test.pl



# --- MakeMaker subdirs section:

# none

# --- MakeMaker clean_subdirs section:
clean_subdirs :
	$(NOECHO) $(NOOP)


# --- MakeMaker clean section:

# Delete temporary files but do not touch installed files. We don't delete
# the Makefile here so a later make realclean still has a makefile to use.

clean :: clean_subdirs
	- $(RM_F) \
	  $(BASEEXT).bso $(BASEEXT).def \
	  $(BASEEXT).exp $(BASEEXT).x \
	  $(BOOTSTRAP) $(INST_ARCHAUTODIR)/extralibs.all \
	  $(INST_ARCHAUTODIR)/extralibs.ld $(MAKE_APERL_FILE) \
	  *$(LIB_EXT) *$(OBJ_EXT) \
	  *perl.core MYMETA.json \
	  MYMETA.yml blibdirs.ts \
	  core core.*perl.*.? \
	  core.[0-9] core.[0-9][0-9] \
	  core.[0-9][0-9][0-9] core.[0-9][0-9][0-9][0-9] \
	  core.[0-9][0-9][0-9][0-9][0-9] lib$(BASEEXT).def \
	  mon.out perl \
	  perl$(EXE_EXT) perl.exe \
	  perlmain.c pm_to_blib \
	  pm_to_blib.ts so_locations \
	  tmon.out 
	- $(RM_RF) \
	  blib 
	  $(NOECHO) $(RM_F) $(MAKEFILE_OLD)
	- $(MV) $(FIRST_MAKEFILE) $(MAKEFILE_OLD) $(DEV_NULL)


# --- MakeMaker realclean_subdirs section:
# so clean is forced to complete before realclean_subdirs runs
realclean_subdirs : clean
	$(NOECHO) $(NOOP)


# --- MakeMaker realclean section:
# Delete temporary files (via clean) and also delete dist files
realclean purge :: realclean_subdirs
	- $(RM_F) \
	  $(FIRST_MAKEFILE) $(MAKEFILE_OLD) 
	- $(RM_RF) \
	  $(DISTVNAME) MYMETA.yml 


# --- MakeMaker metafile section:
metafile :
	$(NOECHO) $(NOOP)


# --- MakeMaker signature section:
signature :
	cpansign -s


# --- MakeMaker dist_basics section:
distclean :: realclean distcheck
	$(NOECHO) $(NOOP)

distcheck :
	$(PERLRUN) "-MExtUtils::Manifest=fullcheck" -e fullcheck

skipcheck :
	$(PERLRUN) "-MExtUtils::Manifest=skipcheck" -e skipcheck

manifest :
	$(PERLRUN) "-MExtUtils::Manifest=mkmanifest" -e mkmanifest

veryclean : realclean
	$(RM_F) *~ */*~ *.orig */*.orig *.bak */*.bak *.old */*.old



# --- MakeMaker dist_core section:

dist : $(DIST_DEFAULT) $(FIRST_MAKEFILE)
	$(NOECHO) $(ABSPERLRUN) -l -e 'print '\''Warning: Makefile possibly out of date with $(VERSION_FROM)'\''' \
	  -e '    if -e '\''$(VERSION_FROM)'\'' and -M '\''$(VERSION_FROM)'\'' < -M '\''$(FIRST_MAKEFILE)'\'';' --

tardist : $(DISTVNAME).tar$(SUFFIX)
	$(NOECHO) $(NOOP)

uutardist : $(DISTVNAME).tar$(SUFFIX)
	uuencode $(DISTVNAME).tar$(SUFFIX) $(DISTVNAME).tar$(SUFFIX) > $(DISTVNAME).tar$(SUFFIX)_uu
	$(NOECHO) $(ECHO) 'Created $(DISTVNAME).tar$(SUFFIX)_uu'

$(DISTVNAME).tar$(SUFFIX) : distdir
	$(PREOP)
	$(TO_UNIX)
	$(TAR) $(TARFLAGS) $(DISTVNAME).tar $(DISTVNAME)
	$(RM_RF) $(DISTVNAME)
	$(COMPRESS) $(DISTVNAME).tar
	$(NOECHO) $(ECHO) 'Created $(DISTVNAME).tar$(SUFFIX)'
	$(POSTOP)

zipdist : $(DISTVNAME).zip
	$(NOECHO) $(NOOP)

$(DISTVNAME).zip : distdir
	$(PREOP)
	$(ZIP) $(ZIPFLAGS) $(DISTVNAME).zip $(DISTVNAME)
	$(RM_RF) $(DISTVNAME)
	$(NOECHO) $(ECHO) 'Created $(DISTVNAME).zip'
	$(POSTOP)

shdist : distdir
	$(PREOP)
	$(SHAR) $(DISTVNAME) > $(DISTVNAME).shar
	$(RM_RF) $(DISTVNAME)
	$(NOECHO) $(ECHO) 'Created $(DISTVNAME).shar'
	$(POSTOP)


# --- MakeMaker distdir section:
create_distdir :
	$(RM_RF) $(DISTVNAME)
	$(PERLRUN) "-MExtUtils::Manifest=manicopy,maniread" \
		-e "manicopy(maniread(),'$(DISTVNAME)', '$(DIST_CP)');"

distdir : create_distdir  
	$(NOECHO) $(NOOP)



# --- MakeMaker dist_test section:
disttest : distdir
	cd $(DISTVNAME) && $(ABSPERLRUN) Makefile.PL 
	cd $(DISTVNAME) && $(MAKE) $(PASTHRU)
	cd $(DISTVNAME) && $(MAKE) test $(PASTHRU)



# --- MakeMaker dist_ci section:
ci :
	$(ABSPERLRUN) -MExtUtils::Manifest=maniread -e '@all = sort keys %{ maniread() };' \
	  -e 'print(qq{Executing $(CI) @all\n});' \
	  -e 'system(qq{$(CI) @all}) == 0 or die $$!;' \
	  -e 'print(qq{Executing $(RCS_LABEL) ...\n});' \
	  -e 'system(qq{$(RCS_LABEL) @all}) == 0 or die $$!;' --


# --- MakeMaker distmeta section:
distmeta : create_distdir metafile
	$(NOECHO) cd $(DISTVNAME) && $(ABSPERLRUN) -MExtUtils::Manifest=maniadd -e 'exit unless -e q{META.yml};' \
	  -e 'eval { maniadd({q{META.yml} => q{Module YAML meta-data (added by MakeMaker)}}) }' \
	  -e '    or die "Could not add META.yml to MANIFEST: $${'\''@'\''}"' --
	$(NOECHO) cd $(DISTVNAME) && $(ABSPERLRUN) -MExtUtils::Manifest=maniadd -e 'exit unless -f q{META.json};' \
	  -e 'eval { maniadd({q{META.json} => q{Module JSON meta-data (added by MakeMaker)}}) }' \
	  -e '    or die "Could not add META.json to MANIFEST: $${'\''@'\''}"' --



# --- MakeMaker distsignature section:
distsignature : distmeta
	$(NOECHO) cd $(DISTVNAME) && $(ABSPERLRUN) -MExtUtils::Manifest=maniadd -e 'eval { maniadd({q{SIGNATURE} => q{Public-key signature (added by MakeMaker)}}) }' \
	  -e '    or die "Could not add SIGNATURE to MANIFEST: $${'\''@'\''}"' --
	$(NOECHO) cd $(DISTVNAME) && $(TOUCH) SIGNATURE
	cd $(DISTVNAME) && cpansign -s



# --- MakeMaker install section:

install :: pure_install doc_install
	$(NOECHO) $(NOOP)

install_perl :: pure_perl_install doc_perl_install
	$(NOECHO) $(NOOP)

install_site :: pure_site_install doc_site_install
	$(NOECHO) $(NOOP)

install_vendor :: pure_vendor_install doc_vendor_install
	$(NOECHO) $(NOOP)

pure_install :: pure_$(INSTALLDIRS)_install
	$(NOECHO) $(NOOP)

doc_install :: doc_$(INSTALLDIRS)_install
	$(NOECHO) $(NOOP)

pure__install : pure_site_install
	$(NOECHO) $(ECHO) INSTALLDIRS not defined, defaulting to INSTALLDIRS=site

doc__install : doc_site_install
	$(NOECHO) $(ECHO) INSTALLDIRS not defined, defaulting to INSTALLDIRS=site

pure_perl_install :: all
	$(NOECHO) umask 022; $(MOD_INSTALL) \
		"$(INST_LIB)" "$(DESTINSTALLPRIVLIB)" \
		"$(INST_ARCHLIB)" "$(DESTINSTALLARCHLIB)" \
		"$(INST_BIN)" "$(DESTINSTALLBIN)" \
		"$(INST_SCRIPT)" "$(DESTINSTALLSCRIPT)" \
		"$(INST_MAN1DIR)" "$(DESTINSTALLMAN1DIR)" \
		"$(INST_MAN3DIR)" "$(DESTINSTALLMAN3DIR)"
	$(NOECHO) $(WARN_IF_OLD_PACKLIST) \
		"$(SITEARCHEXP)/auto/$(FULLEXT)"


pure_site_install :: all
	$(NOECHO) umask 02; $(MOD_INSTALL) \
		read "$(SITEARCHEXP)/auto/$(FULLEXT)/.packlist" \
		write "$(DESTINSTALLSITEARCH)/auto/$(FULLEXT)/.packlist" \
		"$(INST_LIB)" "$(DESTINSTALLSITELIB)" \
		"$(INST_ARCHLIB)" "$(DESTINSTALLSITEARCH)" \
		"$(INST_BIN)" "$(DESTINSTALLSITEBIN)" \
		"$(INST_SCRIPT)" "$(DESTINSTALLSITESCRIPT)" \
		"$(INST_MAN1DIR)" "$(DESTINSTALLSITEMAN1DIR)" \
		"$(INST_MAN3DIR)" "$(DESTINSTALLSITEMAN3DIR)"
	$(NOECHO) $(WARN_IF_OLD_PACKLIST) \
		"$(PERL_ARCHLIB)/auto/$(FULLEXT)"

pure_vendor_install :: all
	$(NOECHO) umask 022; $(MOD_INSTALL) \
		"$(INST_LIB)" "$(DESTINSTALLVENDORLIB)" \
		"$(INST_ARCHLIB)" "$(DESTINSTALLVENDORARCH)" \
		"$(INST_BIN)" "$(DESTINSTALLVENDORBIN)" \
		"$(INST_SCRIPT)" "$(DESTINSTALLVENDORSCRIPT)" \
		"$(INST_MAN1DIR)" "$(DESTINSTALLVENDORMAN1DIR)" \
		"$(INST_MAN3DIR)" "$(DESTINSTALLVENDORMAN3DIR)"


doc_perl_install :: all

doc_site_install :: all
	$(NOECHO) $(ECHO) Appending installation info to "$(DESTINSTALLSITEARCH)/perllocal.pod"
	-$(NOECHO) umask 02; $(MKPATH) "$(DESTINSTALLSITEARCH)"
	-$(NOECHO) umask 02; $(DOC_INSTALL) \
		"Module" "$(NAME)" \
		"installed into" "$(INSTALLSITELIB)" \
		LINKTYPE "$(LINKTYPE)" \
		VERSION "$(VERSION)" \
		EXE_FILES "$(EXE_FILES)" \
		>> "$(DESTINSTALLSITEARCH)/perllocal.pod"

doc_vendor_install :: all


uninstall :: uninstall_from_$(INSTALLDIRS)dirs
	$(NOECHO) $(NOOP)

uninstall_from_perldirs ::

uninstall_from_sitedirs ::
	$(NOECHO) $(UNINSTALL) "$(SITEARCHEXP)/auto/$(FULLEXT)/.packlist"

uninstall_from_vendordirs ::


# --- MakeMaker force section:
# Phony target to force checking subdirectories.
FORCE :
	$(NOECHO) $(NOOP)


# --- MakeMaker perldepend section:


# --- MakeMaker makefile section:
# We take a very conservative approach here, but it's worth it.
# We move Makefile to Makefile.old here to avoid gnu make looping.
$(FIRST_MAKEFILE) : Makefile.PL $(CONFIGDEP)
	$(NOECHO) $(ECHO) "Makefile out-of-date with respect to $?"
	$(NOECHO) $(ECHO) "Cleaning current config before rebuilding Makefile..."
	-$(NOECHO) $(RM_F) $(MAKEFILE_OLD)
	-$(NOECHO) $(MV)   $(FIRST_MAKEFILE) $(MAKEFILE_OLD)
	- $(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) clean $(DEV_NULL)
	$(PERLRUN) Makefile.PL 
	$(NOECHO) $(ECHO) "==> Your Makefile has been rebuilt. <=="
	$(NOECHO) $(ECHO) "==> Please rerun the $(MAKE) command.  <=="
	$(FALSE)



# --- MakeMaker staticmake section:

# --- MakeMaker makeaperl section ---
MAP_TARGET    = perl
FULLPERL      = "/usr/bin/perl"
MAP_PERLINC   = "-Iblib/arch" "-Iblib/lib" "-I/usr/lib/x86_64-linux-gnu/perl/5.38" "-I/usr/share/perl/5.38"

$(MAP_TARGET) :: $(MAKE_APERL_FILE)
	$(MAKE) $(USEMAKEFILE) $(MAKE_APERL_FILE) $@

$(MAKE_APERL_FILE) : static $(FIRST_MAKEFILE) pm_to_blib
	$(NOECHO) $(ECHO) Writing \"$(MAKE_APERL_FILE)\" for this $(MAP_TARGET)
	$(NOECHO) $(PERLRUNINST) \
		Makefile.PL DIR="" \
		MAKEFILE=$(MAKE_APERL_FILE) LINKTYPE=static \
		MAKEAPERL=1 NORECURS=1 CCCDLFLAGS=


# --- MakeMaker test section:
TEST_VERBOSE=0
TEST_TYPE=test_$(LINKTYPE)
TEST_FILE = test.pl
TEST_FILES = t/01app.t t/02pod.t t/03podcoverage.t t/controller_Library.t t/controller_library_validation.t t/database_file_path.t t/database_sql_final.t t/integration_database.t t/model_DB.t t/schema_library.t t/view_TT.t
TESTDB_SW = -d

testdb :: testdb_$(LINKTYPE)
	$(NOECHO) $(NOOP)

test :: $(TEST_TYPE)
	$(NOECHO) $(NOOP)

# Occasionally we may face this degenerate target:
test_ : test_dynamic
	$(NOECHO) $(NOOP)

subdirs-test_dynamic :: dynamic pure_all

test_dynamic :: subdirs-test_dynamic
	PERL_DL_NONLAZY=1 $(FULLPERLRUN) "-MExtUtils::Command::MM" "-MTest::Harness" "-e" "undef *Test::Harness::Switches; test_harness($(TEST_VERBOSE), 'inc', '$(INST_LIB)', '$(INST_ARCHLIB)')" $(TEST_FILES)

testdb_dynamic :: dynamic pure_all
	PERL_DL_NONLAZY=1 $(FULLPERLRUN) $(TESTDB_SW) "-Iinc" "-I$(INST_LIB)" "-I$(INST_ARCHLIB)" $(TEST_FILE)

subdirs-test_static :: static pure_all

test_static :: subdirs-test_static
	PERL_DL_NONLAZY=1 $(FULLPERLRUN) "-MExtUtils::Command::MM" "-MTest::Harness" "-e" "undef *Test::Harness::Switches; test_harness($(TEST_VERBOSE), '$(INST_LIB)', '$(INST_ARCHLIB)')" $(TEST_FILES)

testdb_static :: static pure_all
	PERL_DL_NONLAZY=1 $(FULLPERLRUN) $(TESTDB_SW) "-Iinc" "-I$(INST_LIB)" "-I$(INST_ARCHLIB)" $(TEST_FILE)



# --- MakeMaker ppd section:
# Creates a PPD (Perl Package Description) for a binary distribution.
ppd :
	$(NOECHO) $(ECHO) '<SOFTPKG NAME="SequencesDB" VERSION="0.01">' > SequencesDB.ppd
	$(NOECHO) $(ECHO) '    <ABSTRACT>Bioinformatics sequence library management web application</ABSTRACT>' >> SequencesDB.ppd
	$(NOECHO) $(ECHO) '    <AUTHOR>Edoardo (Refactored for security and maintainability)</AUTHOR>' >> SequencesDB.ppd
	$(NOECHO) $(ECHO) '    <IMPLEMENTATION>' >> SequencesDB.ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Action::RenderView" />' >> SequencesDB.ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::ConfigLoader" />' >> SequencesDB.ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::Log::Log4perl" />' >> SequencesDB.ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::Static::Simple" />' >> SequencesDB.ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Runtime" VERSION="5.90093" />' >> SequencesDB.ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Config::General" />' >> SequencesDB.ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Config::Tiny" />' >> SequencesDB.ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="DBI::" />' >> SequencesDB.ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Log::Log4perl" />' >> SequencesDB.ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Moose::" />' >> SequencesDB.ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Test::DBIx::Class" />' >> SequencesDB.ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Test::Mock::Guard" />' >> SequencesDB.ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Test::More" VERSION="0.88" />' >> SequencesDB.ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Test::WWW::Mechanize::Catalyst" />' >> SequencesDB.ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="namespace::autoclean" />' >> SequencesDB.ppd
	$(NOECHO) $(ECHO) '        <ARCHITECTURE NAME="x86_64-linux-gnu-thread-multi-5.38" />' >> SequencesDB.ppd
	$(NOECHO) $(ECHO) '        <CODEBASE HREF="" />' >> SequencesDB.ppd
	$(NOECHO) $(ECHO) '    </IMPLEMENTATION>' >> SequencesDB.ppd
	$(NOECHO) $(ECHO) '</SOFTPKG>' >> SequencesDB.ppd


# --- MakeMaker pm_to_blib section:

pm_to_blib : $(FIRST_MAKEFILE) $(TO_INST_PM)
	$(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e 'pm_to_blib({@ARGV}, '\''$(INST_LIB)/auto'\'', q[$(PM_FILTER)], '\''$(PERM_DIR)'\'')' -- \
	  'lib/SequencesDB.pm' 'blib/lib/SequencesDB.pm' \
	  'lib/SequencesDB/Controller/Library.pm' 'blib/lib/SequencesDB/Controller/Library.pm' \
	  'lib/SequencesDB/Controller/Library_refactored.pm' 'blib/lib/SequencesDB/Controller/Library_refactored.pm' \
	  'lib/SequencesDB/Controller/Root.pm' 'blib/lib/SequencesDB/Controller/Root.pm' \
	  'lib/SequencesDB/Model/DB.pm' 'blib/lib/SequencesDB/Model/DB.pm' \
	  'lib/SequencesDB/Model/DB_refactored.pm' 'blib/lib/SequencesDB/Model/DB_refactored.pm' \
	  'lib/SequencesDB/Schema.pm' 'blib/lib/SequencesDB/Schema.pm' \
	  'lib/SequencesDB/Schema/Result/Antibody.pm' 'blib/lib/SequencesDB/Schema/Result/Antibody.pm' \
	  'lib/SequencesDB/Schema/Result/Background.pm' 'blib/lib/SequencesDB/Schema/Result/Background.pm' \
	  'lib/SequencesDB/Schema/Result/Cell.pm' 'blib/lib/SequencesDB/Schema/Result/Cell.pm' \
	  'lib/SequencesDB/Schema/Result/Experiment.pm' 'blib/lib/SequencesDB/Schema/Result/Experiment.pm' \
	  'lib/SequencesDB/Schema/Result/File.pm' 'blib/lib/SequencesDB/Schema/Result/File.pm' \
	  'lib/SequencesDB/Schema/Result/Library.pm' 'blib/lib/SequencesDB/Schema/Result/Library.pm' \
	  'lib/SequencesDB/Schema/Result/Library.pm.bk' 'blib/lib/SequencesDB/Schema/Result/Library.pm.bk' \
	  'lib/SequencesDB/Schema/Result/Library.pm.bk2' 'blib/lib/SequencesDB/Schema/Result/Library.pm.bk2' \
	  'lib/SequencesDB/Schema/Result/Method.pm' 'blib/lib/SequencesDB/Schema/Result/Method.pm' \
	  'lib/SequencesDB/Schema/Result/Organism.pm' 'blib/lib/SequencesDB/Schema/Result/Organism.pm' \
	  'lib/SequencesDB/Schema/Result/ReadType.pm' 'blib/lib/SequencesDB/Schema/Result/ReadType.pm' \
	  'lib/SequencesDB/Schema/Result/Sequencer.pm' 'blib/lib/SequencesDB/Schema/Result/Sequencer.pm' \
	  'lib/SequencesDB/Schema/Result/Tissue.pm' 'blib/lib/SequencesDB/Schema/Result/Tissue.pm' \
	  'lib/SequencesDB/Schema/ResultSet/Library.pm' 'blib/lib/SequencesDB/Schema/ResultSet/Library.pm' \
	  'lib/SequencesDB/View/HTML.pm' 'blib/lib/SequencesDB/View/HTML.pm' 
	$(NOECHO) $(TOUCH) pm_to_blib


# --- MakeMaker selfdocument section:

# here so even if top_targets is overridden, these will still be defined
# gmake will silently still work if any are .PHONY-ed but nmake won't

static ::
	$(NOECHO) $(NOOP)

dynamic ::
	$(NOECHO) $(NOOP)

config ::
	$(NOECHO) $(NOOP)


# --- MakeMaker postamble section:


# End.
# Postamble by Module::Install 1.16
# --- Module::Install::AutoInstall section:

config :: installdeps
	$(NOECHO) $(NOOP)

checkdeps ::
	$(PERL) Makefile.PL --checkdeps

installdeps ::
	$(NOECHO) $(NOOP)

installdeps_notest ::
	$(NOECHO) $(NOOP)

upgradedeps ::
	$(PERL) Makefile.PL --config= --upgradedeps=Test::Mock::Guard,0,Test::DBIx::Class,0,Test::WWW::Mechanize::Catalyst,0,Catalyst::Runtime,5.90093,Catalyst::Plugin::ConfigLoader,0,Catalyst::Plugin::Static::Simple,0,Catalyst::Plugin::Log::Log4perl,0,Catalyst::Action::RenderView,0,Moose,0,namespace::autoclean,0,Config::General,0,Log::Log4perl,0,DBI,0,Config::Tiny,0,Test::More,0.88

upgradedeps_notest ::
	$(PERL) Makefile.PL --config=notest,1 --upgradedeps=Test::Mock::Guard,0,Test::DBIx::Class,0,Test::WWW::Mechanize::Catalyst,0,Catalyst::Runtime,5.90093,Catalyst::Plugin::ConfigLoader,0,Catalyst::Plugin::Static::Simple,0,Catalyst::Plugin::Log::Log4perl,0,Catalyst::Action::RenderView,0,Moose,0,namespace::autoclean,0,Config::General,0,Log::Log4perl,0,DBI,0,Config::Tiny,0,Test::More,0.88

listdeps ::
	@$(PERL) -le "print for @ARGV" Test::Mock::Guard Test::DBIx::Class Test::WWW::Mechanize::Catalyst Catalyst::Runtime Catalyst::Plugin::ConfigLoader Catalyst::Plugin::Static::Simple Catalyst::Plugin::Log::Log4perl Catalyst::Action::RenderView Moose namespace::autoclean Config::General Log::Log4perl DBI Config::Tiny

listalldeps ::
	@$(PERL) -le "print for @ARGV" Test::Mock::Guard Test::DBIx::Class Test::WWW::Mechanize::Catalyst Catalyst::Runtime Catalyst::Plugin::ConfigLoader Catalyst::Plugin::Static::Simple Catalyst::Plugin::Log::Log4perl Catalyst::Action::RenderView Moose namespace::autoclean Config::General Log::Log4perl DBI Config::Tiny Test::More

