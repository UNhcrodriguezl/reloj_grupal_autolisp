(vl-load-com)
(setq option 0)
(setq secss 0)
(vlr-mouse-reactor nil '((:vlr-beginDoubleClick . dbclick)))

; se crea el cronografo se necesita el archivo con el indicador esta en la carpeta
; la funcion se activa desde autocad con la funcion cronografo o desde lisp con (c:Cronografo)

; se activa usando inicronografo desde autocad o (c:inicronografo) desde lisp funciona mientras se mueva el mouse
; para cancelar el movimiento se presiona esc  y una vez se regrese a la pestaña de lisp presionar ctrl + r 


(defun c:Cronografo()
  	
	(setq option 0)
	(setq bua 0)
	(setq ptt (list 5325 375 0))
  	(setq ptt2 (list 5325 1175 0))
  	(setq ptt3 (list 5325 1975 0))

  	(setq secs1 0)
  	(setq secs2 0)
  	(setq secs3 0)

  	(setq acadObj (vlax-get-acad-object))
	(setq doc (vla-get-ActiveDocument acadObj))
  	(setq util (vla-get-utility doc))

  	(setq px (nth 0 pt))
  	(setq py (nth 1 pt))
	(setq pz (nth 2 pt))
  	
	(setq centerPoint (vlax-3d-point px py pz) radius 170)
  	(setq centerPoint2 (vlax-3d-point px (+ 800 (nth 1 pt)) pz) radius2 200)
	(setq centerPoint3 (vlax-3d-point px (+ 1600 (nth 1 pt)) pz))
  
	(setq Pt1 (vlax-3d-point px (+ 150 (nth 1 pt)) py))
  	(setq Pt2 (vlax-3d-point px (+ 950 (nth 1 pt)) py))
  	(setq Pt3 (vlax-3d-point px (+ 1750 (nth 1 pt)) py))  	

  	(setq modelSpace (vla-get-ModelSpace doc))
  
  	(setq circleObj (vla-AddCircle modelSpace centerPoint radius))
  
  	(vla-put-Color (vla-AddCircle modelSpace centerPoint radius2) 7)
  	(vla-put-Color (vla-AddCircle modelSpace centerPoint2 radius)7)
  	(vla-put-Color (vla-AddCircle modelSpace centerPoint2 radius2)7)
  	(vla-put-Color (vla-AddCircle modelSpace centerPoint3 radius)7)
  	(vla-put-Color (vla-AddCircle modelSpace centerPoint3 radius2)7)
  
  	(command "insert" "Indicador" ptt 1 1 0 )
  	(setq horasl (entget (entlast)))
  	(command "insert" "Indicador" ptt2 1 1 0 )
  	(setq minutosl (entget (entlast)))
  	(command "insert" "Indicador" ptt3 1 1 0 )
  	(setq segundosl (entget (entlast)))
 	
  	(setq thetextH (vla-AddText modelSpace "vuelta 3" 
                                (vlax-3d-point (- px 150) (+ 250 py) pz) 75))


  	(setq ENT (entlast)
		vuelta1 (vlax-ename->vla-object ENT)
	)
  
  	(setq thetextM (vla-AddText modelSpace "vuelta 2" 
                                (vlax-3d-point (- px 150) (+ 1050 py) pz) 75))

	(setq ENT (entlast)
		vuelta2 (vlax-ename->vla-object ENT)
	)
  	
  	(setq thetextS (vla-AddText modelSpace "vuelta 1" 
                                (vlax-3d-point (- px 150) (+ 1850 py) pz) 75))

  	(setq ENT (entlast)
		vuelta3 (vlax-ename->vla-object ENT)
	)
)

(defun wait (seconds / stop)
	(setq stop (+ (getvar "DATE") (/ seconds 86400.0)))
	(while (> stop (getvar "DATE")))
)


(defun c:fo ()	
	(command "insert" "Indicador" pt 1 1 1)
  )


(defun pasarGrados(grados) 
	(* pi (/ grados 180.0))
)
(setq twopi 6.28319)
(defun c:inicronografo ()
  	;(c:prog)
	(setq count 0)  	
  	(setq secs 0)
  	(setq bua 0)
  	(setq secss 0)	
  	(setq option (+ 1 option))
	;seleccion vuelta uno
  	(if (= option 1)	  
		( (while
               			(and
                    		(not (vl-catch-all-error-p (setq grr (vl-catch-all-apply 'grread '(t 15 1)
								       )
								 )
				       )
				     )
                    	(= 5 (car grr))				
                	)
		    
			(setq angCalcSeg (* twopi (- 1.0 (/ secs 60.0))))
			(setq segundos1 (subst (cons 50 angCalcSeg) (assoc 50 segundosl) segundosl))
			(entmod segundos1)
		    
		   	(vlax-put-property vuelta3 "TextString" secs)					  
			(setq count (1+ count))
		  	(setq secs (1+ secs))
		   	(print secs)
		   	(setq secs1 secs)		   
		   	;(vl-cmdf "._delay" 1000)		   
		   	(wait 1)
		)	  
	  	)	  	
	)
	;seleccion vuelta dos
	(if (= option 2)
	  	((while
               			(and
                    		(not (vl-catch-all-error-p (setq grr (vl-catch-all-apply 'grread '(t 15 1)
								       )
								 )
				       )
				     )
                    	(= 5 (car grr))
                	)
		   
			(setq angCalcSeg (* twopi (- 1.0 (/ secs 60.0))))
			(setq minutos1 (subst (cons 50 angCalcSeg) (assoc 50 minutosl) minutosl))
			(entmod minutos1)
		   
		   	(vlax-put-property vuelta2 "TextString" secs)			  
			(setq count (1+ count))
		  	(setq secs (1+ secs))
		   	(setq secs2 secs)
		  	(wait 1)		  
		)	  
	  	)
	)
  	;seleccion vuelta dos
	(if (= option 3)
		((while
               			(and
                    		(not (vl-catch-all-error-p (setq grr (vl-catch-all-apply 'grread '(t 15 1)
								       )
								 )
				       )
				     )
                    	(= 5 (car grr))
                	)
		   
			(setq angCalcSeg (* twopi (- 1.0 (/ secs 60.0))))
			(setq horas1 (subst (cons 50 angCalcSeg) (assoc 50 horasl) horasl))
			(entmod horas1)
		   
		   	(vlax-put-property vuelta1 "TextString" secs)					  
			(setq count (1+ count))
		  	(setq secs (1+ secs))
		   	(setq secs3 secs)
		  	(wait 1)		 
		)
	 	 (setq option 0)		 
		)
	) 
)


(defun c:prog ()
  
  (setq dcl_id (load_dialog "C:\\Users\\Administrador\\Documents\\Tareas_CG\\Cronografobox.DCL"))
  (if(not (new_dialog "mensaje1" dcl_id))
    (exit)	
    )    
  (action_tile "accept" "(suman)(inicronografo)")
  
  (action_tile "pausar" "(print Nn1)")
  
  (action_tile "cerrar" "(done_dialog)")	

  (defun suman()
	(setq Nn1 (atof (get_tile "n1")))
    	(setq Nn2 (atof (get_tile "n2")))
    	(setq Nn3 (atof (get_tile "n3")))
    )
  

  (start_dialog)
  (unload_dialog dcl_id)
  )
