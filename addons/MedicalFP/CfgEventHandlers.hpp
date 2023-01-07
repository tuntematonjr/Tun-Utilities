class Extended_PreStart_EventHandlers {
    class MedicalFP {
        init = QUOTE(call COMPILE_FILE(XEH_preStart));
    };
};
class Extended_PreInit_EventHandlers {
    class MedicalFP {
        init = QUOTE(call COMPILE_FILE(XEH_preInit));
    };
};
class Extended_PostInit_EventHandlers {
    class MedicalFP {
        clientInit = QUOTE(call COMPILE_FILE(XEH_postInitClient));
    };
};