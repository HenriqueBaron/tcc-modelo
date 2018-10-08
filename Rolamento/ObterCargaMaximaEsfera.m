function [ wz_max ] = ObterCargaMaximaEsfera( wz, n, cd, Eef, R, IF, IE, k )
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

[delta,K] = deal(zeros(2,1));

calcularDelta = @(wz,Eef,R,IF,IE,k) IF*((9/(2*IE*R))*... 
    (wz/(pi*k*Eef))^2)^(1/3);
calcularK = @(Eef,R,IF,IE,k) pi*k*Eef*(2*IE*R/(9*IF^3))^(1/2);

for i=1:2
    % Determina a deformação elástica máxima no contato
    delta(i) = calcularDelta(wz,Eef,R(i),IF(i),IE(i),k(i));
    K(i) = calcularK(Eef,R(i),IF(i),IE(i),k(i));
end

delta_m = sum(delta);
Ki = 1/((1/K(1))^(2/3) + (1/K(2))^(2/3))^(3/2);

wz_max = Ki*delta_m^(3/2)*(1-cd/(2*delta_m))^(3/2);

end