class Extended_PreStart_EventHandlers {
	class ADDON {
		init = QUOTE(call COMPILE_FILE(XEH_preStart));
	};
};

class Extended_PreInit_EventHandlers {
	class ADDON {
		init = QUOTE(call COMPILE_FILE(XEH_preInit));
	};
};

class Extended_PostInit_EventHandlers {
	class ADDON {
		clientInit = QUOTE(call COMPILE_FILE(XEH_postInit_client));
		init = QUOTE(call COMPILE_FILE(XEH_postInit));
	};
};
