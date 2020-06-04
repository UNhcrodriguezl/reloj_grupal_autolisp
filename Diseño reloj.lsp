;Funciones vl
(vl-load-com)
(vl-load-reactors)
(vlr-remove-all)

;Funcion de borrado
(defun c:borrar ()
			(vl-cmdf "_erase" "_all" ""))

;punto base
(setq	base '(0 0)
			listaobj '(""))

;parte reloj digital (1)
(vl-cmdf "_color" 7)
(vl-cmdf "_rectang" base '(1600 750))
(setq digital (entget (entlast)))

(vl-cmdf "_rectang" '(200 200) '(1400 550))

(vl-cmdf "_color" 1)
(vl-cmdf "_rectang" '(250 250) '(550 500))

(vl-cmdf "_rectang" '(700 250) '(1000 500))

(vl-cmdf "_rectang" '(1050 250) '(1300 350))

(vl-cmdf "_rectang" '(1050 400) '(1350 500))

(vl-cmdf "_circle" '(625 325) 25)

(vl-cmdf "_circle" '(625 425) 25)

;parte reloj analogico (2)
(vl-cmdf "_color" 7)
(vl-cmdf "_rectang" '(0 750) '(1600 2350))

(vl-cmdf "_rectang" '(200 950) '(1400 2150))

(vl-cmdf "_color" 1)
(vl-cmdf "_circle" '(800 1550) 550)

;parte alarma (4)
(vl-cmdf "_color" 7)
(vl-cmdf "_rectang" '(1650 0) '(3250 750))

(vl-cmdf "_rectang" '(1850 200) '(3050 550))

(vl-cmdf "_color" 1)
(vl-cmdf "_rectang" '(1900 250) '(2200 500))

(vl-cmdf "_rectang" '(2350 250) '(2650 500))

(vl-cmdf "_rectang" '(2700 250) '(2950 350))

(vl-cmdf "_rectang" '(2700 400) '(3000 500))

(vl-cmdf "_circle" '(2275 325) 25)

(vl-cmdf "_circle" '(2275 425) 25)

;parte temporizador (5)
(vl-cmdf "_color" 7)
(vl-cmdf "_rectang" '(1650 800) '(3250 1550))

(vl-cmdf "_rectang" '(1850 1000) '(3050 1350))

(vl-cmdf "_color" 1)
(vl-cmdf "_rectang" '(1900 1050) '(2200 1300))

(vl-cmdf "_rectang" '(2350 1050) '(2650 1300))

(vl-cmdf "_rectang" '(2700 1050) '(2950 1150))

(vl-cmdf "_rectang" '(2700 1200) '(3000 1300))

(vl-cmdf "_circle" '(2275 1125) 25)

(vl-cmdf "_circle" '(2275 1225) 25)

;parte recordatorio (6)
(vl-cmdf "_color" 7)
(vl-cmdf "_rectang" '(1650 1600) '(3250 2350))

(vl-cmdf "_rectang" '(1850 1800) '(3050 2150))

;parte calendario (7)
(vl-cmdf "_color" 7)
(vl-cmdf "_rectang" '(3300 0) '(4900 750))

(vl-cmdf "_rectang" '(3500 200) '(4700 550))

;parte zona horaria (8)
(vl-cmdf "_color" 7)
(vl-cmdf "_rectang" '(3300 800) '(4900 1550))

(vl-cmdf "_rectang" '(3500 1000) '(4700 1350))

(vl-cmdf "_color" 1)
(vl-cmdf "_rectang" '(3550 1050) '(3850 1300))

(vl-cmdf "_rectang" '(4000 1050) '(4300 1300))

(vl-cmdf "_rectang" '(4350 1050) '(4600 1150))

(vl-cmdf "_rectang" '(4350 1200) '(4650 1300))

(vl-cmdf "_circle" '(3925 1125) 25)

(vl-cmdf "_circle" '(3925 1225) 25)

;parte cronometro (9)
(vl-cmdf "_color" 7)
(vl-cmdf "_rectang" '(3300 1600) '(4900 2350))

(vl-cmdf "_rectang" '(3500 1800) '(4700 2150))

(vl-cmdf "_color" 1)
(vl-cmdf "_rectang" '(3550 1850) '(3850 2100))

(vl-cmdf "_rectang" '(4000 1850) '(4300 2100))

(vl-cmdf "_rectang" '(4350 1850) '(4600 1950))

(vl-cmdf "_rectang" '(4350 2000) '(4650 2100))

(vl-cmdf "_circle" '(3925 1925) 25)

(vl-cmdf "_circle" '(3925 2025) 25)

;parte cronografo (3)
(vl-cmdf "_color" 7)
(vl-cmdf "_rectang" '(4950 0) '(5700 750))

(vl-cmdf "_rectang" '(5100 150) '(5550 600))

(vl-cmdf "_rectang" '(4950 800) '(5700 1550))

(vl-cmdf "_rectang" '(5100 950) '(5550 1400))

(vl-cmdf "_rectang" '(4950 1600) '(5700 2350))

(vl-cmdf "_rectang" '(5100 1750) '(5550 2200))

(vl-cmdf "_color" 1)
(vl-cmdf "_circle" '(5325 375) 200)

(vl-cmdf "_circle" '(5325 1175) 200)

(vl-cmdf "_circle" '(5325 1975) 200)

(vla-zoomextents "")
