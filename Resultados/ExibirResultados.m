exibirImpactos = false;
exibirAnelExtPos = true;
exibirAnelExt = false;
exibirEsfera = false;
exibirAnelInt = false;
exibirEspectroAcc = true;
exibirEnvSpecAcc = true;

%#ok<*UNRCH> Ignorar aviso de "Esta logica pode nao ser executada."
if exibirImpactos
    figure('Name','Perfil dos impulsos de impacto','NumberTitle','off');
    plot(t,FImp);
    xlabel('Tempo $\rm [s]$','Interpreter','latex');
    ylabel('For\c{c}a $\rm [N]$','Interpreter','latex');
    xlim([0 0.1]);
    ylim('auto');
end

if exibirAnelExtPos
    figure('Name','Deslocamento anel externo','NumberTitle','off');
    plot(t,ext.pos);
    xlabel('Tempo $\rm [s]$','Interpreter','latex');
    ylabel('Deslocamento $\rm [m]$','Interpreter','latex');
    xlim([0 0.3]);
    ylim('auto');
end

if exibirAnelExt
    fig = figure('Name','Anel externo','NumberTitle','off');
    xlimTempo = [0 0.5];
    ylimTempo = 'auto';
    subplot(3,1,1);
    plot(t,ext.pos);
    ylabel('Deslocamento $\rm [m]$','Interpreter','latex');
    xlim(xlimTempo);
    ylim(ylimTempo);

    subplot(3,1,2);
    plot(t,ext.vel);
    ylabel('Velocidade $\rm [m/s]$','Interpreter','latex');
    xlim(xlimTempo);
    ylim(ylimTempo);

    subplot(3,1,3);
    plot(t,ext.acc);
    ylabel('Acelera\c{c}\~ao $\rm [m/s^2]$','Interpreter','latex');
    xlabel('Tempo $\rm [s]$','Interpreter','latex');
    xlim(xlimTempo);
    ylim(ylimTempo);
    fig.WindowState = 'maximized';
end

if exibirEsfera
    fig = figure('Name','Esfera','NumberTitle','off');
    xlimTempo = [0 0.5];
    ylimTempo = 'auto';
    subplot(3,1,1);
    plot(t,esf.pos);
    ylabel('Deslocamento $\rm [m]$','Interpreter','latex');
    xlim(xlimTempo);
    ylim(ylimTempo);

    subplot(3,1,2);
    plot(t,esf.vel);
    ylabel('Velocidade $\rm [m/s]$','Interpreter','latex');
    xlim(xlimTempo);
    ylim(ylimTempo);

    subplot(3,1,3);
    plot(t,esf.acc);
    ylabel('Acelera\c{c}\~ao $\rm [m/s^2]$','Interpreter','latex');
    xlabel('Tempo $\rm [s]$','Interpreter','latex');
    xlim(xlimTempo);
    ylim(ylimTempo);
    fig.WindowState = 'maximized';
end

if exibirAnelInt
    fig = figure('Name','Anel interno','NumberTitle','off');
    xlimTempo = [0 0.5];
    ylimTempo = 'auto';
    subplot(3,1,1);
    plot(t,int.pos);
    ylabel('Deslocamento $\rm [m]$','Interpreter','latex');
    xlim(xlimTempo);
    ylim(ylimTempo);

    subplot(3,1,2);
    plot(t,int.vel);
    ylabel('Velocidade $\rm [m/s]$','Interpreter','latex');
    xlim(xlimTempo);
    ylim(ylimTempo);

    subplot(3,1,3);
    plot(t,int.acc);
    ylabel('Acelera\c{c}\~ao $\rm [m/s^2]$','Interpreter','latex');
    xlabel('Tempo $\rm [s]$','Interpreter','latex');
    xlim(xlimTempo);
    ylim(ylimTempo);
    fig.WindowState = 'maximized';
end

if exibirEspectroAcc || exibirEnvSpecAcc
    % Determinacao de parametros para os espectros
    Y = fft(ext.acc);
    L = length(ext.acc);
    f = (0:L/2)*(Fs/L);
end

if exibirEspectroAcc
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    figure('Name','Espectro de frequencias','NumberTitle','off')
    plot(f,P1);
    xlabel('Frequ\^encia $\rm [Hz]$','Interpreter','latex');
    ylabel('Acelera\c{c}\~ao $\rm [m/s^2]$','Interpreter','latex');
    xlim([0 1e4]);
    ylim('auto');
end

if exibirEnvSpecAcc
    figure('Name','Espectro de envelope','NumberTitle','off')
    plot(f,envspectrum(ext.acc,Fs));
    xlabel('Frequ\^encia $\rm [Hz]$','Interpreter','latex');
    ylabel('Acelera\c{c}\~ao $\rm [m/s^2]$','Interpreter','latex');
    xlim([0 1e4]);
    ylim('auto');
end