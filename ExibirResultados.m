figure(1);
plot(t,fImpacto(t));
title('Perfil dos impulsos de impacto','Interpreter','latex');
xlabel('Tempo $\rm [s]$','Interpreter','latex');
ylabel('For\c{c}a $\rm [N]$','Interpreter','latex');
xlim([0 0.1]);
ylim('auto');

figure(2)
xlimTempo = [0 0.5];
ylimTempo = 'auto';
subplot(3,1,1);
plot(t,ext.pos);
title('Anel externo','Interpreter','latex');
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

figure(3)
plot(f,P1);
title('Espectro de frequ\^encias','Interpreter','latex');
xlabel('Frequ\^encia $\rm [Hz]$','Interpreter','latex');
ylabel('Deslocamento $\rm [m]$','Interpreter','latex');