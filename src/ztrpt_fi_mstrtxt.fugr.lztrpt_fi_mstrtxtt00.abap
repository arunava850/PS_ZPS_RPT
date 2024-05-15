*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZTRPT_FI_MSTRTXT................................*
DATA:  BEGIN OF STATUS_ZTRPT_FI_MSTRTXT              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZTRPT_FI_MSTRTXT              .
CONTROLS: TCTRL_ZTRPT_FI_MSTRTXT
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZTRPT_FI_MSTRTXT              .
TABLES: ZTRPT_FI_MSTRTXT               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
