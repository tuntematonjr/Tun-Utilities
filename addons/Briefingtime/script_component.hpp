#define COMPONENT briefingtime
#define PREFIX Tun

#define MAJOR 1
#define MINOR 0
#define PATCHLVL 5
#define BUILD 29112021

#define VERSION MAJOR.MINOR.PATCHLVL.BUILD
#define VERSION_AR MAJOR,MINOR,PATCHLVL,BUILD

// MINIMAL required version for the Mod. Components can specify others..
#define REQUIRED_VERSION 1.94

#ifdef DEBUG_ENABLED_MAIN
	#define DEBUG_MODE_FULL
#endif

#include "\x\cba\addons\main\script_macros_common.hpp"

// Default versioning level
#define DEFAULT_VERSIONING_LEVEL 2

#define TUN_DEBUGLOG(TEXT) 	diag_log format["%1_%2 Debug: %3",PREFIX,COMPONENT,TEXT];