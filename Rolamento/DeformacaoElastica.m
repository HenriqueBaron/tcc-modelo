function [delta] = DeformacaoElastica(wz,Eef,R,IF,IE,k)
%DEFORMACAOELASTICA Calcula a deforma��o el�stica no contato da esfera.
%   Calcula a deforma��o el�stica no contato entre a esfera e a pista do
%   rolamento, conforme a teoria hertziana de deforma��o por contato.
%   Par�metros de entrada:
%   wz - Carga radial, N
%   Eef - M�dulo de elasticidade reduzido, Pa
%   R - Soma de curvatura entre as duas superf�cies
%   IF - Integral el�ptica de primeira ordem
%   IE - Integral el�ptica de segunda ordem
%   k - Fator de elipticidade

delta = IF*((9/(2*IE*R))*(wz/(pi*k*Eef))^2)^(1/3);
end