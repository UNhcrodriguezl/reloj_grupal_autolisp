(vl-load-com)
(setq option 0)

(defun Trut ()
	(setq pt (getpoint "\nSpecify a point :"))
  )


(defun c:dib()
  	(setq pt (getpoint "\nSpecify a point :"))
  	
	(setq acadObj (vlax-get-acad-object))
	(setq doc (vla-get-ActiveDocument acadObj))
  	(setq util (vla-get-utility doc))

  	(setq px (nth 0 pt))
  	(setq py (nth 1 pt))
	(setq pz (nth 2 pt))
  	
	(setq centerPoint (vlax-3d-point px py pz) radius 5)
  	(setq centerPoint2 (vlax-3d-point px (+ 15 (nth 1 pt)) pz) radius2 6.5)
	(setq centerPoint3 (vlax-3d-point px (+ 30 (nth 1 pt)) pz))
  
	(setq Pt1 (vlax-3d-point px (+ 4 (nth 1 pt)) py))
  	(setq Pt2 (vlax-3d-point px (+ 19 (nth 1 pt)) py))
  	(setq Pt3 (vlax-3d-point px (+ 34 (nth 1 pt)) py))  	

  	(setq modelSpace (vla-get-ModelSpace doc))
  
  	(setq circleObj (vla-AddCircle modelSpace centerPoint radius))
  	(vla-AddCircle modelSpace centerPoint radius2)
  	(vla-AddCircle modelSpace centerPoint2 radius)
  	(vla-AddCircle modelSpace centerPoint2 radius2)
  	(vla-AddCircle modelSpace centerPoint3 radius)
  	(vla-AddCircle modelSpace centerPoint3 radius2)
  
  	(setq horasl (vla-addline modelSpace centerPoint Pt1))
 	(setq minutosl (vla-addline modelSpace centerPoint2 Pt2))
  	(setq segundosl (vla-addline modelSpace centerPoint3 Pt3))
  
  	(setq thetextH (vla-AddText modelSpace "Horas" 
                                (vlax-3d-point 7 0 0) 5))
  	(setq thetextM (vla-AddText modelSpace "Minutos" 
                                (vlax-3d-point 7 15 0) 5))
  	(setq thetextS (vla-AddText modelSpace "Segundos" 
                                (vlax-3d-point 7 30 0) 5))
)



(defun c:alr ()  	
  	(setq count 0)  	
  	(setq secs 0)
  
;seleccion vuelta uno
  	(if (= option 0)	  
		((while (< count 60)
			(vla-Rotate segundosl (vlax-3d-point 0 30 0) -0.10471975512)
			(print count)		  
			(setq count (1+ count))
		  	(setq secs (1+ secs))
		  	(vl-cmdf "._delay" 1000)		  
		)
	  (setq option (+ 1 option))
	  )	  
	  )

  ;seleccion vuelta dos
	(if (= option 1)
	  	((while (< count 60)
			(vla-Rotate minutosl (vlax-3d-point 0 15 0) -0.10471975512)
			(print count)		  
			(setq count (1+ count))
		  	(setq secs (1+ secs))
		  	(vl-cmdf "._delay" 1000)		  
		)
	  (setq option (+ 1 option)))
	  )

  ;seleccion vuelta tres
  	(if (= option 2)
		((while (< count 60)
			(vla-Rotate horasl (vlax-3d-point 0 0 0) -0.10471975512)
			(print count)		  
			(setq count (1+ count))
		  	(setq secs (1+ secs))
		  	(vl-cmdf "._delay" 1000)		 
		)
	  (setq option 0))
	  )   
 )


(defun delay_ms (Ms / T1) ;million second
	(setq T1 (getvar "cdate"))
	(setq Ms (* 0.000000001 Ms))
	(while (< (getvar "cdate") (+ T1 Ms)))
)



;(vlr-mouse-reactor nil '((:vlr-beginDoubleClick . dbclick)))
;(defun dbclick (object-reactor point-reactor / numhandle)
	;(setq count 0)
  	;(setq count2 0)
  	;(setq secs 0)
	;(while (< count 1)
		;(vla-Rotate segundosl (vlax-3d-point 0 30 0) -0.10471975512)
		;(vl-cmdf "._delay" 1000)
	  	;(print count)
		;(setq count (1+ count))
	  	;(setq secs (1+ secs))
	  	;(vl-cmdf "._delay" 1000)
	  	;(if (= secs 60)
		;	(setq count2(+ 1 count2))
		; 	(vla-Rotate minutosl (vlax-3d-point 0 30 0) -0.10471975512)
		;  	(setq secs 0)
		;  	)
 ;	)
 ;)
