unit BASS_DSHOW;

{
  BASS_DSHOW 2.4 Delphi unit
  Copyright (c) 2009-2010 Cristea Aurel Ionut.

}


interface

uses
  Windows,bass;
  const
  {BASS_DSHOW Plugin CLSID}
   CLSID_DSHOWPLUGIN: TGUID = '{00000000-0000-0000-0000-000000000000}';
  BASS_DSHOW_VERSION = $20402;             // API version
  BASS_DSHOW_VERSIONTEXT = '2.4.2';         //TEXT version

 type
 HWINDOW = DWORD;

//for Mix_StreamCreate function
PTMixingFiles = ^TMixingFiles ;
TMixingFiles = array[0..15] of PCHAR;

/////////////CALLBACKS///////////////////
///
 TCallBackEnumEncoderFilter = function(Filter : Pointer; FilterName: PChar) : BOOL; stdcall;
 TCallBackConnectedFilters  = function(Filter : Pointer; FilterName: PChar;pp:BOOL;user:pointer) : BOOL; stdcall;
 TCallBackEnumDevices       = function(device: PChar;user:Pointer) : BOOL; stdcall; TCallBackChannelDVDChange  = function(oldChan:HSTREAM;newChan:HSTREAM;user: Pointer):BOOL;stdcall;




 /////////////////////////////////////////
//for BASS_DSHOW_ChannelGetInfo function
PBASS_DSVIDEOINFO= ^TBASS_DSVIDEOINFO;
TBASS_DSVIDEOINFO = record
     AvgTimePerFrame : Double;
     Height, Width : integer;
end;
//for BASS_DSHOW_ChannelSetConfig function
PTTextOverlayStruct = ^TTextOverlayStruct;
TTextOverlayStruct = record
    x:     integer;       //x position
    y:     integer;       //y position
    red:   integer;       //0 ..255
    green: integer;       //0 ..255
    blue : integer;       //0 ..255
    txtfont: HFONT;
end;

PTVideoColors = ^TVideoColors;
TVideoColors=record
  HUE: integer;            //-180...180
  Contrast: integer;       //0...128
  Brightness: integer;     //-128...128.
  Saturation: integer;     //0...128
end;

const                    /////flags
DLLNAME                       =   'BASS_DSHOW.DLL';
BASS_DSHOW_DECODE             =   BASS_STREAM_DECODE;


 ///////BASS_ChannelSetAttribute Constants
 const
   BASS_ATTRIB_FREQ2 = 1002;
   BASS_ATTRIB_TEMPO_PITCH = $10001;

//for BASS_DSHOW_SetConfig function
DSHOW_VMRWINDOW               =    $1001;         //VMR need an initial window so set a HWND to use properly VMR
BASS_DSHOW_VideoRenderer      =    $1000;
BASS_DSHOW_USEDefault         =    1;          //pass this to select default video render
BASS_DSHOW_USEOverlay         =    2;          //pass this to select overlay video render
BASS_DSHOW_USEVMR             =    3;          //pass this to setconfig option to turn on/off VMR
BASS_DSHOW_USENONE            =    4;          //pass this to select NULL Video Renderer

//for BASS_DSHOW_DVDSetOption
DVD_TITLE                     =   100;
DVD_ROOT                      =   101;          //go to DVD root
DVD_NEXTCHAPTER               =   102;          //go to dvd next chapter
DVD_PREVCHAPTER               =   103;          //go to dvd previous chapter
//for BASS_DSHOW_DVDGetProp
DSHOW_DVDCurrentTitle           =$10010;     //used in prop
DSHOW_DVDCurrentTitleTime       =   145;
DSHOW_DVDCurrentTitlePosition   =   146;

// BASS_DSHOW_ChannelSetOption function flags
DSHOW_Overlay                 =   1002;
DSHOW_OverlayText             =   1003;
DSHOW_OverlayProp             =   1004;
DSHOW_CONFIG_PITCH            =   1007;
DSHOW_CheckChannel            =   1009;         //for sync with a channel when first is a decoded one
DSHOW_4p3                     =   1010;
DSHOW_16p9                    =   1011;
DSHOW_AspectRatio             =   1012;
DSHOW_GetBitmap               =   1013;
DSHOW_VideoColors             =   1014;
//for BASS_DSHOW_MultiVideoSetOption
Dshow_MultivideoParent        =    432 ;
////////BASS_DSHOW_MIX_ChanOptions //////////////////////
BASS_DSHOW_MixRect           =    2000;
BASS_DSHOW_MixAlpha          =    2001;

///Recorder Flags///
Record_AudioDevices            =  5000;
Record_VideoDevices            =  5001;

//ERROR CODES
BASS_DSHOW_OK                 =    BASS_OK;          //all is ok
BASS_DSHOW_INVALIDCHAN        =    BASS_ERROR_HANDLE;          //invalid channel
BASS_DSHOW_BADFILENAME        =    BASS_ERROR_FILEOPEN;
BASS_DSHOW_Unknown            =    BASS_ERROR_UNKNOWN;
BASS_DSHOW_ERROR1             =    107;  //this is returned by set dvd menu function
BASS_DSHOW_ERROR2             =    108;  // next chapter failed
BASS_DSHOW_ERROR3             =    109; //prev chapter failed
BASS_DSHOW_ERROR4             =    110;  // title menu failed
BASS_DSHOW_ERROR5             =    111;  //graph creation failed
BASS_DSHOW_ERROR6             =    112;  //DVD Graph creation failed
BASS_DSHOW_ERROR7             =    114;
BASS_DSHOW_ERROR8             =    115; //NO DVD Decoder found




