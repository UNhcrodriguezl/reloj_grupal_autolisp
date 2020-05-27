;Felipe Rojas y Mario Lopez
;Este programa busca determinar la cantidad de segundos que esta descuadrado el reloj y graficar este dato en excel
;En los comentarios se menciona donde debe ir cada seccion y que variables deben relacionarse con el codigo principal 

(vl-load-com)  

;con las siguientes funciones se abre la hoja de excel en la que se va a trabajar
;esta seccion del codigo debe insertarse fuera del repeat 
(setq Excel (vlax-get-or-create-object "excel.application"))
(setq Coleccionlibros(vlax-get-property Excel "Workbooks"))
(setq Libro (vlax-invoke-method Coleccionlibros "add"))
(setq Coleccionhojas (vlax-get-property Libro "Sheets"))
(setq hoja (vlax-get-property Coleccionhojas "Item" 1))
(setq celdas (vlax-get-property hoja "Cells"))
(setq Rango (vlax-get-property celdas "Range" "A1:A60")) ;para determinar el valor de A60 debe tomarse la cantidad de veces que se repite el programa y sumarle una unidad (si el repeat corre 10 veces el valor A60 debe cambiarse por A11)
(setq Rango_select (vlax-invoke-method Rango "Select"))
(vla-put-visible Excel :vlax-true)
(vlax-put-property celdas "Item" 1 1 (vl-princ-to-string "Cantidad de segundo que esta descuadrado el reloj"))
(setq contador_e 2)
(setq grafico (vlax-get-property hoja "Shapes")
      grafico (vlax-invoke-method grafico "AddChart2" "240, xlXYScatterLines")
      grafico (vlax-invoke-method grafico "Select")
      )


;La siguiente parte del codigo debe colocarse dentro del repeat
(setq fecha_hora_e (rtos (getvar "cdate") 2 6)
      minuto_t_e(substr fecha_hora_e  12 2)
      minuto_e(atoi minuto_t_e)
      segundo_t_e(substr fecha_hora_e 14 2)
      segundo_e(atoi segundo_t_e)
	)

(setq tiempo_reloj (+ (* minuto 60) segundo);las variables minuto y segundo deben reemplazarse por la variable que guarde la informacion del minuto y del segundo que marca el reloj en cada instante 
      )

(setq error (- tiempo_reloj tiempo_real))
(vlax-put-property celdas "Item" contador_e 1 (vl-princ-to-string error))
(setq contador_e (1+ contador_e))







