     FQPRINT   O    F     132        PRINTER

     I* Order Line Structure (Demo Only)
     I            DS
     I                                        1   10  OITEM
     I                                       11   13  OQTY   0
     I                                       14   19  OPRICE 2

     C* Mainline
     C                     EXSR PROCESSORD
     C                     SETON                     LR

     C*-------------------------------------------------------------
     C*  Subroutine: PROCESSORD
     C*  This subroutine does EVERYTHING:
     C*     - Calculates order total
     C*     - Validates customer credit
     C*     - Checks item availability
     C*-------------------------------------------------------------
     C     PROCESSORD    BEGSR

     C* Demo order lines (normally read from file)
     C                     Z-ADD     0             TOTAL
     C                     MOVE      'WIDGET001'   OITEM
     C                     Z-ADD     5             OQTY
     C                     Z-ADD     1995          OPRICE
     C                     MVR       OQTY          QTY
     C                     MVR       OPRICE        PRICE
     C                     MULT      PRICE         LINEAMT
     C                     ADD       LINEAMT       TOTAL

     C                     MOVE      'GADGET002'   OITEM
     C                     Z-ADD     2             OQTY
     C                     Z-ADD     4950          OPRICE
     C                     MVR       OQTY          QTY
     C                     MVR       OPRICE        PRICE
     C                     MULT      PRICE         LINEAMT
     C                     ADD       LINEAMT       TOTAL

     C*-------------------------------------------------------------
     C* Validate Customer Credit (Hardcoded Limit)
     C*-------------------------------------------------------------
     C                     Z-ADD     25000         CREDITLIM
     C                     COMP      TOTAL         CREDITLIM
     C                     IFGT
     C                     MOVE      'N'           OKFLAG
     C                     ELSE
     C                     MOVE      'Y'           OKFLAG
     C                     ENDIF

     C                     IF        OKFLAG = 'N'
     C                     EXCPT     NOCREDIT
     C                     ENDIF

     C*-------------------------------------------------------------
     C* Check Item Availability (Hardcoded Inventory)
     C*-------------------------------------------------------------
     C                     MOVE      'WIDGET001'   ITEM
     C                     Z-ADD     10            ONHAND
     C                     Z-ADD     5             NEED
     C                     COMP      NEED          ONHAND
     C                     IFGT
     C                     EXCPT     NOITEM
     C                     ENDIF

     C                     MOVE      'GADGET002'   ITEM
     C                     Z-ADD     1             ONHAND
     C                     Z-ADD     2             NEED
     C                     COMP      NEED          ONHAND
     C                     IFGT
     C                     EXCPT     NOITEM
     C                     ENDIF

     C*-------------------------------------------------------------
     C* Print Total
     C*-------------------------------------------------------------
     C                     EXCPT     TOTALREC

     C                     ENDSR

     OQPRINT   E            NOCREDIT
     O                       'CUSTOMER CREDIT LIMIT EXCEEDED'

     OQPRINT   E            NOITEM
     O                       'ITEM NOT AVAILABLE IN INVENTORY'

     OQPRINT   E            TOTALREC
     O                       'ORDER TOTAL: '          10
     O                       TOTAL        12 2
