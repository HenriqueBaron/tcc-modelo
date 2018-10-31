function a = CompContatoHertz(wz, R, Eef, IE, k)
%COMPCONTATOHERTZ Calcula o comprimento de contato hertziano.
%   Par�metros de entrada:
%   wz - Carga radial, newtons
%   R - Soma de curvatura, metros
%   Eef - M�dulo de elasticidade efetivo, Pa
%   IE - Integral el�ptica de segundo tipo
%   k - Par�metro de elipticidade
a = (3.*wz.*R/Eef)^(1/3).*(2.*k.*IE/pi).^(1/3);
end

