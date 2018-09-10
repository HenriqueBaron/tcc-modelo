% Calcula a vibracao em um rolamento com dano pontual na pista externa.

clearvars;

%----- Entrada de dados -----%
t0 = 0; % Instante inicial
tf = 5; % Instante final
N = 1800; % Velocidade de rotacao, em revolcoes por minuto

% Dados do rolamento - 6004 2RSH
D = 42; % Diametro externo da pista externa, milimetros
d = 20; % Diametro interno da pista interna, milimetros
D2 = 37.19; % Diametro interno da pista externa, milimetros
d2 = 24.65; % Diametro externo da pista interna, milimetros
Nb = 13; % Numero de esferas
alpha = 0; % Angulo de contato do rolamento
rolos = 0; % Rolamento de esferas = 0; rolamento de rolos = 1

% Propriedades do defeito e carregamento
Cmax = 100; % Carga maxima aplicada no eixo, newtons
psi_m = pi/3; % Angulo maximo de distribuicao do carregamento, radianos
d_def = 0.1; % Tamanho do defeito, milimetros
da = 0; % Deslocamento axial provocado pelo defeito, milimetros
dr = 1; % Deslocamento radial provocado pelo defeito, milimetros

%------------------------------------------------------------------------%

% Propriedades derivadas do rolamento
Dp = (D + d)/2; % Pitch diameter, milimetros
Db = (D2 - d2)/2; % Diâmetro das esferas

% Velocidades angulares dos aneis interno e externo
% Como os rolamentos são embutidos no mancal, a velocidade angular do
% anel externo e sempre nula.
omega_i = N*pi/30; % Anel interno
omega_o = 0; % Anel externo

% Frequencias principais do rolamento
% Fundamental Train Frequency
FTF = 0.5*(omega_i*(1-cos(alpha)*Db/Dp) + omega_o*(1+cos(alpha)*Db/Dp));
% Ball Pass Frequency, Outer
BPFO = Nb/2*(omega_i-omega_o)*(1-cos(alpha)*Db/Dp);
% Ball Pass Frequency, Inner
BPFI = Nb/2*(omega_i-omega_o)*(1+cos(alpha)*Db/Dp);
% Ball Spin Frequency
BSF = Dp/(2*Db)*(omega_i-omega_o)*(1-cos(alpha)^2*Db^2/Dp^2);

% Determinacao do carregamento estatico
epsilon = 1/2*(1+tan(alpha)*da/dr);
