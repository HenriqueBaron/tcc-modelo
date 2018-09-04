% Calcula a vibra��o em um rolamento com dano pontual na pista externa.

clearvars;

%% Entrada de dados
t0 = 0; % Instante inicial
tf = 5; % Instante final
N = 1800; % Velocidade de rota��o, em revolu��es por minuto

% Dados do rolamento - 6004 2RSH
D = 42; % Di�metro externo da pista externa, mil�metros
d = 20; % Di�metro interno da pista interna, mil�metros
D2 = 37.19; % Di�metro interno da pista externa, mil�metros
d2 = 24.65; % Di�metro externo da pista interna, mil�metros

%% Propriedades derivadas do rolamento
