function [x] = ImpulsosImpacto(t, fImp)
%PULSOSIMPACTO Gera um sinal com impulsos em uma frequência qualquer
%   Retorna em x o sinal com os impulsos ao longo do tempo.
%   PARÂMETROS DE ENTRADA:
%   t - vetor tempo para o qual o sinal deve ser gerado;
%   fImp - frequência dos impulsos
kMax = ceil(fImp*t(end));
x = zeros(1,length(t));
parfor i=1:length(x)
    for k=0:kMax
        x(i) = x(i)+le(range([t(i) k/fImp]),1e-6);
    end
end
end

