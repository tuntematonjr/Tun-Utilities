#define MAINPREFIX x
#define PREFIX tunuti

#include "script_version.hpp"

#define VERSION MAJOR.MINOR
#define VERSION_AR MAJOR,MINOR,PATCH,BUILD

#define REQUIRED_VERSION 2.14

#ifdef COMPONENT_BEAUTIFIED
    #define COMPONENT_NAME QUOTE(tunuti - COMPONENT_BEAUTIFIED)
#else
    #define COMPONENT_NAME QUOTE(tunuti - COMPONENT)
#endif
