;El siguiente código funciona como un calendiario que indica un dato
;asociado a la fecha tipo "un dia como hoy pero en 19XX nació el escritor..."
;Esto lo hace al extraer la información de un .txt, que consta de tres columnas
;la primera corresponde al dia, la segunda al mes y la tercera al dato asociado
; compara las dos primeras con los datos obtenidos del Cdate e imprime la tercer columna

(defun c:calendario()
  
    (setq file (open (findfile "calendario.txt") "r"))
    (while (setq line (read-line file))
      (setq l (list nil))
    (while (> (setq pos (vl-string-search "**" line)) 0)
          (setq value (substr line 1 pos))
          (setq line (vl-string-left-trim "**" (vl-string-left-trim value line)))
          (setq l (append l (list value)))
    )
       (imprimir (append (cdr l) (list line)))
  )
   (close file)
 )
(defun imprimir (info)
  (setq a (nth 0 info)
        b (nth 1 info)
        c (nth 2 info))
  ;Hay dos opciones para imprimir, la primera es un texto que se añada al reloj
  ;la segunda es un cuadro de "alerta" que se imprime cada cambio de dia
(if (= b "27") (if (= a "5") (command "_text" "0, 0" 500 "0" c "")))
  (if (= b "27") (if (= a "5") (alert c)))
  )
;la fecha por defecto es 5/27, pero la idea es comparar a y b con el dia y mes que lea el reloj general

;supuse que hay varias funciones que se ejecutan al cambiar el dia, así que pense en implementar
;un  "if" en la funcion principal que llame a la función una vez al día. 

;Está lista para la implementación...