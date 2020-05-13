;Jorge Alejandro Avellaneda
;modulo para la funcionalidad de voz para el reloj
;para usarlo cargar (load "voz.lsp") y usarlo con el comando (voz "texto")
(vl-load-com) 

(defun Voz (str)
  (setq tts (vlax-create-object "Sapi.SpVoice"));crea el objeto tts
  (vlax-invoke tts "Speak" str 0) ;invoca o llama el objeto tts
  (vlax-release-object tts) ; libera el objeto tts
)


