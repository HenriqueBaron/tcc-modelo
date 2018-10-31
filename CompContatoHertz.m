function a = CompContatoHertz(wz, R, Eef, IE, k)
%COMPCONTATOHERTZ Calcula o comprimento de contato hertziano.
%   Parâmetros de entrada:
%   wz - Carga radial, newtons
%   R - Soma de curvatura, metros
%   Eef - Módulo de elasticidade efetivo, Pa
%   IE - Integral elíptica de segundo tipo
%   k - Parâmetro de elipticidade
a = (3.*wz.*R/Eef)^(1/3).*(2.*k.*IE/pi).^(1/3);
end

