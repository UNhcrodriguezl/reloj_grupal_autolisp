record : dialog{
		label = "Establecer recordatorio";
		:boxed_column {
				label = "Fecha";
			: popup_list {
				label = "Mes";
				key = "mes";
				edit_width = 12;
				list = "";
				value = 0;
				allow_accept = true; 
			}
			: popup_list {
				label = "Año";
				key = "year";
				edit_width = 6;
				list = "";
				value = 0;
				allow_accept = true; 
			}
							}
		: boxed_row {
			: edit_box {
				label = "Etiqueta";
				key = "rec";
				}
				}
		: boxed_row {
			: button {
				label = "Guardar y establecer día";
				key = "save";
				}
			cancel_button;
			}
			
		}

dias : dialog{
	label = "Seleccione el día";
     : boxed_column {
     		label = "Fecha";
     	: list_box {
		label = "Día";
		key = "dia";
		value = 0;
		allow_accept = true;
		}
		
     }
     :button {
     		label = "Guardar";
     		key = "save";
     		}
     cancel_button;
}
