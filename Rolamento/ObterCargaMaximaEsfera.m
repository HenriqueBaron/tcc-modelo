function [ wz_max ] = ObterCargaMaximaEsfera( wz, n, cd, Eef, F, epsilon, R, k)
%ObterCargaMaximaEsfera Determina a carga na esfera mais solicitada do
%rolamento
%   Realiza um processo iterativo para determinar a carga na esfera mais
%   carregada do rolamento.

delta = zeros(2,1);
Zw = 5;
razaoComp = 0;
erroRel = 1; % Erro relativo do processo iterativo
while erroRel > 0.001
    razaoCompAnt = razaoComp;
    wz_max = Zw*wz/n;
    
    % Compressoes locais elasticas maximas
    for i=1:2
        delta(i) = F(i)*(n/(2*epsilon(i)*R(i))*(wz_max/(pi*k(i)*Eef))^2)^(1/3);
    end
    deltaSum = sum(delta);
    
    razaoComp = cd/(2*deltaSum);
    
    % Reavaliacao do valor de Zw
    Zw = pi*(1-razaoComp)^(3/2)/(2.491*(sqrt(1+((1-razaoComp)/1.23)^2)-1));
    
    erroRel = abs(razaoComp - razaoCompAnt)/razaoComp;
end

end

