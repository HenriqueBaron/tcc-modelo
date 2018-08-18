syms x;         % Deslocamento vertical
m = 1.565;      % Massa total do rotor
e = 10e-3;      % Afastamento do centro de massa do rotor
c_i = 0;        % Amortecimento interno do eixo
c = 0;          % Amortecimento externo do sistema
d_eixo = 0.02;  % Diâmetro do eixo
L_eixo = 0.4;   % Comprimento do eixo
E = 200e9;      % Módulo de elasticidade do aço
N = 1800;       % Velocidade de rotação, em revoluções por minuto

% Rigidez do eixo
A = pi*d_eixo^2/4; % Seção transversal do eixo
k = A*E/L_eixo;

% Velocidade angular
omega = N*pi/30;

t = 0:0.001:1; % Vetor tempo

