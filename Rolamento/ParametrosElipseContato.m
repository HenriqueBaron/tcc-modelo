function [IF,IE,k] = ParametrosElipseContato(rax,ray,rbx,rby)
%ParametrosElipseContato Integrais elípticas e fator de elipticidade
%   Determina o valor das integrais elípticas e do fator de elipticidade em
%   um contato entre duas superfícies não-planas.
%   Parâmetros de entrada:
%   rax - Raio de curvatura da superfície A, direção X
%   ray - Raio de curvatura da superfície A, direção Y
%   rbx - Raio de curvatura da superfície B, direção X
%   rby - Raio de curvatura da superfície B, direção Y
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

end

