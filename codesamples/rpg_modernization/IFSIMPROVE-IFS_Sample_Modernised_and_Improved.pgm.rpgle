**FREE
//  CH5TEXT: Example of creating/reading a text file in the IFS
//   (From Chap 5)
//  Modernized & Enhanced as Free-Form RPG by Nick Litten

ctl-opt DFTACTGRP(*NO) ACTGRP(*NEW) BNDDIR('QC2LE') BNDDIR('IFSTEXT');

/include 'modern/ifsio_h.rpgleinc'
/include 'modern/errno_h.rpgleinc'
/include 'modern/ifstext_h.rpgleinc'

dcl-pr Cmd ExtPgm('QCMDEXC');
    command char(200) const;
    len packed(15:5) const;
end-pr Cmd;

dcl-s ifs char(255) inz('/ifstest/ch5_file.txt');
dcl-s line char(100);
dcl-s fd int(10);
dcl-s len int(10);
dcl-s msg char(52);

MakeFile(ifs);

EditFile(ifs);

ShowFile(ifs);

*inlr = *on;
// Write some text to a text file
dcl-proc MakeFile;
  dcl-pi MakeFile;
    myIFS like(ifs) const;
  end-pi;

     fd = open(myIFS: O_TRUNC+O_CREAT+O_WRONLY: S_IWUSR+S_IRUSR+S_IRGRP+S_IROTH);
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

    close(fd);

  return;
end-proc;
// Call the OS/400 text editor, and let the user change the text around.
dcl-proc EditFile;
  dcl-pi EditFile;
    myIFS like(ifs) const;
  end-pi;

  cmd('EDTF STMF(' + myIFS + ')': 200);

  return;
end-proc;
// Read file, line by line, and dsply what fits
// (DSPLY has a lousy 52-byte max... blech)
dcl-proc ShowFile;
  dcl-pi ShowFile;
    myIFS like(ifs) const;
  end-pi;

    fd = open( myIFS : O_RDONLY);
    IF fd < 0;
        die('open(): ' + %str(strerror(errno)));
    ENDIF;

    DOW readline(fd: %addr(line): %size(line)) >= 0;
        Msg = line;
        DSPLY Msg; // Consider using SND-MSG instead;
    ENDDO;

    close(fd);

    Msg = 'Press ENTER to continue';
    DSPLY Msg; // Consider using SND-MSG instead;

ENDSR;

/DEFINE ERRNO_LOAD_PROCEDURE
/include 'modern/errno_h.rpgleinc'
