(defun ChangeHour ()
  
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
			        ((= city 9)(setq horas (+ 2 horas)));Río
				((= city 10)(setq horas (+ 8 horas)));Estam
				((= city 11)(setq horas (+ 8 horas))); Nair
				((= city 12)(setq horas (+ 13 horas)));Pekín
				((= city 13)(setq horas (+ 14 horas)));Seúl
				((= city 14)(setq horas (+ 13 horas)));HK
				((= city 15)(setq horas (+ 10 horas)));Tij
				((= city 16)(progn (setq horas (+ 10 horas))
								  (setq minutos (+ 30 minutos))));India
				((= city 17)(setq horas (+ 1 horas)));Manaos
				((= city 18)(setq horas (+ 0 horas)));Montev
				((= city 19)(setq horas (+ 8 horas)));Atenas
				((= city 20)(setq horas (+ 8 horas)));Kuwait
				((= city 21)(setq horas (+ 0 horas)));Bgt DC
		   );cond
	    );if
 );defun

(ChangeHour)
