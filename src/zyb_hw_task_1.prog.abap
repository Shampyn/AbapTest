*&---------------------------------------------------------------------*
*& Report ZYB_HW_TASK_1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zyb_hw_task_1.
TYPES: BEGIN OF gty_persons,
         id        TYPE zyb_d_persons-id,
         firstname TYPE zyb_d_persons-firstname,
         lastname  TYPE zyb_d_persons-lastname,
       END OF gty_persons.


DATA: gs_persons    TYPE ZYB_D_PERSONS,
      gt_id         TYPE TABLE OF gty_persons,
      gt_return_tab TYPE TABLE OF ddshretval,
      gs_return_tab LIKE LINE OF gt_return_tab.

PARAMETERS: p_id TYPE zyb_d_persons-id,
            p_fn TYPE zyb_d_persons-firstname,
            p_ln TYPE zyb_d_persons-lastname.



AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_id.

  SELECT id, firstname, lastname FROM zyb_d_persons INTO CORRESPONDING FIELDS OF TABLE @gt_id.

  CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
    EXPORTING
      retfield    = 'ID'
      dynpprog    = sy-repid
      dynpnr      = sy-dynnr
      dynprofield = 'P_ID'
      value_org   = 'S'
    TABLES
      value_tab   = gt_id
      return_tab  = gt_return_tab.
  IF sy-subrc EQ 0.
    READ TABLE gt_return_tab INTO gs_return_tab INDEX 1.
    IF sy-subrc EQ 0.
      p_id = gs_return_tab-fieldval.
    ENDIF.
  ENDIF.


START-OF-SELECTION.
  "INSERT INTO zyb_d_persons VALUES gs_persons.
