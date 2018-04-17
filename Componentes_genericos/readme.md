En esta carpeta se presentan todos los componentes utiles para las seisones,
TODAS FUNCIONAN DE MANERA GENERICA.
A continuacion se presentara una lista de los modulos y los parametros de entrada:

1-  Contador:
Entradas: input logic clk, input logic reset, output logic [n_bits-1,0] contador
Parametros: COUNTER_MAX
Descripcion: genera un contador donde COUNTER_MAX es el valor maximo al cual puede contar, luego de llegar a este valor
el contador se reinicia, si se apreta reset, el contador se reinicia, n_bits se calcula internamente para ajustarse al
valor de bits necesarios para contar hasta COUNTER_MAX.
