% DIAGRAMA DE BODE Y MÁRGENES DE ESTABILIDAD - EJERCICIO 2
clear; clc; close all;

% 1. Parámetros del sistema
f_z1 = 85e3;    w_z1 = 2*pi*f_z1;
f_p1 = 110e3;   w_p1 = 2*pi*f_p1;
f_n  = 130e3;   w_n  = 2*pi*f_n;
f_d  = 120e3;   a_d  = 2*pi*f_d;

% 2. Definición de la Función de Transferencia G2(s)
K = 5e13;
num = K * [1, w_z1];
den = conv([1, 0], conv([1, w_p1], [1, a_d, w_n^2]));
G2 = tf(num, den);

% 3. Opciones del Diagrama de Bode
opts = bodeoptions;
opts.FreqUnits = 'Hz';
opts.Grid = 'on';
opts.Title.String = 'Diagrama de Bode - Ejercicio 2';

% 4. Gráfica de Bode con márgenes
figure('Name', 'Diagrama de Bode Ejercicio 2', 'Color', 'w');
margin(G2, opts);

% 5. Obtención e impresión de parámetros
[Gm, Pm, Wcg, Wcp] = margin(G2);
Gm_dB = 20*log10(Gm);
f_pc_Hz = Wcg / (2*pi); % Frecuencia de cruce de fase (-180 deg)
f_gc_Hz = Wcp / (2*pi); % Frecuencia de cruce de ganancia (0 dB)

fprintf('=======================================================\n');
fprintf('           PUNTOS DE CORTE Y MÁRGENES (EJERCICIO 2)     \n');
fprintf('=======================================================\n');
fprintf('Corte en -180 deg (w_pc) : %.4e rad/s (%.2f kHz)\n', Wcg, f_pc_Hz/1e3);
fprintf(' -> Margen de Ganancia   : %.2f dB\n', Gm_dB);
fprintf('-------------------------------------------------------\n');
fprintf('Corte en 0 dB (w_gc)     : %.4e rad/s (%.2f kHz)\n', Wcp, f_gc_Hz/1e3);
fprintf(' -> Margen de Fase       : %.2f deg\n', Pm);
fprintf('=======================================================\n');

if Gm_dB > 0 && Pm > 0
    fprintf('JUICIO DE ESTABILIDAD: El sistema en lazo cerrado es ESTABLE.\n');
else
    fprintf('JUICIO DE ESTABILIDAD: El sistema en lazo cerrado es INESTABLE.\n');
end
fprintf('=======================================================\n');



