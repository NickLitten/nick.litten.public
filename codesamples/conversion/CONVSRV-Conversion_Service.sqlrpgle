**free

///
/// Service Program: CONVSRV - Character Conversion Service
///
/// Description: Production-quality service program providing character set
///              conversion utilities between EBCDIC and ASCII using CCSID
///              (Coded Character Set Identifier). Supports both variable-length
///              and fixed-length character conversions with automatic CCSID
///              translation by the system.
///
/// Purpose: Production utility demonstrating:
///   - Service program with multiple exported procedures
///   - CCSID-based character conversion
///   - Variable-length (VARCHAR) conversions
///   - Fixed-length (CHAR) conversions with length parameter
///   - Thread-safe service program design
///   - Automatic character set translation
///
/// Features:
///   - Four conversion procedures for different scenarios
///   - EBCDIC (CCSID 37) to ASCII (CCSID 819) conversion
///   - ASCII (CCSID 819) to EBCDIC (CCSID 37) conversion
///   - Supports up to 32,766 characters
///   - Automatic conversion by system
///   - Thread-serialized for safety
///
/// Exported Procedures:
///   - ConvertEbcdicToAscii: Variable-length EBCDIC to ASCII
///   - ConvertAsciiToEbcdic: Variable-length ASCII to EBCDIC
///   - ConvertFixedEbcdicToAscii: Fixed-length EBCDIC to ASCII
///   - ConvertFixedAsciiToEbcdic: Fixed-length ASCII to EBCDIC
///
/// Usage Example:
///   dcl-pr ConvertEbcdicToAscii varchar(32766) extproc(*dclcase);
///     inputData varchar(32766) const;
///   end-pr;
///   
///   dcl-s ebcdicText varchar(100);
///   dcl-s asciiText varchar(100);
///   ebcdicText = 'Hello World';
///   asciiText = ConvertEbcdicToAscii(ebcdicText);
///
/// Binding:
///   Create with binder source CONVSRV.bnd
///   CRTSRVPGM SRVPGM(library/CONVSRV) MODULE(CONVSRV) +
///             EXPORT(*SRCFILE) SRCFILE(QSRVSRC) SRCMBR(CONVSRV)
///
/// Reference:
/// https://www.nicklitten.com/blog/character-conversion-ccsid/
///
/// Modification History:
///   V.000 2026-03-26 | Nick Litten | Initial creation
///   V.001 2026-04-18 | Bob AI | Applied Nick Litten comment standards
///

ctl-opt
  nomain
  thread(*serialize)
  copyright('CONVSRV | V.001 | Character conversion service using CCSID')
  ;

// ------------------------------------------------------------------------------
// Procedure: ConvertEbcdicToAscii
// Description: Converts variable-length EBCDIC string to ASCII
// Parameters:
//   - inputData: varchar(32766) const - EBCDIC input string
// Returns: varchar(32766) - ASCII output string
// ------------------------------------------------------------------------------
Dcl-Proc ConvertEbcdicToAscii export;
   Dcl-Pi *n varchar(32766);
      inputData varchar(32766) const;
   end-pi;
  
   Dcl-S outputData varchar(32766) ccsid(819); // ASCII CCSID
   Dcl-S ebcdicData varchar(32766) ccsid(37);  // EBCDIC CCSID
  
   // Assign input to EBCDIC variable
   ebcdicData = inputData;
  
   // Automatic conversion happens when assigning between different CCSIDs
   outputData = ebcdicData;
  
   Return outputData;
end-proc;

// ------------------------------------------------------------------------------
// Procedure: ConvertAsciiToEbcdic
// Description: Converts variable-length ASCII string to EBCDIC
// Parameters:
//   - inputData: varchar(32766) const - ASCII input string
// Returns: varchar(32766) - EBCDIC output string
// ------------------------------------------------------------------------------
Dcl-Proc ConvertAsciiToEbcdic export;
   Dcl-Pi *n varchar(32766);
      inputData varchar(32766) const;
   end-pi;
  
   Dcl-S outputData varchar(32766) ccsid(37);  // EBCDIC CCSID
   Dcl-S asciiData varchar(32766) ccsid(819);  // ASCII CCSID
  
   // Assign input to ASCII variable
   asciiData = inputData;
  
   // Automatic conversion happens when assigning between different CCSIDs
   outputData = asciiData;
  
   Return outputData;
end-proc;

// ------------------------------------------------------------------------------
// Procedure: ConvertFixedEbcdicToAscii
// Description: Converts fixed-length EBCDIC string to ASCII
// Parameters:
//   - inputData: char(32766) const - EBCDIC input string
//   - dataLength: int(10) const - Length of data to convert
// Returns: char(32766) - ASCII output string
// ------------------------------------------------------------------------------
Dcl-Proc ConvertFixedEbcdicToAscii export;
   Dcl-Pi *n char(32766);
      inputData char(32766) const;
      dataLength int(10) const;
   end-pi;
  
   Dcl-S outputData char(32766);
   Dcl-S ebcdicData char(32766) ccsid(37);
   Dcl-S asciiData char(32766) ccsid(819);
  
   // Initialize variables
   ebcdicData = *blank;
   asciiData = *blank;
   outputData = *blank;
  
   // Copy input to EBCDIC variable
   %subst(ebcdicData:1:dataLength) = %subst(inputData:1:dataLength);
  
   // Automatic conversion
   asciiData = ebcdicData;
  
   // Copy to output
   %subst(outputData:1:dataLength) = %subst(asciiData:1:dataLength);
  
   Return outputData;
end-proc;

// ------------------------------------------------------------------------------
// Procedure: ConvertFixedAsciiToEbcdic
// Description: Converts fixed-length ASCII string to EBCDIC
// Parameters:
//   - inputData: char(32766) const - ASCII input string
//   - dataLength: int(10) const - Length of data to convert
// Returns: char(32766) - EBCDIC output string
// ------------------------------------------------------------------------------
Dcl-Proc ConvertFixedAsciiToEbcdic export;
   Dcl-Pi *n char(32766);
      inputData char(32766) const;
      dataLength int(10) const;
   end-pi;
  
   Dcl-S outputData char(32766);
   Dcl-S asciiData char(32766) ccsid(819);
   Dcl-S ebcdicData char(32766) ccsid(37);
  
   // Initialize variables
   asciiData = *blank;
   ebcdicData = *blank;
   outputData = *blank;
  
   // Copy input to ASCII variable
   %subst(asciiData:1:dataLength) = %subst(inputData:1:dataLength);
  
   // Automatic conversion
   ebcdicData = asciiData;
  
   // Copy to output
   %subst(outputData:1:dataLength) = %subst(ebcdicData:1:dataLength);
  
   Return outputData;
end-proc;
