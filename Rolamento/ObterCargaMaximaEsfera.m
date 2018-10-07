function [ wz_max, Zw ] = ObterCargaMaximaEsfera( wz, n, cd, Eef, R, IF, IE, k)
%ObterCargaMaximaEsfera Determina a carga maxima de esfera do rolamento
%   Realiza um processo iterativo para determinar a carga na esfera mais
%   carregada do rolamento.
%
%   PARAMETROS DE ENTRADA
%   wz - Carga radial, N
%   n - Numero de esferas
%   cd - Folga diametral, m
%   Eef - Modulo de elasticidade efetivo, Pa
%   R - Somas de curvatura, pistas interna e externa
%   IF - Integrais elípticas de primeira ordem, pistas interna e externa
%   IE - Integrais elípticas de segunda ordem, pistas interna e externa
%   k - Parametros de elipticidade, pistas interna e externa

[delta, K] = deal(zeros(2,1));

calcularK = @(Eef,k,R,IF,IE) pi*k*Eef*(2*IE*R/(9*IF.^3)).^(1/2);
calcularDelta = @(wz,K) (wz/K)^(2/3);

Zw = 5;
wz_max_ant = 0;
wz_max = wz*Zw/n;

while abs(wz_max - wz_max_ant) > 1e-7

for i=1:2
    % Determina a deformação elástica máxima no contato
    K(i) = calcularK(Eef,k(i),R(i),IF(i),IE(i));
    delta(i) = calcularDelta(wz,K(i));
end

delta_m = sum(delta);

Zw = pi*(1-cd/(2*delta_m))^(3/2)/ ...
    (2.491*((1+((cd/(2*delta_m)-1)/1.23)^2)^(1/2)-1));

wz_max_ant = wz_max;
wz_max = wz*Zw/n;

end

end