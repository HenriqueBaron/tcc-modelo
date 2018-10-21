function [Rx,Ry,R,Rd] = RaiosCurvatura(rax,ray,rbx,rby)
%RAIOSCURVATURA Raios equivalentes, soma e diferença de curvatura
%   Determina os raios de curvatura equivalentes nas direções X e Y, além
%   da soma de curvatura e diferença de curvatura, para um contato entre
%   duas superfícies não-planas.
%   Parâmetros de entrada:
%   rax - Raio de curvatura da superfície A, direção X
%   ray - Raio de curvatura da superfície A, direção Y
%   rbx - Raio de curvatura da superfície B, direção X
%   rby - Raio de curvatura da superfície B, direção Y
Rx = 1/(1/rax + 1/rbx); % Raio de curvatura equivalente, eixo x
Ry = 1/(1/ray + 1/rby); % Raio de curvatura equivalente, eixo y

R = 1/(1/Rx + 1/Ry); % Soma de curvatura
Rd = R*(1/Rx - 1/Ry); % Diferença de curvatura
end

