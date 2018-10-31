function c = AproxHertz(a, R, IF, IE)
%APROXHERTZ Calcula a aproximação hertziana do contato.
%   Parâmetros de entrada:
%   a - Comprimento do contato hertziano
%   R - Soma de curvatura, metros
%   IF - Integral elíptica de primeiro tipo
%   IE - Integral elíptica de segundo tipo
c = (a.^2/(2.*R)).*IF./IE;
end

