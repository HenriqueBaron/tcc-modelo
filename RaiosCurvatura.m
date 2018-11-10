function [Rx,Ry,R,Rd] = RaiosCurvatura(rax,ray,rbx,rby)
%RAIOSCURVATURA Raios equivalentes, soma e diferenca de curvatura
%   Determina os raios de curvatura equivalentes nas direcoes X e Y, alem
%   da soma de curvatura e diferenca de curvatura, para um contato entre
%   duas superficies nao-planas.
%   Parametros de entrada:
%   rax - Raio de curvatura da superficie A, direcao X
%   ray - Raio de curvatura da superficie A, direcao Y
%   rbx - Raio de curvatura da superficie B, direcao X
%   rby - Raio de curvatura da superficie B, direcao Y
Rx = 1/(1/rax + 1/rbx); % Raio de curvatura equivalente, eixo x
Ry = 1/(1/ray + 1/rby); % Raio de curvatura equivalente, eixo y

R = 1/(1/Rx + 1/Ry); % Soma de curvatura
Rd = R*(1/Rx - 1/Ry); % Diferenca de curvatura
end
