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