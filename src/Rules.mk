# ---
# Rules.mk - Source Directory Build Configuration
# ---
# Project: IBM i TOBi Standards Compliant Build System
# Purpose: Define subdirectories to process during build
# ---
# Subdirectories are processed in dependency order:
# 1. database - Create tables and files first
# 2. binders - Create binding directories
# 3. services - Build service programs (may depend on database)
# 4. All other application directories
# ---

# ---
# Build Order
# ---
# Use := for immediate assignment (TOBi standard)
# Order matters - dependencies must be built before dependents
# ---
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