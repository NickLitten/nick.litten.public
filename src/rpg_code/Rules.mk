# ---
# Rules.mk - RPG Code Examples Build Configuration
# ---
# Project: IBM i TOBi Standards Compliant Build System
# Purpose: Build rules for RPG programming examples
# ---
# Target Release: V7R4M0
# Activation Group: NICKLITTEN
# ---

# ---
# Compilation Settings
# ---
%.MODULE: private TGTRLS := V7R4M0
%.PGM:    private TGTRLS := V7R4M0
%.PGM:    private ENTMOD := *PGM
%.PGM:    private ALWRTVSRC := *NO
%.PGM:    private OPTIMIZE := *FULL
%.PGM:    private ACTGRP := NICKLITTEN

# ---
# Object Dependencies
# ---

# HELLOWORLD Program - Simple Hello World example
HELLOWORLD.PGM: HELLOWORLD-Simple_HelloWorld.pgm.rpgle

# HELLOINC Program - Hello World using copybook
HELLOINC.PGM: HELLOINC-Helloworld_using_copybook.pgm.rpgle

# HELLOADV Program - Advanced Hello World example
HELLOADV.PGM: HELLOADV-Advanced_HelloWorld.pgm.rpgle
