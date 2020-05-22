# Reloj Grupal Autolisp
Repositorio Reloj-Grupal Computacion Grafica 2020-1.
 
# Función para el reloj análogo
#### **Autor**: _Juan Camilo Cárdenas Gómez_ ([Github](https://github.com/juaccardenasgom)).
Esta función inserta los bloques del reloj análogo en un punto dado y mueve sus manecillas con comandos vl.
## Requerimientos
1. **Esta función toma precedencia sobre todas las demás y no debería ejecutarse esperando que el sistema responda a otros eventos mientras está en ejecución.**
2. Debe existir un archivo general donde se encuentren las definiciones de los bloques del reloj: Cuerpo, Segundero, Minutero, Horario. **No funciona con rutas hacia los archivos de los bloques**

## Uso
```
(analog x y c_ref h_ref m_ref s_ref)
```
### Parámetros
- *x* [Número] Coordenada X del punto de inserción de los bloques
- *y* [Número] Coordenada Y del punto de inserción de los bloques
- *c_ref* [String] Nombre del bloque del cuerpo del reloj
- *h_ref* [String] Nombre del bloque del horario del reloj
- *m_ref* [String] Nombre del bloque del minutero cuerpo del reloj
- *s_ref* [String] Nombre del bloque del segundero del reloj


