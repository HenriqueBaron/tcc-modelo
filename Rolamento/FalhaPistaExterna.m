% Calcula a vibração em um rolamento com dano pontual na pista externa.

clearvars;

% Entrada de dados
t0 = 0; % Instante inicial
tf = 5; % Instante final
N = 1800; % Velocidade de rotação, em revoluções por minuto

% Dados do rolamento - 6004 2RSH
D = 42; % Diâmetro externo da pista externa, milímetros
d = 20; % Diâmetro interno da pista interna, milímetros
D2 = 37.19; % Diâmetro interno da pista externa, milímetros
d2 = 24.65; % Diâmetro externo da pista interna, milímetros
Nb = 13; % Número de esferas
alpha = 0; % Ângulo de contato das esferas
%------------------------------------------------------------------------%

% Propriedades derivadas do rolamento
Dp = (D + d)/2; % Pitch diameter, milímetros
Db = (D2 - d2)/2; % Diâmetro das esferas

% Velocidades angulares dos anéis interno e externo
% Como os rolamentos são embutidos no mancal, a velocidade angular do
% anel externo é sempre nula.
omega_i = N*pi/30; % Anel interno
omega_o = 0; % Anel externo

% Frequências principais do rolamento
% Fundamental Train Frequency
FTF = 0.5*(omega_i*(1-cos(alpha)*Db/Dp) + omega_o*(1+cos(alpha)*Db/Dp));
% Ball Pass Frequency, Outer
BPFO = Nb/2*(omega_i-omega_o)*(1-cos(alpha)*Db/Dp);
% Ball Pass Frequency, Inner
BPFI = Nb/2*(omega_i-omega_o)*(1+cos(alpha)*Db/Dp);
% Ball Spin Frequency
BSF = Dp/(2*Db)*(omega_i-omega_o)*(1-cos(alpha)^2*Db^2/Dp^2);