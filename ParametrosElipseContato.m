function [IF,IE,k] = ParametrosElipseContato(Rd)
%PARAMETROSELIPSECONTATO Integrais elipticas e fator de elipticidade
%   Determina o valor das integrais elipticas e do fator de elipticidade em
%   um contato entre duas superficies nao-planas.
%   Parametros de entrada:
%   Rd - Diferenca de curvatura entre as duas superficies em contato.
fun = @(phi,k) 1-(1/k^2)*sin(phi).^2;

% Inicio do metodo iterativo
k = 2; % Um valor inicial para k eh arbitrado
k_ant = 0;

while abs(k-k_ant)>=1e-7
k_ant = k;
% Calcula-se as integrais elipticas
IF = integral(@(phi)fun(phi,k).^(-1/2),0,pi/2);
IE = integral(@(phi)fun(phi,k).^(1/2),0,pi/2);

k = ((2*IF-IE*(1+Rd))/(IE*(1-Rd)))^(1/2); % Determina um novo valor para k
end

end
