classdef SpecBase_SilentModeRequested_class < handle

    properties
        val     = []
        def     = []
        isFalse = []
        desc    = []
    end

%***********************************************************************************************************************************
%***********************************************************************************************************************************

    methods (Access = public)

    %*******************************************************************************************************************************
    %*******************************************************************************************************************************

        function self = SpecBase_SilentModeRequested_class(methodName)
            self.def        = false;
            self.isFalse    = true;
            self.desc       = "If silentModeRequested = true (or T, both case-insensitive), then the following contents will not be printed in the "...
                            + "output report file of " + methodName + ":" + newline + newline...
                            + "    - " + methodName + " interface, compiler, and platform specifications." + newline...
                            + "    - " + methodName + " simulation specification-descriptions." + newline + newline...
                            + "The default value is " + num2str(self.def) + "."...
                            ;
        end

    %*******************************************************************************************************************************
    %*******************************************************************************************************************************

        function set(self, silentModeRequested)
            if isempty(silentModeRequested)
                self.val = self.def;
            else
                self.val = silentModeRequested;
            end
            self.isFalse = ~self.val;
        end

    %*******************************************************************************************************************************
    %*******************************************************************************************************************************

    end

%***********************************************************************************************************************************
%***********************************************************************************************************************************

end