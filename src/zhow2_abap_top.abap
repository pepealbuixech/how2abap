types: begin of t_material,
  matnr type matnr,
  maktx type maktx,
  end of t_material,
  tt_material type table of t_material.

data: i_material type tt_material.

i_material = value #(
  ( matnr = 'MATNR00134' maktx = 'Material 1' )
  ( matnr = 'MATNR00431' maktx = 'Material 2' )
  ( matnr = 'MATNR01431' maktx = 'Material 3' )
  ( matnr = '0000000000' maktx = 'Material vacío' )
).