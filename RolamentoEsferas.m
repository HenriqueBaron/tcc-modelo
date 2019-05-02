classdef RolamentoEsferas
    %ROLAMENTO Define um rolamento de esferas e suas propriedades
    %   Define as propriedades mecanicas de um rolamento de esferas e o
    %   calculo de propriedades dinamicas.
    
    properties
        AnelExt
        AnelInt
        AnguloContato
        FolgaRadial
        NumEsferas
        MassaEsfera
    end
    
    methods
        function obj = RolamentoEsferas(anelExt,anelInt,folgaRad,numEsf,...
                massaEsf)
            %ROLAMENTOESFERAS Construct an instance of this class
            %   Constroi uma instancia do rolamento de esferas, com todas
            %   as suas propriedades
            classeEsperadaAneis = 'AnelRolamentoEsferas';
            if ~isa(anelExt,classeEsperadaAneis)
                error(['O argumento "anelExt" deve ser um objeto da ' ...
                    'classe ' classeEsperadaAneis]);
            end
            if ~isa(anelInt,classeEsperadaAneis)
                error(['O argumento "anelInt" deve ser um objeto da ' ...
                    'classe ' classeEsperadaAneis]);
            end
            obj.AnelExt = anelExt;
            obj.AnelInt = anelInt;
            obj.AnguloContato = 0;
            obj.FolgaRadial = folgaRad;
            obj.DiamEsferas = diamEsf;
            obj.NumEsferas = numEsf;
            obj.MassaEsfera = massaEsf;
        end
        
        function cd = GetFolgaDiametral(obj)
            %GETFOLGADIAMETRAO Retorna a folga diametral do rolamento
            cd = 2*obj.FolgaRadial;
        end
        
        function Dp = GetPitchDiameter(obj)
            %GETPITCHDIAMETER Retorna o Pitch Diameter do rolamento
            Dp = (obj.AnelExt.D + obj.AnelInt.D)/2;
        end
        
        function rb = GetRaioEsferas(obj)
            %GETRAIOESFERAS Retorna o raio calculado das esferas
            rb = (obj.AnelExt.D2 - obj.AnelInt.D2 - ...
                obj.GetFolgaDiametral)/4;
        end
        
    end
end

