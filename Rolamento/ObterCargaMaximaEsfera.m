function [ wz_max ] = ObterCargaMaximaEsfera( wz, n, cd, Eef, R, IF, IE, k)
%ObterCargaMaximaEsfera Determina a carga maxima de esfera do rolamento
%   Realiza um processo iterativo para determinar a carga na esfera mais
%   carregada do rolamento.
%
%   PARAMETROS DE ENTRADA
%   wz - Carga radial, N
%   n - Numero de esferas
%   cd - Folga diametral, mm
%   Eef - Modulo de elasticidade efetivo, MPa
%   R - Somas de curvatura, pistas interna e externa
%   IF - Integrais elípticas de primeira ordem, pistas interna e externa
%   IE - Integrais elípticas de segunda ordem, pistas interna e externa
%   k - Parametros de elipticidade, pistas interna e externa

[delta K] = deal(zeros(2,1));

for i=1:2
    % Determina a deformação elástica máxima no contato
    K(i) = pi*k*Eef*(2*IE(i)*R(i)/(9*IF(i).^3)).^(1/2);
    delta(i) = (wz/K(i)).^(2/3);
end

delta_m = sum(delta);
Kj = 1/((1/K(1)).^(2/3) + (1/K(2)).^(2/3)).^(3/2);

end