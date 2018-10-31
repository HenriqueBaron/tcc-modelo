function c = AproxHertz(a, R, IF, IE)
%APROXHERTZ Calcula a aproxima��o hertziana do contato.
%   Par�metros de entrada:
%   a - Comprimento do contato hertziano
%   R - Soma de curvatura, metros
%   IF - Integral el�ptica de primeiro tipo
%   IE - Integral el�ptica de segundo tipo
c = (a.^2/(2.*R)).*IF./IE;
end

