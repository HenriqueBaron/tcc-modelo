% Calcula a vibra��o de um sistema eixo-rotor desbalanceado analisando um
% ponto com 2 graus de liberdade.

t0 = 0;         % Instante inicial
tf = 0.5;       % Instante final
dt = 0.0005;    % Resolu��o do tempo
m = 1.565;      % Massa total do rotor
e = 10e-3;      % Afastamento do centro de massa do rotor
c_i = 0;        % Amortecimento interno do eixo
c = 0;          % Amortecimento externo do sistema
d_eixo = 0.02;  % Di�metro do eixo
L_eixo = 0.4;   % Comprimento do eixo
E = 200e9;      % M�dulo de elasticidade do a�o
N = 1800;       % Velocidade de rota��o, em revolu��es por minuto

% Rigidez do eixo
A = pi*d_eixo^2/4; % Se��o transversal do eixo
k = A*E/L_eixo;

% Velocidade angular
omega = N*pi/30;

% Fun��es de posi��o nos dos eixos e suas derivadas
syms x(t) y(t);
dx = diff(x);
ddx = diff(dx);
dy = diff(y);
ddy = diff(dy);

% Equa��es diferenciais
fx = m*ddx + (c_i+c)*dx + k*x - c_i*omega*y == m*omega^2*e*cos(omega*t);
fy = m*ddy + (c_i+c)*dy + k*y - c_i*omega*x == m*omega^2*e*sin(omega*t);
f_total = [fx fy];

% Condi��es iniciais
cond1 = x(0) == 0;
cond2 = dx(0) == 0;
cond3 = y(0) == 0;
cond4 = dy(0) == 0;
conds = [cond1 cond2 cond3 cond4];

[sol_x(t) sol_y(t)] = dsolve(f_total,conds);