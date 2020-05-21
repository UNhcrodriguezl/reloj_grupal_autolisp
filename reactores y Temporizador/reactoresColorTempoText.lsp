;Andres Felipe Castellanos Neira
;Marcel Julian Martinez vanegas
;Computacion Grafica 2020-I

;------------Manejo de reactores y Temporizador-------------
 
(vl-load-com)
(setq archivo (load_dialog (findfile "menuReactor.dcl")))

;Función de cambio (click derecho)
(defun change (Caller CmdSet)
  	
  	(if (not(= op 3))
		(check)
	)
)

;Función de selección/menu (doble click)
(defun option (Caller CmdSet)
	(new_dialog "Menu_reactor" archivo)
  		(action_tile "b1" "(setq op 1)")
  		(action_tile "b2" "(setq op 2)")
  		(action_tile "b3" "(setq op 3)")
  	(start_dialog)
)

;Verificar opción de menu

(defun c:check()
	(if (= op 1)
	 	(progn
			(changeColor)
	 	)
  	)
	(if (= op 2)
	   (progn
		   (changeHour)
		)
	)
	(if (= op 3)
	   (progn
			(temporizador)   
		)
	)
)

;Función cambiar color de figura

(defun changeColor()

  		(new_dialog "Color_reactor" archivo)
  		(setq color 255)
			(action_tile "colorR" "(updateR $value)")
				(defun updateR (val)
						(set_tile "EstablecerR" val)
					  	(setq color (atoi (get_tile "colorR")))
					  	(boxColorR)
					)
				   (action_tile "EstablecerR" "(update2R $value)")
				  	(defun update2R (val)
						(set_tile "colorR" val)
					  	(setq color (atoi (get_tile "colorR")))
					  	(boxColorR)
					)
				   (defun boxColorR()
						(setq w (dimx_tile "imgColorR")
								h (dimy_tile "imgColorR"))
					   (start_image "imgColorR")
					  	(fill_image 0 0 w h color)
					   (print w)
					  	(end_image)
					)
  
  		(setq itemsList (list "vla1" "vla2" "vla3" "vla4" "vla5"))

		(start_list "shapes")
		(mapcar 'add_list itemsList)
		(end_list)

		(action_tile "ch" "(setq shape (atoi (get_tile \"shapes\")))")
  
		(start_dialog)
  
		(setq alertString (strcat "Color cambiado a " (itoa color) ". Presione Aceptar"))
		(alert alertString)
		(setq cursor (vl-remove 0.0 (nth 0 (cdr (grread T 1 15)))))
  
  
  ;(setq ent1 (entlast))
  ;(setq vla1 (vlax-ename->vla-object ent1))
  (setq itemsList2 (list vla1 vla2 vla3 vla4 vla5))
  (vla-put-color (nth shape itemsList2) color)
  (vla-get-color vla1)
)

;Función cambiar hora

(defun changeHour()

  (new_dialog "Texto_reactor" archivo)
		(action_tile "hs" "(setq hs (get_tile \"hs\"))")
		(action_tile "ms" "(setq ms (get_tile \"ms\"))")
		(action_tile "ss" "(setq ss (get_tile \"ss\"))")
  (start_dialog)

  (print hs)
  
  ;(setq ent2 (entlast))
  (setq vla2 (vlax-ename->vla-object ent2)
		  vla3 (vlax-ename->vla-object ent3)
		  vla4 (vlax-ename->vla-object ent4))
  (progn
	 (setq flag nil)
	 
	 (if (= (or (> 0 (atoi hs)) (< 23 (atoi hs))
				(> 0 (atoi ms)) (< 59 (atoi ms))
				(> 0 (atoi ss)) (< 59 (atoi ss)) 
		  ) T)
		  (progn
			  (alert "Formato de hora erroneo. Revise la hora.")
			  (setq flag T)
		  )
	 )

    (if (not (= flag T))
		(progn
		 (if (< (atoi hs) 10) (setq hs (strcat "0" hs)))
		 (if (< (atoi ms) 10) (setq ms (strcat "0" ms)))
		 (if (< (atoi ss) 10) (setq ss (strcat "0" ss)))
		 
		 (vla-put-textstring vla2 hs)
		 (vla-put-textstring vla3 ms)
		 (vla-put-textstring vla4 ss)
		)
	 ) 
  )
)

;Definición de reactores

(defun c:init()
  	(setq Reactor-Put (vlr-mouse-reactor nil '((:vlr-beginDoubleClick  . option))))
	(setq Reactor-Put (vlr-mouse-reactor nil '((:vlr-beginRightClick  . change))))
)

(vlax-dump-object vla1);obtener info
;------------Temporizador-------------

(defun Tempo(hor minu secu x1 y1)
	(vl-load-com)
	(vl-cmdf "_erase" "_all" "");BORRA TODO
 	(drawTemp x1 y1)
	(updTemp hor minu secu)
)

(defun drawTemp(x y)
  	(vl-cmdf "_color" "_truecolor" "255,0,0");red
  	(vl-cmdf "_text" (list (+ x 2) (+ y 2)) "8" "0" "00")
  		(setq digiHour (entlast))
  	(vl-cmdf "_text" (list (+ x 14) (+ y 2)) "8" "0" ":")
  		(setq points1 (entlast))
  	(vl-cmdf "_text" (list (+ x 17) (+ y 2)) "8" "0" "00")
  		(setq digiMin (entlast))
  	(command "_text" (list (+ x 29) (+ y 2)) "8" "0" ":")
  		(setq points2 (entlast))
  	(vl-cmdf "_text" (list (+ x 32) (+ y 2)) "8" "0" "00")
  		(setq digiSec (entlast))
  	(vl-cmdf "_pline" (list x y) (list (+ x 46) y) (list (+ x 46) (+ y 12)) (list x (+ y 12)) (list x y) "")

  	(setq vla1 (vlax-ename->vla-object digiHour))
	(setq vla2 (vlax-ename->vla-object points1))
	(setq vla3 (vlax-ename->vla-object digiMin))
	(setq vla4 (vlax-ename->vla-object points2))
  	(setq vla5 (vlax-ename->vla-object digiSec))
)

(defun updTemp(hora minu secu)
  	(setq n (+ secu (* minu 60) (* hora 3600)))
	(if (< secu 9)
		(progn
		  	(vla-put-TextString vla5 (strcat "0" (itoa secu)))
		)
	  	(progn
		  	(vla-put-TextString vla5 secu)
		)
	)
	(if (< minu 9)
		(progn
		  	(vla-put-TextString vla3 (strcat "0" (itoa minu)))
		)
	  	(progn
		  	(vla-put-TextString vla3 minu)
		)
	)
	(if (< hora 9)
	  	(progn
		 	(vla-put-TextString vla1 (strcat "0" (itoa hora)))
		)
	  	(progn
		 	(vla-put-TextString vla1 hora)
		)
	)
;-------------------------------------------------------------
  	(repeat n
	  	(vl-cmdf "_delay" 1000)
	  	(setq secu (- secu 1))
		(if (< secu 0)
		  	(progn
			  	(setq minu (- minu 1))
			  	(setq secu 59)
			)
		)
	  	(if (< minu 0)
		  	(progn
				(setq hour (- hora 1))
			  	(setq minu 59)
			)
		)
	  	(if (< hora 0)
		  	(progn
				(setq hora 0)
			)
		)
;-----------------------------------------------------------
	  	(if (> 10 secu)
			(progn
			  	(vla-put-TextString vla5 (strcat "0" (itoa secu)))
			)
		  	(progn
			  	(vla-put-TextString vla5 secu)
			)
		)
		(if (and (< minu 0) (< hora 0))
			(progn
			  	(vla-put-TextString vla3 "00")
			)
		  	(progn
			  	(if (> 10 minu)
					(progn
					  	(vla-put-TextString vla3 (strcat "0" (itoa minu)))
					)
				  	(progn
					  	(vla-put-TextString vla3 minu)
					)
				)
			)
		)
	  	(if (< hora 0)
			(progn
			  	(vla-put-TextString vla1 "00")
			)
		  	(progn
				(if (> 10 hora)
				  	(progn
					 	(vla-put-TextString vla1 (strcat "0" (itoa hora)))
					)
				  	(progn
					 	(vla-put-TextString vla1 hora)
					)
				)
			)
		)
	)
)

(defun Temporizador()
  	(setq dcl_id (load_dialog (findfile "cajaTempo.dcl")))
	(if (not (new_dialog "temporizador" dcl_id)	;test for dialog
		);not
   	(exit);exit if no dialog
  	);if

	(setq hora 0)
	(setq minuto 0)
	(setq segundo 0)
	(setq xp 0)
  	(setq yp 0)
  	
  	(set_tile "hora" "0")
  	(mode_tile "hora" 1)
  	(set_tile "minu" "0")
  	(mode_tile "minu" 1)
  	(set_tile "secu" "0")
  	(mode_tile "secu" 1)

  	(action_tile "px"
	  	"(setq xp (atoi $value))")
  	(action_tile "py"
	  	"(setq yp (atoi $value))")

  	(action_tile "horaSlider"				
	 	"(slider_action1 $value $reason)")
  	(action_tile "minuSlider"				
	 	"(slider_action2 $value $reason)")
  	(action_tile "secuSlider"				
	 	"(slider_action3 $value $reason)")

  	(action_tile "hora"
	 	"(ebox_action1 $value $reason)")
  	(action_tile "minu"
	 	"(ebox_action2 $value $reason)")
  	(action_tile "secu"
	 	"(ebox_action3 $value $reason)")
 
  	(defun slider_action1 (val why)
      (if (or (= why 2) (= why 1))
      (set_tile "hora" val))
	  	(setq hora (atoi $value)))
 	(defun slider_action2 (val why)
      (if (or (= why 2) (= why 1))
      (set_tile "minu" val))
	  	(setq minuto (atoi $value)))
  	(defun slider_action3 (val why)
      (if (or (= why 2) (= why 1))
      (set_tile "secu" val))
	  	(setq segundo (atoi $value)))
  
  	(defun ebox_action1 (val why)
      (if (or (= why 2) (= why 1))
      (set_tile "horaSlider" val))
	  	(setq hora (atoi $value)))
  	(defun ebox_action2 (val why)
      (if (or (= why 2) (= why 1))
      (set_tile "minuSlider" val))
	  	(setq minuto (atoi $value)))
  	(defun ebox_action3 (val why)
      (if (or (= why 2) (= why 1))
      (set_tile "secuSlider" val))
	  	(setq segundo (atoi $value)))

  	(setq seleccion (start_dialog))
  	(tempo hora minuto segundo xp yp)
)


