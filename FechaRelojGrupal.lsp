;Configuración Fecha del reloj
;Santiago Valdés Ledesma

;Falta configurar la ubicación y posición del reloj según el dibujo principal del dibujo
    (vl-load-com)
    (setq acadObj (vlax-get-acad-object))
    (setq doc (vla-get-ActiveDocument acadObj))
  
    ;; Define the text object
	(setq insertionPointDD (vlax-3d-point 0 5 0)  ;el punto de inserción es la posición en el dibujo
	textStringDD "DD" 
	height 10)
	(setq insertionPointMM (vlax-3d-point 20 5 0)  
	textStringMM "MM"
	height 10)
	(setq insertionPointAA (vlax-3d-point 50 5 0)  
	textStringAA "AA"
	height 10)
	    	    
        ;; Crea el texto en el espacio modelo
	(setq modelSpace (vla-get-ModelSpace doc))
    	;Colocacion de los textos iniciales dia dd, mes mm, año aa
	(setq textObjDD (vla-AddText modelSpace textStringDD insertionPointDD height))
	(setq ObjDD (entget(entlast)))
	(setq textObjMM (vla-AddText modelSpace textStringMM insertionPointMM height))
	(setq ObjMM (entget(entlast)))
	(setq textObjAA (vla-AddText modelSpace textStringAA insertionPointAA height))
	(setq ObjAA (entget(entlast)))

	(setq  Date (menucmd "M=$(edtime,$(getvar,date),YYYYMONDD)")	
	añot (substr Date 1 4)
	mest (substr Date 5 3)
	diat (substr Date 8 2)
	)
   	(setq ObjDD (setq D2 (subst (cons 1  diat) (assoc 1 ObjDD) ObjDD)))
 	(entmod D2)
  	(setq ObjMM (setq M2 (subst (cons 1  mest) (assoc 1 ObjMM) ObjMM)))
 	(entmod M2)
	(setq ObjAA (setq A2 (subst (cons 1   añot) (assoc 1 ObjAA) ObjAA)))
 	(entmod A2)