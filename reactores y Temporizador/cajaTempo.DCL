temporizador : dialog {
	label="Temporizador";
	:row{
		:edit_box{
			label="pos X";
			key = "px";
		}
		:edit_box{
			label="pos Y";
			key = "py";
		}
	}
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

