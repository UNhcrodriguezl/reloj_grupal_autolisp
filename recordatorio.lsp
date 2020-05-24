(defun recordatorio()
		 (setq archivo (load_dialog (findfile "recor.DCL")));Carga el archivo donde se encuentran las dos cajas de diálogo
(setq lst '("Enero" "Febrero" "Marzo" "Abril" "Mayo" "Junio" "Julio" "Agosto" "Septiembre" "Octubre" "Noviembre" "Diciembre"));Nombres de los meses
(setq d28 '("1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" "20" "21" "22" "23" "24" "25" "26" "27" "28"));Días del mes de febrero
(setq d29 '("1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" "20" "21" "22" "23" "24" "25" "26" "27" "28" "29"));Días del mes de febrero (si el año es bisiesto
(setq d30 '("1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" "20" "21" "22" "23" "24" "25" "26" "27" "28" "29" "30"));Días de los meses con 30 días
(setq d31 '("1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" "20" "21" "22" "23" "24" "25" "26" "27" "28" "29" "30" "31"));Días de los meses con 31 días
(setq years '("2020" "2021" "2022" "2023" "2024" "2025" "2026" "2027" "2028" "2029" "2030")) 
(setq mes_r 0);Establece por defecto el mes de Enero sí no se selecciona algún mes en la caja de diálogo
(setq dia_r 0);Establece por defecto el día 1 sí no se selecciona algún día en la caja de diálogo (Caja de diálogo #2)
(setq year_r 0);Establece por defecto el año 2020 sí no se selecciona algún año en la caja de diálogo
(setq record_r "");Establece por defecto vacío el recordatorio sí no se coloca alguno 
(setq cerrada 0);Verifica por cuál botón se cierra la caja (se mantendrá en 0 si la caja se cierra por el botón cancel y se le asignará el valor de 1 sí la caja se cierra por el botón "Guardar y establecer día"

(new_dialog "record" archivo);Abre la primera caja de dialogo donde se selecciona el mes, el año y se añade el recordatorio

(start_list "mes")
(mapcar 'add_list lst) ;Llena el popup_list de los meses
(end_list)

(start_list "year")
(mapcar 'add_list years) ;Llena el popup_list de los años
(end_list)

(action_tile "save" "(setq cerrada 1) (done_dialog)");Cierra la caja cuando se presione el botón "Guardar y establecer día"
(action_tile "mes" "(setq mes_r (atoi $value))");Guarda la posición seleccionada de la lista de meses en la variable mes_r
(action_tile "year" "(setq year_r (atoi $value))");Guarda la posición seleccionada de la lista de years en la variable year_r
(action_tile "rec" "(setq record_r (get_tile \"rec\"))");Guarda el valor introducido en la edit_box de etiqueta en la variable recordatorio

(start_dialog)

(cond ((= mes_r 0) (progn (setq nm "Enero") (setq dias d31)))
		((= mes_r 1) (progn (setq nm "Febrero") (setq dias d28)))
      ((= mes_r 2) (progn (setq nm "Marzo") (setq dias d31)))
      ((= mes_r 3) (progn (setq nm "Abril") (setq dias d30)))
      ((= mes_r 4) (progn (setq nm "Mayo") (setq dias d31)))
      ((= mes_r 5) (progn (setq nm "Junio") (setq dias d30)))
      ((= mes_r 6) (progn (setq nm "Julio") (setq dias d31)))
      ((= mes_r 7) (progn (setq nm "Agosto") (setq dias d31)))
      ((= mes_r 8) (progn (setq nm "Septiembre") (setq dias d30)))
      ((= mes_r 9) (progn (setq nm "Octubre") (setq dias d31)))
      ((= mes_r 10) (progn (setq nm "Noviembre") (setq dias d30)))
      ((= mes_r 11) (progn (setq nm "Diciembre") (setq dias d31)))
      );Establece la cantidad de días que tiene el mes dependiendo del mes seleccionado

(cond ((= year_r 0) (setq year_r 2020))
		((= year_r 1) (setq year_r 2021))
		((= year_r 2) (setq year_r 2022))
		((= year_r 3) (setq year_r 2023))
		((= year_r 4) (setq year_r 2024))
		((= year_r 5) (setq year_r 2025))
		((= year_r 6) (setq year_r 2026))
		((= year_r 7) (setq year_r 2027))
		((= year_r 8) (setq year_r 2028))
		((= year_r 9) (setq year_r 2029))
		((= year_r 10) (setq year_r 2030))
		);Establece el año dependiendo de la posición de la lista que haya retornado la caja de diálogo 1

(if (and (= mes_r 1) (or (= year_r 2020) (= year_r 2024) (= year_r 2028))) (progn (setq nm "Febrero") (setq dias d29))
  );Establece la lista de d29 a la list_box de días si el año es bisiesto (2020,2024 o 2028) y el mes seleccionado fue Febrero

(setq cerrada2 0);Verifica por cuál botón se cierra la caja (se mantendrá en 0 si la caja se cierra por el botón cancel y se le asignará el valor de 1 sí la caja se cierra por el botón "Guardar"
(if (= cerrada 1);Solo sí la caja 1 fue cerrada con el botón "Guardar y establecer día" se cargará la caja 2
(progn (new_dialog "dias" archivo);Abre la caja de diálogo 2, aquí solo se establece el día (se creo otra caja de diálogo para establecer el día debido a que no encontré la manera de cambiar la cantidad de días (cambiar la lista) una vez la caja es abierta, por ejemplo si selecciono el mes de febrero, quería que los días pasarán de 31 a 29, pero no encontré la manera

(start_list "dia")
(mapcar 'add_list dias);Llena el list_box de los días
(end_list)

(action_tile "save" "(setq cerrada2 1) (done_dialog)");Cierra la caja cuando se presione el botón "Guardar"
(action_tile "dia" "(setq dia_r (atoi $value))");Guarda la posición seleccionada de la lista de días en la variable dia_r
(start_dialog))
  )

(if (= cerrada2 1) 
(alert (strcat "Recordatorio" " " "*" record_r "*" " " "establecido para el" " " (itoa (+ dia_r 1)) " " "de" " " nm " " "de" " " (itoa year_r)))
  )
 )
  
