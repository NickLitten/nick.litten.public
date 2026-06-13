      ** Code Snippet for https://www.nicklitten.com/course/what-does-an-rpg-subfile-look-like/
      ** This is an older style COLUMN BASED RPGLE
      ** Assume the Table (file) is called "customer"
      ** The DSPF is "subfile" with two record formats: SFL001 (the subfile) and CTL001 (the control format)

     F Customer     IF   E             K Disk
     F Subfile      CF   E             Workstn

     D NumRecords      S              5 0
     D SubfileRecNo    S              5 0

     C     *Entry        Plist
     C                   Eval      SubfileRecNo = 1
     C                   CallP     LoadSubfile
     C                   CallP     DisplaySubfile
     C                   Seton                                        LR

     C     LoadSubfile   Begsr
     C                   Read      Customer
     C                   Dow       Not %Eof(Customer)
     C                   Eval      SubfileRecNo += 1
     C                   Write     SFL001
     C                   Read      Customer
     C                   Enddo
     C                   Endsr

     C     DisplaySubfile...
     C                   Begsr
     C                   Eval      *In50 = *off                       SFLCLR Indicator
     C                   Write     CTL001
     C                   Eval      *In50 = *on                        SFLDSP/SFLDSPCTL Indicator
     C                   Exfmt     CTL001
     C                   Endsr