function y = ImpulsosTriangulo(t,f,w)
%IMPULSOSTRIANGULO Calcula uma funcao de impulsos triangulares.
%   Calcula uma funcao com impulsos triangulares que ocorrem com uma
%   frequencia angular f e tem largura de pulso w.
fh = f/(2*pi);
kmax = ceil(max(t)*fh) + 1;
yparts = zeros(length(t),kmax+1);
for k=0:kmax
    yparts(:,k+1) = tripuls(t-k/fh,w);
end
y = sum(yparts,2);
end

