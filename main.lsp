;Funciones vl
(vl-load-com)
(vl-load-reactors)
(vlr-remove-all)


;Carga de archivos

(setq archivo (load_dialog (findfile "dialogBoxes.dcl")))


;-----------------------------------Reloj analogico--------------------------

(defun analog (x y c_ref h_ref m_ref s_ref)

  (setq
    insertion_point (vlax-3D-point x y)
    acad_object (vlax-get-acad-object)
    active_document (vla-get-ActiveDocument acad_object)
    modelspace (vla-get-modelspace active_document)
    date (rtos (getvar "CDATE") 2 6)
    h (atoi (substr date 10 2))
    m (atoi (substr date 12 2))
    s (atoi (substr date 14 2))
    h_delta -0.000145444
    m_delta -0.00174533
    s_delta -0.10472
    h_rot (* h_delta (+ (* 3600 h) (* 60 m) s)) 
    m_rot (* m_delta (+ (* 60 m) s)) 
    s_rot (* s_delta s) 
    c_block (vla-InsertBlock modelspace insertion_point c_ref 1 1 1 0)
    h_block (vla-InsertBlock modelspace insertion_point h_ref 1 1 1 h_rot)
    m_block (vla-InsertBlock modelspace insertion_point m_ref 1 1 1 m_rot)
    s_block (vla-InsertBlock modelspace insertion_point s_ref 1 1 1 s_rot)
	 
	)

   (vla-scaleEntity c_block (vla-get-Insertionpoint c_block)  22)
	(vla-scaleEntity h_block (vla-get-Insertionpoint h_block)  22)
	(vla-scaleEntity m_block (vla-get-Insertionpoint m_block)  22)
	(vla-scaleEntity s_block (vla-get-Insertionpoint s_block)  22)

	;(vla-put-insertionPoint c_block (vlax-3d-point 800 1550 0))
  
)

(defun runAnalog()
  (defun silent(com val)
    (setq old (getvar "cmdecho"))
    (setvar "cmdecho" 0)
    (vl-cmdf com val)
    (setvar "cmdecho" old)
  )

  (silent "_vscurrent" "_r")

  (while 
    (setq s (rem (1+ s) 60))
    (if (= s 0) (progn
      (setq m (rem (1+ m) 60))
      (if (= m 0)
        (setq h (rem (1+ h) 24))
      ))
    )
    
    (vla-rotate h_block insertion_point h_delta)
    (vla-rotate m_block insertion_point m_delta)
    (vla-rotate s_block insertion_point s_delta)

    (silent "_.delay" 1000)
  )
)


;------------------------------------Reactores-----------------------------


;Función de cambio (click derecho)
(defun change (Caller CmdSet)
	(check)
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

(defun check()
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
			(vertemporizador)
		)
	)
)

;Función cambiar color de figura

