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
fun = @(psi,C) (cos(psi)-C).^(3/2).*cos(psi);

wz_max = wz;
wz_max_ant = 0;

while abs(wz_max-wz_max_ant) > 1e-5
for i=1:2
    % Determina a deformação elástica máxima no contato
    delta(i) = calcularDelta(wz,Eef,R(i),IF(i),IE(i),k(i));
end

delta_m = sum(delta);
psi_l = acos(cd/(2*delta_m));

wz_max_ant = wz_max;
intFun = integral(@(psi)fun(psi,cd/(2*delta_m)),0,psi_l);
wz_max = wz*pi*(1-cd/(2*delta_m))^(3/2)/(n*intFun);

end

end