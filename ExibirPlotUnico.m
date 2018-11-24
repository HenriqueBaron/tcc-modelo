function [] = ExibirPlotUnico(x,y,labels,xlimits)
%EXIBIRPLOTUNICO Exibe dados em um plot, em uma nova figura
%   Exibe os dados especificados em um plot em uma nova figura. Parametros
%   de entrada:
%       x,y - Arrays de pontos para o plot
%       labels - Struct contendo os seguintes campos:
%           * WindowTitle - Texto para o titlo da nova figura a criar
%           * X - Texto para o eixo x do plot
%           * Y - Texto para o eixo y do plot
%       xlimits - Array de dois elementos para definir os limites do eixo x
%       por padrao. O eixo y comeca sempre como automatico.
if ~isempty(find(strcmp(fieldnames(labels),'WindowTitle'),1))
    figure('Name',labels.WindowTitle,'NumberTitle','off');
else
    figure();
end
plot(x,y);
xlabel(labels.X);
ylabel(labels.Y);
xlim(xlimits);
end