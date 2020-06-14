(vl-load-com)
(setq option 0)
(setq secss 0)
(vlr-mouse-reactor nil '((:vlr-beginDoubleClick . dbclick)))



(defun c:Cronografo()
  	
	(setq option 0)
	(setq bua 0)
	(setq pt (list 5325 375 0))

  	(setq secs1 0)
  	(setq secs2 0)
  	(setq secs3 0)

  	(setq acadObj (vlax-get-acad-object))
	(setq doc (vla-get-ActiveDocument acadObj))
  	(setq util (vla-get-utility doc))

  	(setq px (nth 0 pt))
  	(setq py (nth 1 pt))
	(setq pz (nth 2 pt))
  	
	(setq centerPoint (vlax-3d-point px py pz) radius 150)
  	(setq centerPoint2 (vlax-3d-point px (+ 800 (nth 1 pt)) pz) radius2 170)
	(setq centerPoint3 (vlax-3d-point px (+ 1600 (nth 1 pt)) pz))
  
	(setq Pt1 (vlax-3d-point px (+ 130 (nth 1 pt)) py))
  	(setq Pt2 (vlax-3d-point px (+ 930 (nth 1 pt)) py))
  	(setq Pt3 (vlax-3d-point px (+ 1730 (nth 1 pt)) py))  	

  	(setq modelSpace (vla-get-ModelSpace doc))
  
  	(vla-put-Color (setq circleObj (vla-AddCircle modelSpace centerPoint radius))7)
  
  	(vla-put-Color (vla-AddCircle modelSpace centerPoint radius2) 7)
  	(vla-put-Color (vla-AddCircle modelSpace centerPoint2 radius)7)
  	(vla-put-Color (vla-AddCircle modelSpace centerPoint2 radius2)7)
  	(vla-put-Color (vla-AddCircle modelSpace centerPoint3 radius)7)
  	(vla-put-Color (vla-AddCircle modelSpace centerPoint3 radius2)7)
  
  	(vla-put-Color(setq horasl (vla-addline modelSpace centerPoint Pt1))7)
 	(vla-put-Color(setq minutosl (vla-addline modelSpace centerPoint2 Pt2))7)
  	(vla-put-Color(setq segundosl (vla-addline modelSpace centerPoint3 Pt3))7)
  
  	(vla-put-Color(setq thetextH (vla-AddText modelSpace "vuelta 3" 
                                (vlax-3d-point (- px 150) (+ 250 py) pz) 75))7)


  	(setq ENT (entlast)
		vuelta1 (vlax-ename->vla-object ENT)
	)
  
  	(vla-put-Color(setq thetextM (vla-AddText modelSpace "vuelta 2" 
                                (vlax-3d-point (- px 150) (+ 1050 py) pz) 75))7)

	(setq ENT (entlast)
		vuelta2 (vlax-ename->vla-object ENT)
	)
  	
  	(vla-put-Color(setq thetextS (vla-AddText modelSpace "vuelta 1" 
                                (vlax-3d-point (- px 150) (+ 1850 py) pz) 75))7)

  	(setq ENT (entlast)
		vuelta3 (vlax-ename->vla-object ENT)
	)
)

(defun wait (seconds / stop)
	(setq stop (+ (getvar "DATE") (/ seconds 86400.0)))
	(while (> stop (getvar "DATE")))
)



(defun c:inicronografo ()
  	;(c:prog)
	(setq count 0)  	
  	(setq secs 0)
  	(setq bua 0)
  	(setq secss 0)
	(if (= option 0)
	        (vla-Rotate segundosl (vlax-3d-point px (+ 1600 py) pz) (* -0.10471975512 (- 60 secs1)))
	)(if (= option 0)
	  	(vlax-put-property vuelta3 "TextString" 0)
	)(if (= option 0) 
		(vla-Rotate minutosl (vlax-3d-point px (+ 800 py) pz) (* -0.10471975512 (- 60 secs2)))
	)(if (= option 0)
	   	(vlax-put-property vuelta2 "TextString" 0)
	)(if (= option 0)
	   	(vla-Rotate horasl (vlax-3d-point px py pz) (* -0.10471975512 (- 60 secs3)))
	)(if (= option 0)
	   	(vlax-put-property vuelta1 "TextString" 0)	       
	)  	
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
			(vla-Rotate segundosl (vlax-3d-point px (+ 1600 py) pz) -0.10471975512)
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
			(vla-Rotate minutosl (vlax-3d-point px (+ 800 py) pz) -0.10471975512)
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
			(vla-Rotate horasl (vlax-3d-point px py pz) -0.10471975512)
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

