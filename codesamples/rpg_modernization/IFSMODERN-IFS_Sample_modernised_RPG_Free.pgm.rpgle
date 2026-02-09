**free
//  CH5TEXT: Example of creating/reading a text file in the IFS
//   (From Chap 5)
//  Modernized to Free-Form RPG by Nick Litten

ctl-opt DFTACTGRP(*NO) ACTGRP(*NEW) BNDDIR('QC2LE') BNDDIR('IFSTEXT');

 /include 'legacy/ifsio_h.rpgleinc'
 /include 'legacy/errno_h.rpgleinc'
 /include 'legacy/ifstext_h.rpgleinc'

dcl-pr Cmd ExtPgm('QCMDEXC');
  command char(200) const;
  len packed(15:5) const;
end-pr Cmd;

dcl-s fd int(10);
dcl-s line char(100);
dcl-s len int(10);
dcl-s msg char(52);

EXSR MakeFile;
EXSR EditFile;
EXSR ShowFile;
*inlr = *on;
// Write some text to a text file
BEGSR MakeFile;
  fd = open('/ifstest/ch5_file.txt': O_TRUNC+O_CREAT+O_WRONLY: S_IWUSR+
         S_IRUSR+S_IRGRP+S_IROTH);
  IF fd < 0;
    die('open(): ' + %str(strerror(errno)));
  ENDIF;

  line = 'Dear Cousin,';
  len = %len(%trimr(line));
  writeline(fd: %addr(line): len);

  line = ' ';
  len = 0;
  writeline(fd: %addr(line): len);

  line = 'I love the way you make' + ' cheese fondue.';
  len = %len(%trimr(line));
  writeline(fd: %addr(line): len);

  line = ' ';
  len = 0;
  writeline(fd: %addr(line): len);

  line = 'Thank you for being so cheesy!';
  len = %len(%trimr(line));
  writeline(fd: %addr(line): len);

  line = ' ';
  len = 0;
  writeline(fd: %addr(line): len);

  line = 'Sincerely,';
  len = %len(%trimr(line));
  writeline(fd: %addr(line): len);

  line = '     Richard M. Nixon';
  len = %len(%trimr(line));
  writeline(fd: %addr(line): len);
  CALLP close(fd);
ENDSR;
// Call the OS/400 text editor, and let the user change the
// text around.
BEGSR EditFile;
  cmd('EDTF STMF(''/ifstest/' 'ch5_file.txt'')': 200);
ENDSR;
// Read file, line by line, and dsply what fits
// (DSPLY has a lousy 52-byte max... blech)
BEGSR ShowFile;
  fd = open('/ifstest/ch5_file.txt': O_RDONLY);
  IF fd < 0;
    die('open(): ' + %str(strerror(errno)));
  ENDIF;

  DOW readline(fd: %addr(line): %size(line)) >= 0;
    Msg = line;
    DSPLY Msg; // Consider using SND-MSG instead;
  ENDDO;

  CALLP close(fd);

  Msg = 'Press ENTER to continue';
  DSPLY Msg; // Consider using SND-MSG instead;
ENDSR;

 /DEFINE ERRNO_LOAD_PROCEDURE
 /include 'legacy/errno_h.rpgleinc'
