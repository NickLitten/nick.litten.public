**FREE
//------------------------------------------------------------------------------
// Service Program: CONVSRV
// Description: Character conversion service using CCSID
// Author: Nick Litten
// Created: 2026-03-26
//------------------------------------------------------------------------------

ctl-opt nomain thread(*serialize);

//------------------------------------------------------------------------------
// Convert EBCDIC to ASCII using CCSID
//------------------------------------------------------------------------------
dcl-proc ConvertEbcdicToAscii export;
  dcl-pi *n varchar(32766);
    inputData varchar(32766) const;
  end-pi;
  
  dcl-s outputData varchar(32766) ccsid(819); // ASCII CCSID
  dcl-s ebcdicData varchar(32766) ccsid(37);  // EBCDIC CCSID
  
  // Assign input to EBCDIC variable
  ebcdicData = inputData;
  
  // Automatic conversion happens when assigning between different CCSIDs
  outputData = ebcdicData;
  
  return outputData;
end-proc;

//------------------------------------------------------------------------------
// Convert ASCII to EBCDIC using CCSID
//------------------------------------------------------------------------------
dcl-proc ConvertAsciiToEbcdic export;
  dcl-pi *n varchar(32766);
    inputData varchar(32766) const;
  end-pi;
  
  dcl-s outputData varchar(32766) ccsid(37);  // EBCDIC CCSID
  dcl-s asciiData varchar(32766) ccsid(819);  // ASCII CCSID
  
  // Assign input to ASCII variable
  asciiData = inputData;
  
  // Automatic conversion happens when assigning between different CCSIDs
  outputData = asciiData;
  
  return outputData;
end-proc;

//------------------------------------------------------------------------------
// Convert fixed-length EBCDIC to ASCII
//------------------------------------------------------------------------------
dcl-proc ConvertFixedEbcdicToAscii export;
  dcl-pi *n char(32766);
    inputData char(32766) const;
    dataLength int(10) const;
  end-pi;
  
  dcl-s outputData char(32766);
  dcl-s ebcdicData char(32766) ccsid(37);
  dcl-s asciiData char(32766) ccsid(819);
  
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
  
  return outputData;
end-proc;

//------------------------------------------------------------------------------
// Convert fixed-length ASCII to EBCDIC
//------------------------------------------------------------------------------
dcl-proc ConvertFixedAsciiToEbcdic export;
  dcl-pi *n char(32766);
    inputData char(32766) const;
    dataLength int(10) const;
  end-pi;
  
  dcl-s outputData char(32766);
  dcl-s asciiData char(32766) ccsid(819);
  dcl-s ebcdicData char(32766) ccsid(37);
  
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
  
  return outputData;
end-proc;