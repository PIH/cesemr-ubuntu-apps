# PIH EMR Ubuntu Apps

This is a collection of Ubuntu "apps" to be installed with deployments
of PIH EMR where the server is being administrated by non-technical onsite
staff. They're basically just buttons to do things that are pretty
straightforward on the command line. We just want to protect our users
from the need to use the command line.

It is assumed that the user is named `doc`, and the database and its user
named `openmrs`.

## Apps

**PIH EMR Export** dumps the database to `~doc/ces-laguna.sh`. Could use
to be made a bit more flexible.

**Update PIH EMR** runs a puppet install.

**PIH EMR Logs** opens the log file in gedit.

**Restart PIH EMR** does a `sudo service tomcat7 restart`.

**PIH EMR Restore** guides the user through loading a backup file into
the database.

## Setup

To build, run `./build.sh`. You'll need to know the password for the
MySQL user `openmrs`. This script will produce the debian packages
to be installed in the `dist/` directory.

To install, run `./install.sh`. This will install the debian packages.
Their binaries will go in `/etc/puppet/bin/`.

## Simple Backup

Included in this is a half-baked backup mechanism called `simple_backup.sh`.
It will also be put in the bin directory by the installer, however, its use
is not set up automatically. If for whatever reason you wish to use it,
just create an appropriate cron job.

## Restore from Backup

The Restore application expects to find backup files in the location and with
the names used by Simple Backup, which as of this writing is
`~doc/openmrs-backup/yyyy-mm-ddThh-mmZ`.
