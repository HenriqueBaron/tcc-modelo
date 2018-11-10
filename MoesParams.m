function [ M, L ] = MoesParams( F, E, ni, Rxb, Rxr, eta, z, us )
%MOESPARAMS Calcula os parametros adimensionais de Moes
%   Calcula os parametros adimensionais de Moes para o contato entre a
%   esfera e a pista do rolamento, incluindo o filme de fluido.
%   ENTRADAS:
%   F - Carga radial, N
%   E - Modulo de elasticidade do material da esfera e do anel, Pa
%   ni - Coeficiente de Poisson do material da esfera e do anel
%   Rxb - Raio de curvatura da esfera, m
%   Rxr - Raio de curvatura do anel, m
%   eta - Viscosidade dinamica do lubrificante, Pa*s
%   z - Indice de viscosidade-pressao do lubrificante
%   us - Soma de velocidades entre as superficies, m/s

Eeq = E/(1-ni^2); % Modulo de elasticidade reduzido
Rx = 1/(1/Rxb + 1/Rxr); % Raio de curvatura reduzido

pr = 1.96e8; % Constante de Roelands
alpha = z*(log(eta)+9.67)/pr; % Coeficiente de viscosidade-pressao

M = F/(Eeq*Rx^2)*(Eeq*Rx/(eta*us))^(3/4);
L = alpha*Eeq*(eta*us/(Eeq*Rx))^(1/4);

end
