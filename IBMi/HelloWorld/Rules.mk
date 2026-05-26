# -----------------------------------------------------------------------------
# Rules.MK
# IBM i TOBi/MAKEi Build Rules - HelloWorld Module
# -----------------------------------------------------------------------------
# This file defines build targets for the HelloWorld examples.
# It follows IBM i TOBi naming standards: OBJECTNAME-Description_With_Underscores.ext
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Build Dependencies (IBM i TOBi Format)
# -----------------------------------------------------------------------------
HELLOWORLD.PGM:   HELLOWORLD-Simple_HelloWorld.pgm.rpgle
HELLOINC.PGM:     HELLOINC-Helloworld_using_copybook.pgm.rpgle
HELLOADV.PGM:     HELLOADV-Advanced_HelloWorld.pgm.rpgle