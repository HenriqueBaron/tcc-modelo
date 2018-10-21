function [Rx,Ry,R,Rd] = RaiosCurvatura(rax,ray,rbx,rby)
%RAIOSCURVATURA Raios equivalentes, soma e diferen�a de curvatura
%   Determina os raios de curvatura equivalentes nas dire��es X e Y, al�m
%   da soma de curvatura e diferen�a de curvatura, para um contato entre
%   duas superf�cies n�o-planas.
%   Par�metros de entrada:
%   rax - Raio de curvatura da superf�cie A, dire��o X
%   ray - Raio de curvatura da superf�cie A, dire��o Y
%   rbx - Raio de curvatura da superf�cie B, dire��o X
%   rby - Raio de curvatura da superf�cie B, dire��o Y
Rx = 1/(1/rax + 1/rbx); % Raio de curvatura equivalente, eixo x
Ry = 1/(1/ray + 1/rby); % Raio de curvatura equivalente, eixo y

R = 1/(1/Rx + 1/Ry); % Soma de curvatura
Rd = R*(1/Rx - 1/Ry); % Diferen�a de curvatura
end

