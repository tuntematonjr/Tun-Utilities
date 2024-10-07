#define COMPONENT briefingtime
#define COMPONENT_BEAUTIFIED BriefingTime
#include "\x\tunuti\addons\main\script_mod.hpp"

//#define DEBUG_MODE_FULL
//#define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_MAIN
    #define DEBUG_MODE_FULL
#endif

#include "\x\tunuti\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\definecommoncolors.inc"

// Default grid
#define GUI_GRID_WAbs           ((safezoneW / safezoneH) min 1.2)
#define GUI_GRID_HAbs           (GUI_GRID_WAbs / 1.2)
#define GUI_GRID_W              (GUI_GRID_WAbs / 40)
#define GUI_GRID_H              (GUI_GRID_HAbs / 25)
#define GUI_GRID_X              (safezoneX)
#define GUI_GRID_Y              (safezoneY + safezoneH - GUI_GRID_HAbs)

// Default text sizes
#define GUI_TEXT_SIZE_SMALL         (GUI_GRID_H * 0.8)
#define GUI_TEXT_SIZE_MEDIUM        (GUI_GRID_H * 1)
#define GUI_TEXT_SIZE_LARGE         (GUI_GRID_H * 1.2)

#define TIME_IDD                    1701951
#define TIME_TEXT_IDC               1701952
#define NOTIFICATION_BOX_IDC        1701953
#define BACKGROUND_IDC              1701954
#define SLIDER_IDC                  1701955
#define SLIDER_TEXT_IDC             1701956
#define SLIDER_OK_IDC               -1
#define SLIDER_CANCEL_IDC           -1