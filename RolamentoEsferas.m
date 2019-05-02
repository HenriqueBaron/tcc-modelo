classdef RolamentoEsferas
    %ROLAMENTO Define um rolamento de esferas e suas propriedades
    %   Define as propriedades mecanicas de um rolamento de esferas e o
    %   calculo de propriedades dinamicas.
    
    properties
        AnelExt
        AnelInt
        AnguloContato
        DiamEsferas
        NumEsferas
        MassaEsfera
    end
    
    methods
        function obj = RolamentoEsferas(anelExt,anelInt,diamEsf,numEsf,...
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
            obj.DiamEsferas = diamEsf;
            obj.NumEsferas = numEsf;
            obj.MassaEsfera = massaEsf;
        end
        
    end
end

