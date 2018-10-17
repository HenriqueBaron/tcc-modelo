function [x] = ImpulsosImpacto(t, fImp)
%PULSOSIMPACTO Gera um sinal com impulsos em uma frequ�ncia qualquer
%   Retorna em x o sinal com os impulsos ao longo do tempo.
%   PAR�METROS DE ENTRADA:
%   t - vetor tempo para o qual o sinal deve ser gerado;
%   fImp - frequ�ncia dos impulsos
kMax = ceil(fImp*t(end));
syms k;
x = double(symsum(kroneckerDelta(t-k/fImp),k,0,kMax));
end

