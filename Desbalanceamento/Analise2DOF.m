% Calcula a vibra��o de um sistema eixo-rotor desbalanceado analisando um ponto com 2 graus de liberdade.

clearvars;
t0 = 0; % Instante inicial
tf = 5; % Instante final
m = 1.565; % Massa total do rotor
e = 10e-3; % Afastamento do centro de massa do rotor
gamma = 0.002; % Coeficiente de amortecimento interno
c = 0; % Amortecimento externo do sistema
d_eixo = 0.02; % Di�metro do eixo
L_eixo = 0.4; % Comprimento do eixo
E = 200e9; % M�dulo de elasticidade do a�o
N = 1800; % Velocidade de rota��o, em revolu��es por minuto

% Fun��o de rigidez do eixo. Determinada pelo segundo momento de �rea da
% se��o circular e pela fun��o de deflex�o de mec�nica dos s�lidos.
% Considera que o rotor est� posicionado no centro do eixo
obterRigidez = @(I,l) 48*E*I/l.^3;
I_eixo = pi*d_eixo^4/64;
k = obterRigidez(I_eixo,L_eixo);

omega = N*pi/30; % Frequ�ncia angular
omega_n = sqrt(k/m); % Frequ�ncia natural

% Determina��o do amortecimento interno
c_i = gamma/abs(omega-omega_n)*k;

% Equa��es diferenciais de movimento
eqs = @(t,y) [y(2);
    omega^2*e*cos(omega*t) - (c_i+c)/m*y(2) - k/m*y(1) + c_i*omega/m*y(3);
    y(4);
    omega^2*e*sin(omega*t) - (c_i+c)/m*y(4) - k/m*y(3) + c_i*omega/m*y(1)];

[t,y] = ode45(eqs,[t0 tf], [0; 0; 0; 0]);

di = length(t)/(tf-t0);

% Exibi��o
figure(1)
clf
title('Deslocamentos, in�cio')
grid on;
hold on;
plot(t,y(:,1));
plot(t,y(:,3));
legend('Dire��o x','Dire��o y');
xlim([t0 t0+0.1])
axis 'auto y'

figure(2)
clf
title('Deslocamentos, final')
grid on;
hold on;
plot(t,y(:,1));
plot(t,y(:,3));
legend('Dire��o x','Dire��o y');
xlim([tf-0.1 tf])
axis 'auto y'

figure(3)
clf
title('�rbita, in�cio')
grid on
hold on
iinf = 1;
isup = 100;
plot(y(iinf:isup,1),y(iinf:isup,3))

figure(4)
clf
title('�rbita, final')
grid on
hold on
iinf = length(y) - 1000;
isup = length(y);
plot(y(iinf:isup,1),y(iinf:isup,3))