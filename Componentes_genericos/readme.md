# Componentes Generales
## Descripcion
En esta carpeta se presentan todos los componentes utiles para las seisones,
TODAS FUNCIONAN DE MANERA GENERICA.

## Modulos

1. mod_contador:
  * Entradas: input logic clk; input logic reset; output logic [n_bits-1,0] contador
  * Parametros: COUNTER_MAX
  * Descripcion: genera un contador donde COUNTER_MAX es el valor maximo al cual puede contar, luego de llegar a este valor
el contador se reinicia, si se apreta reset, el contador se reinicia, n_bits es el numero de bits del contador y se calcula internamente para ajustarse al valor de bits necesarios para contar hasta COUNTER_MAX.
2. mod_clk_variable:
  * Entradas: input logic clk_in; input logic reset; output logic clk_out;
  * Parametros: frecuency
  * Descripcion: Genera un reloj de frecuencia variable, donde el parametro frecuency ajusta la frecuencia de clk_out en donde clk_in corresponde a un reloj de 100MHz
