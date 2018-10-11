function [ M, L ] = MoesParams( F, E, ni, Rxb, Rxr, eta, z, us )
%MOESPARAMS Calcula os par�metros adimensionais de Moes
%   Calcula os par�metros adimensionais de Moes para o contato entre a
%   esfera e a pista do rolamento, inlcuindo o filme de fluido.
%   ENTRADAS:
%   F - Carga radial, N
%   E - M�dulo de elasticidade do material da esfera e do anel, Pa
%   ni - Coeficiente de Poisson do material da esfera e do anel
%   Rxb - Raio de curvatura da esfera, m
%   Rxr - Raio de curvatura do anel, m
%   eta - Viscosidade din�mica do lubrificante, Pa*s
%   z - �ndice de viscosidade-press�o do lubrificante
%   us - Soma de velocidades entre as superf�cies, m/s

Eeq = E/(1-ni^2); % M�dulo de elasticidade reduzido
Rx = 1/(1/Rxb + 1/Rxr); % Raio de curvatura reduzido

pr = 1.96e8; % Constante de Roelands
alpha = z*(log(eta)+9.67)/pr; % Coeficiente de viscosidade-press�o

M = F/(Eeq*Rx^2)*(Eeq*Rx/(eta*us))^(3/4);
L = alpha*Eeq*(eta*us/(Eeq*Rx))^(1/4);

end

