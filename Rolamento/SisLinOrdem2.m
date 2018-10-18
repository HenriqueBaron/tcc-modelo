function dydt = SisLinOrdem2(t, y, M, C, K, F)
%SISLINORDEM2 Monta um vetor de EDOs de ordem 2 para sistema de vibracao.
%   Utiliza as matrizes de massa, amortecimento, rigidez e forca externa
%   fornecidas para montar um vetor de equacoes diferenciais do tipo
%   y'=f(t,y) para ser resolvido com solvers do MATLAB como o ode45.
%
%   Os parametros t e y sao utilizados justamente pelo solver do MATLAB.
%   Para utilizar esta funcao no solver, utilize uma funcao anonima na
%   chamada:
%   [t, y] = ode45(@(t,y) SisLinOrdem2(t,y,M,C,K,F),tspan,y0)

% Verificacao de forma das entradas
if size(F,2) > 1
    error('O vetor de forcas deve ser um vetor coluna.');
end
if size(M,1) ~= size(M,2) || ...
   size(C,1) ~= size(C,2) || ...
   size(K,1) ~= size(K,2)
    error(['As matrizes de massa, amortecimento e rigidez ' ...
        'devem ser quadradas.']);
end
if size(M,2) ~= size(F,1) || ...
   size(C,2) ~= size(F,1) || ...
   size(K,2) ~= size(F,1)
    error(['A largura das matrizes de massa, amortecimento e rigidez '...
        'nao correspondem a altura do vetor de forcas.']);
end


end

