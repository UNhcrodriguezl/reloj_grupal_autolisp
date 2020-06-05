;Configuración Fecha Digital del reloj
;Santiago Valdés Ledesma
(vl-load-com)
(setq acadObj (vlax-get-acad-object))
(setq doc (vla-get-ActiveDocument acadObj))

  	(setq insertionPointDD (vlax-3d-point 1057 430 0)  ;el punto de inserción es la posición en el dibujo
	textStringDD "DD" 
	height 35)
	(setq insertionPointMM (vlax-3d-point 1119 430 0)  
	textStringMM "MM"
	height 35)
	(setq insertionPointAA (vlax-3d-point 1235 430 0)  
	textStringAA "AA"
	height 35)
	   	    
        ;; Crea el texto en el espacio modelo
	(setq modelSpace (vla-get-ModelSpace doc))
    	;Colocacion de los textos iniciales dia dd, mes mm, año aa
	(setq textObjDD (vla-AddText modelSpace textStringDD insertionPointDD height))
	(setq ObjDD (entget(entlast)))
 	(setq textObjMM (vla-AddText modelSpace textStringMM insertionPointMM height))
	(setq ObjMM (entget(entlast)))
	(setq textObjAA (vla-AddText modelSpace textStringAA insertionPointAA height))
	(setq ObjAA (entget(entlast)))


	(setq  Date (rtos (getvar "cdate") 2 6)	
	anot (substr Date 1 4)
	mest (substr Date 5 2)
	diat (substr Date 7 2)
	)
	(setq mes (nth 	(setq nummes (atoi mest)) '(nil "ENE" "FEB" "MAR" "ABR" "MAY" "JUN" "JUL" "AGO" "SEP" "OCT" "NOV" "DEC")))

	(setq ObjDD (setq D2 (subst (cons 1  diat) (assoc 1 ObjDD) ObjDD)))
 	(entmod D2)
	(setq ObjDD (setq D2 (subst (cons 62  07) (assoc 62 ObjAA) ObjDD)));Cambia el color de el texto al color 7:Blanco
 	(entmod D2)
	(setq ObjAA (setq A2 (subst (cons 1   anot) (assoc 1 ObjAA) ObjAA)))
 	(entmod A2)
	(setq ObjAA (setq A2 (subst (cons 62  07) (assoc 62 ObjAA) ObjAA)));Cambia el color de el texto al color 7:Blanco
 	(entmod A2)
  	(setq ObjMM (setq M2 (subst (cons 1  mes) (assoc 1 ObjMM) ObjMM)))
 	(entmod M2)
	(setq ObjMM (setq M2 (subst (cons 62  07) (assoc 62 ObjMM) ObjMM))) ;Cambia el color de el texto al color 7:Blanco
 	(entmod M2)