(defun changeColor()

		(setq flag 1)
  
		(while (not (= flag 0))
  
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
  
  		(setq itemsList (list "HorTempo" "MinTempo" "SecTempo"))

		(start_list "shapes")
		(mapcar 'add_list itemsList)
		(end_list)

		(action_tile "ch" "(setq shape (atoi (get_tile \"shapes\"))) (done_dialog 1)")
		(action_tile "accept" "(done_dialog 0)")
		(setq flag (start_dialog))

		(if (= flag 1)
		  	(progn
			  	(setq alertString (strcat "Color cambiado a " (itoa color) ". Presione Aceptar"))
				(alert alertString)
				(setq cursor (vl-remove 0.0 (nth 0 (cdr (grread T 1 15)))))
		  
		  ;(setq ent1 (entlast))
		  ;(setq vla1 (vlax-ename->vla-object ent1))

		  		(setq itemsList2 (list vlaHorTemp vlaMinTemp vlaSecTemp))
		  		(vla-put-color (nth shape itemsList2) color)
			)
		)
	)
  
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

;(vlax-dump-object vla1)obtener info

;-----------------------------Temporizador------------------------------

(defun Tempo(hor minu secu x y)
	(drawTemp x y)
	(updTemp hor minu secu)
)

(defun drawTemp(x y)
  	(vl-cmdf "_color" "_truecolor" "255,255,255");red
  	(vl-cmdf "_text" (list (- x 5) (+ y 30)) "200" "0" "00")
  		(setq digiHour (entlast))
  	(vl-cmdf "_text" (list (+ x 447) (+ y 30)) "200" "0" "00")
  		(setq digiMin (entlast))
  	(vl-cmdf "_text" (list (+ x 862) (+ y 12)) "80" "0" "00")
  		(setq digiSec (entlast))
  
  	;(vl-cmdf "_pline" (list x y) (list (+ x 46) y) (list (+ x 46) (+ y 12)) (list x (+ y 12)) (list x y) "")

  	(setq vlaHorTemp (vlax-ename->vla-object digiHour))
	(setq vlaMinTemp (vlax-ename->vla-object digiMin))
  	(setq vlaSecTemp (vlax-ename->vla-object digiSec))
)

(defun updTemp(hora minu secu)
  	(princ secu)
  	(setq n (+ secu (* minu 60) (* hora 3600)))
	(if (< secu 9)
		(progn
		  	(vla-put-TextString vlaSecTemp (strcat "0" (itoa secu)))
		)
	  	(progn
		  	(vla-put-TextString vlaSecTemp secu)
		)
	)
	(if (< minu 9)
		(progn
		  	(vla-put-TextString vlaMinTemp (strcat "0" (itoa minu)))
		)
	  	(progn
		  	(vla-put-TextString vlaMinTemp minu)
		)
	)
	(if (< hora 9)
	  	(progn
		 	(vla-put-TextString vlaHorTemp (strcat "0" (itoa hora)))
		)
	  	(progn
		 	(vla-put-TextString vlaHorTemp hora)
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
			  	(vla-put-TextString vlaSecTemp (strcat "0" (itoa secu)))
			)
		  	(progn
			  	(vla-put-TextString vlaSecTemp secu)
			)
		)
		(if (and (< minu 0) (< hora 0))
			(progn
			  	(vla-put-TextString vlaMinTemp "00")
			)
		  	(progn
			  	(if (> 10 minu)
					(progn
					  	(vla-put-TextString vlaMinTemp (strcat "0" (itoa minu)))
					)
				  	(progn
					  	(vla-put-TextString vlaMinTemp minu)
					)
				)
			)
		)
	  	(if (< hora 0)
			(progn
			  	(vla-put-TextString vlaHorTemp "00")
			)
		  	(progn
				(if (> 10 hora)
				  	(progn
					 	(vla-put-TextString vlaHorTemp (strcat "0" (itoa hora)))
					)
				  	(progn
					 	(vla-put-TextString vlaHorTemp hora)
					)
				)
			)
		)
	)
)

(defun Temporizador()
  	
	(if (not (new_dialog "temporizador" archivo)	;test for dialog
		);not
   	(exit);exit if no dialog
  	);if

	(setq hora 0)
	(setq minuto 0)
	(setq segundo 0)
	(setq xTempo 1900)
  	(setq yTempo 1050)
  	
  	(set_tile "hora" "0")
  	(mode_tile "hora" 1)
  	(set_tile "minu" "0")
  	(mode_tile "minu" 1)
  	(set_tile "secu" "0")
  	(mode_tile "secu" 1)

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
  	
  	;(tempo hora minuto segundo xTempo yTempo)
  	(updTemp hora minuto segundo)
)


;---------------------------------Funciones visualización-------------------
(defun c:borrar ()
			(vl-cmdf "_erase" "_all" ""))
(defun c:verdigital ()
			(setq xd (nth 1 listaobj))
			(vl-cmdf "_zoom" "_o" xd ""))
(defun c:veranalogo ()
			(setq xd (nth 2 listaobj))
			(vl-cmdf "_zoom" "_o" xd "")
			(runAnalog))
(defun c:veralarma ()
			(setq xd (nth 3 listaobj))
			(vl-cmdf "_zoom" "_o" xd ""))
(defun c:vertemporizador ()
			(setq xd (nth 4 listaobj))
			(vl-cmdf "_zoom" "_o" xd "")
  			(temporizador)
)
(defun c:verrecordatorio ()
			(setq xd (nth 5 listaobj))
			(vl-cmdf "_zoom" "_o" xd ""))
(defun c:vercalendario ()
			(setq xd (nth 6 listaobj))
			(vl-cmdf "_zoom" "_o" xd ""))
(defun c:verzonahor ()
			(setq xd (nth 7 listaobj))
			(vl-cmdf "_zoom" "_o" xd ""))
(defun c:vercronometro ()
			(setq xd (nth 8 listaobj))
			(vl-cmdf "_zoom" "_o" xd ""))
(defun c:vercronografo ()
			(setq xd (nth 9 listaobj))
			(vl-cmdf "_zoom" "_o" xd ""))
(defun c:vertodo ()
			(vla-zoomextents (vlax-get-acad-object)))
	
(defun c:drawAll()						
	;variables
	(setq	basedig1 '(0 0)
				basedig2 '(1600 750)
				basedig3 '(50 600)
				baseanl1 '(0 750)
				baseanl2 '(1600 2350)
				baseanl3 '(50 2200)
				basealm1 '(1650 0)
				basealm2 '(3250 750)
				basealm3 '(1700 600)
				basetemp1 '(1650 800)
				basetemp2 '(3250 1550)
				basetemp3 '(1700 1400)
				baserecor1 '(1650 1600)
				baserecor2 '(3250 2350)
				baserecor3 '(1700 2200)
				basecal1 '(3300 0)
				basecal2 '(4900 750)
				basecal3 '(3350 600)
				basezhor1 '(3300 800)
				basezhor2 '(4900 1550)
				basezhor3 '(3350 1400)
				basecrono1 '(3300 1600)
				basecrono2 '(4900 2350)
				basecrono3 '(3350 2200)
				listaobj '("0"))

	;parte reloj digital (1)
	(vl-cmdf "_color" 7)
	(vl-cmdf "_rectang" basedig1 basedig2)
	(setq dig (ssget "_W" basedig1 basedig2)
				listaobj (cons dig listaobj))

	(vl-cmdf "_rectang" '(200 200) '(1400 550))

	(vl-cmdf "_color" 30)
	(vl-cmdf "_text" basedig3 100 0 "1. Digital")

	(vl-cmdf "_color" 1)
	(vl-cmdf "_rectang" '(250 250) '(550 500))

	(vl-cmdf "_rectang" '(700 250) '(1000 500))

	(vl-cmdf "_rectang" '(1050 250) '(1300 350))

	(vl-cmdf "_rectang" '(1050 400) '(1350 500))

	(vl-cmdf "_circle" '(625 325) 25)

	(vl-cmdf "_circle" '(625 425) 25)

	;parte reloj analogico (2)
	(vl-cmdf "_color" 7)
	(vl-cmdf "_rectang" baseanl1 baseanl2)
	(setq analogo (ssget "_W" baseanl1 baseanl2)
				listaobj (cons analogo listaobj))

	(vl-cmdf "_rectang" '(200 950) '(1400 2150))

	(vl-cmdf "_color" 30)
	(vl-cmdf "_text" baseanl3 100 0 "2. Analogo")

	(vl-cmdf "_color" 1)
	(vl-cmdf "_circle" '(800 1550) 550)

	(analog 800 1550 "case" "hor" "min" "sec")
  
	;parte alarma (3)
	(vl-cmdf "_color" 7)
	(vl-cmdf "_rectang" basealm1 basealm2)
	(setq alarma (ssget "_W" basealm1 basealm2)
				listaobj (cons alarma listaobj))

	(vl-cmdf "_rectang" '(1850 200) '(3050 550))

	(vl-cmdf "_color" 30)
	(vl-cmdf "_text" basealm3 100 0 "3. Alarma")

	(vl-cmdf "_color" 1)
	(vl-cmdf "_rectang" '(1900 250) '(2200 500))

	(vl-cmdf "_rectang" '(2350 250) '(2650 500))

	(vl-cmdf "_rectang" '(2700 250) '(2950 350))

	(vl-cmdf "_rectang" '(2700 400) '(3000 500))

	(vl-cmdf "_circle" '(2275 325) 25)

	(vl-cmdf "_circle" '(2275 425) 25)

	;parte temporizador (4)
	(vl-cmdf "_color" 7)
	(vl-cmdf "_rectang" basetemp1 basetemp2)
	(setq temp (ssget "_W" basetemp1 basetemp2)
				listaobj (cons temp listaobj))

	(vl-cmdf "_rectang" '(1850 1000) '(3050 1350))

	(vl-cmdf "_color" 30)
	(vl-cmdf "_text" basetemp3 100 0 "4. Temporizador")

	(vl-cmdf "_color" 1)
	(vl-cmdf "_rectang" '(1900 1050) '(2200 1300))

	(vl-cmdf "_rectang" '(2350 1050) '(2650 1300))

	(vl-cmdf "_rectang" '(2700 1050) '(2950 1150))

	(vl-cmdf "_rectang" '(2700 1200) '(3000 1300))

	(vl-cmdf "_circle" '(2275 1125) 25)

	(vl-cmdf "_circle" '(2275 1225) 25)

  	(drawTemp 1900 1050)

	;parte recordatorio (5)
	(vl-cmdf "_color" 7)
	(vl-cmdf "_rectang" baserecor1 baserecor2)
	(setq recor (ssget "_W" baserecor1 baserecor2)
				listaobj (cons recor listaobj))

	(vl-cmdf "_rectang" '(1850 1800) '(3050 2150))

	(vl-cmdf "_color" 30)
	(vl-cmdf "_text" baserecor3 100 0 "5. Recordatorio")

	;parte calendario (6)
	(vl-cmdf "_color" 7)
	(vl-cmdf "_rectang" basecal1 basecal2)
	(setq cal (ssget "_W" basecal1 basecal2)
				listaobj (cons cal listaobj))

	(vl-cmdf "_rectang" '(3500 200) '(4700 550))

	(vl-cmdf "_color" 30)
	(vl-cmdf "_text" basecal3 100 0 "6. Calendario")

	;parte zona horaria (7)
	(vl-cmdf "_color" 7)
	(vl-cmdf "_rectang" basezhor1 basezhor2)
	(setq zhor (ssget "_W" basezhor1 basezhor2)
				listaobj (cons zhor listaobj))

	(vl-cmdf "_rectang" '(3500 1000) '(4700 1350))

	(vl-cmdf "_color" 30)
	(vl-cmdf "_text" basezhor3 100 0 "7. Zona Horaria")

	(vl-cmdf "_color" 1)
	(vl-cmdf "_rectang" '(3550 1050) '(3850 1300))

	(vl-cmdf "_rectang" '(4000 1050) '(4300 1300))

	(vl-cmdf "_rectang" '(4350 1050) '(4600 1150))

	(vl-cmdf "_rectang" '(4350 1200) '(4650 1300))

	(vl-cmdf "_circle" '(3925 1125) 25)

	(vl-cmdf "_circle" '(3925 1225) 25)

	;parte cronometro (8)
	(vl-cmdf "_color" 7)
	(vl-cmdf "_rectang" basecrono1 basecrono2)
	(setq crono (ssget "_W" basecrono1 basecrono2)
				listaobj (cons crono listaobj))

	(vl-cmdf "_rectang" '(3500 1800) '(4700 2150))

	(vl-cmdf "_color" 30)
	(vl-cmdf "_text" basecrono3 100 0 "8. Cronometro")

	(vl-cmdf "_color" 1)
	(vl-cmdf "_rectang" '(3550 1850) '(3850 2100))

	(vl-cmdf "_rectang" '(4000 1850) '(4300 2100))

	(vl-cmdf "_rectang" '(4350 1850) '(4600 1950))

	(vl-cmdf "_rectang" '(4350 2000) '(4650 2100))

	(vl-cmdf "_circle" '(3925 1925) 25)

	(vl-cmdf "_circle" '(3925 2025) 25)

	;parte cronografo (9)
	(vl-cmdf "_color" 7)
	(vl-cmdf "_rectang" '(4950 0) '(5700 750))

	(vl-cmdf "_rectang" '(5100 150) '(5550 600))

	(vl-cmdf "_rectang" '(4950 800) '(5700 1550))

	(vl-cmdf "_rectang" '(5100 950) '(5550 1400))

	(vl-cmdf "_rectang" '(4950 1600) '(5700 2350))

	(vl-cmdf "_rectang" '(5100 1750) '(5550 2200))
	(setq cronog (ssget "_W" '(4950 0) '(5700 2350))
				listaobj (cons cronog listaobj))

	(vl-cmdf "_color" 30)
	(vl-cmdf "_text" '(5850 750) 100 90 "9. Cronografo")

	(vl-cmdf "_color" 1)
	(vl-cmdf "_circle" '(5325 375) 200)

	(vl-cmdf "_circle" '(5325 1175) 200)

	(vl-cmdf "_circle" '(5325 1975) 200)

	(setq listaobj (reverse listaobj))

	(vla-zoomextents (vlax-get-acad-object))

)
