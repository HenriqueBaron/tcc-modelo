tf = 4; % Instante final, segundos
Fs = 50e3; % Frequencia de amostragem, hertz

[ext, esf, int, FImp, t] = FalhaPistaExterna(tf, Fs);

ExibirResultados;