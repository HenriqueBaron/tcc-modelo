function [delta] = DeformacaoElastica(wz,Eef,R,IF,IE,k)
%DEFORMACAOELASTICA Calcula a deformacao elastica no contato da esfera.
%   Calcula a deformacao elastica no contato entre a esfera e a pista do
%   rolamento, conforme a teoria hertziana de deformacao por contato.
%   Parametros de entrada:
%   wz - Carga radial, N
%   Eef - Modulo de elasticidade reduzido, Pa
%   R - Soma de curvatura entre as duas superficies
%   IF - Integral eliptica de primeira ordem
%   IE - Integral eliptica de segunda ordem
%   k - Fator de elipticidade

delta = IF*((9/(2*IE*R))*(wz/(pi*k*Eef))^2)^(1/3);
end