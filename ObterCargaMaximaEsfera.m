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
%   k - Fatores de elipticidade, pistas interna e externa

delta = deal(zeros(2,1));

fun = @(psi,C) (cos(psi)-C).^(3/2).*cos(psi);

wz_max = wz;
Zw = 5;
Zw_ant = 0;
tol = 100;
m = 0;
while abs(Zw - Zw_ant) > 1e-7 && m < tol
for i=1:2
    % Determina a deformação elástica máxima no contato
    delta(i) = DeformacaoElastica(wz_max,Eef,R(i),IF(i),IE(i),k(i));
end

delta_m = sum(delta);
psi_l = acos(cd/(2*delta_m));

Zw_ant = Zw;

intFun = integral(@(psi)fun(psi,cd/(2*delta_m)),0,psi_l);
Zw = pi*(1-cd/(2*delta_m))^(3/2)/intFun;
wz_max = wz*Zw/n;

m = m + 1;
end

end