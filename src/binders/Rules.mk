# ---
# Rules.mk - Binding Directory Build Configuration
# ---
# Project: IBM i TOBi Standards Compliant Build System
# Purpose: Define binding directory object dependencies
# ---
# Binding directories group service programs and modules for linking
# ---

# ---
# Object Dependencies
# ---
# Format: OBJECT.TYPE: source-file-name.extension
# ---

# SIMPLEBND Binding Directory - Sample binding directory for examples
SIMPLEBND.BNDDIR: SIMPLEBND-Nicks_Sample_Binding_Directory.bnddir

# PWDMON Binding Directory - Password monitor service program bindings
PWDMON.BNDDIR: PWDMON-Password_Monitor_Binding_Directory.bnddir