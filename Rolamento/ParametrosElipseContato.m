function [IF,IE,k] = ParametrosElipseContato(rax,ray,rbx,rby)
%ParametrosElipseContato Integrais el�pticas e fator de elipticidade
%   Determina o valor das integrais el�pticas e do fator de elipticidade em
%   um contato entre duas superf�cies n�o-planas.
%   Par�metros de entrada:
%   rax - Raio de curvatura da superf�cie A, dire��o X
%   ray - Raio de curvatura da superf�cie A, dire��o Y
%   rbx - Raio de curvatura da superf�cie B, dire��o X
%   rby - Raio de curvatura da superf�cie B, dire��o Y
Rx = 1/(1/rax + 1/rbx); % Raio de curvatura equivalente, eixo x
Ry = 1/(1/ray + 1/rby); % Raio de curvatura equivalente, eixo y

R = 1/(1/Rx + 1/Ry); % Soma de curvatura
Rd = R*(1/Rx - 1/Ry); % Diferen�a de curvatura

fun = @(phi,k) 1-(1/k^2)*sin(phi).^2;

% In�cio do m�todo iterativo
k = 2; % Um valor inicial para k � arbitrado
k_ant = 0;

while abs(k-k_ant)>=1e-7
k_ant = k;
% Calcula-se as integrais el�pticas
IF = integral(@(phi)fun(phi,k).^(-1/2),0,pi/2);
IE = integral(@(phi)fun(phi,k).^(1/2),0,pi/2);

k = ((2*IF-IE*(1+Rd))/(IE*(1-Rd)))^(1/2); % Determina um novo valor para k
end

end

