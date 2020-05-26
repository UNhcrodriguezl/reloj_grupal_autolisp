(vl-load-com)
(defun c:Exa()
    ;; This example creates a text object in model space.
    (setq acadObj (vlax-get-acad-object))
    (setq doc (vla-get-ActiveDocument acadObj))
  
    ;; Define the text object
    (setq insertionPoint (vlax-3d-point 0 0 0)  
          textString "Hello, World."
          height 0.5)
    
    ;; Create the text object in model space
    (setq modelSpace (vla-get-ModelSpace doc))
    (setq textObj (vla-AddText modelSpace textString insertionPoint height))  
    (vla-ZoomAll acadObj)
)

(defun c:dib()
	(setq acadObj (vlax-get-acad-object))
	(setq doc (vla-get-ActiveDocument acadObj))	   
	(setq centerPoint (vlax-3d-point 0 0 0) radius 5)
  	(setq centerPoint2 (vlax-3d-point 0 15 0) radius2 6.5)
	(setq centerPoint3 (vlax-3d-point 0 30 0))
	(setq PT (vlax-3d-point 0 4 0 ))
  	(setq Pt2 (vlax-3d-point 0 19 0))
  	(setq Pt3 (vlax-3d-point 0 34 0))  	
	(setq modelSpace (vla-get-ModelSpace doc))
	(setq circleObj (vla-AddCircle modelSpace centerPoint radius))
  	(vla-AddCircle modelSpace centerPoint radius2)
  	(vla-AddCircle modelSpace centerPoint2 radius)
  	(vla-AddCircle modelSpace centerPoint2 radius2)
  	(vla-AddCircle modelSpace centerPoint3 radius)
  	(vla-AddCircle modelSpace centerPoint3 radius2)
  
  	(setq horasl (vla-addline modelSpace centerPoint Pt))
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
	(while (< count 60)
	  	(vla-Rotate segundosl (vlax-3d-point 0 30 0) -0.10471975512)
		(princ count)
		(setq count (1+ count))
	  	(command "_delay" 1000)
	  	
	  	
	)
	

 )



(defun delay_ms (Ms / T1) ;million second
	(setq T1 (getvar "cdate"))
	(setq Ms (* 0.000000001 Ms))
	(while (< (getvar "cdate") (+ T1 Ms)))
)
