(defun analog (x y c_ref h_ref m_ref s_ref)
  (vl-load-com)

  (setq
    insertion_point (vlax-3D-point x y)
    acad_object (vlax-get-acad-object)
    active_document (vla-get-ActiveDocument acad_object)
    modelspace (vla-get-modelspace active_document)
    date (rtos (getvar "CDATE") 2 6)
    h (atoi (substr date 10 2))
    m (atoi (substr date 12 2))
    s (atoi (substr date 14 2))
    h_delta -0.000145444
    m_delta -0.00174533
    s_delta -0.10472
    h_rot (* h_delta (+ (* 3600 h) (* 60 m) s)) 
    m_rot (* m_delta (+ (* 60 m) s)) 
    s_rot (* s_delta s) 
    c_block (vla-InsertBlock modelspace insertion_point c_ref 1 1 1 0)
    h_block (vla-InsertBlock modelspace insertion_point h_ref 1 1 1 h_rot)
    m_block (vla-InsertBlock modelspace insertion_point m_ref 1 1 1 m_rot)
    s_block (vla-InsertBlock modelspace insertion_point s_ref 1 1 1 s_rot)
  )

  (vla-ZoomAll acad_object)

  (defun silent(com val)
    (setq old (getvar "cmdecho"))
    (setvar "cmdecho" 0)
    (vl-cmdf com val)
    (setvar "cmdecho" old)
  )

  (silent "_vscurrent" "_r")

  (while 
    (setq s (rem (1+ s) 60))
    (if (= s 0) (progn
      (setq m (rem (1+ m) 60))
      (if (= m 0)
        (setq h (rem (1+ h) 24))
      ))
    )
    
    (vla-rotate h_block insertion_point h_delta)
    (vla-rotate m_block insertion_point m_delta)
    (vla-rotate s_block insertion_point s_delta)

    (silent "_.delay" 1000)
  )
)