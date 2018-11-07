function y = ImpulsosTriangulo(t,f,w)
%IMPULSOSTRIANGULO Calcula uma funcao de impulsos triangulares.
%   Calcula uma funcao com impulsos triangulares que ocorrem com uma
%   frequencia f (em hertz) e tem largura de pulso w.
kmax = ceil(max(t)*f) + 1;
yparts = zeros(length(t),kmax+1);
parfor k=0:kmax
    yparts(:,k+1) = tripuls(t-k/f,w);
end
y = sum(yparts,2);
end

