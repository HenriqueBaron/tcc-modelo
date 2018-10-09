function [delta] = DeformacaoElastica(wz,Eef,R,IF,IE,k)
%DEFORMACAOELASTICA Calcula a deformação elástica no contato da esfera.
%   Calcula a deformação elástica no contato entre a esfera e a pista do
%   rolamento, conforme a teoria hertziana de deformação por contato.
%   Parâmetros de entrada:
%   wz - Carga radial, N
%   Eef - Módulo de elasticidade reduzido, Pa
%   R - Soma de curvatura entre as duas superfícies
%   IF - Integral elíptica de primeira ordem
%   IE - Integral elíptica de segunda ordem
%   k - Fator de elipticidade

delta = IF*((9/(2*IE*R))*(wz/(pi*k*Eef))^2)^(1/3);
end