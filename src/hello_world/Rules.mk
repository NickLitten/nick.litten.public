# ---
# Rules.mk - Hello World Examples Build Configuration
# ---
# Project: IBM i TOBi Standards Compliant Build System
# Purpose: Build rules for Hello World demonstration programs
# ---

# HELLOWORLD Program - Simple Hello World example
HELLOWORLD.PGM: HELLOWORLD-Simple_HelloWorld.pgm.rpgle

# HELLOINC Program - Hello World using copybook
HELLOINC.PGM: HELLOINC-Helloworld_using_copybook.pgm.rpgle

# HELLOADV Program - Advanced Hello World example
HELLOADV.PGM: HELLOADV-Advanced_HelloWorld.pgm.rpgle