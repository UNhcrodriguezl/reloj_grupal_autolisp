//--------------------------Reactores--------------------------

Menu_reactor: dialog{
	label = "Menu reloj";
	:boxed_column{ 
		label = "Opciones";
		:radio_button{
			label = "Cambiar color reloj";
			key = "b1";
		}
		:radio_button{
			label = "Cambiar texto reloj";
			key = "b2"; 
		}
		:radio_button{
			label = "Iniciar temporizador";
			key = "b3";
		}
	}
	ok_cancel;
}

Texto_reactor: dialog{
	label = "Menu texto";
	:boxed_column{ 
		label = "Opciones";
		:edit_box{
			label = "Ingrese horas: ";
			min_value = 0;
			max_value = 23;
			key = "hs";
		}
		:edit_box{
			label = "Ingrese minutos: ";
			min_value = 0;
			max_value = 59;
			key = "ms";
		}
		:edit_box{
			label = "Ingrese segundos: ";
			min_value = 0;
			max_value = 59;
			key = "ss";
		}
	}
	ok_cancel;
}

Color_reactor: dialog{
	label = "Menu reloj";
	:boxed_column{
		label = "Color";
		:text{
			label = "Color";
		}
		:slider{
			min_value = 0;
			max_value = 255;
			value = "125";
			key = "colorR";
		}
		:image{
		key = "imgColorR";
		height = 1;
     	width = 1;
		}
		:edit_box{
		label = "Establecer";
		key = "EstablecerR";
		}
		:popup_list{
			key = "shapes";
		}
		:button{
			label = "Cambiar";
			key = "ch";
		}
	}
	ok_cancel;
}

//------------------------Temporizador---------------------------

temporizador : dialog {
	label="Temporizador";
	:row{
		:column{
			:edit_box{
				label="Hora";
				key = "hora";
			}
			: slider {			
	        key = "horaSlider" ;	
	        max_value = 24;	
	        min_value = 0;		
	        value = "0";		
	      }
     	}
     	:column{
			:edit_box{
				label="Minutos";
				key = "minu";
			}
			: slider {			
	        key = "minuSlider" ;	
	        max_value = 59;	
	        min_value = 0;		
	        value = "0";		
	      }
	   }
      :column{
			:edit_box{
				label="Segundos";
				key = "secu";
			}
			: slider {			
	        key = "secuSlider" ;	
	        max_value = 59;	
	        min_value = 0;		
	        value = "0";		
	      }
		}
	}
  	ok_cancel;
}



//--------------------------Cronometro----------------------------
CDCronometro1 : dialog {
  label="Cronometro Digital";
  :row{
    :button{
      label="Dibujar";
      key="Draw";
    }
  }
  ok_cancel;
}

CDCronometro2 : dialog {
  label="Cronometro Digital";
  :button{
      label="Abrir el Cronometro";
      key="Open";
  }
  ok_cancel;
}

CDCronometro3 : dialog {
  label="Cronometro Digital";
  :button{
      label="Actualizar Dibujo";
      key="Fresh";
  }
  ok_cancel;
}

//--------------------------Zonas Horarias----------------------------

UTCs: dialog {
  label= "Cambio de hora";
    :row {
      label= "Seleccione hora de pais o la ciudad";
      :list_box{
         key="ciudad";
         width=38; 
         list="";
         value=0;
         allow_accept=true;
      }
    }     
  ok_cancel;
}

//--------------------------Alarma------------------------------------

CDSetalarm: dialog {
  label= "Fijar una Alarma";
    :row{
      label="Configurar hora y minutos";
      :edit_box{
        label="Hora (00 a 23)";
        key="horset";
      }
      :edit_box{
        label="Minutos (00 a 59)";
        key="minset";
      }
    }
  ok_cancel;
}