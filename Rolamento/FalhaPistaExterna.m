% Calcula a vibração em um rolamento com dano pontual na pista externa.

clearvars;

%% Entrada de dados
t0 = 0; % Instante inicial
tf = 5; % Instante final
N = 1800; % Velocidade de rotação, em revoluções por minuto

% Dados do rolamento - 6004 2RSH
D = 42; % Diâmetro externo da pista externa, milímetros
d = 20; % Diâmetro interno da pista interna, milímetros
D2 = 37.19; % Diâmetro interno da pista externa, milímetros
d2 = 24.65; % Diâmetro externo da pista interna, milímetros

%% Propriedades derivadas do rolamento
