**free

/// Program: HELLOWORLD - Simple Hello World
///
/// Description: The simplest possible RPG program demonstrating basic output
///              using the DSPLY operation. This is the minimal "Hello World"
///              example for IBM i RPG programming.
///
/// Purpose: Educational example demonstrating:
///   - Minimal RPG program structure
///   - **FREE format directive
///   - DSPLY operation for output
///   - Program termination with RETURN
///
/// Features:
///   - Ultra-simple 3-line program
///   - No parameters or complex logic
///   - Direct display to operator console
///   - Ideal starting point for RPG beginners
///
/// Usage: CALL HELLOWORLD
///        Displays: 'Hello World!'
///
/// Dependencies: None
///
/// Reference:
///   https://www.ibm.com/docs/en/i/7.5?topic=concepts-free-form-rpg-iv
///
/// Modification History:
///   1.0 2020-01-01 | Nick Litten | Initial creation
///

dsply 'Hello World!';
Return;