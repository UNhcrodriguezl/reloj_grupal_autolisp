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
    h_rot (*  h_delta (+ (* 3600 h) (* 60 m) s))
    m_rot (+ (* m_delta (+ (* 60 m) s)) (/ pi 2))
    s_rot (+ (* s_delta s) (/ pi 2))
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

(defun c:runAnalog(c_ref h_ref m_ref s_ref)


  (vla-delete h_block)
  (vla-delete m_block)
  (vla-delete s_block)

  (setq
	 date (rtos (getvar "CDATE") 2 6)
    h (atoi (substr date 10 2))
    m (atoi (substr date 12 2))
    s (atoi (substr date 14 2))
    h_delta -0.000145444
    m_delta -0.00174533
    s_delta -0.10472
    h_rot (*  h_delta (+ (* 3600 h) (* 60 m) s))
    m_rot (+ (* m_delta (+ (* 60 m) s)) (/ pi 2))
    s_rot (+ (* s_delta s) (/ pi 2))
    h_block (vla-InsertBlock modelspace insertion_point h_ref 1 1 1 (- h_rot h_delta))
    m_block (vla-InsertBlock modelspace insertion_point m_ref 1 1 1 (- m_rot m_delta))
    s_block (vla-InsertBlock modelspace insertion_point s_ref 1 1 1 (- s_rot s_delta))
  )

 	(vla-scaleEntity h_block (vla-get-Insertionpoint h_block)  22)
	(vla-scaleEntity m_block (vla-get-Insertionpoint m_block)  22)
	(vla-scaleEntity s_block (vla-get-Insertionpoint s_block)  22)
  
  (defun silent(com val)
    (setq old (getvar "cmdecho"))
    (setvar "cmdecho" 0)
    (vl-cmdf com val)
    (setvar "cmdecho" old)
  )

  (silent "_vscurrent" "_r")

  (while

	 (setq date (rtos (getvar "CDATE") 2 6))
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

	 (runDigital)
	 
    (silent "_.delay" 1000)
  )
)

;------------------------------Reloj digital-------------------------------


