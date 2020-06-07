  ;CRONOMETRO DEL RELOJ

;FUNCIÓN PARA DIBUJO DEL CRONOMETRO

(defun draw_crono ()
  (setq s_cnt2 "00"
        m_cnt2 "00"
        h_cnt2 "00"
        texto  (strcat h_cnt2 ":" m_cnt2 ":" s_cnt2)
  )
  (vl-cmdf "_text" "J" "C" "0,0" 18 0 texto)
  (setq ENT (entlast)
        OBJ (vlax-ename->vla-object ENT)
  )
  
  (c:crono2)
)

;-------------------------------------------------------------------------------------------------------------------------------------------------------

;CAJA DE DIALOGO PARA EL DIBUJO DEL CRONOMETRO
(defun c:cronometro ()
  
  (setq archivo (load_dialog (findfile "CD_Cronometro1.dcl")))
  
  (new_dialog "CDCronometro1" archivo)  ;mismo nombre del DIALOG
  
  (action_tile "Draw" "(setq active1 T) (done_dialog)")
  
  (start_dialog)
  
  (if (= active1 T) (draw_crono))
  

)

;-------------------------------------------------------------------------------------------------------------------------------------------------------

;FUNCIÓN PARA ABRIR EL CRONOMETRO
(defun open_crono ()
  (vl-cmdf "CRONO" "")
  (vl-cmdf "_delay" 10000 "")
  
  (C:crono3)
)

;-------------------------------------------------------------------------------------------------------------------------------------------------------

;CAJA DE DIALOGO PARA ABRIR EL CRONOMETRO
(defun c:crono2 ()
  (setq archivo (load_dialog (findfile "CD_Cronometro2.dcl")))
  
  (new_dialog "CDCronometro2" archivo)  ;mismo nombre del DIALOG
  
  (action_tile "Open" "(setq active2 T) (done_dialog)")
  
  (start_dialog)
  
  (if (= active2 T) (open_crono))
)

;-------------------------------------------------------------------------------------------------------------------------------------------------------

;FUNCIÓN PARA ACTUALIZAR EL DIBUJO

(defun actu_crono ()
  ;Abrir el archivo y guardar los valores
  (setq ruta  (findfile "tiempo.txt")
        arch  (open ruta "r")
        hms   (read-line arch)
  )

  ;Modifica el objeto texto
  (vlax-put-property OBJ "TextString" hms)  
)

;-------------------------------------------------------------------------------------------------------------------------------------------------------

;CAJA DE DIALOGO ACTUALIZAR EL DIBUJO

(defun c:crono3 ()
  (setq archivo (load_dialog (findfile "CD_Cronometro3.dcl")))
  
  (new_dialog "CDCronometro3" archivo)  ;mismo nombre del DIALOG
  
  (action_tile "Fresh" "(setq active3 T) (done_dialog)")
  
  (start_dialog)
  
  (if (= active3 T) (actu_crono))
)