;Andres Felipe Castellanos Neira
;Marcel Julian Martinez

;------------Manejo de reactores-------------
 
(vl-load-com)

;Función de cambio (click derecho)
(defun change (Caller CmdSet)
	(check)
)

;Función de selección/menu (doble click)
(defun option (Caller CmdSet)
	(setq op (getint "Seleccionar acción (1: Hora / 2: Color / 3: Posición)"))
)

;Verificar opción de menu

(defun check()
		(if (= op 1)
		 (progn
			(setq q (getint "EXECUTION"))
			(setq newHours (getint "Ingrese Nueva hora"))
			(setq newMinutes (getint "Ingrese Nuevo minuto"))
			(setq newSeconds (getint "Ingrese Nuevo segundo"))
			(changeHour)	
		 )
	  )
		(if (= op 2)
		   (progn
				(setq q (getint "EXECUTION"))
				(setq c (getint "Color"))
			   (setq alertString (strcat "Color Changed To " (itoa c) ". Press OK"))
			   (alert alertString)
			   (setq cursor (vl-remove 0.0 (nth 0 (cdr (grread T 1 15)))))
				;(vl-cmdf "_select" ())
			  	(changeColor)
			)
		)
  
)

;Función cambiar color de figura

(defun changeColor()
  ;(setq ent1 (entlast))
  (setq vla1 (vlax-ename->vla-object ent1))
  (if (AND (> (nth 0 cursor) -30) (< (nth 0 cursor) 30))
		(progn
			(vla-put-color vla1 c)
		)
	)
)

;Función cambiar hora

(defun changeHour()
  ;(setq ent2 (entlast))
  (setq vla2 (vlax-ename->vla-object ent2)
		  vla3 (vlax-ename->vla-object ent3)
		  vla4 (vlax-ename->vla-object ent4))
  (progn
	 (setq flag nil)
	 
	 (if (= (or (> 0 newHours) (< 23 newHours)
				(> 0 newMinutes) (< 59 newMinutes)
				(> 0 newSeconds) (< 59 newSeconds) 
		  ) T)
		  (progn
			  (alert "Formato de hora erroneo. Revise la hora.")
			  (setq flag T)
		  )
	 )

    (if (not (= flag T))
		(progn
		 (if (< newHours 10) (setq newHours (strcat "0" (itoa newHours))))
		 (if (< newMinutes 10) (setq newMinutes (strcat "0" (itoa newMinutes))))
		 (if (< newSeconds 10) (setq newSeconds (strcat "0" (itoa newSeconds))))
		 
		 (vla-put-textstring vla2 newHours)
		 (vla-put-textstring vla3 newMinutes)
		 (vla-put-textstring vla4 newSeconds)
		)
	 ) 
  )
)

;Definición de reactores

(setq Reactor-Put (vlr-mouse-reactor nil '((:vlr-beginDoubleClick  . option))))
(setq Reactor-Put (vlr-mouse-reactor nil '((:vlr-beginRightClick  . change))))