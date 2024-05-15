*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZTRPT_FI_MSTR...................................*
DATA:  BEGIN OF STATUS_ZTRPT_FI_MSTR                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZTRPT_FI_MSTR                 .
CONTROLS: TCTRL_ZTRPT_FI_MSTR
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZTRPT_FI_MSTR                 .
TABLES: ZTRPT_FI_MSTR                  .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
