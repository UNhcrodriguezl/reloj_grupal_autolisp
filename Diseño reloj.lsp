;Funciones vl
(vl-load-com)
(vl-load-reactors)
(vlr-remove-all)

;Funciones
(defun c:borrar ()
			(vl-cmdf "_erase" "_all" ""))
(defun c:ver ()
			(setq xd (getint "Parte que quiere ver (1-9): ")
			     	xd2 (nth xd listaobj))
			(vl-cmdf "_zoom" "_o" xd2 ""))
(defun c:vertodo ()
			(vla-zoomextents (vlax-get-acad-object)))
	
						
;variables
(setq	basedig1 '(0 0)
			basedig2 '(1600 750)
			basedig3 '(50 600)
			baseanl1 '(0 750)
			baseanl2 '(1600 2350)
			baseanl3 '(50 2200)
			basealm1 '(1650 0)
			basealm2 '(3250 750)
			basealm3 '(1700 600)
			basetemp1 '(1650 800)
			basetemp2 '(3250 1550)
			basetemp3 '(1700 1400)
			baserecor1 '(1650 1600)
			baserecor2 '(3250 2350)
			baserecor3 '(1700 2200)
			basecal1 '(3300 0)
			basecal2 '(4900 750)
			basecal3 '(3350 600)
			basezhor1 '(3300 800)
			basezhor2 '(4900 1550)
			basezhor3 '(3350 1400)
			basecrono1 '(3300 1600)
			basecrono2 '(4900 2350)
			basecrono3 '(3350 2200)
			listaobj '("0"))

;parte reloj digital (1)
(vl-cmdf "_color" 7)
(vl-cmdf "_rectang" basedig1 basedig2)
(setq dig (ssget "W" basedig1 basedig2)
			listaobj (cons dig listaobj))

(vl-cmdf "_rectang" '(200 200) '(1400 550))

(vl-cmdf "_color" 30)
(vl-cmdf "_text" basedig3 100 0 "1. Digital")

(vl-cmdf "_color" 1)
(vl-cmdf "_rectang" '(250 250) '(550 500))

(vl-cmdf "_rectang" '(700 250) '(1000 500))

(vl-cmdf "_rectang" '(1050 250) '(1300 350))

(vl-cmdf "_rectang" '(1050 400) '(1350 500))

(vl-cmdf "_circle" '(625 325) 25)

(vl-cmdf "_circle" '(625 425) 25)

;parte reloj analogico (2)
(vl-cmdf "_color" 7)
(vl-cmdf "_rectang" baseanl1 baseanl2)
(setq analogo (ssget "W" baseanl1 baseanl2)
			listaobj (cons analogo listaobj))

(vl-cmdf "_rectang" '(200 950) '(1400 2150))

(vl-cmdf "_color" 30)
(vl-cmdf "_text" baseanl3 100 0 "2. Analogo")

(vl-cmdf "_color" 1)
(vl-cmdf "_circle" '(800 1550) 550)

;parte alarma (4)
(vl-cmdf "_color" 7)
(vl-cmdf "_rectang" basealm1 basealm2)
(setq alarma (ssget "W" basealm1 basealm2)
			listaobj (cons alarma listaobj))

(vl-cmdf "_rectang" '(1850 200) '(3050 550))

(vl-cmdf "_color" 30)
(vl-cmdf "_text" basealm3 100 0 "3. Alarma")

(vl-cmdf "_color" 1)
(vl-cmdf "_rectang" '(1900 250) '(2200 500))

(vl-cmdf "_rectang" '(2350 250) '(2650 500))

(vl-cmdf "_rectang" '(2700 250) '(2950 350))

(vl-cmdf "_rectang" '(2700 400) '(3000 500))

(vl-cmdf "_circle" '(2275 325) 25)

(vl-cmdf "_circle" '(2275 425) 25)

;parte temporizador (5)
(vl-cmdf "_color" 7)
(vl-cmdf "_rectang" basetemp1 basetemp2)
(setq temp (ssget "W" basetemp1 basetemp2)
			listaobj (cons temp listaobj))

(vl-cmdf "_rectang" '(1850 1000) '(3050 1350))

(vl-cmdf "_color" 30)
(vl-cmdf "_text" basetemp3 100 0 "4. Temporizador")

(vl-cmdf "_color" 1)
(vl-cmdf "_rectang" '(1900 1050) '(2200 1300))

(vl-cmdf "_rectang" '(2350 1050) '(2650 1300))

(vl-cmdf "_rectang" '(2700 1050) '(2950 1150))

(vl-cmdf "_rectang" '(2700 1200) '(3000 1300))

(vl-cmdf "_circle" '(2275 1125) 25)

(vl-cmdf "_circle" '(2275 1225) 25)

;parte recordatorio (6)
(vl-cmdf "_color" 7)
(vl-cmdf "_rectang" baserecor1 baserecor2)
(setq recor (ssget "W" baserecor1 baserecor2)
			listaobj (cons recor listaobj))

(vl-cmdf "_rectang" '(1850 1800) '(3050 2150))

(vl-cmdf "_color" 30)
(vl-cmdf "_text" baserecor3 100 0 "5. Recordatorio")

;parte calendario (7)
(vl-cmdf "_color" 7)
(vl-cmdf "_rectang" basecal1 basecal2)
(setq cal (ssget "W" basecal1 basecal2)
			listaobj (cons cal listaobj))

(vl-cmdf "_rectang" '(3500 200) '(4700 550))

(vl-cmdf "_color" 30)
(vl-cmdf "_text" basecal3 100 0 "6. Calendario")

;parte zona horaria (8)
(vl-cmdf "_color" 7)
(vl-cmdf "_rectang" basezhor1 basezhor2)
(setq zhor (ssget "W" basezhor1 basezhor2)
			listaobj (cons zhor listaobj))

(vl-cmdf "_rectang" '(3500 1000) '(4700 1350))

(vl-cmdf "_color" 30)
(vl-cmdf "_text" basezhor3 100 0 "7. Zona Horaria")

(vl-cmdf "_color" 1)
(vl-cmdf "_rectang" '(3550 1050) '(3850 1300))

(vl-cmdf "_rectang" '(4000 1050) '(4300 1300))

(vl-cmdf "_rectang" '(4350 1050) '(4600 1150))

(vl-cmdf "_rectang" '(4350 1200) '(4650 1300))

(vl-cmdf "_circle" '(3925 1125) 25)

(vl-cmdf "_circle" '(3925 1225) 25)

;parte cronometro (9)
(vl-cmdf "_color" 7)
(vl-cmdf "_rectang" basecrono1 basecrono2)
(setq crono (ssget "W" basecrono1 basecrono2)
			listaobj (cons crono listaobj))

(vl-cmdf "_rectang" '(3500 1800) '(4700 2150))

(vl-cmdf "_color" 30)
(vl-cmdf "_text" basecrono3 100 0 "8. Cronometro")

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
(setq cronog (ssget "W" '(4950 0) '(5550 2200))
			listaobj (cons cronog listaobj))

(vl-cmdf "_color" 30)
(vl-cmdf "_text" '(5850 750) 100 90 "9. Cronografo")

(vl-cmdf "_color" 1)
(vl-cmdf "_circle" '(5325 375) 200)

(vl-cmdf "_circle" '(5325 1175) 200)

(vl-cmdf "_circle" '(5325 1975) 200)

(setq listaobj (reverse listaobj))

(vla-zoomextents (vlax-get-acad-object))
