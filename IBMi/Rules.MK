# -----------------------------------------------------------------------------
# Rules.MK
# IBM i TOBi/MAKEi Build Rules
# -----------------------------------------------------------------------------
# This file defines build targets and subdirectories for the MAKEi build system.
# It follows IBM i TOBi naming standards: OBJECTNAME-Description_With_Underscores.ext
#
# Variables:
#   TARGETS  - Source files to compile in this directory
#   SUBDIRS  - Subdirectories to process recursively
#
# Usage:
#   make          - Build all targets in this directory
#   make clean    - Remove all built objects
#   make install  - Deploy objects to IBM i system
# -----------------------------------------------------------------------------
## SUBDIRS := check_subsystem_active clear_bob_logs clear_pfrdata codesamples conversion database debug email_csv_file email_outq hello_world list_libraries mysql_server services sql_encryption sqlrpgle_dynamic stored_procs subfile upload_files webservice

SUBDIRS := database \
           services \
           check_subsystem_active \
           clear_bob_logs \
           clear_pfrdata \
           conversion \
           debug \
           email_csv_file \
           email_outq \
           hello_world \
           list_libraries \
           mysql_server \
           sql_encryption \
           sqlrpgle_dynamic \
           stored_procs \
           subfile \
           upload_files \
           webservice