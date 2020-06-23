;Jorge Alejandro Avellaneda
;modulo para la funcionalidad de voz para el reloj
;para usarlo cargar (load "voz.lsp") y usarlo con el comando (voz "texto")
(vl-load-com) 

(defun Voz (str)
  (setq tts (vlax-create-object "Sapi.SpVoice"));crea el objeto tts
  (vlax-invoke tts "Speak" str 0) ;invoca la funcion Speak el objeto tts
  (vlax-release-object tts) ; libera el objeto tts
)

(defun timeToString (hora minuto / str)
  (strcat (itoa hora) " horas y " (itoa minuto) " minutos")
)

(defun dateToString (dia mes ano / str)
  (strcat (itoa dia) " de " mes " del año " (itoa ano))
)