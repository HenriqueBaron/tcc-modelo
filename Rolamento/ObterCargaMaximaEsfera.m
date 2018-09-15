function [ wz_max ] = ObterCargaMaximaEsfera( wz, n, cd, Eef, F, epsilon, R, k)
%ObterCargaMaximaEsfera Determina a carga maxima de esfera do rolamento
%   Realiza um processo iterativo para determinar a carga na esfera mais
%   carregada do rolamento.
%
%   PARAMETROS DE ENTRADA
%   wz - Carga radial, N
%   n - Numero de esferas
%   cd - Folga diametral, mm
%   Eef - Modulo de elasticidade efetivo, MPa
%   F, epsilon - Resultados integrais elipticas, pistas interna e externa
%   R - Raios equivalentes, pistas interna e externa
%   k - Parametros de elipticidade, pistas interna e externa

% delta = zeros(2,1);
% Zw = 5;
Zw = 4.37;
% razaoComp = 0;
% erroRel = 1; % Erro relativo do processo iterativo
% while erroRel > 1e-5
%     razaoCompAnt = razaoComp;
    wz_max = Zw*wz/n;
%     
%     % Compressoes locais elasticas maximas
%     for i=1:2
%         delta(i) = F(i)*(9/(2*epsilon(i)*R(i))*(wz_max/(pi*k(i)*Eef))^2)^(1/3);
%     end
%     deltaSum = sum(delta);
%     
%     razaoComp = cd/(2*deltaSum);
%     
%     % Reavaliacao do valor de Zw
%     Zw = pi*(1-razaoComp)^(3/2)/(2.491*(sqrt(1+((1-razaoComp)/1.23)^2)-1));
%     
%     erroRel = abs(razaoComp - razaoCompAnt)/razaoComp;
% end

end

