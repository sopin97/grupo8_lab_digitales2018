# Componentes Generales
## Descripcion
En esta carpeta se presentan todos los componentes utiles para las seisones,
TODAS FUNCIONAN DE MANERA GENERICA.

## Modulos

### mod_contador:
  1. Entradas: 
  > * input logic clk
  > * input logic reset
  > * output logic [n_bits-1:0] contador
  2. Parametros:
  > * COUNTER_MAX
  3. Descripcion:
  > * genera un contador donde COUNTER_MAX es el valor maximo al cual puede contar, luego de llegar a este valor
el contador se reinicia, si se apreta reset, el contador se reinicia, n_bits es el numero de bits del contador y se calcula internamente para ajustarse al valor de bits necesarios para contar hasta COUNTER_MAX.
### mod_clk_variable:
  1. Entradas:
   > * input logic clk_in
   > * input logic reset
   > * output logic clk_out
  2. Parametros:
   > * frecuency
  3. Descripcion:
   > * Genera un reloj de frecuencia variable, donde el parametro frecuency ajusta la frecuencia de clk_out en donde clk_in corresponde a un reloj de 100MHz, si reset es 1, el clk_out es 0.
### mod_ALU_generalizado
  1. Entradas:
   > * input logic [n_bits-1:0] entrada_a, entrada_b
   > * input logic [2:0] operacion
   > * output logic [n_bits-1:0] resultado
  2. Parametros:
   > * n_bits
  3. Descripcion:
   > * arroja un resultado de acuerdo a la operacion escogida
   >> * **3'b001:** resultado = entrada_a + entrada_b
   >> * **3'b010:** resultado = entrada_a - entrada_b
   >> * **3'b011:** resultado = entrada_a AND entrada_b
   >> * **3'b100:** resultado = entrada_a OR entrada_b
   >> * **default:** resultado = 'd0
### mod_debouncer
  1. Entradas:
   > * input logic clk, PB
   > * output logic PB_state, PB_down, PB_up
  2. Descripcion:
   > * Genera una salida del boton estable, ocupa un contador de 16 bit, por lo que el tiempo de muestreo sera 16/frecuencia_del_reloj
### mod_debouncer2
  1. Entradas:
   > * input logic clk, rst, PB
   > * output logic PB_state, PB_negedge, PB_posedge
  3. Descripcion:
   > * Genera una salida del boton estable, ocupa un contador de 16 bit, por lo que el tiempo de muestreo sera 16/frecuencia_del_reloj
### mod_display_32bit
  1. Entradas:
   > * input logic [31:0] numero_entrada
   > * input logic power_on, clk
   > * output logic [6:0] SEG
   > * output logic [7:0] ANODO
  3. Descripcion:
   > * muestra en 8 displays un numero de 32 bit a una frecuencia de 480Hz, clk es un reloj de 100MHz, power_on enciende y apga el display.
### mod_retainer
  1. Entradas:
   > * input logic clk, reset, retain
   > * input logic [N-1:0] switches
   > * output logic [N-1:0] retain_output
  2. Parametros:
   > * N
  3. Descripcion:
   > * Si retain = 0, retain_output tiene el mismo valor que switches, si retain = 0, retain_output guarda el ultimo valor registrado, si reset vale 1, la salida vale 0.
   