(defun digital ()
  
	(setq acadObj (vlax-get-acad-object))
	(setq doc (vla-get-ActiveDocument acadObj))

  	(setq insertionPointDD1 (vlax-3d-point 1057 430 0)  ;el punto de inserción es la posición en el dibujo
	textStringDD1 "DD" 
	height 35)
	(setq insertionPointMM1 (vlax-3d-point 1119 430 0)  
	textStringMM1 "MM"
	height 35)
	(setq insertionPointAA1 (vlax-3d-point 1235 430 0)  
	textStringAA1 "AA"
	height 35)
	   	    
   ;; Crea el texto en el espacio modelo
  
	(setq modelSpace (vla-get-ModelSpace doc))
  
   ;Colocacion de los textos iniciales dia dd, mes mm, año aa
	(setq textObjDD1 (vla-AddText modelSpace textStringDD1 insertionPointDD1 height))
	(setq ObjDD1 (entget(entlast)))
 	(setq textObjMM1 (vla-AddText modelSpace textStringMM1 insertionPointMM1 height))
	(setq ObjMM1 (entget(entlast)))
	(setq textObjAA1 (vla-AddText modelSpace textStringAA1 insertionPointAA1 height))
	(setq ObjAA1 (entget(entlast)))


	(setq  date (rtos (getvar "CDATE") 2 6)
		anot (substr date 1 4)
		mest (substr date 5 2)
		diat (substr date 7 2)
	)
	(setq mes (nth 	(setq nummes (atoi mest)) '(nil "ENE" "FEB" "MAR" "ABR" "MAY" "JUN" "JUL" "AGO" "SEP" "OCT" "NOV" "DEC")))

	(setq ObjDD1 (setq D12 (subst (cons 1  diat) (assoc 1 ObjDD1) ObjDD1)))
 	(entmod D12)
	(setq ObjDD1 (setq D12 (subst (cons 62  07) (assoc 62 ObjAA1) ObjDD1)));Cambia el color de el texto al color 7:Blanco
 	(entmod D12)
	(setq ObjAA1 (setq A12 (subst (cons 1   anot) (assoc 1 ObjAA1) ObjAA1)))
 	(entmod A12)
	(setq ObjAA1 (setq A12 (subst (cons 62  07) (assoc 62 ObjAA1) ObjAA1)));Cambia el color de el texto al color 7:Blanco
 	(entmod A12)
  	(setq ObjMM1 (setq M12 (subst (cons 1  mest) (assoc 1 ObjMM1) ObjMM1)))
 	(entmod M12)
	(setq ObjMM1 (setq M12 (subst (cons 62  07) (assoc 62 ObjMM1) ObjMM1))) ;Cambia el color de el texto al color 7:Blanco
 	(entmod M12)

	; Define the text object
	(setq insertionPointDD2 (vlax-3d-point 245 280 0)  ;el punto de inserción es la posición en el dibujo
	textStringHH2 "HH" 
	;height 10
	)
	(setq insertionPointMM2 (vlax-3d-point 695 280 0)  
	textStringMM2 "MM"
	;height 10
	)
	(setq insertionPointAA2 (vlax-3d-point 1110 260 0)  
	textStringSS2 "SS"
	;height 10
	)

	(vl-cmdf "_color" 255)
  
	(setq textObjHH2 (vla-AddText modelSpace textStringHH2 insertionPointDD2 200))
	(setq ObjHH2 (entget(entlast)))
	(setq textObjMM2 (vla-AddText modelSpace textStringMM2 insertionPointMM2 200))
	(setq ObjMM2 (entget(entlast)))
	(setq textObjSS2 (vla-AddText modelSpace textStringSS2 insertionPointAA2 80))
	(setq ObjSS2 (entget(entlast)))
  		
  	(setq ht (substr date 10 2))  ;sustraigo el valor del hora
  	(setq mt (substr date 12 2))  ;sustraigo el valor del min
 	(setq st (substr date 14 2))  ;sustraigo el valor del seg

		
  	(setq ObjHH2 (setq H22 (subst (cons 1  ht) (assoc 1 ObjHH2) ObjHH2)))
 	(entmod H22)
  	(setq ObjMM2 (setq M22 (subst (cons 1  mt) (assoc 1 ObjMM2) ObjMM2)))
 	(entmod M22)
	(setq ObjSS2 (setq S22 (subst (cons 1   st) (assoc 1 ObjSS2) ObjSS2)))
 	(entmod S22)
  
  )

(defun runDigital()
  	
  	(setq ht (substr date 10 2))  ;sustraigo el valor del hora
  	(setq mt (substr date 12 2))  ;sustraigo el valor del min
 	(setq st (substr date 14 2))  ;sustraigo el valor del seg
		
  	(setq ObjHH2 (setq H22 (subst (cons 1  ht) (assoc 1 ObjHH2) ObjHH2)))
 	(entmod H22)
  	(setq ObjMM2 (setq M22 (subst (cons 1  mt) (assoc 1 ObjMM2) ObjMM2)))
 	(entmod M22)
	(setq ObjSS2 (setq S22 (subst (cons 1   st) (assoc 1 ObjSS2) ObjSS2)))
 	(entmod S22)
  
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

(defun c:Temporizador()
  	
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


;---------------------------------Calendario---------------------------------

(defun c:calendario(alertDate)

	 (vl-cmdf "_color" 255)
  
    (setq file (open (findfile "calendario.txt") "r"))
    (while (setq line (read-line file))
    (setq l (list nil))
    (while (> (setq pos (vl-string-search "**" line)) 0)
          (setq value (substr line 1 pos))
          (setq line (vl-string-left-trim "**" (vl-string-left-trim value line)))
          (setq l (append l (list value)))
    )
    (imprimir (append (cdr l) (list line)) alertDate)
  )
  (close file)
)

(defun imprimir (info alertDate)
   (setq a (nth 0 info)
         b (nth 1 info)
		   c (nth 2 info)
   )

  (if (= alertDate nil)
	 (if (= b (itoa (atoi diat)))
	   (if (= a (itoa (atoi mest)))
		  (progn
			  (vl-cmdf "_text" "3500, 405" 60 "0" (strcat (substr c 1 28) "-") "")
			  (vl-cmdf "_text" "3500, 237" 60 "0" (strcat (substr c 19 25)"...") "")
		  )
		)
	 )
	 (if (= b (itoa (atoi diat)))
		(if (= a (itoa (atoi mest)))
		  (progn
			 	(voz c)
		  		(alert c)
		  )
		)
	 )
  )
)

(defun Voz (str)
  (setq tts (vlax-create-object "Sapi.SpVoice"));crea el objeto tts
  (vlax-invoke tts "Speak" str 0) ;invoca o llama el objeto tts
  (vlax-release-object tts) ; libera el objeto tts
)

;---------------------------------Cronografo---------------------------------

(setq option 0)
(setq secss 0)

(defun c:Cronografo()
  	
	(setq option 0)
	(setq bua 0)
	(setq pt (list 5325 375 0))
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
  	(setq centerPoint2 (vlax-3d-point px (+ 800 (nth 1 pt)) pz) radius2 190)
	(setq centerPoint3 (vlax-3d-point px (+ 1600 (nth 1 pt)) pz))
  
	(setq Pt1 (vlax-3d-point px (+ 150 (nth 1 pt)) py))
  	(setq Pt2 (vlax-3d-point px (+ 950 (nth 1 pt)) py))
  	(setq Pt3 (vlax-3d-point px (+ 1750 (nth 1 pt)) py))  	

  	(setq modelSpace (vla-get-ModelSpace doc))
  
  	(vla-put-Color (vla-AddCircle modelSpace centerPoint radius)7)  
  	(vla-put-Color (vla-AddCircle modelSpace centerPoint radius2) 7)
  	(vla-put-Color (vla-AddCircle modelSpace centerPoint2 radius)7)
  	(vla-put-Color (vla-AddCircle modelSpace centerPoint2 radius2)7)
  	(vla-put-Color (vla-AddCircle modelSpace centerPoint3 radius)7)
  	(vla-put-Color (vla-AddCircle modelSpace centerPoint3 radius2)7)
  
  	(command "_insert" "Indicador" pt 22 22 0 )
  	(setq horasl (entget (entlast)))
  	(command "_insert" "Indicador" ptt2 22 22 0 )
  	(setq minutosl (entget (entlast)))
  	(command "_insert" "Indicador" ptt3 22 22 0 )
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
	(command "_insert" "Indicador" pt 1 1 1)
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
		( (while (and (not (vl-catch-all-error-p (setq grr (vl-catch-all-apply 'grread '(t 15 1)))))
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
	  	((while	(and (not (vl-catch-all-error-p (setq grr (vl-catch-all-apply 'grread '(t 15 1)))))
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
		((while	(and (not (vl-catch-all-error-p (setq grr (vl-catch-all-apply 'grread '(t 15 1)))))
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

(defun c:resetCronografo()
  
	(setq option 0)

)


;---------------------------------Funciones visualización-------------------
(defun c:borrar ()
			(vl-cmdf "_erase" "_all" "")
)
(defun c:verdigital ()
			(setq xd (nth 1 listaobj))
			(vl-cmdf "_zoom" "_o" xd "")
)
(defun c:veranalogo ()
			(setq xd (nth 2 listaobj))
			;(vl-cmdf "_zoom" "_o" xd "")
			(c:runAnalog "case" "hor" "min" "sec")
)
(defun c:veralarma ()
			(setq xd (nth 3 listaobj))
			(vl-cmdf "_zoom" "_o" xd "")
)
(defun c:vertemporizador ()
			(setq xd (nth 4 listaobj))
			(vl-cmdf "_zoom" "_o" xd "")
  			(c:temporizador)
)
(defun c:verrecordatorio ()
			(setq xd (nth 5 listaobj))
			(vl-cmdf "_zoom" "_o" xd "")
)
(defun c:vercalendario ()
			(setq xd (nth 6 listaobj))
			(vl-cmdf "_zoom" "_o" xd "")
  			(c:calendario T)
)
(defun c:verzonahor ()
			(setq xd (nth 7 listaobj))
			(vl-cmdf "_zoom" "_o" xd "")
      	(c:changeTimeZone)
)
(defun c:vercronometro ()
			(setq xd (nth 8 listaobj))
			(vl-cmdf "_zoom" "_o" xd "")
      	(c:crono2)
)
(defun c:vercronografo ()
			(setq xd (nth 9 listaobj))
			(vl-cmdf "_zoom" "_o" xd "")
  			(c:inicronografo)
)
(defun c:vertodo ()
			(vla-zoomextents (vlax-get-acad-object))
)
	
(defun c:drawAll()
   (c:borrar)
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

  	(digital)

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
  
	(c:calendario nil)
	;parte zona horaria (7)
	(vl-cmdf "_color" 7)
	(vl-cmdf "_rectang" basezhor1 basezhor2)
  (setq zhor (ssget "_W" basezhor1 basezhor2)
				listaobj (cons zhor listaobj))
	(vl-cmdf "_rectang" '(3500 1000) '(4700 1350))
  (vl-cmdf "_text" "_J" "_MC" "4225,1250" 50 0 "HORAS")
  (vl-cmdf "_text" "_J" "_MC" "4525,1250" 50 0 "MINUT")
  (drawzh)

	(vl-cmdf "_color" 30)
	(vl-cmdf "_text" basezhor3 100 0 "7. Zona Horaria")

	(vl-cmdf "_color" 1)
	(vl-cmdf "_rectangle" '(3550 1050) '(4000 1300))
  (vl-cmdf "_rectangle" '(4100 1050) '(4350 1175))
  (vl-cmdf "_rectangle" '(4100 1200) '(4350 1300))
  (vl-cmdf "_rectangle" '(4400 1050) '(4650 1175))
  (vl-cmdf "_rectangle" '(4400 1200) '(4650 1300))

	;parte cronometro (8)
	(vl-cmdf "_color" 7)
	(vl-cmdf "_rectang" basecrono1 basecrono2)
  
  (draw_crono)
  
	(setq crono (ssget "_W" basecrono1 basecrono2)
				listaobj (cons crono listaobj))

	(vl-cmdf "_rectang" '(3500 1800) '(4800 2150))

	(vl-cmdf "_color" 30)
  
	(vl-cmdf "_text" basecrono3 100 0 "8. Cronometro")

	(vl-cmdf "_color" 1)
  
	(vl-cmdf "_rectang" '(3550 1850) '(3850 2100))

	(vl-cmdf "_rectang" '(4000 1850) '(4300 2100))

	(vl-cmdf "_rectang" '(4450 1850) '(4750 2100))

	(vl-cmdf "_circle" '(3925 1925) 25)

	(vl-cmdf "_circle" '(3925 2025) 25)
  
  (vl-cmdf "_circle" '(4375 1925) 25)

	(vl-cmdf "_circle" '(4375 2025) 25)

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

	(c:cronografo)
  
	(setq listaobj (reverse listaobj))

	(vla-zoomextents (vlax-get-acad-object))

)

;-------------------------------Cronometro--------------------------------

;FUNCIONES PARA EL FUNCIONAMIENTO DEL CRONOMETRO

;SEPARAR STRINGS
(defun splitStr (src delim)
  (setq wordlist (list))
  (setq cnt 1)
  (while (<= cnt (strlen src))

    (setq word "")

    (setq letter (substr src cnt 1))
    (while (and (/= letter delim) (<= cnt (strlen src)) )
      (setq word (strcat word letter))
      (setq cnt (+ cnt 1))      
      (setq letter (substr src cnt 1))
    )
    (setq cnt (+ cnt 1))
    (setq wordlist (append wordlist (list word)))
  )
)


;FUNCIÓN PARA DIBUJO DEL CRONOMETRO

(defun draw_crono ()
  
  (setq textoh "00"
        textom "00"
        textos "00"
  )

  (vl-cmdf "_text" "_J" "_MC" "3700,1975" 200 0 textoh)
  (setq ENT (entlast)
        ObjTh (vlax-ename->vla-object ENT)
  )
  
  (vl-cmdf "_text" "_J" "_MC" "4150,1975" 200 0 textom)
  (setq ENT (entlast)
        ObjTm (vlax-ename->vla-object ENT)
  )
  
  (vl-cmdf "_text" "_J" "_MC" "4600,1975" 200 0 textos)
  (setq ENT (entlast)
        ObjTs (vlax-ename->vla-object ENT)
  )
  
)

;FUNCIÓN PARA ABRIR EL CRONOMETRO
(defun open_crono ()
  (vl-cmdf "CRONO" "")
  (vl-cmdf "_delay" 10000 "")
  (C:crono3)
)

;CAJA DE DIALOGO PARA ABRIR EL CRONOMETRO
(defun c:crono2 ()
  
  (setq archivo (load_dialog (findfile "dialogBoxes.dcl")))
  
  (new_dialog "CDCronometro2" archivo)  ;mismo nombre del DIALOG
  
  (action_tile "Open" "(setq active2 T) (done_dialog)")
  
  (start_dialog)
  
  (if (= active2 T) (open_crono))
)

;FUNCIÓN PARA ACTUALIZAR EL DIBUJO

(defun actu_crono ()
  ;Abrir el archivo y guardar los valores
  (setq ruta  (findfile "tiempo.txt")
        arch  (open ruta "r")
        hms   (read-line arch)
  )

  ;Modifica el objeto texto
  (splitStr hms ":")
  (vlax-put-property ObjTh "TextString" (nth 0 wordlist))
  (vlax-put-property ObjTm "TextString" (nth 1 wordlist))
  (vlax-put-property ObjTs "TextString" (nth 2 wordlist))
)

;CAJA DE DIALOGO ACTUALIZAR EL DIBUJO

(defun c:crono3 ()
  (setq archivo (load_dialog (findfile "dialogBoxes.dcl")))
  
  (new_dialog "CDCronometro3" archivo)  ;mismo nombre del DIALOG
  
  (action_tile "Fresh" "(setq active3 T) (done_dialog)")
  
  (start_dialog)
  
  (if (= active3 T) (actu_crono))
)


;-------------------------------Zonas Horarias--------------------------------

;FUNCIÓN PARA DIBUJAR LAS ZONAS HORARIAS

(defun drawzh ()
  
  ;Abreviatura
  (vl-cmdf "_text" "_J" "_MC" "3775,1175" 140 0 "BOG")
  (setq ENT (entlast)
        ObjAbrZh (vlax-ename->vla-object ENT)
  )
  
  ;Cuantas horas aumenta
  (vl-cmdf "_text" "_J" "_MC" "4225,1112.5" 75 0 "+00")
  (setq ENT (entlast)
        ObjHorZh (vlax-ename->vla-object ENT)
  )
  
  ;Cuantos minutos aumenta
  (vl-cmdf "_text" "_J" "_MC" "4525,1112.5" 75 0 "+00")
  (setq ENT (entlast)
        ObjMinZh (vlax-ename->vla-object ENT)
  )
  
)

;FUNCIÓN PARA CAMBIAR ZONAS HORARIAS

(defun c:ChangeTimeZone ()
  
  ;Lee la fecha y hora
  (setq   fecha_hora  (rtos (getvar "cdate") 2 6 )
			;fecha_hora  "20191231.235855"
			año		    (atoi (substr fecha_hora 1 4))
			mes		    (atoi (substr fecha_hora 5 2))
			dias	    (atoi (substr fecha_hora 7 2))
			horas	    (atoi (substr fecha_hora 10 2))
			minutos	  (atoi (substr fecha_hora 12 2))
	)
  
  (setq p0 (strcat (itoa minutos) " " (itoa horas) " " (itoa dias) " " (itoa mes) " " (itoa año)))
  
  ;Caja de diálogo 

	(setq lista '("Hora de Australia oriental (Sidney)" "Hora oriental (Nueva York)" "Hora de Argentina (Buenos Aires)" "Afganistán"
					  "Hora estándar Europa Central (Ámsterdam)" "Hora media de Greenwich (Londres)" "Hora estándar de Japón (Tokio)"
					  "Los Ángeles" "Moscú" "Río de Janeiro" "Estambul" "Nairobi" "Hora de China (Pekín)" "Hora de Corea (Seúl)"
					  "Hong Kong" "Tijuana" "Hora estándar de India (Calcuta)" "Hora Amazonas (Manaos)" "Hora de Uruguay (Montevideo)"
					  "Hora estándar de Europa del Este (Atenas)" "Hora de Arabia (Kuwait)" "Hora de Colombia (Bogotá DC)"))

	(new_dialog "UTCs" archivo)
  
	(start_list "ciudad")
	(mapcar 'add_list lista)
	(end_list)
  
	(action_tile "ciudad" "(setq city (atoi $value))")
  
	(setq select (start_dialog))

	(if (/= select nil)
		(cond ((= city 0)(progn (setq dias (+ 1 dias)) (setq horas (+ 3 horas))))          ;Sidney
          ((= city 1)(setq horas (+ 1 horas)))                                         ;NY
          ((= city 2)(setq horas (+ 2 horas)))                                         ;BA
          ((= city 3)(progn (setq horas (+ 9 horas)) (setq minutos (+ 30 minutos))))   ;Afg
          ((= city 4)(setq horas (+ 7 horas)))                                         ;Áms
          ((= city 5)(setq horas (+ 6 horas)))                                         ;Lon
          ((= city 6)(setq horas (+ 14 horas)))                                        ;Tokio
          ((= city 7)(setq horas (- 2 horas)))                                         ;LA
          ((= city 8)(setq horas (+ 8 horas)))                                         ;Moscú
          ((= city 9)(setq horas (+ 8 horas)))                                         ;Estam
          ((= city 10)(setq horas (+ 8 horas)))                                        ;Nair
          ((= city 11)(setq horas (+ 13 horas)))                                       ;Pekín
          ((= city 12)(setq horas (+ 14 horas)))                                       ;Seúl
          ((= city 13)(setq horas (+ 13 horas)))                                       ;HK
          ((= city 14)(setq horas (+ 10 horas)))                                       ;Tij
          ((= city 15)(progn (setq horas (+ 10 horas)) (setq minutos (+ 30 minutos)))) ;India
          ((= city 17)(setq horas (+ 1 horas)))                                        ;Manaos
          ((= city 18)(setq horas (+ 0 horas)))                                        ;Montev
          ((= city 19)(setq horas (+ 8 horas)))                                        ;Atenas
          ((= city 20)(setq horas (+ 8 horas)))                                        ;Kuwait
          ((= city 21)(setq horas (+ 0 horas)))                                        ;Bgt DC
		);cond
	);if

  (if (> minutos 59); Condición que determina la hora 
    (progn
      (setq horas (1+ horas)
            minutos (+ minutos -60)
      )
    )
  )
  
  (if (> horas 23); Condición que determina el día
    (progn
      (setq dias (1+ dias)
            horas (+ horas -24)
      )
    )
  )

  (setq dias_mes '(0 31 (if (= (rem año 4) 0)(29)(28)) 31 30 31 30 31 31 30 31 30 31)); Determina si un año es bisiesto 

  (if (= dias (1+ (nth mes dias_mes))); Condición que determina el mes
    (progn
      (setq mes (1+ mes)
	    dias 1)
    )
  )

  (if (= mes 13); Condición que determina el año
    (progn
      (setq año (1+ año)
	          mes 1)
    )
  )
  
  (setq minutos (itoa minutos))
  (setq horas (itoa horas))
  (setq dias (itoa dias))
  (setq mes (itoa mes))
  (setq año (itoa año))
  
  (CambiObjetos city)
  
 );defun

(defun CambiObjetos (c)
  
  (setq lista_abr     (list "SID" "NY" "ARG" "AFG" "AMS" "LDN" "JPN" "LA" "MOS" "RIO" "EST" "NAI" "CN" "KR" "HKN" "MX" "IN" "AMZ" "URG" "ATN" "ARB" "COL")
        lista_hormas  (list "+03" "+01" "+02" "+09" "+07" "+06" "+14" "-02" "+08" "+02" "+08" "+08" "+13" "+14" "+13" "+10" "+10" "+01" "+00" "+08" "+08" "+00")
        lista_minmas  (list "+00" "+00" "+00" "+30" "+00" "+00" "+00" "+00" "+00" "+00" "+00" "+00" "+00" "+00" "+00" "+00" "+30" "+00" "+00" "+00" "+00" "+00")
  )
  
  (setq NewAbr    (nth c lista_abr)
        NewHormas (nth c lista_hormas)
        NewMinmas (nth c lista_minmas)
  )
  
  (vlax-put-property ObjAbrZh "TextString" NewAbr)
  (vlax-put-property ObjHorZh "TextString" NewHormas)
  (vlax-put-property ObjMinZh "TextString" NewMinmas)
  
)