% SCRIPT DE TESTE - Método iterativo para determinação do parâmetro de
% elipticidade k e integrais elípticas de primeira ordem IF e segunda ordem
% IE.
% Procedimento de teste aplicado com os dados do anel EXTERNO.

rax = 3.175e-3; % Raio de curvatura da esfera (eixo x), m
ray = 3.175e-3; % Raio de curvatura da esfera (eixo y), m

rbx = 18.68e-3; % Raio de curvatura do groove (eixo x), m
rby = 3.18e-3; % Raio de curvatura do groove (eixo y), m

Rx = 1/(1/rax + 1/rbx); % Raio de curvatura equivalente, eixo x
Ry = 1/(1/ray + 1/rby); % Raio de curvatura equivalente, eixo y

R = 1/(1/Rx + 1/Ry); % Soma de curvatura
Rd = R*(1/Rx - 1/Ry); % Diferença de curvatura

fun = @(phi,k) 1-(1/k^2)*sin(phi).^2;

% Início do método iterativo
k = 2; % Um valor inicial para k é arbitrado
k_ant = 0;

while abs(k-k_ant)>=1e-7
k_ant = k;
% Calcula-se as integrais elípticas
IF = integral(@(phi)fun(phi,k).^(-1/2),0,pi/2);
IE = integral(@(phi)fun(phi,k).^(1/2),0,pi/2);

k = ((2*IF-IE*(1+Rd))/(IE*(1-Rd)))^(1/2); % Determina um novo valor para k
end