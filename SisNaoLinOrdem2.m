function dydt = SisNaoLinOrdem2(t, y, M, C, Klin, KfInt, KfExt, F, ...
    fiInt, fiExt)
%SISLINORDEM2 Monta um vetor de EDOs de ordem 2 para sistema de vibracao.
%   Utiliza as matrizes de massa, amortecimento, rigidezes e forca externa
%   fornecidas para montar um vetor de equacoes diferenciais do tipo
%   y'=f(t,y) para ser resolvido com solvers do MATLAB como o ode45.
%
%   Os parametros t e y sao utilizados justamente pelo solver do MATLAB.
%   Para utilizar esta funcao no solver, utilize uma funcao anonima na
%   chamada:
%   [t, y] = ode45(@(t,y) SisNaoLinOrdem2(t,y,M,C,K,F),tspan,y0)

% Verificacao de forma das entradas
if size(F,2) > 1
    error('O vetor de forcas deve ser um vetor coluna.');
end
if size(M,1) ~= size(M,2) || ...
   size(C,1) ~= size(C,2) || ...
   size(Klin,1) ~= size(Klin,2) || ...
   size(KfInt,1) ~= size(KfInt,2) || ...
   size(KfExt,1) ~= size(KfExt,2)
    error(['As matrizes de massa, amortecimento e rigidez ' ...
        'devem ser quadradas.']);
end
if size(M,2) ~= size(F,1) || ...
   size(C,2) ~= size(F,1) || ...
   size(Klin,2) ~= size(F,1) || ...
   size(KfInt,2) ~= size(F,1) || ...
   size(KfExt,2) ~= size(F,1)
    error(['A largura das matrizes de massa, amortecimento e rigidez '...
        'nao correspondem a altura do vetor de forcas.']);
end

% Cria um function handle para calcular a forca de restauracao por uma
% rigidez nao-linear. O function handle eh necessario porque pode haver um
% termo de forca constante a incluir.
fk = @(y,fiSt) real(fiSt.k.*y.^fiSt.n) + fiSt.Fs;

% A resolucao e a manipulacao dos dados para o solver e feita em duas
% partes (dividindo ao meio os vetores) porque os algoritmos para ODEs do
% MATLAB resolvem equacoes de primeira ordem. Para segunda ordem, uma
% substituicao para reducao de ordem e aplicada.

% Separacao dos dados de entrada do solver em dois vetores
yPos = y(1:length(y)/2); % Primeira metade, posicoes
yVel = y(length(y)/2+1:end); % Segunda metade, velocidades

% Montagem das equacoes diferenciais para o solver
dydtPos = yVel;
dydtVel = M\(F - C*yVel - Klin*yPos - ...
    KfInt*fk(yPos,fiInt) - KfExt*fk(yPos,fiExt));

dydt = [dydtPos; dydtVel];

disp(t);
end