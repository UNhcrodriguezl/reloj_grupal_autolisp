(vl-load-com)

;****************************************************************************

(defun line-draw ()

(setq acadDocument (vla-get-activedocument (vlax-get-acad-object)))

(setq mspace (vla-get-modelspace acadDocument))

(setq apt (getpoint "Specify First Point: "))

(setq pt (getpoint "Specify next point: " apt))

(setq myLine (vla-addline mspace (vlax-3d-point apt)(vlax-3d-point pt)))

(setq lineReactor (vlr-object-reactor (list myLine)
"Line Reactor" '((:vlr-modified . print-length))))

(princ)

);defun
