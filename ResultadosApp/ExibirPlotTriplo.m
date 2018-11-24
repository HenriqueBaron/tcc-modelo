function [] = ExibirPlotTriplo(x,y,labels,xlimits)
%EXIBIRPLOTTRIPLO Exibe tres series de dados em subplots, em nova figura
%   Exibe os conjuntos de dados especificados em tres plots em uma nova
%   figura. Parametros de entrada:
%       x - Vetor de dados do eixo x, ou tempo. Deve ser um vetor linha.
%       y - Vetor de dados dos eixos y para os tres plots. Deve ser um
%       vetor de tres linhas ou tres colunas, uma para cada subplot
%       labels - Struct contendo os seguintes campos:
%           * WindowTitle - Texto para o titlo da nova figura a criar
%           * X - Texto para o eixo x do plot
%           * Y1 - Texto para o eixo y do plot 1
%           * Y2 - Texto para o eixo y do plot 2
%           * Y3 - Texto para o eixo y do plot 3
%       xlimits - Array de dois elementos para definir os limites do eixo x
%       por padrao. O eixo y comeca sempre como automatico.
if ~isempty(find(strcmp(fieldnames(labels),'WindowTitle'),1))
    fig = figure('Name',labels.WindowTitle,'NumberTitle','off');
else
    fig = figure();
end
% Corrige a orientacao da matriz y
if size(y,2) == 3
    y = y';
end
ylabels = {labels.Y1 labels.Y2 labels.Y3};
for i=1:length(ylabels)
    subplot(3,1,i);
    plot(x,y(i,:));
    xlim(xlimits)
    ylim('auto');
    ylabel(ylabels(i));
end
xlabel(labels.X);
fig.WindowState = 'maximized';
end