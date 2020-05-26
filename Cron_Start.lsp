;Base del cronometro
(setq s_cnt 0
      m_cnt 0
      h_cnt 0
      start T
)

(setq s_cnt2 "00"
      m_cnt2 "00"
      h_cnt2 "00"
      texto  (strcat h_cnt2 ":" m_cnt2 ":" s_cnt2)
)

(vl-cmdf "_text" "J" "C" "0,0" 18 0 texto)
(setq ENT (entlast)
	    OBJ (vlax-ename->vla-object ENT)
)

(setq TXT (vlax-get-property OBJ "TextString"))

(setq c 1)
;------------------------------------------------------------------------------------------------------------------------

(defun startcron ()
  (while (<= s_cnt 30) 
    ;Aumenta minutos
    (if (= s_cnt 60)
        (setq s_cnt 0
              m_cnt (1+ m_cnt)
        )
    )
    ;Aumenta horas
    (if (= m_cnt 60)
        (setq m_cnt 0
              h_cnt (1+ h_cnt)
        )
    )
    
    ;Crea Textos
    (if (<= s_cnt 9)
        (setq s_cnt2 (strcat "0" (rtos s_cnt)))
        (setq s_cnt2 (rtos s_cnt))
    )
    (if (<= m_cnt 9)
        (setq m_cnt2 (strcat "0" (rtos m_cnt)))
        (setq m_cnt2 (rtos m_cnt))
    )
    (if (<= h_cnt 9)
        (setq h_cnt2 (strcat "0" (rtos h_cnt)))
        (setq h_cnt2 (rtos h_cnt))
    )           

    (setq texto2  (strcat h_cnt2 ":" m_cnt2 ":" s_cnt2))
    (vlax-put-property OBJ "TextString" texto2)
                
    ;Aumenta los segundos
    (setq s_cnt (1+ s_cnt))
    
    (vl-cmdf "delay" 1000)
  )    
)




