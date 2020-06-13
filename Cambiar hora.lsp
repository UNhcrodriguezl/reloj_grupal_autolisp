;Maria Paula Carvajal
;Configuración cambio zona horaria reloj 
;Acepta el año, el mes, el día, la hora y los minutos actuales

(defun ChangeTimeZone ()

   ;Caja de diálogo 
	(setq arch (load_dialog (findfile "CambioHusos.dcl")))

	(setq lista '("Hora de Australia oriental (Sidney)" "Hora oriental (Nueva York)" "Hora de Argentina (Buenos Aires)" "Afganistán"
					  "Hora estándar Europa Central (Ámsterdam)" "Hora media de Greenwich (Londres)" "Hora estándar de Japón (Tokio)"
					  "Los Ángeles" "Moscú" "Río de Janeiro" "Estambul" "Nairobi" "Hora de China (Pekín)" "Hora de Corea (Seúl)"
					  "Hong Kong" "Tijuana" "Hora estándar de India (Calcuta)" "Hora Amazonas (Manaos)" "Hora de Uruguay (Montevideo)"
					  "Hora estándar de Europa del Este (Atenas)" "Hora de Arabia (Kuwait)" "Hora de Colombia (Bogotá DC)"))

	(new_dialog "UTCs" arch)
	(start_list "ciudad")
	(mapcar 'add_list lista)
	(end_list)
	(action_tile "ciudad" "(setq city (atoi $value))")
	(setq select (start_dialog))

	(if (/= select nil)
		(cond ((= city 0)(progn (setq dias (+ 1 dias))
								 (setq horas (+ 3 horas))));Sidney
				((= city 1)(setq horas (+ 1 horas)));NY
				((= city 2)(setq horas (+ 2 horas)));BA
				((= city 3)(progn (setq horas (+ 9 horas))
								 (setq minutos (+ 30 minutos))));Afg
				((= city 4)(setq horas (+ 7 horas)));Áms
				((= city 5)(setq horas (+ 6 horas)));Lon
				((= city 6)(setq horas (+ 14 horas)));Tokio
				((= city 7)(setq horas (- 2 horas)));LA
				((= city 8)(setq horas (+ 8 horas)));Moscú
				((= city 9)(setq horas (+ 8 horas)));Estam
				((= city 10)(setq horas (+ 8 horas))); Nair
				((= city 11)(setq horas (+ 13 horas)));Pekín
				((= city 12)(setq horas (+ 14 horas)));Seúl
				((= city 13)(setq horas (+ 13 horas)));HK
				((= city 14)(setq horas (+ 10 horas)));Tij
				((= city 15)(progn (setq horas (+ 10 horas))
								  (setq minutos (+ 30 minutos))));India
				((= city 17)(setq horas (+ 1 horas)));Manaos
				((= city 18)(setq horas (+ 0 horas)));Montev
				((= city 19)(setq horas (+ 8 horas)));Atenas
				((= city 20)(setq horas (+ 8 horas)));Kuwait
				((= city 21)(setq horas (+ 0 horas)));Bgt DC
		   );cond
	    );if
  

  (if (= segundos 60); Condición que determina los minutos
    (progn
      (setq minutos (1+ minutos)
            segundos 1)
      )
    (setq segundos (1+ segundos))
    )
    
  

  (if (= minutos 60); Condición que determina la hora 
    (progn
      (setq horas (1+ horas)
            minutos 1)
      )
    )
  
   
  
  (if (= horas 24); Condición que determina el día
    (progn
      (setq dias (1+ dias)
            horas 1)
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


  
  ; AÑADE UN CERO ANTES DE LOS VALORES DE LA FECHA Y LA HORA RESPECTIVAMENTE DE UNA SOLA CIFRA
	;Y CONVIERTE LOS VALORES A STRING 
  
  (defun cero_izq (x); Añade dos ceros a la izquierda de un número
    (setq numero (rtos x 2 0))
    (while (< (strlen numero) 2)
    (setq numero (strcat "0" numero))));defun

  
  (if (< segundos 10)
    (setq segundos (cero_izq segundos)); invoca la función encargada
    (setq segundos (itoa segundos))); convierte los valores a string cuando no se cumple la condición
  
  (if (< minutos 10)
    (setq minutos (cero_izq minutos))
    (setq minutos (itoa minutos)))

  (if (< horas 10)
    (setq horas (cero_izq horas))
    (setq horas (itoa horas)))

  (if (< dias 10)
    (setq dias (cero_izq dias))
    (setq dias (itoa dias)))

  (if (< mes 10)
    (setq mes (cero_izq mes))
    (setq mes (itoa mes)))
  
  (if (< año 10)
    (setq año (cero_izq año))
    (setq año (itoa año)))
		  
 
 );defun

(ChangeTimeZone)

