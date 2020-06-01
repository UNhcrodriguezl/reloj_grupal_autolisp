# reloj_grupal_autolisp
# Recordatorio

**Manuel Nicolás Castiblanco Avendaño**

**Computación Gráfica 2020-1**

## **IMPORTANTE**
##### -LA CARPETA DONDE SE GUARDEN LOS DOS ARCHIVOS DEBE SER CONOCIDA POR AUTOCAD
##### -SI SE DESEA ESTABLECER UN BOTÓN PARA CREAR UN RECORDATORIO SE RECOMIENDA VER ESTE VÍDEO Y EN EL CAMPO DE MACRO PONER `(recordatorio)` https://www.youtube.com/watch?v=TdH29Y_bjKQ
##### -ADICIONALMENTE EN EL CÓDIGO PRINCIPAL SE DEBE COLOCAR UNA PEQUEÑA PARTE DE CÓDIGO DONDE SE VAYA COMPARANDO LA FECHA ACTUAL DEL RELOJ CON LA ASIGNADA EN EL RECORDATORIO 

##### EJEMPLO: 

`(if (and (= dia_ ;día actual del reloj (+ dia_r ;día establecido en el recordatorio 1)) (= mes_ ;mes actual del reloj (+ mes_r ;mes establecido en el recordatorio 1)) (and (= on_off 0) (= año_ ;año actual del reloj year_r ;año establecido en el recordatorio))) (progn (setq on_off 1) (alert record_r))
		  )`

 **INSTRUCCIONES**
1. Cargar `recordatorio.lsp` .
2. En caso de no haber creado el botón como se sugirió anteriormente, ejecutar el comando `(recordatorio)` para abrir la caja de diálogo. 
3. Una vez puestos los datos de la primera caja (Mes, Año y Etiqueta) se abrirá una segunda donde deberá seleccionar únicamente el día .
