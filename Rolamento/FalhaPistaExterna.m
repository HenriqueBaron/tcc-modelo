% Calcula a vibra��o em um rolamento com dano pontual na pista externa.

clearvars;

%----- Entrada de dados -----%
t0 = 0; % Instante inicial
tf = 5; % Instante final
N = 1800; % Velocidade de rota��o, em revolu��es por minuto

% Propriedades do carregamento
Cmax = 100; % Carga m�xima aplicada no eixo, newtons
psi_m = pi/3; % �ngulo m�ximo de distribui��o do carregamento, radianos

% Dados do rolamento - 6004 2RSH
D = 42; % Di�metro externo da pista externa, mil�metros
d = 20; % Di�metro interno da pista interna, mil�metros
D2 = 37.19; % Di�metro interno da pista externa, mil�metros
d2 = 24.65; % Di�metro externo da pista interna, mil�metros
Nb = 13; % N�mero de esferas
alpha = 0; % �ngulo de contato do rolamento
rolos = 0; % Rolamento de esferas = 0; rolamento de rolos = 1

% Propriedades do defeito
d_def = 0.1; % Tamanho do defeito, mil�metros
da = 0; % Deslocamento axial provocado pelo defeito, mil�metros
dr = 1; % Deslocamento radial provocado pelo defeito, mil�metros

%------------------------------------------------------------------------%

% Propriedades derivadas do rolamento
Dp = (D + d)/2; % Pitch diameter, mil�metros
Db = (D2 - d2)/2; % Di�metro das esferas

% Velocidades angulares dos an�is interno e externo
% Como os rolamentos s�o embutidos no mancal, a velocidade angular do
% anel externo � sempre nula.
omega_i = N*pi/30; % Anel interno
omega_o = 0; % Anel externo

% Frequ�ncias principais do rolamento
% Fundamental Train Frequency
FTF = 0.5*(omega_i*(1-cos(alpha)*Db/Dp) + omega_o*(1+cos(alpha)*Db/Dp));
% Ball Pass Frequency, Outer
BPFO = Nb/2*(omega_i-omega_o)*(1-cos(alpha)*Db/Dp);
% Ball Pass Frequency, Inner
BPFI = Nb/2*(omega_i-omega_o)*(1+cos(alpha)*Db/Dp);
% Ball Spin Frequency
BSF = Dp/(2*Db)*(omega_i-omega_o)*(1-cos(alpha)^2*Db^2/Dp^2);

% Determina��o do carregamento est�tico
epsilon = 1/2*(1+tan(alpha)*da/dr);
