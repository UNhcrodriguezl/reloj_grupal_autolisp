;Configuración Hora del reloj Digital
;Gustavo Bonilla

;Falta configurar la ubicación y posición del reloj según el dibujo principal del dibujo
    (vl-load-com)
    (setq acadObj (vlax-get-acad-object))
    (setq doc (vla-get-ActiveDocument acadObj))

; Define the text object
	(setq insertionPointDD (vlax-3d-point 0 5 0)  ;el punto de inserción es la posición en el dibujo
	textStringHH "HH" 
	height 10)
	(setq insertionPointMM (vlax-3d-point 18 5 0)  
	textStringMM "MM"
	height 10)
	(setq insertionPointAA (vlax-3d-point 36 5 0)  
	textStringSS "SS"
	height 10)

; Crea el texto en el espacio modelo
	(setq modelSpace (vla-get-ModelSpace doc))
    	;Colocacion de los textos iniciales Hora HH, minutos MM, segundos SS
	(setq textObjHH (vla-AddText modelSpace textStringHH insertionPointDD height))
	(setq ObjHH (entget(entlast)))
	(setq textObjMM (vla-AddText modelSpace textStringMM insertionPointMM height))
	(setq ObjMM (entget(entlast)))
	(setq textObjSS (vla-AddText modelSpace textStringSS insertionPointAA height))
	(setq ObjSS (entget(entlast)))
	
  
  (setq Da (rtos (getvar "cdate") 2 6))	
  (setq ht (substr Da 10 2))  ;sustraigo el valor del hora
  (setq mt (substr Da 12 2))  ;sustraigo el valor del min
 	(setq st (substr Da 14 2))  ;sustraigo el valor del seg

		
  (setq ObjHH (setq H2 (subst (cons 1  ht) (assoc 1 ObjHH) ObjHH)))
 	(entmod H2)
  (setq ObjMM (setq M2 (subst (cons 1  mt) (assoc 1 ObjMM) ObjMM)))
 	(entmod M2)
	(setq ObjSS (setq S2 (subst (cons 1   st) (assoc 1 ObjSS) ObjSS)))
 	(entmod S2)