///
///
function  BASS_DSHOW_GetVersion(): DWORD; stdcall; external DLLNAME;
function  BASS_DSHOW_StreamCreateURL( str: PCHAR;flags: DWORD): HSTREAM;  stdcall; external DLLNAME;
function  BASS_DSHOW_StreamCreateFile(str: PCHAR;flags: DWORD):HSTREAM;stdcall; external DLLNAME;
function  BASS_DSHOW_Init(handle: HWND):bool;stdcall; external DLLNAME;
procedure BASS_DSHOW_ChannelSetPosition(chan: HSTREAM;pos: QWORD);stdcall;   external DLLNAME;
function  BASS_DSHOW_ChannelGetLength(chan: HSTREAM): QWORD; stdcall;  external DLLNAME;
function  BASS_DSHOW_ChannelGetPosition(chan: HSTREAM): QWORD;    stdcall;  external DLLNAME;
procedure BASS_DSHOW_ChannelSetWindow(chan: HSTREAM;handle: HWND);stdcall;   external DLLNAME;
procedure BASS_DSHOW_ChannelResizeWindow(chan: HSTREAM;left,top,right,bottom: integer);stdcall; external DLLNAME;
procedure BASS_DSHOW_ChannelSetFullscreen(chan: HSTREAM;value: boolean);stdcall; external DLLNAME;
function  BASS_DSHOW_ChannelPlay(chan: HSTREAM):bool;stdcall;  external DLLNAME;
function  BASS_DSHOW_ChannelPause(chan: HSTREAM):bool;stdcall;  external DLLNAME;
function  BASS_DSHOW_StreamFree(chan: HStream): bool; stdcall;  external DLLNAME;
function  BASS_DSHOW_ChannelStop(chan: HStream): bool; stdcall;  external DLLNAME;
procedure BASS_DSHOW_ChannelGetInfo(chan: HSTREAM;value: PBASS_DSVIDEOINFO);stdcall; external DLLNAME;
function  BASS_DSHOW_StreamCreateDVD(dvdfile: Pointer;flags:DWORD):HSTREAM;stdcall; external DLLNAME;
function  BASS_DSHOW_DVDSetOption(chan: HStream;option: DWORD;value: DWORD): bool; stdcall;  external DLLNAME;
function  BASS_DSHOW_DVDGetProp(Chan: HSTREAM; prop: DWORD; value: DWORD): DWORD; stdcall; external DLLNAME;
procedure BASS_DSHOW_SetConfig(config: integer;value: integer);   stdcall;  external DLLNAME;
function  BASS_DSHOW_ErrorGetCode(): DWORD; stdcall;  external DLLNAME;
procedure BASS_DSHOW_LoadPlugin(str: pchar;guid :TGUID;name: PCHAR);   stdcall;  external DLLNAME;
procedure BASS_DSHOW_LoadPlugin2(str: Pointer;guid :Pointer;name: Pointer;flags: DWORD);   stdcall;  external DLLNAME;
procedure BASS_DSHOW_ChannelSetOption(chan:HSTREAM;option:DWORD;value:DWORD;value2: pointer);     stdcall;  external DLLNAME;
function  BASS_DSHOW_Free(): BOOL; stdcall;  external DLLNAME;
procedure BASS_DSHOW_ChannelGetConnectedFilters(chan: HSTREAM;callback :Pointer;user:Pointer);stdcall; external DLLNAME;      //2.4.1
procedure BASS_DSHOW_ShowFilterPropertyPage(chan:HSTREAM;filter:DWORD;hndparent: HWND);  stdcall; external DLLNAME;      //2.4.1
function  BASS_DSHOW_MIX_StreamCreateFile(files: TMixingFiles;fileno: integer;flags: DWORD): HSTREAM;    stdcall;  external DLLNAME;
function  BASS_DSHOW_MIX_ChanOptions(chan: HSTREAM;option:DWORD;value: DWORD;value2: DWORD;rect: TRECT): BOOL;   stdcall;  external DLLNAME;
procedure BASS_DSHOW_ChannelSetTextOverlay(chan: HSTREAM ;text:PCHAR;x, y, red, green, blue: integer;font :HFONT);   stdcall;  external DLLNAME;
function  BASS_DSHOW_GetGraph(chan: HSTREAM): Pointer;   stdcall;  external DLLNAME;
///////
function BASS_DSHOW_Record_GetDevices(devicetype: DWORD;callback: Pointer;user: Pointer): integer; stdcall; external DLLNAME;
function BASS_DSHOW_RecordStart(audiodevice: Integer;videodevice: Integer;devicetype: DWORD;flags: DWORD): HRECORD; stdcall; external DLLNAME;
function BASS_DSHOW_RecordFree(rec: HRECORD): BOOL; stdcall; external DLLNAME;


function  BASS_DSHOW_ChannelAddWindow( chan:HSTREAM;win:HWND): HWINDOW;  stdcall; external DLLNAME;
function  BASS_DSHOW_ChannelRemoveWindow(chan:HSTREAM;window:HWINDOW):BOOL;stdcall; external DLLNAME;
procedure BASS_DSHOW_MultiVideoResize(chan:HSTREAM;window:HWINDOW;left,top,width,height: integer); stdcall; external DLLNAME;
procedure BASS_DSHOW_MultiVideoSetOption(chan: HSTREAM; window: HWINDOW; option: DWORD; value: DWORD);stdcall; external DLLNAME;
function  BASS_DSHOW_ChannelGetFrame(chan: HSTREAM; frame: integer): HBITMAP; stdcall; external DLLNAME;
implementation
// END OF FILE /////////////////////////////////////////////////////////////////

end.
