/*
	GFZONE V2
	verificare ultima misiune
	de revizuit sistemul de misiuni
	de testat sistemul de wanted - refacut cu  PlayCrimeReportForPlayer daca e nevoie
	missions nu se salveaza
	de despawnat masina de la ds daca iese jucatorul in ds
	de iesit din ds cand jucatorul da esc
	de facut:
		-biz-uri
		-jobs
		-vip
		-nr/taxi/ha
		-events
		-comenzi de admin
	IDEI:
	-My Summer Car Quest.
	-Steel The Drug Case (clanuri)
	-Sistem de dedicatii cu PP
	-De adaugat CanQuitJob, CanGetWanted, CanJoinEvents

	JOB CONTRUCTOR
	-sa ai de carat chestii
	-sa ai de batut cuie/sudat

	-De verificat cand mori cu job-ul activ.
	-De sters masina daca jucatorul iesi cand este in ds.
*/


// INCLUDE
#include 		<a_samp>
#include 		<crashdetect>
#include 		<YSI\y_master>
#include 		<YSI\y_timers>
#include 		<YSI\y_va>
#include		<YSI\y_iterate>
#include 		<YSI\y_hooks>
#include 		<YSI\y_bit>
#include 		<a_mysql>
#include 		<sscanf2>
#include 		<zcmd>
#include 		<timestamptodate>
#include 		<streamer>
#include        <fly>
#include        <respray>
#include        <i_quat>
#include 		<callbacks>	
#define 		MAX_DIALOG_PREVIEW_MODELS 15
#define 		MAX_DIALOG_PREVIEW_TEXTSIZE 32
#include 		<PreviewModelDialog>



// DEFINE
#define        GAMEMODE_VERSION           "0.0.1"

#define         SQL_HOST            "cloud2-falkenstein.cloud-center.ro"
#define         SQL_USER            "client4347_user1"
#define         SQL_DATABASE        "client4347_db1"
#define         SQL_PASSWORD        "yeeStNuQ4nkqndNu"

#define 		COLOR_WHITE 		0xFFFFFFFF
#define         COLOR_BLUE          0x006EBBBB
#define 		COLOR_SERVER		0xA9C4E4FF
#define			COLOR_CLIENT        0xA9C4E4FF
#define 		COLOR_GREY			0xAFAFAFAA
#define 		COLOR_RED		    0xAA3333AA
#define 		COLOR_GRAD1			0xB4B5B7FF
#define 		COLOR_GRAD2		 	0xBFC0C2FF
#define 		COLOR_GRAD3 		0xCBCCCEFF
#define 		COLOR_GRAD4 		0xD8D8D8FF
#define 		COLOR_GRAD5 		0xE3E3E3FF
#define 		COLOR_FADE1			0xE6E6E6E6
#define 		COLOR_FADE2 		0xC8C8C8C8
#define 		COLOR_FADE3 		0xAAAAAAAA
#define 		COLOR_FADE4 		0x8C8C8C8C
#define 		COLOR_FADE5 		0x6E6E6E6E
#define 		COLOR_YELLOW 		0xDABB3EAA
#define 		COLOR_YELLOW2 		0xF5DEB3AA
#define 		COLOR_PURPLE 		0xC2A2DAAA
#define 		COLOR_LIGHTRED  	0xFF6347AA
#define			COLOR_HOTORANGE 	0xF97804FF
#define 		COLOR_TEAL          0x67AAB1FF
#define 		COLOR_NEWBIE		0xBED9EFFF
#define 		COLOR_LGREEN 		0xC9FFA6FF
#define 		COLOR_RED1 			0xFF0000AA
#define COLOR_CHARTREUSE 0x7FFF00FF
#define COLOR_CHOCOLATE 0xD2691EFF
#define COLOR_CONTROL 0xF0F0F0FF
#define COLOR_CONTROLDARK 0xA0A0A0FF
#define COLOR_CONTROLDARKDARK 0x696969FF
#define COLOR_CONTROLLIGHT 0xE3E3E3FF
#define COLOR_CONTROLLIGHTLIGHT 0xFFFFFFFF
#define COLOR_CONTROLTEXT 0x000000FF
#define COLOR_CORAL 0xFF7F50FF
#define COLOR_CORNFLOWERBLUE 0x6495EDFF
#define COLOR_CORNSILK 0xFFF8DCFF
#define COLOR_CRIMSON 0xDC143CFF
#define COLOR_CYAN 0x00FFFFFF
#define COLOR_DARKBLUE 0x00008BFF
#define COLOR_DARKCYAN 0x008B8BFF
#define COLOR_DARKGOLDENROD 0xB8860BFF 
#define COLOR_DARKGRAY 0xA9A9A9FF
#define COLOR_DARKGREEN 0x006400FF
#define COLOR_DARKKHAKI 0xBDB76BFF
#define COLOR_DARKMAGENTA 0x8B008BFF
#define COLOR_DARKOLIVEGREEN 0x556B2FFF
#define COLOR_DARKORANGE 0xFF8C00FF
#define COLOR_DARKORCHID 0x9932CCFF
#define COLOR_DARKRED 0x8B0000FF
#define COLOR_DARKSALMON 0xE9967AFF
#define COLOR_DARKSEAGREEN 0x8FBC8BFF
#define COLOR_DARKSLATEBLUE 0x483D8BFF
#define COLOR_DARKSLATEGRAY 0x2F4F4FFF
#define COLOR_DARKTURQUOISE 0x00CED1FF
#define COLOR_DARKVIOLET 0x9400D3FF
#define COLOR_DEEPPINK 0xFF1493FF
#define COLOR_DEEPSKYBLUE 0x00BFFFFF
#define COLOR_DESKTOP 0x000000FF
#define COLOR_DIMGRAY 0x696969FF
#define COLOR_DODGERBLUE 0x1E90FFFF
#define COLOR_FIREBRICK 0xB22222FF
#define COLOR_FLORALWHITE 0xFFFAF0FF
#define COLOR_FORESTGREEN 0x228B22FF
#define COLOR_FUCHSIA 0xFF00FFFF
#define COLOR_GAINSBORO 0xDCDCDCFF
#define COLOR_GHOSTWHITE 0xF8F8FFFF
#define COLOR_GOLD 0xFFD700FF
#define COLOR_GOLDENROD 0xDAA520FF
#define COLOR_GRADIENTACTIVECAPTION 0xB9D1EAFF
#define COLOR_GRADIENTINACTIVECAPTION 0xD7E4F2FF
#define COLOR_GRAY 0x808080FF
#define COLOR_GRAYTEXT 0x808080FF
#define COLOR_GREEN 0x008000FF
#define COLOR_GREENYELLOW 0xADFF2FFF
#define COLOR_HIGHLIGHT 0x3399FFFF
#define COLOR_HIGHLIGHTTEXT 0xFFFFFFFF
#define COLOR_HONEYDEW 0xF0FFF0FF
#define COLOR_HOTPINK 0xFF69B4FF
#define COLOR_HOTTRACK 0x0066CCFF
#define COLOR_INACTIVEBORDER 0xF4F7FCFF
#define COLOR_INACTIVECAPTION 0xBFCDDBFF
#define COLOR_INACTIVECAPTIONTEXT 0x434E54FF
#define COLOR_INDIANRED 0xCD5C5CFF
#define COLOR_INDIGO 0x4B0082FF
#define COLOR_INFO 0xFFFFE1FF
#define COLOR_INFOTEXT 0x000000FF
#define COLOR_IVORY 0xFFFFF0FF
#define COLOR_KHAKI 0xF0E68CFF
#define COLOR_LAVENDER 0xE6E6FAFF
#define COLOR_LAVENDERBLUSH 0xFFF0F5FF
#define COLOR_LAWNGREEN 0x7CFC00FF
#define COLOR_LEMONCHIFFON 0xFFFACDFF
#define COLOR_LIGHTBLUE 0xADD8E6FF
#define COLOR_LIGHTCORAL 0xF08080FF
#define COLOR_LIGHTCYAN 0xE0FFFFFF
#define COLOR_LIGHTGOLDENRODYELLOW 0xFAFAD2FF
#define COLOR_LIGHTGRAY 0xD3D3D3FF
#define COLOR_LIGHTGREEN 0x90EE90FF
#define COLOR_LIGHTPINK 0xFFB6C1FF
#define COLOR_LIGHTSALMON 0xFFA07AFF
#define COLOR_LIGHTSEAGREEN 0x20B2AAFF
#define COLOR_LIGHTSKYBLUE 0x87CEFAFF
#define COLOR_LIGHTSLATEGRAY 0x778899FF
#define COLOR_LIGHTSTEELBLUE 0xB0C4DEFF
#define COLOR_LIGHTYELLOW 0xFFFFE0FF
#define COLOR_LIME 0x00FF00FF
#define COLOR_LIMEGREEN 0x32CD32FF
#define COLOR_LINEN 0xFAF0E6FF
#define COLOR_MAGENTA 0xFF00FFFF
#define COLOR_MAROON 0x800000FF
#define COLOR_MEDIUMAQUAMARINE 0x66CDAAFF
#define COLOR_MEDIUMBLUE 0x0000CDFF
#define COLOR_MEDIUMORCHID 0xBA55D3FF
#define COLOR_MEDIUMPURPLE 0x9370DBFF
#define COLOR_MEDIUMSEAGREEN 0x3CB371FF
#define COLOR_MEDIUMSLATEBLUE 0x7B68EEFF
#define COLOR_MEDIUMSPRINGGREEN 0x00FA9AFF
#define COLOR_MEDIUMTURQUOISE 0x48D1CCFF
#define COLOR_MEDIUMVIOLETRED 0xC71585FF
#define COLOR_MENU 0xF0F0F0FF
#define COLOR_MENUBAR 0xF0F0F0FF
#define COLOR_MENUHIGHLIGHT 0x3399FFFF
#define COLOR_MENUTEXT 0x000000FF
#define COLOR_MIDNIGHTBLUE 0x191970FF
#define COLOR_MINTCREAM 0xF5FFFAFF
#define COLOR_MISTYROSE 0xFFE4E1FF
#define COLOR_MOCCASIN 0xFFE4B5FF
#define COLOR_NAVAJOWHITE 0xFFDEADFF
#define COLOR_NAVY 0x000080FF
#define COLOR_OLDLACE 0xFDF5E6FF
#define COLOR_OLIVE 0x808000FF
#define COLOR_OLIVEDRAB 0x6B8E23FF
#define COLOR_ORANGE 0xFFA500FF
#define COLOR_ORANGERED 0xFF4500FF
#define COLOR_ORCHID 0xDA70D6FF
#define COLOR_PALEGOLDENROD 0xEEE8AAFF
#define COLOR_PALEGREEN 0x98FB98FF
#define COLOR_PALETURQUOISE 0xAFEEEEFF
#define COLOR_PALEVIOLETRED 0xDB7093FF
#define COLOR_PAPAYAWHIP 0xFFEFD5FF
#define COLOR_PEACHPUFF 0xFFDAB9FF
#define COLOR_PERU 0xCD853FFF
#define COLOR_PINK 0xFFC0CBFF
#define COLOR_PLUM 0xDDA0DDFF
#define COLOR_POWDERBLUE 0xB0E0E6FF
#define COLOR_ROYALBLUE 0x4169E1FF
#define COLOR_SADDLEBROWN 0x8B4513FF
#define COLOR_SALMON 0xFA8072FF
#define COLOR_SANDYBROWN 0xF4A460FF
#define COLOR_SCROLLBAR 0xC8C8C8FF
#define COLOR_SEAGREEN 0x2E8B57FF
#define COLOR_SEASHELL 0xFFF5EEFF
#define COLOR_SIENNA 0xA0522DFF
#define COLOR_SILVER 0xC0C0C0FF
#define COLOR_SKYBLUE 0x87CEEBFF
#define COLOR_SLATEBLUE 0x6A5ACDFF
#define COLOR_SLATEGRAY 0x708090FF
#define COLOR_SNOW 0xFFFAFAFF
#define COLOR_SPRINGGREEN 0x00FF7FFF
#define COLOR_STEELBLUE 0x4682B4FF
#define COLOR_TAN 0xD2B48CFF
#define COLOR_TURQUOISE 0x40E0D0FF
#define COLOR_VIOLET 0xEE82EEFF
#define COLOR_WHEAT 0xF5DEB3FF
#define COLOR_WHITE 0xFFFFFFFF
#define COLOR_WHITESMOKE 0xF5F5F5FF
#define COLOR_WINDOW 0xFFFFFFFF
#define COLOR_WINDOWFRAME 0x646464FF
#define COLOR_WINDOWTEXT 0x000000FF

#define COLOR_GROVE 0x1d9b14E6
#define COLOR_LSV 0xccc80aE6
#define COLOR_TT 0x663e02E6
#define COLOR_BALLAS 0x8512baE6
#define COLOR_VLA 0x1dd1d1E6
#define COLOR_TM 0xb70b0bE6

#define MAX_DISPLAYED_STARS		24
#define NUM_INACTIVE_STARS		6
#define STARS_PER_ROW			10
#define ROW_HEIGHT				20.0	// The height between rows; no need to edit this.

#define         DIALOG_REGISTER     1
#define         DIALOG_LOGIN        2
#define         DIALOG_EMAIL        3
#define         DIALOG_GENDER       4
#define         DIALOG_AGE          5
#define         DIALOG_REFFERAL     6
#define         DIALOG_REFFERAL2    7
#define 		DIALOG_WANTEDON     8
#define         DIALOG_UNDERCOVER   9
#define         DIALOG_LICENSES     10
#define         DIALOG_LICSELL 	    11
#define         DIALOG_LICSELLM     12
#define         DIALOG_ERROR 	    13
#define         DIALOG_SELECTWAR    14
#define         DIALOG_WARSTATS   	15
#define			DIALOG_MYCARS       16
#define 		DIALOG_MYCARSACTION 17
#define 		DIALOG_GIVEPKEY     18
#define 		DIALOG_MYCARSPLATE  19 
#define 		DIALOG_VIPCARS		20
#define 		DIALOG_VIPCOLOR     21
#define 		DIALOG_VIPNAME      22
#define       	DIALOG_RENTCAR		23
#define     	DIALOG_TLOCATIONS   24
#define         DIALOG_LOADCARGO    25
#define         DIALOG_JOBSLOCATION 26
#define         DIALOG_GPS1         27
#define         DIALOG_GPS2         28
#define 		DIALOG_JOBHELP      29
#define 		DIALOG_CHOSERADIO	30
#define 		DIALOG_FACTIONS	    31
#define         CAR_AMOUNT          2000


#define MPH_KMH 1.609344
#define SCM SendClientMessage

#define     MAX_SVEHICLES           (2000)

#define 		function%0(%1) 		forward%0(%1); public%0(%1)
forward Kick_Ban ( playerid, bool: kickban ); public Kick_Ban ( playerid, bool: kickban ) return ( !kickban ) ? Kick ( playerid ) : Ban ( playerid );
#define KickEx(%1) 			SetTimerEx ( "Kick_Ban", 500, false, "ii", %1, false )
#define Ban(%1) 			SetTimerEx ( "Kick_Ban", 500, false, "ii", %1, true )


// VARIABILE
stock
	g_UpdateTimer = -1,
	g_aPreviousWantedLevel[MAX_PLAYERS],
	Text:g_aStarTextDraws[MAX_DISPLAYED_STARS - 1],
	Text:g_aInactiveStarTextDraws[NUM_INACTIVE_STARS - 6]
;
new NewBieMute[MAX_PLAYERS];
new NewBieCoolDown[MAX_PLAYERS];

new MySQL:handle;
new CanAdd;
new gString[526];
new gQuery[256];

new CreateZiar[1001][7][256];
new NewsPaper[10][256];
new CanCLineNr[1001];
new LoadNP[1001];
new HaveNP[1001];
new SellPaperInfo[1001][1001];

new DrugsTimer[1001];

new Tentative[MAX_PLAYERS];
new LastCarID[MAX_PLAYERS];
new Text:Clock[2];
new Text:ServerTextDraw;
new FillCar[MAX_PLAYERS];
new PaintJobP[2002];
new PColor1[2002];
new PColor2[2002];
new GPSID[1001];
new CarRadioID[1001];

new TimeAFK[1001];
new Float:PlayerPos[1001][3]; 

new ContractsPlayersID[1001];
new ContractsMoney[1001];
new nrContracts;
new PlayerText:InfoTD;
new PlayerText:PlayerNameTXD[MAX_PLAYERS];
new PlayerText:OnlineTXD[MAX_PLAYERS];
new PD;
new TaxiFare[1001];
new TaxiPrice[1001];
new Float:fuel[MAX_VEHICLES]; //fuel per vehicle

new SellingCarPos[1001][1001];
new SellingCarPrice[1001][1001];

new PillsCD[MAX_PLAYERS];
new TaxiPComandsID[1001];
new nrTPC;
new CanUseService[MAX_PLAYERS];
new RemoveTPCtimer[MAX_PLAYERS];
new TaxiPlayerC[MAX_PLAYERS];
new RemoveTPtimer[MAX_PLAYERS];
new PlayerText: wantedscade[MAX_PLAYERS];
new LawyerPrice[1001][1001];
new CanNews[1001];
enum licenseid
{
	ID,
	Money,
	LicID
};
new TaxiTimer[MAX_PLAYERS];
new LicenseID[MAX_PLAYERS][licenseid];

new PlayerText: jailtime[MAX_PLAYERS];

new nrmasinifactiune;

new objects[] = {1283,1350,1284,1315,1350,1351,1352,3516,3855,1490,1524,1525,1526,1527,1528,1529,1530,1531,3465,1676};

new nrhq;

new HouseNumber=0;

new SelectedPlayer[MAX_PLAYERS][100];

new	Float:BikersX;
new	Float:BikersY;
new	Float:BikersZ;
new	BikersActive = 0;
new	BikersNume1[256];
new	BikersNume2[256];
new	BikersNume3[256];
new	BikersN1 = 0;
new	BikersN2 = 0;
new	BikersN3 = 0;
new	BikersPrize1;
new	BikersPrize2;
new	BikersPrize3;
enum trkInfo
{
	ID,
	Type[256],
	Float:trX,
	Float:trZ,
	Float:trY
};
new TCargoInfo[100][trkInfo];


enum fmembers
{
	fTotalMembers,
	fMaxMembers,
	fMinLevel
};
new FactionMembers[15][fmembers];

enum svInteriorInfo
{
	ID,
	Job,
	Faction,
	Interior1,
	VW1,
	Interior2,
	VW2,
	Type,
	Float:X1,
	Float:Y1,
	Float:Z1,
	Float:X2,
	Float:Y2,
	Float:Z2
};
new SellDrugsInfo[1002][1002];
new PlayerText:WoodJobInfo[MAX_PLAYERS];
new PlayerText:WoodJobTask[MAX_PLAYERS];
new PlayerText:WoodJobLinie[MAX_PLAYERS];
new PlayerText:WoodJobBusteni[MAX_PLAYERS];
new PlayerText:WoodJobMoney[MAX_PLAYERS];
new PlayerText:MinerJobInfo[MAX_PLAYERS];
new PlayerText:MinerInfo1[MAX_PLAYERS];
new PlayerText:MinerLinie[MAX_PLAYERS];
new PlayerText:MinerInfo2[MAX_PLAYERS];
new PlayerText:MinerMoney[MAX_PLAYERS];
new PlayerText:TruckerJobInfo[MAX_PLAYERS];
new PlayerText:TruckerLine1[MAX_PLAYERS];
new PlayerText:TruckerLinie[MAX_PLAYERS];
new PlayerText:TruckerType[MAX_PLAYERS];
new PlayerText:TruckerMoney[MAX_PLAYERS];
new RentCarPID[2001];
new PRentCarID[1001];
new RentCarTimer[2001];
//----biz-------
enum svBiz
{
	ID,
	Type, /// 1 - 24/7 || 2 - rentcar
	Name[256],
	OwnerID,
	Float:bX,
	Float:bY,
	Float:bZ,
	VW,
	Interior,
	Float:iX,
	Float:iY,
	Float:iZ,
	Money,
	CanEnter,
	Fee,
	OwnerName[256],
	Text3D:TextID
};
new BizInfo[200][svBiz];
new nrBiz;
enum gpsEnum
{
	ID,
	Type,
	Float:gpX,
	Float:gpY,
	Float:gpZ,
	Name[256]
};
new nrGPS;
new GpsInfo[200][gpsEnum];
//-----DS-------
new dsCars;
enum dealerCarsInfo
{
	ID,
	Model,
	Speed,
	Price,
	Stock
};
new DealerCars[400][dealerCarsInfo];
new Text:DealerBox1[MAX_PLAYERS];
new Text:DealerBox2[MAX_PLAYERS];
new Text:DealerBox3[MAX_PLAYERS];
new Text:DealerBox4[MAX_PLAYERS];
new Text:DealerBox5[MAX_PLAYERS];
new Text:DealerModel[MAX_PLAYERS];
new Text:DealerName[MAX_PLAYERS];
new Text:DealerPrice[MAX_PLAYERS];
new Text:DealerPrice1[MAX_PLAYERS];
new Text:DealerSpeed[MAX_PLAYERS];
new Text:DealerStock[MAX_PLAYERS];
new Text:DealerCumpara[MAX_PLAYERS];
new Text:DealerAnuleaza[MAX_PLAYERS];
new Text:DealerInapoi[MAX_PLAYERS];
new Text:DealerInainte[MAX_PLAYERS];
new dsID[MAX_PLAYERS];
new dsCarID[MAX_PLAYERS];
enum personalcarsinfo
{
	ID,
	OwnerID,
	OwnerSQLID,
	Model,
	Float:cX,
	Float:cY,
	Float:cZ,
	Float:cR,
	Mode1,
	Mode2,
	Mode3,
	Mode4,
	Mode5,
	Mode6,
	Mode7,
	Mode8,
	Mode9,
	Mode10,
	Mode11,
	Mode12,
	Mode13,
	Mode14,
	Color1,
	Color2,
	PaintJob,
	Plate[256],
	Spawned,
	CarID,
	Timer,
	RainBow,
	RainBowI,
	Vip,
	ObjectID,
	Float:vX,
	Float:vY,
	Float:vZ,
	Float:rX,
	Float:rY,
	Float:rZ,
	VColor[256],
	VText[256],
	VStatus
};
new PersonalCars[10002][personalcarsinfo];
new EmptyPersonalCars[10002];
new PersonalSCars[2002];
new PCarMaxID;
new MyCarID[MAX_PLAYERS];
new PVLock[10002][1001];
new GivePSkey[MAX_PLAYERS];
//-----turfs----

enum svTurfs
{
	tID,
	tOwnerID,
	tCity,
	tZoneID,
	tStatus,
	tVW,
	tKills1,
	tKills2,
	tTimer,
	tFac1,
	tFac2,
	Float: tMaxX,
	Float: tMaxY,
	Float: tMinX,
	Float: tMinY
}
enum svTurfsCar
{
	Float:tX,
	Float:tY,
	Float:tZ,
	Float:tR
};
new TurfSpawn[3][5][svTurfsCar];
new TurfCarPos1[4][10][svTurfsCar];
new TurfCarPos2[4][10][svTurfsCar];
new TurfsInfo[200][svTurfs];
new TurfsNumber;
new TurfsOn[1001];
new FactionTurf[10];
new CanTurf[10];
new TurfCarID[10][10];
new TurfCarColor[10];
new TurfTimer[10];
new PlayerText:TextTurf0[MAX_PLAYERS];
new PlayerText:TextTurf1[MAX_PLAYERS];

//-----war------
new WarNumbers;
new WarStatus;
new WarID;
new WarZone;
new WarEndH;
new WarEndM;
new WarAlianceKills1;
new WarAlianceKills2;
new lWarID, lWarTime[256], lWarZID,  lWarWinnerID, lWarScore1, lWarScore2, lWarBestKiller[256], lWarBestKills;

enum wInfo
{
	ID,
	VW,
	Name[256],
	Float:x1,
	Float:x2,
	Float:y1,
	Float:y2,
};

new PlayerText:wTextdraw0[MAX_PLAYERS];
new PlayerText:wTextdraw1[MAX_PLAYERS];
new PlayerText:wTextdraw2[MAX_PLAYERS];
new PlayerText:wTextdraw3[MAX_PLAYERS];
new PlayerText:wTextdraw4[MAX_PLAYERS];
new PlayerText:wTextdraw5[MAX_PLAYERS];
new PlayerText:wTextdraw6[MAX_PLAYERS];
new PlayerText:wTextdraw7[MAX_PLAYERS];
new PlayerText:wTextdraw8[MAX_PLAYERS];
new PlayerText:wTextdraw9[MAX_PLAYERS];

new WarInfo[25][wInfo];
new WarCars[2005][3];
//----------
new PlayerText:FarmerJobInfo[MAX_PLAYERS];
new PlayerText:FarmerTime[MAX_PLAYERS];
new PlayerText:FarmerSpeed[MAX_PLAYERS];
new PlayerText:FarmerComeback[MAX_PLAYERS];
new PlayerText:FarmerLinie[MAX_PLAYERS];
new FarmerCarID[MAX_PLAYERS];
new FarmerTimer[MAX_PLAYERS];
new FarmerComeTimer[MAX_PLAYERS];
enum HouseCInfo
{
	Float:hcX,
	Float:hcY,
	Float:hcZ,
	Float:hcR,
	HouseID,
	Model,
	Color1,
	Color2,
	Plate[256],
	ID
};
new HouseCar[1000][HouseCInfo];
new HouseCarsNumber;
new CarHouse[2002];
enum HouseInfo
{
	Float:hX,
	Float:hY,
	Float:hZ,
	hName[256],
	hInterior
};
enum HouseInfos
{
	ID,
	hMoney,
	Float:hX1,
	Float:hX2,
	Float:hY1,
	Float:hY2,
	Float:hZ1,
	Float:hZ2,
	Float:hX3,
	Float:hY3,
	Float:hZ3,
	hInteriorID1,
	hInteriorID2,
	hOwnerName[256],
	hOwned,
	hName[256],
	hPrice,
	hRentPrice,
	hLevel,
	hPickup,
	Text3D:hTextID,
	hVW,
	hLock,
	hVehID
};

new svHouse[1000][HouseInfos];

new HouseCreateInfo[30][HouseInfo];

new SvHq[200][svInteriorInfo];

enum svMisInfo
{
	ID,
	Title[64],
	Description[64],
	Difficulty[64],
	Reward,
	Text1[64],
	Text2[64],
	Text3[64],
	Text4[64],
	Text5[64],
	Text6[64],
	Float:CP1X,
	Float:CP1Y,
	Float:CP1Z,
	Float:CP2X,
	Float:CP2Y,
	Float:CP2Z,
	Float:CP3X,
	Float:CP3Y,
	Float:CP3Z,
	Float:CP4X,
	Float:CP4Y,
	Float:CP4Z,
	Float:CP5X,
	Float:CP5Y,
	Float:CP5Z,
	Float:CP6X,
	Float:CP6Y,
	Float:CP6Z
};
new Missions[1000][svMisInfo];
new NrMissions;
new CurrentMission = 0;
new CreateMissions[MAX_PLAYERS][svMisInfo];
new dmEventGangZone;
enum dmEventSpawnPoints
{
	Float:dX,
	Float:dY,
	Float:dZ
};
new dmSpawnPoints[30][dmEventSpawnPoints];
new dmStatus;
new dmID;
new dmTimeLeft;
new dmMaxKills;
new dmMXID;
new PlayerText:dmTxd0[MAX_PLAYERS];
new PlayerText:dmTxd1[MAX_PLAYERS];
new PlayerText:dmTxd2[MAX_PLAYERS];
new PlayerText:dmTxd3[MAX_PLAYERS];
new NewsPaperStatus;

enum CPInfo
{
	Player,
	ID
};

new CP[MAX_PLAYERS][CPInfo];
//1- wanted cop
//2- mission
//3- bikers mission
//4- gps
//5- woodcutter
//6 - hitman
enum pInfo
{
	pID,
	pInDM,
	pDmKills,
    pPassword,
    pIP[25],
    pEmail,
    pGender,
    pAge,
    pRefferal,
    pRegisterStep,
    pAdmin,
    pHelper,
    pClub,
    pRClub,
    pFaction,
    pRFaction,
    pXp,
    pLvl,
    pMoney,
    pSkin,
    pFacName[60],
    pFacRank[60],
    pClubName[60],
    pClubRank[60],
    pWantedReason[60],
	pWanted,
	pWantedMinute,
	pInterior,
	pVW,
	pJailTime,
	pDuty,
	pUndercover,
	pCuff,
	pPillsid,
	pPillsnumber,
	pTicketid,
	pTicketMoney,
	Speed,
	pKills,
	pArrests,
	pTickets,
	pAssists,
	pFW,
	pPills,
	pPillsSold,
	pHealP,
	pCarLic,
	pWeaponLic,
	pFlyLic,
	pBoatLic,
	pLicID,
	pLicNumber,
	pLicMoney,
	pLicenseSold,
	pMissionid,
	pMissionCP,
	pMissionF,
	pLastMission,
	pLastOnlineDay,
	pLastOnlineMonth,
	pLastOnlineYear,
	pLastOnlineMinute,
	pLastOnlineHour,
	pHouseID,
	pTypeHome,
	pSpawnType,
	pChangeSpawnTimer,
	pBP,
	pBounty,
	Float:pMarkX,
    Float:pMarkY,
	Float:pMarkZ,
	pMarkInterior,
	pMarkVW,
	pWKills,
	pWDeaths,
	pLWarID,
	pCarPos[10],
	pMaxCars,
	pEditVName,
	pDrugs,
	pSeifDrugs,
	pMats,
	pSeifMats,
	pJob,
	pMatsP,
	pDrugsSkill,
	pCanGetDrugs,
	pCanQuitJob,
	pFaina,
	pBizID,
	pFishKG,
	pBusteni,
	pBusteniT,
	pIdConT,
	pMinerAur,
	pMinerArgint,
	pMinerCupru,
	pMinerFier,
	pTruckerCarID,
	pTruckerMoney,
	pTruckerCMoney,
	pTruckerTrailerID,
	pTruckerStatus,
	pTruckerPos,
	pLawyerSkill,
	pLawerFree,
	pTaxiRaport,
	pNrRaport,
	pHasContract,
	pContractMoney,
	pDoneContracts,
	pCancelContracts,
	pFailContracts,
	pPremiumPoints,
	pVIP,
	pOnlineSeconds,
	pPSeconds
};
new PlayerInfo[MAX_PLAYERS][pInfo];
new TruckerTrailerTimer[2001];
new TruckerTrailerPlayerID[2001];
new TruckerCarPlayerID[2001];
new Skins[16][16];

new Mute[MAX_PLAYERS];
new FMute[MAX_PLAYERS];
new CMute[MAX_PLAYERS];

enum svInfo {
	vID,
	vModel,
	Float: vLocation[3],
	Float: vAngle,
	vColor[2],
	vFaction,
	vRank,
	vJob,
	vNumberPlate[64]
};

enum SpeedT {
    PlayerText:UseBox,
    PlayerText:White1,
    PlayerText:White2,
    PlayerText:White3,
    PlayerText:White4,
    PlayerText:Car,
    PlayerText:Speed,
    PlayerText:Health,
    PlayerText:Fuel


    
};

new SpeedText[MAX_PLAYERS][SpeedT];


new ServerVehicles[MAX_SVEHICLES][svInfo];
new pdup;
new pddown;
new pdgatecheck1;
new pdgatecheck2;
new pdgarage;
new fbigate1;
new	fbigate2;
new fbi1;
new fbi2;
new nggate;
new nggateo;
new nggate2;
new nggateo2;
new sfpdpoarta1;
new sfpdpoarta2;
new sfpdpoartao;
new sfgate1o;
new sfgate1c;
new sfgate1status;
new sfgate2o;
new sfgate2c;
new sfgate2status;
new lastminute;
new lasthour;
new UNDERCOVER_MODELS[] = {
    1, 2, 3, 4, 5, 6, 7, 93,96,98
};

new UNDERCOVER_NAMES[][] = {
    "ID: 0", "ID: 1", "ID: 2", "ID: 3", "ID: 4", "ID: 5", "ID: 6", "ID: 7","ID: 8","ID: 9"
};
new HqTypeExit[][] = {
{"Pentru a iesi tasteaza \n{009933}/exit "},
{"Pentru a iesi in training tasteaza\n{009933}/exit"},
{"Pentru a iesi in jail tasteaza \n{009933}/exit"},
{"Pentru a iesi in HQ tasteaza \n{009933}/exit"},
{"Pentru a parasi acoperisul cladirii tasteaza \n{009933}/exit"}
};
new HqTypeEnter[][] = {
{"Pentru a intra tasteaza \n{009933}/enter "},
{"Pentru a intra in training tasteaza \n{009933}/enter"},
{"Pentru a intra in jail tasteaza \n{009933}/enter"},
{"Pentru a intra in HQ tasteaza \n{009933}/enter"},
{"Pentru a accesa  acoperisul cladirii tasteaza \n{009933}/enter"}
};
new VehicleNames[212][] = {
{"Landstalker"},{"Bravura"},{"Buffalo"},{"Linerunner"},{"Perrenial"},{"Sentinel"},{"Dumper"},
{"Firetruck"},{"Trashmaster"},{"Stretch"},{"Manana"},{"Infernus"},{"Voodoo"},{"Pony"},{"Mule"},
{"Cheetah"},{"Ambulance"},{"Leviathan"},{"Moonbeam"},{"Esperanto"},{"Taxi"},{"Washington"},
{"Bobcat"},{"Mr Whoopee"},{"BF Injection"},{"Hunter"},{"Premier"},{"Enforcer"},{"Securicar"},
{"Banshee"},{"Predator"},{"Bus"},{"Rhino"},{"Barracks"},{"Hotknife"},{"Trailer 1"},{"Previon"},
{"Coach"},{"Cabbie"},{"Stallion"},{"Rumpo"},{"RC Bandit"},{"Romero"},{"Packer"},{"Monster"},
{"Admiral"},{"Squalo"},{"Seasparrow"},{"Pizzaboy"},{"Tram"},{"Trailer 2"},{"Turismo"},
{"Speeder"},{"Reefer"},{"Tropic"},{"Flatbed"},{"Yankee"},{"Caddy"},{"Solair"},{"Berkley's RC Van"},
{"Skimmer"},{"PCJ-600"},{"Faggio"},{"Freeway"},{"RC Baron"},{"RC Raider"},{"Glendale"},{"Oceanic"},
{"Sanchez"},{"Sparrow"},{"Patriot"},{"Quad"},{"Coastguard"},{"Dinghy"},{"Hermes"},{"Sabre"},
{"Rustler"},{"ZR-350"},{"Walton"},{"Regina"},{"Comet"},{"BMX"},{"Burrito"},{"Camper"},{"Marquis"},
{"Baggage"},{"Dozer"},{"Maverick"},{"News Chopper"},{"Rancher"},{"FBI Rancher"},{"Virgo"},{"Greenwood"},
{"Jetmax"},{"Hotring"},{"Sandking"},{"Blista Compact"},{"Police Maverick"},{"Boxville"},{"Benson"},
{"Mesa"},{"RC Goblin"},{"Hotring Racer A"},{"Hotring Racer B"},{"Bloodring Banger"},{"Rancher"},
{"Super GT"},{"Elegant"},{"Journey"},{"Bike"},{"Mountain Bike"},{"Beagle"},{"Cropdust"},{"Stunt"},
{"Tanker"}, {"Roadtrain"},{"Nebula"},{"Majestic"},{"Buccaneer"},{"Shamal"},{"Hydra"},{"FCR-900"},
{"NRG-500"},{"HPV1000"},{"Cement Truck"},{"Tow Truck"},{"Fortune"},{"Cadrona"},{"FBI Truck"},
{"Willard"},{"Forklift"},{"Tractor"},{"Combine"},{"Feltzer"},{"Remington"},{"Slamvan"},
{"Blade"},{"Freight"},{"Streak"},{"Vortex"},{"Vincent"},{"Bullet"},{"Clover"},{"Sadler"},
{"Firetruck LA"},{"Hustler"},{"Intruder"},{"Primo"},{"Cargobob"},{"Tampa"},{"Sunrise"},{"Merit"},
{"Utility"},{"Nevada"},{"Yosemite"},{"Windsor"},{"Monster A"},{"Monster B"},{"Uranus"},{"Jester"},
{"Sultan"},{"Stratum"},{"Elegy"},{"Raindance"},{"RC Tiger"},{"Flash"},{"Tahoma"},{"Savanna"},
{"Bandito"},{"Freight Flat"},{"Streak Carriage"},{"Kart"},{"Mower"},{"Duneride"},{"Sweeper"},
{"Broadway"},{"Tornado"},{"AT-400"},{"DFT-30"},{"Huntley"},{"Stafford"},{"BF-400"},{"Newsvan"},
{"Tug"},{"Trailer 3"},{"Emperor"},{"Wayfarer"},{"Euros"},{"Hotdog"},{"Club"},{"Freight Carriage"},
{"Trailer 3"},{"Andromada"},{"Dodo"},{"RC Cam"},{"Launch"},{"Police Car (LSPD)"},{"Police Car (SFPD)"},
{"Police Car (LVPD)"},{"Police Ranger"},{"Picador"},{"S.W.A.T. Van"},{"Alpha"},{"Phoenix"},{"Glendale"},
{"Sadler"},{"Luggage Trailer A"},{"Luggage Trailer B"},{"Stair Trailer"},{"Boxville"},{"Farm Plow"},
{"Utility Trailer"}
};
// Forward
forward pdgate1();
forward ExitDmEvent(playerid);
forward CreateWarCars();
forward StartWarTXD(playerid);
forward UpdatePWarTXD(killerid, deathid);
forward UpdateAWarTXD();
forward StopWarTXD(playerid);
forward EndWarFunctions();
forward CheckCP();
forward SecondTimer();
forward pdgate2();
forward fbi2gate();
forward fbi1gate();
forward IsPlayerAtFuelStation(playerid);
forward nggateopen();
forward nggateopen2();
forward sfgate1();
forward sfpdpoartaopen();
forward sfgate2();
forward UpdateTime();
forward UpdateLicenses();
forward InitRegister(playerid);
forward ResetLicenseTimer(playerid);

main(){}

// PUBLICE

AntiDeAMX()
{
	printf("AntiDeAMX loaded\n");
    new antidamx[][] =
    {
		"Unarmed (Fist)",
		"Brass K",
		"Fire Ex"
	};
	#pragma unused antidamx
}

public OnGameModeInit()
{
	if(GetMaxPlayers() > MAX_PLAYERS)
    {
        SendRconCommand("hostname Error Check Logs!");
        SendRconCommand("password bahr4h25h");
 
        printf("[ERROR]: 'maxplayers' (%i) exceeds MAX_PLAYERS (%i). Please fix this.", GetMaxPlayers(), MAX_PLAYERS);
    }
	AddPlayerClass(0, 1958.33, 1343.12, 15.36, 269.15, 0, 0, 0, 0, 0, 0);
    LimitPlayerMarkerRadius(75.0);
    new Hour, Minute, Second; //Top of the function
	gettime(Hour, Minute, Second); //Top of the function
	lastminute=Minute;
	format(gString, sizeof(gString), "PLAYNION %s", GAMEMODE_VERSION);
	SetGameModeText(gString);
	
	UsePlayerPedAnims();

	DisableInteriorEnterExits();
	SetNameTagDrawDistance(30);

	EnableStuntBonusForAll(0);
	DatabaseConnect();

    LoadSVehicles();
    LoadHQ();
    LoadSvHouse();
    LoadMissions();
    LoadWarInfo();
    LoadTurfInfo();
    LoadHouseCars();
    LoadDsCars();
    LoadBiz();
    LoadGPS();
    LoadFactionMembers();

    new string[256];
	format(string, sizeof(string), "SELECT * FROM `personalcars` ORDER BY `personalcars`.`ID` DESC");
	new Cache: db = mysql_query (handle, string);
	cache_get_value_name(0, "ID", string); 					PCarMaxID = strval(string);
	cache_delete(db);
	ServerTextDraw = TextDrawCreate(546.666503, 428.503631, "PLAYNION.RO");
	TextDrawLetterSize(ServerTextDraw, 0.449999, 1.600000);
	TextDrawAlignment(ServerTextDraw, 1);
	TextDrawColor(ServerTextDraw, -1);
	TextDrawSetShadow(ServerTextDraw, 0);
	TextDrawSetOutline(ServerTextDraw, 1);
	TextDrawBackgroundColor(ServerTextDraw, 51);
	TextDrawFont(ServerTextDraw, 3);
	TextDrawSetProportional(ServerTextDraw, 1);

	Clock[0] = TextDrawCreate(576.267517, 13.818528, "05.02.2015");
    TextDrawLetterSize(Clock[0], 0.275997, 1.409183);
    TextDrawAlignment(Clock[0], 2);
    TextDrawColor(Clock[0], -1);
    TextDrawSetShadow(Clock[0], 0);
    TextDrawSetOutline(Clock[0], 1);
    TextDrawBackgroundColor(Clock[0], 255);
    TextDrawFont(Clock[0], 3);
    TextDrawSetProportional(Clock[0], 1);
    TextDrawSetShadow(Clock[0], 0);

	Clock[1] = TextDrawCreate(576.400695, 25.018529, "15:27");
 	TextDrawLetterSize(Clock[1], 0.512664, 2.551999);
    TextDrawAlignment(Clock[1], 2);
    TextDrawColor(Clock[1], -1);
    TextDrawSetShadow(Clock[1], 0);
    TextDrawSetOutline(Clock[1], 1);
    TextDrawBackgroundColor(Clock[1], 255);
    TextDrawFont(Clock[1], 3);
    TextDrawSetProportional(Clock[1], 1);
    TextDrawSetShadow(Clock[1], 0);

    for(new i=0;i<MAX_VEHICLES;i++) {
	    fuel[i] = 100; //sets every car's fuel to 100 in a loop
	}
	SetTimer("UpdateTime", 6000, true);
	SetTimer("SecondTimer",1000,true);
	SetTimer("UpdateLicenses",60000,true);
	
	AntiDeAMX();
	//
	CreateObject(977, 371.01654, 166.47404, 1008.46973,   0.00000, 0.00000, 10.00000);
	CreateObject(2603, 357.25201, 200.59140, 1007.79999,   0.00000, 0.00000, 90.00000);
	CreateObject(2603, 357.25201, 204.17300, 1007.79999,   0.00000, 0.00000, 90.00000);
	CreateObject(19466, 354.61890, 205.72050, 1007.90100,   0.00000, 0.00000, 90.00000);
	CreateObject(19466, 363.55029, 205.72050, 1007.90100,   0.00000, 0.00000, 90.00000);
	CreateObject(19466, 361.31100, 205.72050, 1007.90100,   0.00000, 0.00000, 90.00000);
	CreateObject(19466, 359.07449, 205.72050, 1007.90100,   0.00000, 0.00000, 90.00000);
	CreateObject(19466, 356.84079, 205.72050, 1007.90100,   0.00000, 0.00000, 90.00000);
	CreateObject(19466, 356.84079, 205.72050, 1009.82098,   0.00000, 0.00000, 90.00000);
	CreateObject(19466, 354.61890, 205.72050, 1009.82098,   0.00000, 0.00000, 90.00000);
	CreateObject(19466, 359.07449, 205.72050, 1009.82098,   0.00000, 0.00000, 90.00000);
	CreateObject(19466, 361.31100, 205.72050, 1009.82098,   0.00000, 0.00000, 90.00000);
	CreateObject(2603, 363.51031, 204.17300, 1007.79999,   0.00000, 0.00000, 90.00000);
	CreateObject(2603, 360.45450, 204.17300, 1007.79999,   0.00000, 0.00000, 90.00000);
	CreateObject(2603, 363.51035, 200.59138, 1007.79999,   0.00000, 0.00000, 90.00000);
	CreateObject(2603, 360.45450, 200.59140, 1007.79999,   0.00000, 0.00000, 90.00000);
	CreateObject(2002, 353.94949, 202.24361, 1007.38342,   0.00000, 0.00000, 90.00000);
	CreateObject(1776, 353.84311, 203.50580, 1008.48743,   0.00000, 0.00000, 90.00000);
	CreateObject(1775, 353.94312, 204.99130, 1008.48743,   0.00000, 0.00000, 90.00000);
	CreateObject(2001, 361.45950, 199.38789, 1007.38110,   0.00000, 0.00000, 0.00000);
	CreateObject(2001, 364.44781, 199.38789, 1007.38110,   0.00000, 0.00000, 0.00000);
	CreateObject(2001, 364.44910, 205.18469, 1007.38110,   0.00000, 0.00000, 0.00000);
	CreateObject(2001, 361.51709, 205.18469, 1007.38110,   0.00000, 0.00000, 0.00000);
	CreateObject(2001, 358.32840, 205.18469, 1007.38110,   0.00000, 0.00000, 0.00000);
	CreateObject(2001, 358.24799, 199.38789, 1007.38110,   0.00000, 0.00000, 0.00000);
	CreateObject(19903, 359.44583, 214.03474, 1007.40131,   0.00000, 0.00000, -90.00000);
	CreateObject(19466, 363.55029, 205.72050, 1009.82098,   0.00000, 0.00000, 90.00000);
	CreateObject(3383, 356.91852, 213.60991, 1007.38348,   0.00000, 0.00000, 180.00000);
	CreateObject(3386, 354.04999, 213.60460, 1007.38208,   0.00000, 0.00000, 90.00000);
	CreateObject(3395, 360.93124, 206.49428, 1007.38190,   0.00000, 0.00000, -90.00000);
	CreateObject(3396, 357.19250, 206.45490, 1007.38330,   0.00000, 0.00000, -90.00000);
	CreateObject(3391, 364.12341, 211.06920, 1007.38232,   0.00000, 0.00000, 0.00000);
	CreateObject(18963, 355.65677, 213.52411, 1008.55402,   0.00000, -33.00000, 0.00000);
	CreateObject(19466, 353.32251, 200.14140, 1009.82098,   0.00000, 0.00000, 0.00000);
	CreateObject(19466, 364.89691, 204.59531, 1007.90100,   0.00000, 0.00000, 0.00000);
	CreateObject(19466, 364.89691, 202.36050, 1007.90100,   0.00000, 0.00000, 0.00000);
	CreateObject(19466, 364.89691, 200.12640, 1007.90100,   0.00000, 0.00000, 0.00000);
	CreateObject(19466, 364.89691, 202.36050, 1009.82098,   0.00000, 0.00000, 0.00000);
	CreateObject(19466, 364.89691, 200.12640, 1009.82098,   0.00000, 0.00000, 0.00000);
	CreateObject(19466, 363.55029, 205.72050, 1009.82098,   0.00000, 0.00000, 90.00000);
	CreateObject(19466, 363.70520, 198.83279, 1009.80939,   0.00000, 0.00000, 90.00000);
	CreateObject(19466, 361.46552, 198.83279, 1009.82098,   0.00000, 0.00000, 90.00000);
	CreateObject(19466, 359.22910, 198.83279, 1009.82098,   0.00000, 0.00000, 90.00000);
	CreateObject(19466, 363.68521, 198.83279, 1007.90100,   0.00000, 0.00000, 90.00000);
	CreateObject(19466, 361.44550, 198.83279, 1007.90100,   0.00000, 0.00000, 90.00000);
	CreateObject(19466, 359.20911, 198.83279, 1007.90100,   0.00000, 0.00000, 90.00000);
	CreateObject(19466, 357.01071, 198.83279, 1007.90100,   0.00000, 0.00000, 90.00000);
	CreateObject(19466, 364.89691, 204.59531, 1009.82098,   0.00000, 0.00000, 0.00000);
	CreateObject(19466, 353.32251, 204.59441, 1009.82098,   0.00000, 0.00000, 0.00000);
	CreateObject(19466, 353.32251, 202.36349, 1009.82098,   0.00000, 0.00000, 0.00000);
	CreateObject(19466, 353.32251, 200.14140, 1007.90100,   0.00000, 0.00000, 0.00000);
	CreateObject(19466, 353.32251, 202.36349, 1007.90100,   0.00000, 0.00000, 0.00000);
	CreateObject(19466, 353.32251, 204.59441, 1007.90100,   0.00000, 0.00000, 0.00000);
	CreateObject(19466, 363.55029, 205.72050, 1009.82098,   0.00000, 0.00000, 90.00000);
	CreateObject(19466, 361.20319, 214.49210, 1009.82098,   0.00000, 0.00000, 90.00000);
	CreateObject(19466, 358.97229, 214.49210, 1009.82098,   0.00000, 0.00000, 90.00000);
	CreateObject(19466, 356.74069, 214.49210, 1009.82098,   0.00000, 0.00000, 90.00000);
	CreateObject(19466, 361.20319, 214.49210, 1007.90100,   0.00000, 0.00000, 90.00000);
	CreateObject(19466, 358.97229, 214.49210, 1007.90100,   0.00000, 0.00000, 90.00000);
	CreateObject(19466, 356.74069, 214.49210, 1007.90100,   0.00000, 0.00000, 90.00000);
	CreateObject(19466, 354.51419, 214.49210, 1007.90100,   0.00000, 0.00000, 90.00000);
	CreateObject(19466, 354.51419, 214.49210, 1009.82098,   0.00000, 0.00000, 90.00000);
	CreateObject(19466, 353.28781, 211.50459, 1009.80518,   0.00000, 0.00000, 0.00000);
	CreateObject(19466, 353.28781, 213.46460, 1009.80688,   0.00000, 0.00000, 0.00000);
	CreateObject(19466, 353.28781, 209.26460, 1007.90100,   0.00000, 0.00000, 0.00000);
	CreateObject(19466, 353.28781, 211.50459, 1007.90100,   0.00000, 0.00000, 0.00000);
	CreateObject(19466, 353.28781, 213.46460, 1007.90100,   0.00000, 0.00000, 0.00000);
	CreateObject(19466, 353.28781, 209.26460, 1009.82098,   0.00000, 0.00000, 0.00000);
	CreateObject(19466, 364.95630, 211.50920, 1009.82098,   0.00000, 0.00000, 0.00000);
	CreateObject(19466, 364.95630, 213.45760, 1009.80133,   0.00000, 0.00000, 0.00000);
	CreateObject(19466, 364.95630, 209.28281, 1007.90100,   0.00000, 0.00000, 0.00000);
	CreateObject(19466, 364.95630, 211.50920, 1007.90100,   0.00000, 0.00000, 0.00000);
	CreateObject(19466, 364.95630, 213.45760, 1007.90100,   0.00000, 0.00000, 0.00000);
	CreateObject(19325, 369.00021, 182.77310, 1008.70630,   0.00000, 0.00000, 0.00000);
	CreateObject(19325, 369.00021, 189.41310, 1008.70630,   0.00000, 0.00000, 0.00000);
	CreateObject(19325, 374.82120, 179.48480, 1008.70630,   0.00000, 0.00000, 90.00000);
	
	///Truckers

	TCargoInfo[1][ID] = 1; TCargoInfo[1][trX] = 1008.2728; TCargoInfo[1][trY] = -904.4464; TCargoInfo[1][trZ] = 42.1954; format(TCargoInfo[1][Type], 256, "Panificatie");
	TCargoInfo[2][ID] = 1; TCargoInfo[2][trX] = 1838.4231; TCargoInfo[2][trY] = -1867.4596; TCargoInfo[2][trZ] = 13.3897; format(TCargoInfo[2][Type], 256, "Panificatie");
	TCargoInfo[3][ID] = 1; TCargoInfo[3][trX] = 1350.3684; TCargoInfo[3][trY] = -1748.8843; TCargoInfo[3][trZ] = 13.3699; format(TCargoInfo[3][Type], 256, "Panificatie");
	TCargoInfo[4][ID] = 1; TCargoInfo[4][trX] = -2040.1454; TCargoInfo[4][trY] = 135.6220; TCargoInfo[4][trZ] = 28.8359; format(TCargoInfo[4][Type], 256, "Panificatie");
	TCargoInfo[5][ID] = 1; TCargoInfo[5][trX] = 2110.7368; TCargoInfo[5][trY] = 900.8420; TCargoInfo[5][trZ] = 10.8203; format(TCargoInfo[5][Type], 256, "Panificatie");
	TCargoInfo[6][ID] = 1; TCargoInfo[6][trX] = 2645.9683; TCargoInfo[6][trY] = 1125.5464; TCargoInfo[6][trZ] = 10.8203; format(TCargoInfo[6][Type], 256, "Panificatie");

	TCargoInfo[7][ID]  = 2; TCargoInfo[7][trX] = 1004.2475; TCargoInfo[7][trY] = -937.9796; TCargoInfo[7][trZ] = 42.1797; format(TCargoInfo[7][Type], 256, "Combustibil");
	TCargoInfo[8][ID]  = 2; TCargoInfo[8][trX] = 1943.6311; TCargoInfo[8][trY] = -1772.9531; TCargoInfo[8][trZ] = 13.3906; format(TCargoInfo[8][Type], 256, "Combustibil");
	TCargoInfo[9][ID]  = 2; TCargoInfo[9][trX] = -1606.3761; TCargoInfo[9][trY] = -2713.7097; TCargoInfo[9][trZ] = 48.5335; format(TCargoInfo[9][Type], 256, "Combustibil");
	TCargoInfo[10][ID] = 2; TCargoInfo[10][trX] = -2026.5939; TCargoInfo[10][trY] = 156.7059; TCargoInfo[10][trZ] = 29.0391; format(TCargoInfo[10][Type], 256, "Combustibil");
	TCargoInfo[11][ID] = 2; TCargoInfo[11][trX] = -1328.9844; TCargoInfo[11][trY] = 2677.9714; TCargoInfo[11][trZ] = 50.0625; format(TCargoInfo[11][Type], 256, "Combustibil");
	TCargoInfo[12][ID] = 2; TCargoInfo[12][trX] = 608.8265; TCargoInfo[12][trY] = 1699.7535; TCargoInfo[12][trZ] = 6.9922; format(TCargoInfo[12][Type], 256, "Combustibil");
	///TCargoInfo[13][ID] = 5; TCargoInfo[13][trX] = 90.6712; TCargoInfo[13][trY] = -1168.1633; TCargoInfo[13][trZ] = 2.4245; format(TCargoInfo[13][Type], 256, "Combustibil");
	TCargoInfo[14][ID] = 2; TCargoInfo[14][trX] = 655.5261; TCargoInfo[14][trY] = -564.8308; TCargoInfo[14][trZ] = 16.3359; format(TCargoInfo[14][Type], 256, "Combustibil");
	TCargoInfo[15][ID] = 2; TCargoInfo[15][trX] = 608.8265; TCargoInfo[15][trY] = 1699.7535; TCargoInfo[15][trZ] = 6.9922; format(TCargoInfo[15][Type], 256, "Combustibil");
	TCargoInfo[16][ID] = 2; TCargoInfo[16][trX] = -1675.6821; TCargoInfo[16][trY] = 412.9916; TCargoInfo[16][trZ] = 7.1797; format(TCargoInfo[16][Type], 256, "Combustibil");
	TCargoInfo[17][ID] = 2; TCargoInfo[17][trX] = -2409.4727; TCargoInfo[17][trY] = 975.9866; TCargoInfo[17][trZ] = 45.2969; format(TCargoInfo[17][Type], 256, "Combustibil");
	TCargoInfo[18][ID] = 2; TCargoInfo[18][trX] = 2114.4636; TCargoInfo[18][trY] = 920.2435; TCargoInfo[18][trZ] = 10.8203; format(TCargoInfo[18][Type], 256, "Combustibil");

	TCargoInfo[19][ID] = 3; TCargoInfo[19][trX] = 2719.6570; TCargoInfo[19][trY] = 853.2819; TCargoInfo[19][trZ] = 10.8984; format(TCargoInfo[19][Type], 256, "Metale");
	TCargoInfo[20][ID] = 3; TCargoInfo[20][trX] = 2466.9924; TCargoInfo[20][trY] = 1947.0571; TCargoInfo[20][trZ] = 10.2133; format(TCargoInfo[20][Type], 256, "Metale");
	TCargoInfo[21][ID] = 3; TCargoInfo[21][trX] = 863.0157; TCargoInfo[21][trY] = -33.2323; TCargoInfo[21][trZ] = 63.1953; format(TCargoInfo[21][Type], 256, "Metale");
	TCargoInfo[22][ID] = 3; TCargoInfo[22][trX] = -2105.1125; TCargoInfo[22][trY] = 210.1036; TCargoInfo[22][trZ] = 35.2591; format(TCargoInfo[22][Type], 256, "Metale");
	TCargoInfo[23][ID] = 3; TCargoInfo[23][trX] = -2401.2542; TCargoInfo[23][trY] = 2349.3899; TCargoInfo[23][trZ] = 4.9844; format(TCargoInfo[23][Type], 256, "Metale");
	TCargoInfo[24][ID] = 3; TCargoInfo[24][trX] = -753.7741; TCargoInfo[24][trY] = 1559.5599; TCargoInfo[24][trZ] = 26.9609; format(TCargoInfo[24][Type], 256, "Metale");

	TCargoInfo[25][ID] = 4; TCargoInfo[25][trX] = 2719.6570; TCargoInfo[25][trY] = 853.2819; TCargoInfo[25][trZ] = 10.8984; format(TCargoInfo[25][Type], 256, "Cherestea");
	TCargoInfo[26][ID] = 4; TCargoInfo[26][trX] = 2466.9924; TCargoInfo[26][trY] = 1947.0571; TCargoInfo[26][trZ] = 10.2133; format(TCargoInfo[26][Type], 256, "Cherestea");
	TCargoInfo[27][ID] = 4; TCargoInfo[27][trX] = 863.0157; TCargoInfo[27][trY] = -33.2323; TCargoInfo[27][trZ] = 63.1953; format(TCargoInfo[27][Type], 256, "Cherestea");
	TCargoInfo[28][ID] = 4; TCargoInfo[28][trX] = -2105.1125; TCargoInfo[28][trY] = 210.1036; TCargoInfo[28][trZ] = 35.2591; format(TCargoInfo[28][Type], 256, "Cherestea");
	TCargoInfo[29][ID] = 4; TCargoInfo[29][trX] = -2401.2542; TCargoInfo[29][trY] = 2349.3899; TCargoInfo[29][trZ] = 4.9844; format(TCargoInfo[29][Type], 256, "Cherestea");
	TCargoInfo[30][ID] = 4; TCargoInfo[30][trX] = -753.7741; TCargoInfo[30][trY] = 1559.5599; TCargoInfo[30][trZ] = 26.9609; format(TCargoInfo[30][Type], 256, "Cherestea");
	///TurfCars
	///Aliance1
	///LS
	TurfCarPos1[1][1][tX] = 2496.6948; TurfCarPos1[1][1][tY] = -1683.1232; TurfCarPos1[1][1][tZ] = 13.2642; TurfCarPos1[1][1][tR] = 98.6844; 
	TurfCarPos1[1][2][tX] = 2507.0652; TurfCarPos1[1][2][tY] = -1676.9545; TurfCarPos1[1][2][tZ] = 13.3210; TurfCarPos1[1][2][tR] = 142.5202; 
	TurfCarPos1[1][3][tX] = 2508.8477; TurfCarPos1[1][3][tY] = -1666.5720; TurfCarPos1[1][3][tZ] = 13.3442; TurfCarPos1[1][3][tR] = 185.1735; 
	TurfCarPos1[1][4][tX] = 2458.6975; TurfCarPos1[1][4][tY] = -1653.9934; TurfCarPos1[1][4][tZ] = 13.1166; TurfCarPos1[1][4][tR] = 87.5264; 
	TurfCarPos1[1][5][tX] = 2471.3376; TurfCarPos1[1][5][tY] = -1653.9142; TurfCarPos1[1][5][tZ] = 13.1186; TurfCarPos1[1][5][tR] = 89.2778; 
	TurfCarPos1[1][6][tX] = 2473.3735; TurfCarPos1[1][6][tY] = -1691.4307; TurfCarPos1[1][6][tZ] = 13.6682; TurfCarPos1[1][6][tR] = 359.1097;
	///LV 
	TurfCarPos1[2][1][tX] = 2294.3503; TurfCarPos1[2][1][tY] = 618.2003; TurfCarPos1[2][1][tZ] = 10.5481; TurfCarPos1[2][1][tR] = 359.4745; 
	TurfCarPos1[2][2][tX] = 2294.2451; TurfCarPos1[2][2][tY] = 606.6879; TurfCarPos1[2][2][tZ] = 10.5474; TurfCarPos1[2][2][tR] = 359.4745; 
	TurfCarPos1[2][3][tX] = 2280.6611; TurfCarPos1[2][3][tY] = 616.7534; TurfCarPos1[2][3][tZ] = 10.5474; TurfCarPos1[2][3][tR] = 0.1978; 
	TurfCarPos1[2][4][tX] = 2280.7014; TurfCarPos1[2][4][tY] = 606.2729; TurfCarPos1[2][4][tZ] = 10.5473; TurfCarPos1[2][4][tR] = 0.1330; 
	TurfCarPos1[2][5][tX] = 2274.7793; TurfCarPos1[2][5][tY] = 625.5848; TurfCarPos1[2][5][tZ] = 10.5474; TurfCarPos1[2][5][tR] = 88.6784; 
	TurfCarPos1[2][6][tX] = 2299.8367; TurfCarPos1[2][6][tY] = 625.0883; TurfCarPos1[2][6][tZ] = 10.5474; TurfCarPos1[2][6][tR] = 270.8298;
	///SF
	TurfCarPos1[3][1][tX] = -2248.4233; TurfCarPos1[3][1][tY] = 635.8123; TurfCarPos1[3][1][tZ] = 48.6773; TurfCarPos1[3][1][tR] = 359.0471; 
	TurfCarPos1[3][2][tX] = -2248.4846; TurfCarPos1[3][2][tY] = 624.0909; TurfCarPos1[3][2][tZ] = 45.8857; TurfCarPos1[3][2][tR] = 1.2334; 
	TurfCarPos1[3][3][tX] = -2247.7776; TurfCarPos1[3][3][tY] = 651.6231; TurfCarPos1[3][3][tZ] = 49.1535; TurfCarPos1[3][3][tR] = 357.9499; 
	TurfCarPos1[3][4][tX] = -2248.4658; TurfCarPos1[3][4][tY] = 624.0912; TurfCarPos1[3][4][tZ] = 45.8823; TurfCarPos1[3][4][tR] = 0.6481; 
	TurfCarPos1[3][5][tX] = -2248.3384; TurfCarPos1[3][5][tY] = 611.7631; TurfCarPos1[3][5][tZ] = 42.8363; TurfCarPos1[3][5][tR] = 1.0015; 
	TurfCarPos1[3][6][tX] = -2247.8965; TurfCarPos1[3][6][tY] = 659.0448; TurfCarPos1[3][6][tZ] = 49.1494; TurfCarPos1[3][6][tR] = 357.7397;
	
	///Aliance2
	///LS
	TurfCarPos2[1][1][tX] = 670.4915; TurfCarPos2[1][1][tY] = -1286.6492; TurfCarPos2[1][1][tZ] = 13.3287; TurfCarPos2[1][1][tR] = 0.1718; 
	TurfCarPos2[1][2][tX] = 659.7745; TurfCarPos2[1][2][tY] = -1286.6012; TurfCarPos2[1][2][tZ] = 13.3277; TurfCarPos2[1][2][tR] = 2.3699; 
	TurfCarPos2[1][3][tX] = 659.6782; TurfCarPos2[1][3][tY] = -1263.0181; TurfCarPos2[1][3][tZ] = 13.2465; TurfCarPos2[1][3][tR] = 0.7749; 
	TurfCarPos2[1][4][tX] = 670.6943; TurfCarPos2[1][4][tY] = -1262.9916; TurfCarPos2[1][4][tZ] = 13.2362; TurfCarPos2[1][4][tR] = 0.4405; 
	TurfCarPos2[1][5][tX] = 685.5192; TurfCarPos2[1][5][tY] = -1260.1176; TurfCarPos2[1][5][tZ] = 13.4708; TurfCarPos2[1][5][tR] = 87.4289; 
	TurfCarPos2[1][6][tX] = 685.4229; TurfCarPos2[1][6][tY] = -1255.2982; TurfCarPos2[1][6][tZ] = 13.5009; TurfCarPos2[1][6][tR] = 89.5250;
	///LV 
	TurfCarPos2[2][1][tX] = 2025.8154; TurfCarPos2[2][1][tY] = 1018.2813; TurfCarPos2[2][1][tZ] = 10.5465; TurfCarPos2[2][1][tR] = 268.2379; 
	TurfCarPos2[2][2][tX] = 2025.3500; TurfCarPos2[2][2][tY] = 1027.6600; TurfCarPos2[2][2][tZ] = 10.5676; TurfCarPos2[2][2][tR] = 271.4910; 
	TurfCarPos2[2][3][tX] = 2026.2781; TurfCarPos2[2][3][tY] = 996.8256; TurfCarPos2[2][3][tZ] = 10.9330; TurfCarPos2[2][3][tR] = 270.8591; 
	TurfCarPos2[2][4][tX] = 2025.8295; TurfCarPos2[2][4][tY] = 988.0350; TurfCarPos2[2][4][tZ] = 10.5574; TurfCarPos2[2][4][tR] = 270.6566; 
	TurfCarPos2[2][5][tX] = 2038.7134; TurfCarPos2[2][5][tY] = 1013.9177; TurfCarPos2[2][5][tZ] = 10.4830; TurfCarPos2[2][5][tR] = 0.8370; 
	TurfCarPos2[2][6][tX] = 2038.8522; TurfCarPos2[2][6][tY] = 1004.4080; TurfCarPos2[2][6][tZ] = 10.4830; TurfCarPos2[2][6][tR] = 0.8376;
	///SF
	TurfCarPos2[3][1][tX] = -1986.5240; TurfCarPos2[3][1][tY] = 129.9458; TurfCarPos2[3][1][tZ] = 27.4128; TurfCarPos2[3][1][tR] = 1.1726; 
	TurfCarPos2[3][2][tX] = -1986.9039; TurfCarPos2[3][2][tY] = 145.4232; TurfCarPos2[3][2][tZ] = 27.4130; TurfCarPos2[3][2][tR] = 0.8910; 
	TurfCarPos2[3][3][tX] = -1995.7367; TurfCarPos2[3][3][tY] = 146.4006; TurfCarPos2[3][3][tZ] = 27.6374; TurfCarPos2[3][3][tR] = 0.0251; 
	TurfCarPos2[3][4][tX] = -1995.6765; TurfCarPos2[3][4][tY] = 132.9328; TurfCarPos2[3][4][tZ] = 27.6394; TurfCarPos2[3][4][tR] = 0.4027; 
	TurfCarPos2[3][5][tX] = -1995.6965; TurfCarPos2[3][5][tY] = 161.5057; TurfCarPos2[3][5][tZ] = 27.6380; TurfCarPos2[3][5][tR] = 359.8913; 
	TurfCarPos2[3][6][tX] = -1986.4718; TurfCarPos2[3][6][tY] = 162.5502; TurfCarPos2[3][6][tZ] = 27.3891; TurfCarPos2[3][6][tR] = 5.2247;
	
	TurfSpawn[1][1][tX] = 2492.0081; TurfSpawn[1][1][tY] = -1667.1776; TurfSpawn[1][1][tZ] = 13.3438;
	TurfSpawn[1][2][tX] = 2288.2466; TurfSpawn[1][2][tY] = 603.9662; TurfSpawn[1][2][tZ] = 10.8203;
	TurfSpawn[1][3][tX] = -2245.7122; TurfSpawn[1][3][tY] = 643.0581; TurfSpawn[1][3][tZ] = 49.4453;

	TurfSpawn[2][1][tX] = 664.8140; TurfSpawn[2][1][tY] = -1276.6028; TurfSpawn[2][1][tZ] = 13.4609;
	TurfSpawn[2][2][tX] = 2022.8859; TurfSpawn[2][2][tY] = 1007.5541; TurfSpawn[2][2][tZ] = 10.8203;
	TurfSpawn[2][3][tX] = -1973.7284; TurfSpawn[2][3][tY] = 137.9889; TurfSpawn[2][3][tZ] = 27.6875;

	TurfCarColor[4] = 86;
	TurfCarColor[5] = 197;
	TurfCarColor[6] = 174;

	TurfCarColor[7] = 85;
	TurfCarColor[8] = 155;
	TurfCarColor[9] = 3;
	////
	dmSpawnPoints[0][dX] = 1667;
	dmSpawnPoints[0][dY] = -1140;
	dmSpawnPoints[0][dZ] = 24;

	dmSpawnPoints[1][dX] = 1605;
	dmSpawnPoints[1][dY] = -1105;
	dmSpawnPoints[1][dZ] = 25;

	dmSpawnPoints[2][dX] = 1636;
	dmSpawnPoints[2][dY] = -1054;
	dmSpawnPoints[2][dZ] = 24;

	dmSpawnPoints[3][dX] = 1622;
	dmSpawnPoints[3][dY] = -1017;
	dmSpawnPoints[3][dZ] = 24;

	dmSpawnPoints[4][dX] = 1530;
	dmSpawnPoints[4][dY] = -1012;
	dmSpawnPoints[4][dZ] = 25;

	dmSpawnPoints[5][dX] = 1527;
	dmSpawnPoints[5][dY] = -1066;
	dmSpawnPoints[5][dZ] = 26;

	dmSpawnPoints[6][dX] = 1550;
	dmSpawnPoints[6][dY] = -1104;
	dmSpawnPoints[6][dZ] = 26;

	dmSpawnPoints[7][dX] = 1554;
	dmSpawnPoints[7][dY] = -1149;
	dmSpawnPoints[7][dZ] = 25;

	dmSpawnPoints[8][dX] = 1492;
	dmSpawnPoints[8][dY] = -1168;
	dmSpawnPoints[8][dZ] = 25;

	dmSpawnPoints[9][dX] = 1471;
	dmSpawnPoints[9][dY] = -1130;
	dmSpawnPoints[9][dZ] = 25;

	dmSpawnPoints[10][dX] = 1494;
	dmSpawnPoints[10][dY] = -1110;
	dmSpawnPoints[10][dZ] = 25;

	dmSpawnPoints[11][dX] = 1468;
	dmSpawnPoints[11][dY] = -1048;
	dmSpawnPoints[11][dZ] = 24;

	dmSpawnPoints[12][dX] = 1469;
	dmSpawnPoints[12][dY] = -1013;
	dmSpawnPoints[12][dZ] = 27;

	dmSpawnPoints[13][dX] = 1427;
	dmSpawnPoints[13][dY] = -1050;
	dmSpawnPoints[13][dZ] = 24;

	dmSpawnPoints[14][dX] = 1426;
	dmSpawnPoints[14][dY] = -1091;
	dmSpawnPoints[14][dZ] = 18;

	dmSpawnPoints[15][dX] = 1420;
	dmSpawnPoints[15][dY] = -1138;
	dmSpawnPoints[15][dZ] = 24;

	dmSpawnPoints[16][dX] = 1370;
	dmSpawnPoints[16][dY] = -1110;
	dmSpawnPoints[16][dZ] = 25;

	dmSpawnPoints[17][dX] = 1372;
	dmSpawnPoints[17][dY] = -1056;
	dmSpawnPoints[17][dZ] = 27;

	dmSpawnPoints[18][dX] = 1370;
	dmSpawnPoints[18][dY] = -957;
	dmSpawnPoints[18][dZ] = 35;

	dmSpawnPoints[19][dX] = 1333;
	dmSpawnPoints[19][dY] = -983;
	dmSpawnPoints[19][dZ] = 34;

	dmSpawnPoints[20][dX] = 1334;
	dmSpawnPoints[20][dY] = -1016;
	dmSpawnPoints[20][dZ] = 31;

	dmSpawnPoints[21][dX] = 1304;
	dmSpawnPoints[21][dY] = -1016;
	dmSpawnPoints[21][dZ] = 34;

	dmSpawnPoints[22][dX] = 1289;
	dmSpawnPoints[22][dY] = -979;
	dmSpawnPoints[22][dZ] = 39;

	dmSpawnPoints[23][dX] = 1303;
	dmSpawnPoints[23][dY] = -1060;
	dmSpawnPoints[23][dZ] = 30;

	dmSpawnPoints[24][dX] = 1318;
	dmSpawnPoints[24][dY] = -1129;
	dmSpawnPoints[24][dZ] = 24;

	//House
	//1
	HouseCreateInfo[1][hX]= 225.68;
	HouseCreateInfo[1][hY]= 1021.45;
	HouseCreateInfo[1][hZ]= 1084.02;
	format(HouseCreateInfo[1][hName],256,"Luxury Type 1");
	HouseCreateInfo[1][hInterior]=7;
	//2
	HouseCreateInfo[2][hX]= 234.19;
	HouseCreateInfo[2][hY]= 1063.73;
	HouseCreateInfo[2][hZ]= 1084.21;
	format(HouseCreateInfo[2][hName],256,"Luxury Type 2");
	HouseCreateInfo[2][hInterior]= 6;
	//3
	HouseCreateInfo[3][hX]= 226.30;
	HouseCreateInfo[3][hY]= 1114.24;
	HouseCreateInfo[3][hZ]= 1080.99;
	format(HouseCreateInfo[3][hName],256,"Medium Type 1");
	HouseCreateInfo[3][hInterior]= 5;
	//4
	HouseCreateInfo[4][hX]= 235.34;
	HouseCreateInfo[4][hY]= 1186.68;
	HouseCreateInfo[4][hZ]= 1080.26;
	format(HouseCreateInfo[4][hName],256,"Medium Type 2");
	HouseCreateInfo[4][hInterior]= 3;
	//5
	HouseCreateInfo[5][hX]= 24.04;
	HouseCreateInfo[5][hY]= 1340.17;
	HouseCreateInfo[5][hZ]= 1084.38;
	format(HouseCreateInfo[5][hName],256,"Medium Type 3");
	HouseCreateInfo[5][hInterior]=10;
	//6
	HouseCreateInfo[6][hX]= 2317.89;
	HouseCreateInfo[6][hY]= -1026.76;
	HouseCreateInfo[6][hZ]= 1050.22;
	format(HouseCreateInfo[6][hName],256,"Medium Type 4");
	HouseCreateInfo[6][hInterior]= 9;
	//7
	HouseCreateInfo[7][hX]= 221.92;
	HouseCreateInfo[7][hY]= 1140.20;
	HouseCreateInfo[7][hZ]= 1082.61;
	format(HouseCreateInfo[7][hName],256,"Poor Type 1");
	HouseCreateInfo[7][hInterior]= 4;
	//8
	HouseCreateInfo[8][hX]= 2468.84;
	HouseCreateInfo[8][hY]= -1698.24;
	HouseCreateInfo[8][hZ]= 1013.51;
	format(HouseCreateInfo[8][hName],256,"Poor Type 2");
	HouseCreateInfo[8][hInterior]= 2;
	//9
	HouseCreateInfo[9][hX]= 223.20;
	HouseCreateInfo[9][hY]= 1287.08;
	HouseCreateInfo[9][hZ]= 1082.14;
	format(HouseCreateInfo[9][hName],256,"Poor Type 3");
	HouseCreateInfo[9][hInterior]= 1;
	//-----
	//
	    ///SKINS
	//Civil;
	Skins[0][1]=289;
	Skins[0][2]=289;
	Skins[0][3]=289;
	Skins[0][4]=289;
	Skins[0][5]=289;
	Skins[0][6]=289;
	Skins[0][7]=289;
	Skins[0][8]=289;
	//PD
	Skins[1][1]=280;
	Skins[1][2]=267;
	Skins[1][3]=266;
	Skins[1][4]=265;
	Skins[1][5]=282;
	Skins[1][6]=283;
	Skins[1][7]=288;
	Skins[1][8]=141;
	//FBI
	Skins[2][1]=281;
	Skins[2][2]=164;
	Skins[2][3]=163;
	Skins[2][4]=165;
	Skins[2][5]=166;
	Skins[2][6]=17;
	Skins[2][7]=286;
	Skins[2][8]=76;
	//NG
	Skins[3][1]=71;
	Skins[3][2]=179;
	Skins[3][3]=179;
	Skins[3][4]=285;
	Skins[3][5]=285;
	Skins[3][6]=287;
	Skins[3][7]=273;
	Skins[3][8]=191;
	//GROVE
	Skins[4][1]=105;
	Skins[4][2]=106;
	Skins[4][3]=107;
	Skins[4][4]=269;
	Skins[4][5]=149;
	Skins[4][6]=270;
	Skins[4][7]=271;
	Skins[4][8]=195;
	//LSV
	Skins[5][1]=47;
	Skins[5][2]=30;
	Skins[5][3]=108;
	Skins[5][4]=109;
	Skins[5][5]=110;
	Skins[5][6]=110;
	Skins[5][7]=292;
	Skins[5][8]=211;
	//TT
	Skins[6][1]=121;
	Skins[6][2]=122;
	Skins[6][3]=117;
	Skins[6][4]=118;
	Skins[6][5]=123;
	Skins[6][6]=186;
	Skins[6][7]=120;
	Skins[6][8]=169;
	//Ballas
	Skins[7][1]=293;
	Skins[7][2]=103;
	Skins[7][3]=297;
	Skins[7][4]=185;
	Skins[7][5]=296;
	Skins[7][6]=102;
	Skins[7][7]=104;
	Skins[7][8]=13;
	//VLA
	Skins[8][1]=48;
	Skins[8][2]=114;
	Skins[8][3]=173;
	Skins[8][4]=174;
	Skins[8][5]=175;
	Skins[8][6]=116;
	Skins[8][7]=115;
	Skins[8][8]=55;
	//TM
	Skins[9][1]=126;
	Skins[9][2]=124;
	Skins[9][3]=111;
	Skins[9][4]=112;
	Skins[9][5]=272;
	Skins[9][6]=125;
	Skins[9][7]=113;
	Skins[9][8]=193;
	//Medics
	Skins[10][1]=221;
	Skins[10][2]=275;
	Skins[10][3]=274;
	Skins[10][4]=276;
	Skins[10][5]=70;
	Skins[10][6]=228;
	Skins[10][7]=227;
	Skins[10][8]=91;
	//HA
	Skins[11][1]=127;
	Skins[11][2]=258;
	Skins[11][3]=208;
	Skins[11][4]=165;
	Skins[11][5]=166;
	Skins[11][6]=295;
	Skins[11][7]=294;
	Skins[11][8]=93;
	//LF
	Skins[12][1]=250;
	Skins[12][2]=60;
	Skins[12][3]=170;
	Skins[12][4]=59;
	Skins[12][5]=240;
	Skins[12][6]=189;
	Skins[12][7]=171;
	Skins[12][8]=172;
	//Taxi
	Skins[13][1]=206;
	Skins[13][2]=182;
	Skins[13][3]=261;
	Skins[13][4]=253;
	Skins[13][5]=220;
	Skins[13][6]=255;
	Skins[13][7]=61;
	Skins[13][8]=263;
	//NR
	Skins[14][1]=188;
	Skins[14][2]=291;
	Skins[14][3]=290;
	Skins[14][4]=187;
	Skins[14][5]=17;
	Skins[14][6]=147;
	Skins[14][7]=57;
	Skins[14][8]=148;

    CreateObject(995, 1543.69067, -1633.86523, 13.23160,   91.00000, 0.00000, -91.00000);
	CreateObject(995, 1544.23474, -1619.15527, 13.23160,   91.00000, 0.00000, -91.00000);
    pddown=CreateObject(968, 1544.70850, -1630.77942, 13.26140,   0.00000, 91.00000, 91.00000);//jos
    pdgarage=CreateObject(971, 1588.76697, -1638.40149, 15.07090,   0.00000, 0.00000, 180.00000);
    CreateObject(977, 1582.15393, -1637.98340, 13.65380,   0.00000, 0.00000, 11.00000);
    fbi1=CreateObject(971, 321.44199, -1488.15222, 26.58430,   0.00000, 0.00000, 142.00000);
	fbi2=CreateObject(971, 283.22751, -1542.60132, 27.09560,   0.00000, 0.00000, -35.00000);
	nggate=CreateObject(971, -1530.22327, 482.41272, 6.21660,   0.00000, 0.00000, 0.00000);
	nggate2=CreateObject(10841, -1466.54443, 500.94949, 5.89130,   -15.00000, 0.00000, 89.00000);
	CreateObject(977, -1621.70667, 688.39978, 7.74510,   0.00000, 0.00000, 12.00000);
	CreateObject(977, -1620.72607, 688.41943, 7.74640,   0.00000, 0.00000, 12.00000);
	sfpdpoarta1=CreateObject(971, -1635.62866, 688.16260, 9.17640,   0.00000, 0.00000, 0.00000);
	sfpdpoarta2=CreateObject(971, -1626.81104, 688.13092, 9.18100,   0.00000, 0.00000, 180.00000);
	sfgate1c=CreateObject(968, -1572.18433, 658.69690, 6.90130,   0.00000, 90.00000, 90.00000);
	sfgate2c=CreateObject(968, -1701.44397, 687.70813, 24.73360,   0.00000, -90.00000, 90.00000);
	CreateObject(970, -1697.78491, 688.15948, 24.33540,   0.00000, 0.00000, 0.00000);
	CreateObject(970, -1693.62793, 688.16339, 24.37540,   0.00000, 0.00000, 0.00000);
	CreateObject(970, -1689.47021, 688.16846, 24.37540,   0.00000, 0.00000, 0.00000);
	CreateObject(1676, 998.21478, -937.64661, 42.88470,   0.00000, 0.00000, 8.00000);
	CreateObject(1676, 1002.64661, -937.00372, 42.88470,   0.00000, 0.00000, 8.00000);
	CreateObject(1676, 1005.22681, -936.66571, 42.88470,   0.00000, 0.00000, 8.00000);
	CreateObject(1676, 1009.55902, -936.05231, 42.88470,   0.00000, 0.00000, 8.00000);
	CreateObject(19858, 1564.20667, -1667.32544, 28.68909,   0.00000, 0.00000, 0.00000);
	CreateObject(19858, 2018.86353, 1008.52130, 39.35350,   0.00000, 0.00000, -90.00000);
	CreateObject(19858, -2192.96094, 661.96130, 70.03740,   0.00000, 0.00000, 0.00000);
	CreateObject(3852, -2068.73047, 441.93979, 140.25101,   0.00000, 0.00000, 47.00000);
	CreateObject(3852, -2656.57935, 585.38348, 66.62720,   0.00000, 0.00000, 90.00000);
	CreateObject(3852, 314.05621, -1504.57202, 77.05050,   0.00000, 0.00000, -40.00000);
	CreateObject(3852, -1977.31042, 158.46130, 37.46970,   0.00000, 0.00000, 0.00000);
    //RemoveBuildingForPlayer(playerid, 968, -1526.4375, 481.3828, 6.9063, 0.25);
	//RemoveBuildingForPlayer(playerid, 966, -1526.3906, 481.3828, 6.1797, 0.25);
	CreateObject(1557, 2543.94604, -1306.40088, 1053.63562,   0.00000, 0.00000, 90.00000);
	CreateObject(1557, 2543.94336, -1303.37048, 1053.63562,   0.00000, 0.00000, -90.00000);
	CreateObject(1557, 2577.35889, -1301.90430, 1059.98486,   0.00000, 0.00000, 90.00000);
	CreateObject(1557, 2577.36035, -1298.88245, 1059.98560,   0.00000, 0.00000, -90.00000);
	CreateObject(1557, 2522.36084, -1287.40771, 1053.63208,   0.00000, 0.00000, 90.00000);
	CreateObject(1557, 2522.35156, -1284.43506, 1053.63318,   0.00000, 0.00000, -90.00000);
	CreateObject(977, 368.74719, 161.32790, 1026.25989,   0.00000, 0.00000, 100.00000);
	CreateObject(977, 363.47449, 187.31070, 1014.22180,   0.00000, 0.00000, 10.00000);
	CreateObject(19377, 968.57581, -56.45497, 1000.11365,   0.00000, 0.00000, 0.00000);
	CreateObject(1504, 968.46893, -53.99498, 1000.11279,   0.00000, 0.00000, 90.00000);
	
	CreateObject(11714, 248.00369, 86.78610, 1003.91107,   0.00000, 0.00000, 0.00000);
	CreateObject(11714, 244.86099, 75.84580, 1003.94659,   0.00000, 0.00000, 0.00000);
	CreateObject(19369, 217.42780, 126.55130, 1000.30219,   0.00000, 0.00000, 0.00000);
	CreateObject(19369, 217.42780, 126.55130, 999.64221,   -180.00000, 0.00000, 0.00000);
	CreateObject(2949, 229.42390, 115.20090, 998.02887,   0.00000, 0.00000, 0.00000);
    CreateObject(19911, 1781.10510, -1534.25891, 8.68380,   90.00000, 0.00000, -2.00000);
	CreateObject(977, 1781.14331, -1537.69043, 10.00980,   0.00000, 0.00000, -76.00000);
	CreateObject(977, 1759.75024, -1561.66797, 9.73700,   0.00000, 0.00000, 11.00000);
	CreateObject(11714, 217.87630, 116.56330, 999.26318,   0.00000, 0.00000, 90.00000);
	CreateObject(19304, 320.84030, 312.20389, 1001.26459,   0.00000, 0.00000, -90.00000);
	CreateObject(19304, 320.84030, 316.24390, 1001.26459,   0.00000, 0.00000, -90.00000);
	CreateObject(19303, 320.84030, 317.09100, 999.38910,   0.00000, 0.00000, 90.00000);
	CreateObject(19303, 320.84030, 315.37100, 999.38910,   0.00000, 0.00000, -90.00000);
	CreateObject(19303, 320.84030, 311.34790, 999.38910,   0.00000, 0.00000, -90.00000);
	CreateObject(19303, 320.84030, 312.95099, 999.38910,   0.00000, 0.00000, 90.00000);
	CreateObject(2634, 322.18744, 301.81897, 999.33972,   0.00000, 0.00000, 0.00000);
	
	//GetPills
	AddStaticPickup(1240,1,-2640.5422,637.7804,14.4531,0);
	Create3DTextLabel("/getpills\n/healme",COLOR_WHITE,-2640.5422,637.7804,14.4531,20,0,0);
	AddStaticPickup(1240,1,-1182.3969,-1323.4067,13.5794,0);
	Create3DTextLabel("/getpills\n/healme",COLOR_WHITE,1182.3969,-1323.4067,13.5794,20,0,0);
	AddStaticPickup(1240,1,2036.2089,-1404.2548,17.2640,0);
	Create3DTextLabel("/getpills\n/healme",COLOR_WHITE,2036.2089,-1404.2548,17.2640,20,0,0);
	//seif
	Create3DTextLabel("{db9602}Comenzi:\n{939290}/depune\n{939290}/retrage",COLOR_WHITE,2026.9764,1007.7463,10.8203,20,0,1);
	AddStaticPickup(1279,1,2026.9764,1007.7463,10.8203,0);

	Create3DTextLabel("{db9602}Comenzi:\n{939290}/depune\n{939290}/retrage",COLOR_WHITE,2158.0566,-1454.6040,25.5391,20,0,1);
	AddStaticPickup(1279,1,2158.0566,-1454.6040,25.5391,0);

	Create3DTextLabel("{db9602}Comenzi:\n{939290}/depune\n{939290}/retrage",COLOR_WHITE,2493.7822,-1666.7747,13.3438,20,0,1);
	AddStaticPickup(1279,1,2493.7822,-1666.7747,13.3438,0);

	Create3DTextLabel("{db9602}Comenzi:\n{939290}/depune\n{939290}/retrage",COLOR_WHITE,2769.2451,-1945.1285,13.3734,20,0,1);
	AddStaticPickup(1279,1,2769.2451,-1945.1285,13.3734,0);

	Create3DTextLabel("{db9602}Comenzi:\n{939290}/depune\n{939290}/retrage",COLOR_WHITE,680.9553,-1276.6500,13.5836,20,0,1);
	AddStaticPickup(1279,1,680.9553,-1276.6500,13.5836,0);

	Create3DTextLabel("{db9602}Comenzi:\n{939290}/depune\n{939290}/retrage",COLOR_WHITE,-2192.0007,641.5342,49.4375,20,0,1);
	AddStaticPickup(1279,1,-2192.0007,641.5342,49.4375,0);

	///Jobs
	//--Arms Dealer;
	Create3DTextLabel("{db9602}Arms Dealer:\n{939290}/getjob",COLOR_WHITE,1365.0842,-1275.0449,13.5469,20,0,1);
	AddStaticPickup(1239,1,1365.0842,-1275.0449,13.5469,0);//getjob

	Create3DTextLabel("{db9602}Comenzi:\n{939290}/getmats",COLOR_WHITE,593.1838,-1248.7792,18.1781,20,0,1);
	AddStaticPickup(1239,1,593.1838,-1248.7792,18.1781,0);//getpack

	Create3DTextLabel("{db9602}Comenzi:\n{939290}/delivermats",COLOR_WHITE,-2119.4187,-178.3190,35.3203,20,0,1);
	AddStaticPickup(1239,1,-2119.4187,-178.3190,35.3203,0);//delivermats
	//--Drugs Dealer
	Create3DTextLabel("{db9602}Drugs Dealer:\n{939290}/getjob",COLOR_WHITE,2166.6367,-1677.7665,15.0859,20,0,1);
	AddStaticPickup(1239,1,2166.6367,-1677.7665,15.0859,0);//getjob

	Create3DTextLabel("{db9602}Comenzi:\n{939290}/getdrugs",COLOR_WHITE,324.3867,1118.7701,1083.8828,20,1,1);
	AddStaticPickup(1239,1,324.3867,1118.7701,1083.8828,1);//getdrugs
	//--Farmer
	Create3DTextLabel("{db9602}Farmer:\n{939290}/getjob",COLOR_WHITE,-382.8611,-1426.3734,26.2900,20,0,1);
	AddStaticPickup(1239,1,-382.8611,-1426.3734,26.2900,0);//getjob

	Create3DTextLabel("{db9602}Comenzi:\n{939290}/startwork",COLOR_WHITE,-372.3134,-1427.8519,25.7266,20,0,1);
	AddStaticPickup(1239,1,-372.3134,-1427.8519,25.7266,0);//startwork

	Create3DTextLabel("{db9602}Comenzi:\n{939290}/vindefaina",COLOR_WHITE,-86.2853,-299.6250,2.7646,20,0,1);
	AddStaticPickup(1239,1,-86.2853,-299.6250,2.7646,0);//vinefaina

	//--Fisher
	Create3DTextLabel("{db9602}Comenzi:\n{939290}/fish",COLOR_WHITE,383.7176,-2087.3936,7.8359,20,0,1);
	AddStaticPickup(1239,1,383.7176,-2087.3936,7.8359,0);//fish

	Create3DTextLabel("{db9602}Fisher:\n{939290}/getjob",COLOR_WHITE,376.4070,-2054.5667,8.0156,20,0,1);
	AddStaticPickup(1239,1,376.4070,-2054.5667,8.0156,0);//getjob

	//--WoodCutter
	Create3DTextLabel("{db9602}Comenzi:\n{939290}/startwork",COLOR_WHITE,-2000.6581,-2368.5271,30.6250,20,0,1);
	AddStaticPickup(1239,1,-2000.6581,-2368.5271,30.6250,0);//startwork

	Create3DTextLabel("{db9602}WoodCutter:\n{939290}/getjob",COLOR_WHITE,-1992.9341,-2387.8445,30.6250,20,0,1);
	AddStaticPickup(1239,1,-1992.9341,-2387.8445,30.6250,0);//getjob

	//--Miner
	Create3DTextLabel("{db9602}Comenzi:\n{939290}/startwork",COLOR_WHITE,-1855.0463,-1560.4830,21.7500,20,0,1);
	AddStaticPickup(1239,1,-1855.0463,-1560.4830,21.7500,0);//startwork

	Create3DTextLabel("{db9602}Miner:\n{939290}/getjob",COLOR_WHITE,-1864.4252,-1559.7217,21.7500,20,0,1);
	AddStaticPickup(1239,1,-1864.4252,-1559.7217,21.7500,0);//getjob

	//--Trucker
	Create3DTextLabel("{db9602}Comenzi:\n{939290}/startwork",COLOR_WHITE,2804.2161,972.3039,10.7500,20,0,1);
	AddStaticPickup(1239,1,2804.2161,972.3039,10.7500,0);//startwork

	Create3DTextLabel("{db9602}Trucker:\n{939290}/getjob",COLOR_WHITE,2813.8909,972.8784,10.7500,20,0,1);
	AddStaticPickup(1239,1,2813.8909,972.8784,10.7500,0);//getjob

	Create3DTextLabel("{db9602}Trucker:\n{939290}/loadcargo",COLOR_WHITE,-235.4882,-256.6768,1.4297,20,0,1);
	AddStaticPickup(1239,1,-235.4882,-256.6768,1.4297,0);//loadcargo

	Create3DTextLabel("{db9602}Trucker:\n{939290}/loadcargo",COLOR_WHITE,-1039.1711,-590.1835,32.0078,20,0,1);
	AddStaticPickup(1239,1,-1039.1711,-590.1835,32.0078,0);//loadcargo

	Create3DTextLabel("{db9602}Trucker:\n{939290}/loadcargo",COLOR_WHITE,-1929.8365,-1757.9303,24.1367,20,0,1);
	AddStaticPickup(1239,1,-1929.8365,-1757.9303,24.1367,0);//loadcargo

	Create3DTextLabel("{db9602}Trucker:\n{939290}/loadcargo",COLOR_WHITE,-1962.2478,-2477.5640,30.6250,20,0,1);
	AddStaticPickup(1239,1,-1962.2478,-2477.5640,30.6250,0);//loadcargo
	//--Lawyer
	Create3DTextLabel("{db9602}Lawyer:\n{939290}/free",COLOR_WHITE,224.3974,121.0106,999.0969,20,15,1);
	AddStaticPickup(1239,1,224.3974,121.0106,999.0969,15);//free

	Create3DTextLabel("{db9602}Lawyer:\n{939290}/getjob",COLOR_WHITE,1547.4502,-1669.6681,13.5669,20,0,1);
	AddStaticPickup(1239,1,1547.4502,-1669.6681,13.5669,0);//free
	///
	Create3DTextLabel("{db9602}News Reporter:\n{939290}/cnewspaper\n/readnp\n/loadpaper",COLOR_WHITE,-2041.4490,451.6047,35.1723,20,0,1);
	AddStaticPickup(1239,1,-2041.4490,451.6047,35.1723,0);//nr

	Create3DTextLabel("{db9602}Sell Your Car To DealerShip \nFor 1/4 oF his price:\n{939290}/sellcartods",COLOR_WHITE,2121.0017,-1131.1345,25.3776,20,0,1);
	AddStaticPickup(1239,1,2121.0017,-1131.1345,25.3776,0);//sellcartods

	Create3DTextLabel("{db9602}Weapon:\n{939290}/order",COLOR_WHITE,1080.6824,-345.0348,73.9868,20,0,1);
	AddStaticPickup(1239,1,1080.6824,-345.0348,73.9868,0);//order

	Create3DTextLabel("Pentru undercover tasteaza\n{009933}/undercover",COLOR_WHITE,285.3049,173.5263,1007.1719,20,2,1);//fbi
	AddStaticPickup(1239,1,285.3049,173.5263,1007.1719,2);
	
	Create3DTextLabel("Pentru duty tasteaza\n{009933}/duty",COLOR_WHITE,256.5275,74.2209,1003.6406,20,1,1);//pd
	AddStaticPickup(1239,1,256.5275,74.2209,1003.6406,1);
	
	Create3DTextLabel("Pentru duty tasteaza\n{009933}/duty",COLOR_WHITE,289.9962,173.3008,1007.1794,20,2,1);//fbi
	AddStaticPickup(1239,1,289.9962,173.3008,1007.1794,2);
	
	Create3DTextLabel("Pentru duty tasteaza\n{009933}/duty",COLOR_WHITE,-1348.4601,492.6391,11.1953,20,0,1);//ng
	AddStaticPickup(1239,1,-1348.4601,492.6391,11.1953,0);
	
	Create3DTextLabel("/arrest",COLOR_WHITE,1529.9692,-1665.5592,6.2188,20,0,1);
	AddStaticPickup(1239,1,1529.9692,-1665.5592,6.2188,0);
	Create3DTextLabel("Pentru a iesi tasteaza\n{009933}/exitlf",COLOR_WHITE,-2047.3822,-109.2990,34.9515,20,0,1);
	AddStaticPickup(1239,1,-2047.3822,-109.2990,34.9515,0);
	Create3DTextLabel("Pentru a intra tasteaza\n{009933}/enterlf",COLOR_WHITE,-2046.1213,-96.8852,34.8954,20,0,1);
	AddStaticPickup(1239,1,-2046.1213,-96.8852,34.8954,0);

	Create3DTextLabel("Pentru a intra tasteaza\n{009933}/enterlf",COLOR_WHITE,-2046.1213,-96.8852,34.8954,20,0,1);
	//ds
	AddStaticPickup(1239,1,2131.7778,-1150.3885,24.1623,0);
	Create3DTextLabel("Pentru cumpara o masina tasteaza\n{009933}/buycar",COLOR_WHITE,2131.7778,-1150.3885,24.1623,20,0,1);
	
	//Benzinarii
	AddStaticPickup(1239,1,1004.2475,-937.9796,42.1797,0);
	AddStaticPickup(1239,1,1943.6311,-1772.9531,13.3906,0);
	AddStaticPickup(1239,1,-1606.3761,-2713.7097,48.5335,0);
	AddStaticPickup(1239,1,-2026.5939,156.7059,29.0391,0);
	AddStaticPickup(1239,1,-1328.9844,2677.9714,50.0625,0);
	AddStaticPickup(1239,1,608.8265,1699.7535,6.9922,0);
	AddStaticPickup(1239,1,655.5261,-564.8308,16.3359,0);
	AddStaticPickup(1239,1,-1675.6821,412.9916,7.1797,0);
	AddStaticPickup(1239,1,-2409.4727,975.9866,45.2969,0);
	AddStaticPickup(1239,1,2114.4636,920.2435,10.8203,0);
	Create3DTextLabel("Type\n{009933}/fill",COLOR_WHITE,1004.2475,-937.9796,42.1797,40,0,1);
	Create3DTextLabel("Type\n{009933}/fill",COLOR_WHITE,1943.6311,-1772.9531,13.3906,40,0,1);
	Create3DTextLabel("Type\n{009933}/fill",COLOR_WHITE,-1606.3761,-2713.7097,48.5335,40,0,1);
	Create3DTextLabel("Type\n{009933}/fill",COLOR_WHITE,-2026.5939,156.7059,29.0391,40,0,1);
	Create3DTextLabel("Type\n{009933}/fill",COLOR_WHITE,-1328.9844,2677.9714,50.0625,40,0,1);
	Create3DTextLabel("Type\n{009933}/fill",COLOR_WHITE,608.8265,1699.7535,6.9922,40,0,1);
	Create3DTextLabel("Type\n{009933}/fill",COLOR_WHITE,655.5261,-564.8308,16.3359,40,0,1);
	Create3DTextLabel("Type\n{009933}/fill",COLOR_WHITE,-1675.6821,412.9916,7.1797,40,0,1);
	Create3DTextLabel("Type\n{009933}/fill",COLOR_WHITE,-2409.4727,975.9866,45.2969,40,0,1);
	Create3DTextLabel("Type\n{009933}/fill",COLOR_WHITE,2114.4636,920.2435,10.8203,40,0,1);
	for(new i = 0; i <= 2000; i++)
	{
		RentCarPID[i] = -1;
		TruckerCarPlayerID[i] = -1;
	}
	for(new i = 1; i <= 1000; i++)
	{
		TaxiPComandsID[i] = -1;
		ContractsPlayersID[i] = -1;
	}
	for(new i = 0; i < MAX_PLAYERS; i++)
		TaxiPlayerC[i] = -1;

	new
		w,
		#if STARS_PER_ROW > 6
			col = 7,
			row = 0
		#else
			col = 1,
			row = 1
		#endif
	;
	for ( w = 0; w < sizeof(g_aStarTextDraws); w++ ) {
		g_aStarTextDraws[ w ] = TextDrawCreate( 503.5 - ( 18.0 * ( col - 7 ) ), 102.1 + ( row * ROW_HEIGHT ), "]" );
		TextDrawColor			( g_aStarTextDraws[ w ], 0x906210FF );
		TextDrawBackgroundColor	( g_aStarTextDraws[ w ], 0x000000AA );
		TextDrawFont			( g_aStarTextDraws[ w ], 2 );
		TextDrawSetShadow		( g_aStarTextDraws[ w ], 0 );
		TextDrawSetProportional	( g_aStarTextDraws[ w ], true );
		TextDrawLetterSize		( g_aStarTextDraws[ w ], 0.6, 2.4 );
		TextDrawAlignment		( g_aStarTextDraws[ w ], 3 );
		TextDrawSetOutline		( g_aStarTextDraws[ w ], 1 );
		if ( ++col > STARS_PER_ROW ) {
			col = 1;

			++row;
		}
	}

	#if NUM_INACTIVE_STARS > 6

	#if STARS_PER_ROW > 6
		col = 7;
		row = 0;
	#else
		col = 1;
		row = 1;
	#endif

	for ( w = 0; w < NUM_INACTIVE_STARS - 6; w++ ) {
		g_aInactiveStarTextDraws[ w ] = TextDrawCreate( 503.0 - ( 18.0 * ( col - 7 ) ), 100.0 + ( row * ROW_HEIGHT ), "]" );

		TextDrawColor			( g_aInactiveStarTextDraws[ w ], 0x00000070 );
		TextDrawFont			( g_aInactiveStarTextDraws[ w ], 2 );
		TextDrawSetShadow		( g_aInactiveStarTextDraws[ w ], 0 );
		TextDrawSetProportional	( g_aInactiveStarTextDraws[ w ], true );
		TextDrawLetterSize		( g_aInactiveStarTextDraws[ w ], 0.72, 2.88 );
		TextDrawAlignment		( g_aInactiveStarTextDraws[ w ], 3 );
		TextDrawSetOutline		( g_aInactiveStarTextDraws[ w ], 0 );

		if ( ++col > STARS_PER_ROW ) {
			col = 1;

			++row;
		}
	}

	#endif
	return 1;
}

public OnGameModeExit()
{
	for(new i = 0; i < sizeof(g_aStarTextDraws); i++) TextDrawDestroy( g_aStarTextDraws[ i ] );
	#if NUM_INACTIVE_STARS > 6
	for(new i = 0; i < sizeof(g_aInactiveStarTextDraws); i++) TextDrawDestroy(g_aInactiveStarTextDraws[i]);
	#endif
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	if(PlayerInfo[playerid][pMissionid] != 0)
	{
		if(issuerid != INVALID_PLAYER_ID)
		{
			SCM(issuerid,COLOR_RED1,"!! NU AI VOIE SA ATACI JUCATORI CARE AU O MISIUNE IN DESFASURARE !!");
			Slap(issuerid);
		}
	}
	return 1;
}
public OnPlayerConnect(playerid)
{
	new string[256];
	format(string, sizeof(string), "SELECT * FROM `bans` WHERE BINARY `PlayerName` = BINARY '%s'",GetName(playerid));
	new Cache: db = mysql_query(handle, string);
    new result[256], AdminName[256], Reason[256], BanDate[256], ExpireBan, nrBans;
	cache_get_row_count(nrBans);
	for(new i = 0; i < nrBans ; i++)
	{
		cache_get_value_name(i, "AdminName", result);				format(AdminName, 256, result);
		cache_get_value_name(i, "Reason", result);				    format(Reason, 256, result);
		cache_get_value_name(i, "BanDate", result);					format(BanDate, 256, result);
		cache_get_value_name(i, "ExpireDate", result);				ExpireBan = strval(result);
		if(ExpireBan == 0 || ExpireBan > gettime())
		{
			if(ExpireBan != 0) format(string, sizeof(string), "You are banned by %s | Ban Date: %s | Expire Date: %s | Reason: %s", AdminName, BanDate, ConvertTime(ExpireBan), Reason);
			else format(string, sizeof(string), "You are banned by %s Ban Date: %s | Expire Date: PERMANENT | Reason: %s", AdminName, BanDate, Reason);
			SCM(playerid, COLOR_RED, string);
			KickEx(playerid);
			cache_delete(db);
			return 1;
		}

	}
	if(nrBans != 0)
	{
		mysql_format(handle, string, sizeof(string), "DELETE FROM `bans` WHERE BINARY `PlayerName` = BINARY '%s'", GetName(playerid));
		mysql_query(handle, string);
	}
	cache_delete(db);
	TimeAFK[playerid] = 0;
	PlayerInfo[playerid][pIdConT] = 0;
	for(new i = 0; i <= MAX_PLAYERS; i++)
	{
		SellDrugsInfo[playerid][i] = 0;
		SellDrugsInfo[i][playerid] = 0;
		SellPaperInfo[playerid][i] = 0;
		SellPaperInfo[i][playerid] = 0;
	}
	NewBieCoolDown[playerid] = 0;
	dsCarID[playerid] = 0;
	LoadNP[playerid] = 0;
	HaveNP[playerid] = 0;
	PlayerInfo[playerid][pNrRaport] = 0;
	LastCarID[playerid] = 0;
	SetPlayerColor(playerid,0xff4f5051);
	SetPlayerScore(playerid, 0);
	InitRegister(playerid);
	TurfsOn[playerid] = 0;
	CanNews[playerid] = 0;
	CP[playerid][ID]=0;
	PillsCD[playerid]=0;
	PlayerInfo[playerid][pInDM] = 0;
	FillCar[playerid]=0;
 	mysql_format(handle, gQuery, sizeof(gQuery), "SELECT * FROM users WHERE BINARY `Name` = BINARY '%s'", GetName(playerid));
    mysql_tquery(handle, gQuery, "IsRegistered", "i", playerid);
    TextDrawShowForPlayer(playerid, ServerTextDraw);
    TextDrawShowForPlayer(playerid, Clock[0]);
    TextDrawShowForPlayer(playerid, Clock[1]);
    InitFly(playerid);
    SetPlayerScore(playerid, PlayerInfo[playerid][pLvl]);
    SetPlayerMapIcon(playerid, 99, 1380.3617,-1088.7767,27.3844, 35, 0, MAPICON_LOCAL);
    for(new i = 1; i <= nrBiz; i++)
    	if(BizInfo[i][Type] == 1)
    		SetPlayerMapIcon(playerid, i, BizInfo[i][bX], BizInfo[i][bY], BizInfo[i][bZ], 17, 0, MAPICON_LOCAL);
    
    RemoveBuildingForPlayer(playerid, 968, -1526.4375, 481.3828, 6.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 966, -1526.3906, 481.3828, 6.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 6253, 1305.4688, -1619.7422, 13.3984, 0.25);
	RemoveBuildingForPlayer(playerid, 6046, 1305.4688, -1619.7422, 13.3984, 0.25);
	RemoveBuildingForPlayer(playerid, 1491, 2543.8516, -1306.3828, 1053.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1491, 2543.8359, -1303.3594, 1053.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1491, 2577.4531, -1301.9141, 1059.9688, 0.25);
	RemoveBuildingForPlayer(playerid, 1491, 2577.4375, -1298.8906, 1059.9688, 0.25);
	RemoveBuildingForPlayer(playerid, 1499, 2522.3516, -1287.4063, 1053.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1491, 2531.3516, -1287.4141, 1053.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1499, 2522.3359, -1284.3984, 1053.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1491, 2531.3359, -1284.3906, 1053.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1502, 363.6875, 187.3281, 1013.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 14883, 320.8672, 314.2109, 1000.1484, 0.25);
	//
	RemoveBuildingForPlayer(playerid, 2164, 350.5078, 196.9609, 1007.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 2164, 350.5078, 198.7344, 1007.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 2164, 350.5078, 200.5078, 1007.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 1776, 350.9063, 206.0859, 1008.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 2002, 350.9453, 204.0781, 1007.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 2162, 350.4922, 214.5234, 1007.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 2164, 350.5078, 210.9766, 1007.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 2164, 350.5078, 212.7500, 1007.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 2164, 350.5078, 216.2969, 1007.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 2011, 350.8125, 209.1094, 1007.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 1998, 354.3828, 200.9766, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 355.5703, 200.7656, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 357.6719, 200.7656, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 2202, 352.9141, 217.1563, 1007.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 354.7188, 204.5234, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 2009, 354.4297, 209.3828, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 354.7109, 212.0625, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 2008, 355.3984, 202.9922, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 355.5156, 208.6172, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 2186, 355.2031, 217.1563, 1007.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 1999, 355.4453, 211.4063, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 2008, 356.4688, 201.9766, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 356.5938, 203.4219, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 1998, 357.4844, 203.9922, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 2001, 357.5625, 204.7969, 1007.3594, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 356.3828, 213.5938, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 1999, 356.4688, 210.3828, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 357.6953, 209.5938, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 2009, 357.4844, 212.4063, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 2001, 358.1641, 211.0234, 1007.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 14598, 364.7266, 173.8906, 1022.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 2001, 359.5703, 202.8125, 1007.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 360.0156, 204.1328, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 2162, 359.9922, 217.5703, 1007.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 2009, 360.2734, 201.2969, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 1998, 360.7734, 209.7344, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 2001, 360.8203, 209.0078, 1007.3594, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 361.2344, 201.5313, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 1999, 362.3125, 202.2969, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 1999, 361.2813, 203.3203, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 362.2656, 204.1328, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 361.1172, 212.3906, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 2008, 361.7813, 211.7500, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 361.7500, 209.8281, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 2162, 361.7734, 217.5703, 1007.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 2008, 362.8594, 210.7344, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 362.9219, 200.6953, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 2009, 363.3203, 204.3203, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 363.0625, 212.3906, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 363.9063, 209.8281, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 2164, 363.5547, 217.5547, 1007.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 1998, 363.8672, 212.7500, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 2164, 365.3281, 217.5547, 1007.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 2164, 368.8516, 213.0625, 1007.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 2164, 368.8516, 214.8359, 1007.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 2164, 367.1016, 217.5547, 1007.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 2164, 368.8516, 216.6094, 1007.3750, 0.25);
	//
	PlayerTextdraws(playerid);
	PlayerTextDrawShow(playerid, PlayerNameTXD[playerid]);
    UpdateNameTXD(playerid);
	PlayerInfo[playerid][pWantedMinute]=0;
	for(new ob=0; ob<sizeof(objects);ob++)
    {
        RemoveBuildingForPlayer(playerid, objects[ob], 0.0, 0.0, 0.0, 6000.0);
    }
    
	return 1;
}
stock PlayerTextdraws(playerid) {

	OnlineTXD[playerid] = CreatePlayerTextDraw(playerid, 474.666564, 2.488887, "Online Time: 12:99");
	PlayerTextDrawLetterSize(playerid, OnlineTXD[playerid], 0.219999, 1.508741);
	PlayerTextDrawAlignment(playerid, OnlineTXD[playerid], 1);
	PlayerTextDrawColor(playerid, OnlineTXD[playerid], -1);
	PlayerTextDrawSetShadow(playerid, OnlineTXD[playerid], 0);
	PlayerTextDrawSetOutline(playerid, OnlineTXD[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, OnlineTXD[playerid], 51);
	PlayerTextDrawFont(playerid, OnlineTXD[playerid], 1);
	PlayerTextDrawSetProportional(playerid, OnlineTXD[playerid], 1);

	PlayerNameTXD[playerid] = CreatePlayerTextDraw(playerid, 545.666320, 421.037109, "Fashion");
	PlayerTextDrawLetterSize(playerid, PlayerNameTXD[playerid], 0.209666, 1.040000);
	PlayerTextDrawAlignment(playerid, PlayerNameTXD[playerid], 1);
	PlayerTextDrawColor(playerid, PlayerNameTXD[playerid], -1061109505);
	PlayerTextDrawSetShadow(playerid, PlayerNameTXD[playerid], 0);
	PlayerTextDrawSetOutline(playerid, PlayerNameTXD[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerNameTXD[playerid], 51);
	PlayerTextDrawFont(playerid, PlayerNameTXD[playerid], 1);
	PlayerTextDrawSetProportional(playerid, PlayerNameTXD[playerid], 1);
	
	InfoTD = CreatePlayerTextDraw(playerid, 4.670661, 334.366821, "200~n~Tick~n~~n~1196~n~anim~n~~n~67~n~fps~n~~n~30~n~ping~n~~n~0~n~queries");
	PlayerTextDrawLetterSize(playerid, InfoTD, 0.209779, 0.847500);
	PlayerTextDrawAlignment(playerid, InfoTD, 1);
	PlayerTextDrawColor(playerid, InfoTD, -1);
    PlayerTextDrawSetShadow(playerid, InfoTD, 0);
	PlayerTextDrawSetOutline(playerid, InfoTD, 1);
	PlayerTextDrawBackgroundColor(playerid, InfoTD, 51);
	PlayerTextDrawFont(playerid, InfoTD, 2);
	PlayerTextDrawSetProportional(playerid, InfoTD, 1);
	PlayerTextDrawSetShadow(playerid, InfoTD, 0);

	TruckerJobInfo[playerid] = CreatePlayerTextDraw(playerid, 18.333330, 193.718490, "Job Info:");
	PlayerTextDrawLetterSize(playerid, TruckerJobInfo[playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, TruckerJobInfo[playerid], 1);
	PlayerTextDrawColor(playerid, TruckerJobInfo[playerid], -1);
	PlayerTextDrawSetShadow(playerid, TruckerJobInfo[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TruckerJobInfo[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, TruckerJobInfo[playerid], 51);
	PlayerTextDrawFont(playerid, TruckerJobInfo[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TruckerJobInfo[playerid], 1);

	TruckerLine1[playerid] = CreatePlayerTextDraw(playerid, 23.666666, 209.896301, "!!! Foloseste comanda /tlocations pentru a lua trailer");
	PlayerTextDrawLetterSize(playerid, TruckerLine1[playerid], 0.203333, 1.081482);
	PlayerTextDrawAlignment(playerid, TruckerLine1[playerid], 1);
	PlayerTextDrawColor(playerid, TruckerLine1[playerid], -1);
	PlayerTextDrawSetShadow(playerid, TruckerLine1[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TruckerLine1[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, TruckerLine1[playerid], 51);
	PlayerTextDrawFont(playerid, TruckerLine1[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TruckerLine1[playerid], 1);

	TruckerLinie[playerid] = CreatePlayerTextDraw(playerid, 20.333335, 213.214813, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, TruckerLinie[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TruckerLinie[playerid], 1.666666, 24.888900);
	PlayerTextDrawAlignment(playerid, TruckerLinie[playerid], 1);
	PlayerTextDrawColor(playerid, TruckerLinie[playerid], -1);
	PlayerTextDrawSetShadow(playerid, TruckerLinie[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TruckerLinie[playerid], 0);
	PlayerTextDrawFont(playerid, TruckerLinie[playerid], 4);

	TruckerType[playerid] = CreatePlayerTextDraw(playerid, 23.666664, 219.022293, "Type: Paine/Combustibil");
	PlayerTextDrawLetterSize(playerid, TruckerType[playerid], 0.202333, 1.069036);
	PlayerTextDrawAlignment(playerid, TruckerType[playerid], 1);
	PlayerTextDrawColor(playerid, TruckerType[playerid], -1);
	PlayerTextDrawSetShadow(playerid, TruckerType[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TruckerType[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, TruckerType[playerid], 51);
	PlayerTextDrawFont(playerid, TruckerType[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TruckerType[playerid], 1);

	TruckerMoney[playerid] = CreatePlayerTextDraw(playerid, 23.666666, 227.733337, "Money: 1234$");
	PlayerTextDrawLetterSize(playerid, TruckerMoney[playerid], 0.191664, 1.102221);
	PlayerTextDrawAlignment(playerid, TruckerMoney[playerid], 1);
	PlayerTextDrawColor(playerid, TruckerMoney[playerid], -1);
	PlayerTextDrawSetShadow(playerid, TruckerMoney[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TruckerMoney[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, TruckerMoney[playerid], 51);
	PlayerTextDrawFont(playerid, TruckerMoney[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TruckerMoney[playerid], 1);


	MinerJobInfo[playerid] = CreatePlayerTextDraw(playerid, 18.333330, 193.718490, "Job Info:");
	PlayerTextDrawLetterSize(playerid, MinerJobInfo[playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, MinerJobInfo[playerid], 1);
	PlayerTextDrawColor(playerid, MinerJobInfo[playerid], -1);
	PlayerTextDrawSetShadow(playerid, MinerJobInfo[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MinerJobInfo[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, MinerJobInfo[playerid], 51);
	PlayerTextDrawFont(playerid, MinerJobInfo[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MinerJobInfo[playerid], 1);

	MinerInfo1[playerid] = CreatePlayerTextDraw(playerid, 23.666666, 209.896301, "Aur: 1231g Argint: 1231g");
	PlayerTextDrawLetterSize(playerid, MinerInfo1[playerid], 0.203333, 1.081482);
	PlayerTextDrawAlignment(playerid, MinerInfo1[playerid], 1);
	PlayerTextDrawColor(playerid, MinerInfo1[playerid], -1);
	PlayerTextDrawSetShadow(playerid, MinerInfo1[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MinerInfo1[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, MinerInfo1[playerid], 51);
	PlayerTextDrawFont(playerid, MinerInfo1[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MinerInfo1[playerid], 1);

	MinerLinie[playerid] = CreatePlayerTextDraw(playerid, 20.333335, 213.214813, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, MinerLinie[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MinerLinie[playerid], 1.666666, 24.888900);
	PlayerTextDrawAlignment(playerid, MinerLinie[playerid], 1);
	PlayerTextDrawColor(playerid, MinerLinie[playerid], -1);
	PlayerTextDrawSetShadow(playerid, MinerLinie[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MinerLinie[playerid], 0);
	PlayerTextDrawFont(playerid, MinerLinie[playerid], 4);

	MinerInfo2[playerid] = CreatePlayerTextDraw(playerid, 23.666664, 219.022293, "Cupru: 1233g Fier: 1233g");
	PlayerTextDrawLetterSize(playerid, MinerInfo2[playerid], 0.202333, 1.069037);
	PlayerTextDrawAlignment(playerid, MinerInfo2[playerid], 1);
	PlayerTextDrawColor(playerid, MinerInfo2[playerid], -1);
	PlayerTextDrawSetShadow(playerid, MinerInfo2[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MinerInfo2[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, MinerInfo2[playerid], 51);
	PlayerTextDrawFont(playerid, MinerInfo2[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MinerInfo2[playerid], 1);

	MinerMoney[playerid] = CreatePlayerTextDraw(playerid, 23.666666, 227.733337, "Money: 1234$");
	PlayerTextDrawLetterSize(playerid, MinerMoney[playerid], 0.191665, 1.102222);
	PlayerTextDrawAlignment(playerid, MinerMoney[playerid], 1);
	PlayerTextDrawColor(playerid, MinerMoney[playerid], -1);
	PlayerTextDrawSetShadow(playerid, MinerMoney[playerid], 0);
	PlayerTextDrawSetOutline(playerid, MinerMoney[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, MinerMoney[playerid], 51);
	PlayerTextDrawFont(playerid, MinerMoney[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MinerMoney[playerid], 1);

	WoodJobInfo[playerid] = CreatePlayerTextDraw(playerid, 18.333330, 193.718490, "Job Info:");
	PlayerTextDrawLetterSize(playerid, WoodJobInfo[playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, WoodJobInfo[playerid], 1);
	PlayerTextDrawColor(playerid, WoodJobInfo[playerid], -1);
	PlayerTextDrawSetShadow(playerid, WoodJobInfo[playerid], 0);
	PlayerTextDrawSetOutline(playerid, WoodJobInfo[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, WoodJobInfo[playerid], 51);
	PlayerTextDrawFont(playerid, WoodJobInfo[playerid], 1);
	PlayerTextDrawSetProportional(playerid, WoodJobInfo[playerid], 1);

	WoodJobTask[playerid] = CreatePlayerTextDraw(playerid, 23.666666, 209.896301, "!! Du-te si taie copacul");
	PlayerTextDrawLetterSize(playerid, WoodJobTask[playerid], 0.200000, 1.380149);
	PlayerTextDrawAlignment(playerid, WoodJobTask[playerid], 1);
	PlayerTextDrawColor(playerid, WoodJobTask[playerid], -1);
	PlayerTextDrawSetShadow(playerid, WoodJobTask[playerid], 0);
	PlayerTextDrawSetOutline(playerid, WoodJobTask[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, WoodJobTask[playerid], 51);
	PlayerTextDrawFont(playerid, WoodJobTask[playerid], 1);
	PlayerTextDrawSetProportional(playerid, WoodJobTask[playerid], 1);

	WoodJobLinie[playerid] = CreatePlayerTextDraw(playerid, 20.333335, 213.214813, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, WoodJobLinie[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, WoodJobLinie[playerid], 1.666666, 24.888900);
	PlayerTextDrawAlignment(playerid, WoodJobLinie[playerid], 1);
	PlayerTextDrawColor(playerid, WoodJobLinie[playerid], -1);
	PlayerTextDrawSetShadow(playerid, WoodJobLinie[playerid], 0);
	PlayerTextDrawSetOutline(playerid, WoodJobLinie[playerid], 0);
	PlayerTextDrawFont(playerid, WoodJobLinie[playerid], 4);

	WoodJobBusteni[playerid] = CreatePlayerTextDraw(playerid, 23.666664, 219.022293, "Busteni: 12");
	PlayerTextDrawLetterSize(playerid, WoodJobBusteni[playerid], 0.203000, 1.255703);
	PlayerTextDrawAlignment(playerid, WoodJobBusteni[playerid], 1);
	PlayerTextDrawColor(playerid, WoodJobBusteni[playerid], -1);
	PlayerTextDrawSetShadow(playerid, WoodJobBusteni[playerid], 0);
	PlayerTextDrawSetOutline(playerid, WoodJobBusteni[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, WoodJobBusteni[playerid], 51);
	PlayerTextDrawFont(playerid, WoodJobBusteni[playerid], 1);
	PlayerTextDrawSetProportional(playerid, WoodJobBusteni[playerid], 1);

	WoodJobMoney[playerid] = CreatePlayerTextDraw(playerid, 23.666666, 227.733337, "Money: 1234$");
	PlayerTextDrawLetterSize(playerid, WoodJobMoney[playerid], 0.193999, 1.284741);
	PlayerTextDrawAlignment(playerid, WoodJobMoney[playerid], 1);
	PlayerTextDrawColor(playerid, WoodJobMoney[playerid], -1);
	PlayerTextDrawSetShadow(playerid, WoodJobMoney[playerid], 0);
	PlayerTextDrawSetOutline(playerid, WoodJobMoney[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, WoodJobMoney[playerid], 51);
	PlayerTextDrawFont(playerid, WoodJobMoney[playerid], 1);
	PlayerTextDrawSetProportional(playerid, WoodJobMoney[playerid], 1);

	FarmerJobInfo[playerid] = CreatePlayerTextDraw(playerid, 18.333330, 193.718490, "Job Info:");
	PlayerTextDrawLetterSize(playerid, FarmerJobInfo[playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, FarmerJobInfo[playerid], 1);
	PlayerTextDrawColor(playerid, FarmerJobInfo[playerid], -1);
	PlayerTextDrawSetShadow(playerid, FarmerJobInfo[playerid], 0);
	PlayerTextDrawSetOutline(playerid, FarmerJobInfo[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, FarmerJobInfo[playerid], 51);
	PlayerTextDrawFont(playerid, FarmerJobInfo[playerid], 1);
	PlayerTextDrawSetProportional(playerid, FarmerJobInfo[playerid], 1);

	FarmerTime[playerid] = CreatePlayerTextDraw(playerid, 23.666666, 209.896301, "Munceste Inca 123 secunde pentru a fi platit");
	PlayerTextDrawLetterSize(playerid, FarmerTime[playerid], 0.200000, 1.380149);
	PlayerTextDrawAlignment(playerid, FarmerTime[playerid], 1);
	PlayerTextDrawColor(playerid, FarmerTime[playerid], -1);
	PlayerTextDrawSetShadow(playerid, FarmerTime[playerid], 0);
	PlayerTextDrawSetOutline(playerid, FarmerTime[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, FarmerTime[playerid], 51);
	PlayerTextDrawFont(playerid, FarmerTime[playerid], 1);
	PlayerTextDrawSetProportional(playerid, FarmerTime[playerid], 1);

	FarmerSpeed[playerid] = CreatePlayerTextDraw(playerid, 23.666662, 219.851959, "!! Viteza ta trebuie sa fie mai mare de 25km/h");
	PlayerTextDrawLetterSize(playerid, FarmerSpeed[playerid], 0.200665, 1.268147);
	PlayerTextDrawAlignment(playerid, FarmerSpeed[playerid], 1);
	PlayerTextDrawColor(playerid, FarmerSpeed[playerid], -1);
	PlayerTextDrawSetShadow(playerid, FarmerSpeed[playerid], 0);
	PlayerTextDrawSetOutline(playerid, FarmerSpeed[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, FarmerSpeed[playerid], 51);
	PlayerTextDrawFont(playerid, FarmerSpeed[playerid], 1);
	PlayerTextDrawSetProportional(playerid, FarmerSpeed[playerid], 1);

	FarmerComeback[playerid] = CreatePlayerTextDraw(playerid, 24.000000, 228.977798, "!! Intoarce-te la ferma, ai 10 secunde");
	PlayerTextDrawLetterSize(playerid, FarmerComeback[playerid], 0.198999, 1.164443);
	PlayerTextDrawAlignment(playerid, FarmerComeback[playerid], 1);
	PlayerTextDrawColor(playerid, FarmerComeback[playerid], -1);
	PlayerTextDrawSetShadow(playerid, FarmerComeback[playerid], 0);
	PlayerTextDrawSetOutline(playerid, FarmerComeback[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, FarmerComeback[playerid], 51);
	PlayerTextDrawFont(playerid, FarmerComeback[playerid], 1);
	PlayerTextDrawSetProportional(playerid, FarmerComeback[playerid], 1);

	FarmerLinie[playerid] = CreatePlayerTextDraw(playerid, 20.333335, 211.555572, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, FarmerLinie[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, FarmerLinie[playerid], 1.666666, 27.377777);
	PlayerTextDrawAlignment(playerid, FarmerLinie[playerid], 1);
	PlayerTextDrawColor(playerid, FarmerLinie[playerid], -1);
	PlayerTextDrawSetShadow(playerid, FarmerLinie[playerid], 0);
	PlayerTextDrawSetOutline(playerid, FarmerLinie[playerid], 0);
	PlayerTextDrawFont(playerid, FarmerLinie[playerid], 4);

	DealerBox1[playerid] = TextDrawCreate(629.666687, 212.225936, "usebox");
	TextDrawLetterSize(DealerBox1[playerid], 0.000000, 22.175512);
	TextDrawTextSize(DealerBox1[playerid], 476.000000, 0.000000);
	TextDrawAlignment(DealerBox1[playerid], 1);
	TextDrawColor(DealerBox1[playerid], 0);
	TextDrawUseBox(DealerBox1[playerid], true);
	TextDrawBoxColor(DealerBox1[playerid], 102);
	TextDrawSetShadow(DealerBox1[playerid], 0);
	TextDrawSetOutline(DealerBox1[playerid], 0);
	TextDrawFont(DealerBox1[playerid], 0);

	DealerBox2[playerid] = TextDrawCreate(477.333343, 210.725936, "LD_SPAC:white");
	TextDrawLetterSize(DealerBox2[playerid], 0.000000, 0.000000);
	TextDrawTextSize(DealerBox2[playerid], 150.999969, 2.488876);
	TextDrawAlignment(DealerBox2[playerid], 1);
	TextDrawColor(DealerBox2[playerid], -65281);
	TextDrawSetShadow(DealerBox2[playerid], 0);
	TextDrawSetOutline(DealerBox2[playerid], 0);
	TextDrawFont(DealerBox2[playerid], 4);

	DealerBox3[playerid] = TextDrawCreate(477.333343, 210.725936, "LD_SPAC:white");
	TextDrawLetterSize(DealerBox3[playerid], 0.000000, 0.000000);
	TextDrawTextSize(DealerBox3[playerid], 2.333343, 202.429611);
	TextDrawAlignment(DealerBox3[playerid], 1);
	TextDrawColor(DealerBox3[playerid], -65281);
	TextDrawSetShadow(DealerBox3[playerid], 0);
	TextDrawSetOutline(DealerBox3[playerid], 0);
	TextDrawFont(DealerBox3[playerid], 4);

	DealerBox4[playerid] = TextDrawCreate(628.333312, 413.155548, "LD_SPAC:white");
	TextDrawLetterSize(DealerBox4[playerid], 0.000000, 0.000000);
	TextDrawTextSize(DealerBox4[playerid], -2.666687, -202.014801);
	TextDrawAlignment(DealerBox4[playerid], 1);
	TextDrawColor(DealerBox4[playerid], -65281);
	TextDrawSetShadow(DealerBox4[playerid], 0);
	TextDrawSetOutline(DealerBox4[playerid], 0);
	TextDrawFont(DealerBox4[playerid], 4);

	DealerBox5[playerid] = TextDrawCreate(628.333312, 413.155548, "LD_SPAC:white");
	TextDrawLetterSize(DealerBox5[playerid], 0.000000, 0.000000);
	TextDrawTextSize(DealerBox5[playerid], -150.999969, -3.318511);
	TextDrawAlignment(DealerBox5[playerid], 1);
	TextDrawColor(DealerBox5[playerid], -65281);
	TextDrawSetShadow(DealerBox5[playerid], 0);
	TextDrawSetOutline(DealerBox5[playerid], 0);
	TextDrawFont(DealerBox5[playerid], 4);

	DealerModel[playerid] = TextDrawCreate(514.000122, 241.837112, "New Textdraw");
	TextDrawLetterSize(DealerModel[playerid], 0.449999, 1.600000);
	TextDrawTextSize(DealerModel[playerid], 82.333389, 77.155578);
	TextDrawAlignment(DealerModel[playerid], 1);
	TextDrawColor(DealerModel[playerid], -1);
	TextDrawUseBox(DealerModel[playerid], true);
	TextDrawBoxColor(DealerModel[playerid], 0);
	TextDrawSetShadow(DealerModel[playerid], 0);
	TextDrawSetOutline(DealerModel[playerid], 1);
	TextDrawBackgroundColor(DealerModel[playerid], 51);
	TextDrawFont(DealerModel[playerid], 5);
	TextDrawSetProportional(DealerModel[playerid], 1);
	TextDrawSetPreviewModel(DealerModel[playerid], 522);
	TextDrawSetPreviewRot(DealerModel[playerid], -20.000000, 0.000000, 0.000000, 1.000000);

	DealerName[playerid] = TextDrawCreate(557.333679, 218.192642, "NRG-500");
	TextDrawLetterSize(DealerName[playerid], 0.449999, 1.600000);
	TextDrawAlignment(DealerName[playerid], 2);
	TextDrawColor(DealerName[playerid], -1);
	TextDrawSetShadow(DealerName[playerid], 0);
	TextDrawSetOutline(DealerName[playerid], 1);
	TextDrawBackgroundColor(DealerName[playerid], 51);
	TextDrawFont(DealerName[playerid], 1);
	TextDrawSetProportional(DealerName[playerid], 1);

	DealerPrice[playerid] = TextDrawCreate(482.000000, 322.311065, "Price:");
	TextDrawLetterSize(DealerPrice[playerid], 0.449999, 1.600000);
	TextDrawAlignment(DealerPrice[playerid], 1);
	TextDrawColor(DealerPrice[playerid], -1);
	TextDrawSetShadow(DealerPrice[playerid], 0);
	TextDrawSetOutline(DealerPrice[playerid], 1);
	TextDrawBackgroundColor(DealerPrice[playerid], 51);
	TextDrawFont(DealerPrice[playerid], 1);
	TextDrawSetProportional(DealerPrice[playerid], 1);

	DealerPrice1[playerid] = TextDrawCreate(526.333374, 322.725921, "50000000 $");
	TextDrawLetterSize(DealerPrice1[playerid], 0.449999, 1.600000);
	TextDrawAlignment(DealerPrice1[playerid], 1);
	TextDrawColor(DealerPrice1[playerid], 8388863);
	TextDrawSetShadow(DealerPrice1[playerid], 0);
	TextDrawSetOutline(DealerPrice1[playerid], -1);
	TextDrawBackgroundColor(DealerPrice1[playerid], 51);
	TextDrawFont(DealerPrice1[playerid], 1);
	TextDrawSetProportional(DealerPrice1[playerid], 1);

	DealerSpeed[playerid] = TextDrawCreate(480.999969, 336.829528, "Speed : 210km/h");
	TextDrawLetterSize(DealerSpeed[playerid], 0.449999, 1.600000);
	TextDrawAlignment(DealerSpeed[playerid], 1);
	TextDrawColor(DealerSpeed[playerid], -1);
	TextDrawSetShadow(DealerSpeed[playerid], 0);
	TextDrawSetOutline(DealerSpeed[playerid], 1);
	TextDrawBackgroundColor(DealerSpeed[playerid], 51);
	TextDrawFont(DealerSpeed[playerid], 1);
	TextDrawSetProportional(DealerSpeed[playerid], 1);

	DealerStock[playerid] = TextDrawCreate(480.666778, 350.933288, "Stock: 12 left");
	TextDrawLetterSize(DealerStock[playerid], 0.449999, 1.600000);
	TextDrawAlignment(DealerStock[playerid], 1);
	TextDrawColor(DealerStock[playerid], -1);
	TextDrawSetShadow(DealerStock[playerid], 0);
	TextDrawSetOutline(DealerStock[playerid], 1);
	TextDrawBackgroundColor(DealerStock[playerid], 51);
	TextDrawFont(DealerStock[playerid], 1);
	TextDrawSetProportional(DealerStock[playerid], 1);

	DealerCumpara[playerid] = TextDrawCreate(480.333526, 364.622192, "Cumpara");
	TextDrawLetterSize(DealerCumpara[playerid], 0.449999, 1.600000);
	TextDrawAlignment(DealerCumpara[playerid], 1);
	TextDrawColor(DealerCumpara[playerid], 8388863);
	TextDrawSetShadow(DealerCumpara[playerid], 0);
	TextDrawSetOutline(DealerCumpara[playerid], 1);
	TextDrawBackgroundColor(DealerCumpara[playerid], 51);
	TextDrawFont(DealerCumpara[playerid], 1);
	TextDrawSetProportional(DealerCumpara[playerid], 1);
	TextDrawSetSelectable(DealerCumpara[playerid], 1);

	DealerAnuleaza[playerid] = TextDrawCreate(553.333312, 365.037048, "Anuleaza");
	TextDrawLetterSize(DealerAnuleaza[playerid], 0.449999, 1.600000);
	TextDrawAlignment(DealerAnuleaza[playerid], 1);
	TextDrawColor(DealerAnuleaza[playerid], -2147483393);
	TextDrawSetShadow(DealerAnuleaza[playerid], 0);
	TextDrawSetOutline(DealerAnuleaza[playerid], 1);
	TextDrawBackgroundColor(DealerAnuleaza[playerid], 51);
	TextDrawFont(DealerAnuleaza[playerid], 1);
	TextDrawSetProportional(DealerAnuleaza[playerid], 1);
	TextDrawSetSelectable(DealerAnuleaza[playerid], 1);

	DealerInapoi[playerid] = TextDrawCreate(482.333282, 392.414855, "Inapoi");
	TextDrawLetterSize(DealerInapoi[playerid], 0.449999, 1.600000);
	TextDrawAlignment(DealerInapoi[playerid], 1);
	TextDrawColor(DealerInapoi[playerid], -2147450625);
	TextDrawSetShadow(DealerInapoi[playerid], 0);
	TextDrawSetOutline(DealerInapoi[playerid], 1);
	TextDrawBackgroundColor(DealerInapoi[playerid], 51);
	TextDrawFont(DealerInapoi[playerid], 1);
	TextDrawSetProportional(DealerInapoi[playerid], 1);
	TextDrawSetSelectable(DealerInapoi[playerid], 1);

	DealerInainte[playerid] = TextDrawCreate(570.000061, 392.414764, "Inainte");
	TextDrawLetterSize(DealerInainte[playerid], 0.449999, 1.600000);
	TextDrawAlignment(DealerInainte[playerid], 1);
	TextDrawColor(DealerInainte[playerid], 16777215);
	TextDrawSetShadow(DealerInainte[playerid], 0);
	TextDrawSetOutline(DealerInainte[playerid], 1);
	TextDrawBackgroundColor(DealerInainte[playerid], 51);
	TextDrawFont(DealerInainte[playerid], 1);
	TextDrawSetProportional(DealerInainte[playerid], 1);
	TextDrawSetSelectable(DealerInainte[playerid], 1);

	TextTurf0[playerid] = CreatePlayerTextDraw(playerid, 140.333358, 368.770385, "Time Left: 1200s");
	PlayerTextDrawLetterSize(playerid, TextTurf0[playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, TextTurf0[playerid], 1);
	PlayerTextDrawColor(playerid, TextTurf0[playerid], -1);
	PlayerTextDrawSetShadow(playerid, TextTurf0[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TextTurf0[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TextTurf0[playerid], 51);
	PlayerTextDrawFont(playerid, TextTurf0[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TextTurf0[playerid], 1);

	TextTurf1[playerid] = CreatePlayerTextDraw(playerid, 139.000030, 382.459167, "Team Kills: 123");
	PlayerTextDrawLetterSize(playerid, TextTurf1[playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, TextTurf1[playerid], 1);
	PlayerTextDrawColor(playerid, TextTurf1[playerid], -1);
	PlayerTextDrawSetShadow(playerid, TextTurf1[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TextTurf1[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TextTurf1[playerid], 51);
	PlayerTextDrawFont(playerid, TextTurf1[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TextTurf1[playerid], 1);

	dmTxd0[playerid] = CreatePlayerTextDraw(playerid, 143.999984, 392.829681, "Timp ramas:");
	PlayerTextDrawLetterSize(playerid, dmTxd0[playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, dmTxd0[playerid], 1);
	PlayerTextDrawColor(playerid, dmTxd0[playerid], -1);
	PlayerTextDrawSetShadow(playerid, dmTxd0[playerid], 0);
	PlayerTextDrawSetOutline(playerid, dmTxd0[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, dmTxd0[playerid], 51);
	PlayerTextDrawFont(playerid, dmTxd0[playerid], 3);
	PlayerTextDrawSetProportional(playerid, dmTxd0[playerid], 1);

	dmTxd1[playerid] = CreatePlayerTextDraw(playerid, 247.000000, 392.829620, "20:00");
	PlayerTextDrawLetterSize(playerid, dmTxd1[playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, dmTxd1[playerid], 1);
	PlayerTextDrawColor(playerid, dmTxd1[playerid], -2139094785);
	PlayerTextDrawSetShadow(playerid, dmTxd1[playerid], 0);
	PlayerTextDrawSetOutline(playerid, dmTxd1[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, dmTxd1[playerid], 51);
	PlayerTextDrawFont(playerid, dmTxd1[playerid], 3);
	PlayerTextDrawSetProportional(playerid, dmTxd1[playerid], 1);

	dmTxd2[playerid] = CreatePlayerTextDraw(playerid, 134.333343, 407.762908, "Best Killer:");
	PlayerTextDrawLetterSize(playerid, dmTxd2[playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, dmTxd2[playerid], 1);
	PlayerTextDrawColor(playerid, dmTxd2[playerid], -1);
	PlayerTextDrawSetShadow(playerid, dmTxd2[playerid], 0);
	PlayerTextDrawSetOutline(playerid, dmTxd2[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, dmTxd2[playerid], 51);
	PlayerTextDrawFont(playerid, dmTxd2[playerid], 3);
	PlayerTextDrawSetProportional(playerid, dmTxd2[playerid], 1);

	dmTxd3[playerid] = CreatePlayerTextDraw(playerid, 235.000030, 407.763031, "No-One");
	PlayerTextDrawLetterSize(playerid, dmTxd3[playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, dmTxd3[playerid], 1);
	PlayerTextDrawColor(playerid, dmTxd3[playerid], -2139094785);
	PlayerTextDrawSetShadow(playerid, dmTxd3[playerid], 0);
	PlayerTextDrawSetOutline(playerid, dmTxd3[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, dmTxd3[playerid], 51);
	PlayerTextDrawFont(playerid, dmTxd3[playerid], 3);
	PlayerTextDrawSetProportional(playerid, dmTxd3[playerid], 1);

	wTextdraw0[playerid] = CreatePlayerTextDraw(playerid, 626.666687, 160.788894, "usebox");
	PlayerTextDrawLetterSize(playerid, wTextdraw0[playerid], 0.000000, 7.703084);
	PlayerTextDrawTextSize(playerid, wTextdraw0[playerid], 507.333343, 0.000000);
	PlayerTextDrawAlignment(playerid, wTextdraw0[playerid], 1);
	PlayerTextDrawColor(playerid, wTextdraw0[playerid], 0);
	PlayerTextDrawUseBox(playerid, wTextdraw0[playerid], true);
	PlayerTextDrawBoxColor(playerid, wTextdraw0[playerid], 102);
	PlayerTextDrawSetShadow(playerid, wTextdraw0[playerid], 0);
	PlayerTextDrawSetOutline(playerid, wTextdraw0[playerid], 0);
	PlayerTextDrawFont(playerid, wTextdraw0[playerid], 0);

	wTextdraw1[playerid] = CreatePlayerTextDraw(playerid, 506.666687, 235.614822, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, wTextdraw1[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, wTextdraw1[playerid], 120.333312, -4.148161);
	PlayerTextDrawAlignment(playerid, wTextdraw1[playerid], 1);
	PlayerTextDrawColor(playerid, wTextdraw1[playerid], -1);
	PlayerTextDrawSetShadow(playerid, wTextdraw1[playerid], 0);
	PlayerTextDrawSetOutline(playerid, wTextdraw1[playerid], 0);
	PlayerTextDrawFont(playerid, wTextdraw1[playerid], 4);

	wTextdraw2[playerid] = CreatePlayerTextDraw(playerid, 627.666687, 235.614822, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, wTextdraw2[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, wTextdraw2[playerid], -3.333312, -79.644454);
	PlayerTextDrawAlignment(playerid, wTextdraw2[playerid], 1);
	PlayerTextDrawColor(playerid, wTextdraw2[playerid], -1);
	PlayerTextDrawSetShadow(playerid, wTextdraw2[playerid], 0);
	PlayerTextDrawSetOutline(playerid, wTextdraw2[playerid], 0);
	PlayerTextDrawFont(playerid, wTextdraw2[playerid], 4);

	wTextdraw3[playerid] = CreatePlayerTextDraw(playerid, 506.666687, 235.614822, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, wTextdraw3[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, wTextdraw3[playerid], 3.000000, -79.229644);
	PlayerTextDrawAlignment(playerid, wTextdraw3[playerid], 1);
	PlayerTextDrawColor(playerid, wTextdraw3[playerid], -1);
	PlayerTextDrawSetShadow(playerid, wTextdraw3[playerid], 0);
	PlayerTextDrawSetOutline(playerid, wTextdraw3[playerid], 0);
	PlayerTextDrawFont(playerid, wTextdraw3[playerid], 4);

	wTextdraw4[playerid] = CreatePlayerTextDraw(playerid, 627.666687, 155.140747, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, wTextdraw4[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, wTextdraw4[playerid], -121.000000, 4.148147);
	PlayerTextDrawAlignment(playerid, wTextdraw4[playerid], 1);
	PlayerTextDrawColor(playerid, wTextdraw4[playerid], -1);
	PlayerTextDrawSetShadow(playerid, wTextdraw4[playerid], 0);
	PlayerTextDrawSetOutline(playerid, wTextdraw4[playerid], 0);
	PlayerTextDrawFont(playerid, wTextdraw4[playerid], 4);

	wTextdraw5[playerid] = CreatePlayerTextDraw(playerid, 553.666687, 160.118576, "War Stats");
	PlayerTextDrawLetterSize(playerid, wTextdraw5[playerid], 0.185332, 1.284741);
	PlayerTextDrawAlignment(playerid, wTextdraw5[playerid], 1);
	PlayerTextDrawColor(playerid, wTextdraw5[playerid], -5963521);
	PlayerTextDrawSetShadow(playerid, wTextdraw5[playerid], 0);
	PlayerTextDrawSetOutline(playerid, wTextdraw5[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, wTextdraw5[playerid], 51);
	PlayerTextDrawFont(playerid, wTextdraw5[playerid], 1);
	PlayerTextDrawSetProportional(playerid, wTextdraw5[playerid], 1);

	wTextdraw6[playerid] = CreatePlayerTextDraw(playerid, 513.666748, 179.200042, "Kills:0");
	PlayerTextDrawLetterSize(playerid, wTextdraw6[playerid], 0.296665, 1.782517);
	PlayerTextDrawTextSize(playerid, wTextdraw6[playerid], 16.999998, -3.318516);
	PlayerTextDrawAlignment(playerid, wTextdraw6[playerid], 1);
	PlayerTextDrawColor(playerid, wTextdraw6[playerid], 8388863);
	PlayerTextDrawSetShadow(playerid, wTextdraw6[playerid], 16);
	PlayerTextDrawSetOutline(playerid, wTextdraw6[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, wTextdraw6[playerid], 51);
	PlayerTextDrawFont(playerid, wTextdraw6[playerid], 1);
	PlayerTextDrawSetProportional(playerid, wTextdraw6[playerid], 1);

	wTextdraw7[playerid] = CreatePlayerTextDraw(playerid, 570.333679, 180.029525, "Deaths:0");
	PlayerTextDrawLetterSize(playerid, wTextdraw7[playerid], 0.256666, 1.807407);
	PlayerTextDrawAlignment(playerid, wTextdraw7[playerid], 1);
	PlayerTextDrawColor(playerid, wTextdraw7[playerid], -2147483393);
	PlayerTextDrawSetShadow(playerid, wTextdraw7[playerid], 0);
	PlayerTextDrawSetOutline(playerid, wTextdraw7[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, wTextdraw7[playerid], 51);
	PlayerTextDrawFont(playerid, wTextdraw7[playerid], 1);
	PlayerTextDrawSetProportional(playerid, wTextdraw7[playerid], 1);

	wTextdraw8[playerid] = CreatePlayerTextDraw(playerid, 513.666625, 196.207351, "Aliance Kills:0");
	PlayerTextDrawLetterSize(playerid, wTextdraw8[playerid], 0.332999, 1.583406);
	PlayerTextDrawAlignment(playerid, wTextdraw8[playerid], 1);
	PlayerTextDrawColor(playerid, wTextdraw8[playerid], -1);
	PlayerTextDrawSetShadow(playerid, wTextdraw8[playerid], 0);
	PlayerTextDrawSetOutline(playerid, wTextdraw8[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, wTextdraw8[playerid], 51);
	PlayerTextDrawFont(playerid, wTextdraw8[playerid], 1);
	PlayerTextDrawSetProportional(playerid, wTextdraw8[playerid], 1);

	wTextdraw9[playerid] = CreatePlayerTextDraw(playerid, 514.666625, 210.725952, "Enemy Kills:0");
	PlayerTextDrawLetterSize(playerid, wTextdraw9[playerid], 0.345666, 1.682962);
	PlayerTextDrawAlignment(playerid, wTextdraw9[playerid], 1);
	PlayerTextDrawColor(playerid, wTextdraw9[playerid], -1);
	PlayerTextDrawSetShadow(playerid, wTextdraw9[playerid], 0);
	PlayerTextDrawSetOutline(playerid, wTextdraw9[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, wTextdraw9[playerid], 51);
	PlayerTextDrawFont(playerid, wTextdraw9[playerid], 1);
	PlayerTextDrawSetProportional(playerid, wTextdraw9[playerid], 1);

	wantedscade[playerid] = CreatePlayerTextDraw(playerid, 498.666595, 134.399993, "WANTED SCADE IN : %d MINUTE");
	PlayerTextDrawLetterSize(playerid, wantedscade[playerid], 0.250665, 1.558518);
	PlayerTextDrawAlignment(playerid, wantedscade[playerid], 1);
	PlayerTextDrawColor(playerid, wantedscade[playerid], -1);
	PlayerTextDrawSetShadow(playerid, wantedscade[playerid], 0);
	PlayerTextDrawSetOutline(playerid, wantedscade[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, wantedscade[playerid], 51);
	PlayerTextDrawFont(playerid, wantedscade[playerid], 1);
	PlayerTextDrawSetProportional(playerid, wantedscade[playerid], 1);

	
	jailtime[playerid] = CreatePlayerTextDraw(playerid, 386.666625, 11.199997, "Time Left : 1231 sec");
	PlayerTextDrawLetterSize(playerid, jailtime[playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, jailtime[playerid], 3);
	PlayerTextDrawColor(playerid, jailtime[playerid], -1);
	PlayerTextDrawUseBox(playerid, jailtime[playerid], true);
	PlayerTextDrawBoxColor(playerid, jailtime[playerid], 0);
	PlayerTextDrawSetShadow(playerid, jailtime[playerid], 0);
	PlayerTextDrawSetOutline(playerid, jailtime[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, jailtime[playerid], 51);
	PlayerTextDrawFont(playerid, jailtime[playerid], 1);
	PlayerTextDrawSetProportional(playerid, jailtime[playerid], 1);
	
 	SpeedText[playerid][UseBox] = CreatePlayerTextDraw(playerid, 592.000000, 311.781494, "usebox");
	PlayerTextDrawLetterSize(playerid, SpeedText[playerid][UseBox], 0.000000, 9.039710);
	PlayerTextDrawTextSize(playerid, SpeedText[playerid][UseBox], 464.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, SpeedText[playerid][UseBox], 1);
	PlayerTextDrawColor(playerid, SpeedText[playerid][UseBox], 0);
	PlayerTextDrawUseBox(playerid, SpeedText[playerid][UseBox], true);
	PlayerTextDrawBoxColor(playerid, SpeedText[playerid][UseBox], 102);
	PlayerTextDrawSetShadow(playerid, SpeedText[playerid][UseBox], 0);
	PlayerTextDrawSetOutline(playerid, SpeedText[playerid][UseBox], 0);
	PlayerTextDrawFont(playerid, SpeedText[playerid][UseBox], 0);

	SpeedText[playerid][White1] = CreatePlayerTextDraw(playerid, 465.333312, 310.281494, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, SpeedText[playerid][White1], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, SpeedText[playerid][White1], 2.000030, 84.622192);
	PlayerTextDrawAlignment(playerid, SpeedText[playerid][White1], 1);
	PlayerTextDrawColor(playerid, SpeedText[playerid][White1], -1);
	PlayerTextDrawSetShadow(playerid, SpeedText[playerid][White1], 0);
	PlayerTextDrawSetOutline(playerid, SpeedText[playerid][White1], 0);
	PlayerTextDrawFont(playerid, SpeedText[playerid][White1], 4);

	SpeedText[playerid][White2] = CreatePlayerTextDraw(playerid, 590.333312, 309.866668, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, SpeedText[playerid][White2], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, SpeedText[playerid][White2], -125.000000, 2.903686);
	PlayerTextDrawAlignment(playerid, SpeedText[playerid][White2], 1);
	PlayerTextDrawColor(playerid, SpeedText[playerid][White2], -1);
	PlayerTextDrawSetShadow(playerid, SpeedText[playerid][White2], 0);
	PlayerTextDrawSetOutline(playerid, SpeedText[playerid][White2], 0);
	PlayerTextDrawFont(playerid, SpeedText[playerid][White2], 4);

	SpeedText[playerid][White3] = CreatePlayerTextDraw(playerid, 590.666625, 309.866668, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, SpeedText[playerid][White3], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, SpeedText[playerid][White3], -2.666625, 84.622222);
	PlayerTextDrawAlignment(playerid, SpeedText[playerid][White3], 1);
	PlayerTextDrawColor(playerid, SpeedText[playerid][White3], -1);
	PlayerTextDrawSetShadow(playerid, SpeedText[playerid][White3], 0);
	PlayerTextDrawSetOutline(playerid, SpeedText[playerid][White3], 0);
	PlayerTextDrawFont(playerid, SpeedText[playerid][White3], 4);

	SpeedText[playerid][White4] = CreatePlayerTextDraw(playerid, 465.333312, 392.000000, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, SpeedText[playerid][White4], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, SpeedText[playerid][White4], 125.333312, 3.318542);
	PlayerTextDrawAlignment(playerid, SpeedText[playerid][White4], 1);
	PlayerTextDrawColor(playerid, SpeedText[playerid][White4], -1);
	PlayerTextDrawSetShadow(playerid, SpeedText[playerid][White4], 0);
	PlayerTextDrawSetOutline(playerid, SpeedText[playerid][White4], 0);
	PlayerTextDrawFont(playerid, SpeedText[playerid][White4], 4);

	SpeedText[playerid][Car] = CreatePlayerTextDraw(playerid, 470.333404, 313.185180, "Infernus");
	PlayerTextDrawLetterSize(playerid, SpeedText[playerid][Car], 0.361666, 1.305481);
	PlayerTextDrawAlignment(playerid, SpeedText[playerid][Car], 1);
	PlayerTextDrawColor(playerid, SpeedText[playerid][Car], -1061109505);
	PlayerTextDrawSetShadow(playerid, SpeedText[playerid][Car], 0);
	PlayerTextDrawSetOutline(playerid, SpeedText[playerid][Car], 1);
	PlayerTextDrawBackgroundColor(playerid, SpeedText[playerid][Car], 51);
	PlayerTextDrawFont(playerid, SpeedText[playerid][Car], 1);
	PlayerTextDrawSetProportional(playerid, SpeedText[playerid][Car], 1);

	SpeedText[playerid][Speed] = CreatePlayerTextDraw(playerid, 471.333160, 330.607452, "Speed : 240 MPH");
	PlayerTextDrawLetterSize(playerid, SpeedText[playerid][Speed], 0.361666, 1.305481);
	PlayerTextDrawTextSize(playerid, SpeedText[playerid][Speed], 1043.999877, 1246.518554);
	PlayerTextDrawAlignment(playerid, SpeedText[playerid][Speed], 1);
	PlayerTextDrawColor(playerid, SpeedText[playerid][Speed], -1);
	PlayerTextDrawSetShadow(playerid, SpeedText[playerid][Speed], 0);
	PlayerTextDrawSetOutline(playerid, SpeedText[playerid][Speed], 1);
	PlayerTextDrawBackgroundColor(playerid, SpeedText[playerid][Speed], 51);
	PlayerTextDrawFont(playerid, SpeedText[playerid][Speed], 1);
	PlayerTextDrawSetProportional(playerid, SpeedText[playerid][Speed], 1);

	SpeedText[playerid][Health] = CreatePlayerTextDraw(playerid, 471.666687, 348.444580, "Health: 1000");
	PlayerTextDrawLetterSize(playerid, SpeedText[playerid][Health], 0.394666, 1.293036);
	PlayerTextDrawAlignment(playerid, SpeedText[playerid][Health], 1);
	PlayerTextDrawColor(playerid, SpeedText[playerid][Health], -1);
	PlayerTextDrawSetShadow(playerid, SpeedText[playerid][Health], 0);
	PlayerTextDrawSetOutline(playerid, SpeedText[playerid][Health], 1);
	PlayerTextDrawBackgroundColor(playerid, SpeedText[playerid][Health], 51);
	PlayerTextDrawFont(playerid, SpeedText[playerid][Health], 1);
	PlayerTextDrawSetProportional(playerid, SpeedText[playerid][Health], 1);

	SpeedText[playerid][Fuel] = CreatePlayerTextDraw(playerid, 470.999908, 367.940673, "Fuel: 100");
	PlayerTextDrawLetterSize(playerid, SpeedText[playerid][Fuel], 0.366333, 1.272296);
	PlayerTextDrawAlignment(playerid, SpeedText[playerid][Fuel], 1);
	PlayerTextDrawColor(playerid, SpeedText[playerid][Fuel], -1);
	PlayerTextDrawSetShadow(playerid, SpeedText[playerid][Fuel], 0);
	PlayerTextDrawSetOutline(playerid, SpeedText[playerid][Fuel], 1);
	PlayerTextDrawBackgroundColor(playerid, SpeedText[playerid][Fuel], 51);
	PlayerTextDrawFont(playerid, SpeedText[playerid][Fuel], 1);
	PlayerTextDrawSetProportional(playerid, SpeedText[playerid][Fuel], 1);
	

	return 1;
}
function UpdateNameTXD(playerid)
{
	PlayerTextDrawHide(playerid, PlayerNameTXD[playerid]);
	new string[256];
	format(string, sizeof(string), "%s(ID:%d)", GetName(playerid), playerid);
	PlayerTextDrawSetString(playerid, PlayerNameTXD[playerid], string);
	PlayerTextDrawShow(playerid, PlayerNameTXD[playerid]);
}
public OnPlayerDisconnect(playerid, reason)
{
	if(PlayerInfo[playerid][pIdConT] == 0) return 1;
	if(PlayerInfo[playerid][pFaction] == 14) Update(playerid, pNrRaport); 
	if(dsCarID[playerid] != 0)
	{
		DestroyVehicle(dsCarID[playerid]);
		dsCarID[playerid] = 0;
	}
	//Update
	Update(playerid, pPremiumPoints);
	Update(playerid, pVIP);
	Update(playerid, pDrugs);
	Update(playerid, pSeifDrugs);
	Update(playerid, pMats);
	Update(playerid, pSeifMats);
	Update(playerid, pDrugsSkill);
	Update(playerid, pJob);
	Update(playerid, pLawyerSkill);
	Update(playerid, pLawerFree);
	Update(playerid, pOnlineSeconds);
	Update(playerid, pMoney);
	Update(playerid, pPills);
	Update(playerid, pCarLic);
	Update(playerid, pWeaponLic);
	Update(playerid, pBoatLic);
	Update(playerid, pFlyLic);
	Update(playerid, pPSeconds);
	if(PlayerInfo[playerid][pLvl] <= 5)
	{
		mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `NewBieMute`='%d' WHERE BINARY `Name`= BINARY '%s'", NewBieMute[playerid], GetName(playerid));
		mysql_query(handle, gQuery);
	}

	if(PlayerInfo[playerid][pFaction] == 11)
	{
		Update(playerid, pDoneContracts); 
		Update(playerid, pCancelContracts); 
		Update(playerid, pFailContracts);
		if(PlayerInfo[playerid][pHasContract] != -1)
		{
			nrContracts++;
			ContractsPlayersID[nrContracts] = PlayerInfo[playerid][pHasContract];
			ContractsMoney[nrContracts] = PlayerInfo[playerid][pContractMoney];
			new string[256];
			format(string, sizeof(string), "{adadad}[HITMAN] {e0e0e0}Deoarece %s a iesit de pe server, contractul sau este liber. Info: %d $  Nume Tinta: %s [ID:%d].", GetName(playerid), ContractsMoney[nrContracts], GetName(ContractsPlayersID[nrContracts]), ContractsPlayersID[nrContracts]);
			for(new i = 0; i <= 1000; i++)
				if(IsPlayerConnected(i) && PlayerInfo[i][pFaction] == 11)
					SCM(i, -1, string);
		}
		
	}
	if(PlayerInfo[playerid][pFaction] == 13) 
	{
		Update(playerid, pTaxiRaport);
		if(TaxiFare[playerid] != 0)
    	{
    		TaxiFare[playerid] = 0;
    		new vehicle = LastCarID[playerid];
    		for(new i = 0; i <= MAX_PLAYERS; i++)
    			if(IsPlayerConnected(i))
    				if(IsPlayerInVehicle(i, vehicle))
    					if(GetPlayerVehicleSeat(i) != 0)
    					{
    						KillTimer(TaxiTimer[i]);
    						TaxiPrice[i] = 0;
    						SCM(i, COLOR_GREY, "Taximetristul a iesit de pe server.");
    					}
    	}
    	if(TaxiPlayerC[playerid] != -1)
    	{
    		new clientid = TaxiPlayerC[playerid];
    		SCM(clientid, COLOR_GREY, "!!Comanda de taxi a fost anulata deoarece taximetristul care a acceptat comanda a iesit de pe server.");
    		TaxiPlayerC[playerid] = -1;
    		CanUseService[clientid] = 0;
    		KillTimer(RemoveTPtimer[playerid]);
			ResetTaxiTimer(playerid);
    	}
	}
	for(new i = 1; i <= nrContracts; i++)
		if(ContractsPlayersID[i] == playerid)
		{
			ContractsPlayersID[i] = -1;
			break;
		}
	for(new i = 0; i <= MAX_PLAYERS; i++)
	{
		SellingCarPos[playerid][i] = 0;
		SellingCarPos[i][playerid] = 0;
		if(IsPlayerConnected(i) && PlayerInfo[i][pFaction] == 13 && TaxiPlayerC[i] == playerid)
		{
			KillTimer(RemoveTPtimer[i]);
			ResetTaxiTimer(i);
			SCM(i, COLOR_YELLOW, "!!Clientul tau a iesit de pe server.");
		}
		if(IsPlayerConnected(i) && PlayerInfo[i][pHasContract] == playerid)
		{
			SCM(i, COLOR_GREY, "Tinta ta a iesit de pe server.");
			PlayerInfo[i][pHasContract] = -1;
			CP[i][ID] = 0;
			DisablePlayerCheckpoint(i);
		}
	}
	if(TaxiPrice[playerid] != 0 || TaxiTimer[playerid] != 0)
	{
		KillTimer(TaxiTimer[playerid]);
    	TaxiTimer[playerid]= 0;
    	new taxidriverid, money;
    	money = TaxiPrice[playerid];
    	TaxiPrice[playerid] = 0;
    	taxidriverid = GetDriverID(LastCarID[playerid]);
    	PlayerInfo[playerid][pMoney] -= money;
    	GivePlayerMoney(playerid, -money);
    	PlayerInfo[taxidriverid][pMoney] += money;
    	new string[256];
    	format(string, sizeof(string), "**Ai platit %d $ pentru cursa.", money);
    	SCM(playerid, COLOR_GREY, string);
    	format(string, sizeof(string), "**Ai primit de la %s %d $ pentru cursa.", GetName(playerid), money);
    	SCM(taxidriverid, COLOR_GREY, string);
    	PlayerInfo[taxidriverid][pTaxiRaport]++;

	}
	if(PlayerInfo[playerid][pJob] == 7 && PlayerInfo[playerid][pCanQuitJob] == 1)
	{
		StopTruckerTXD(playerid);
		TruckerCarPlayerID[PlayerInfo[playerid][pTruckerCarID]] = -1;
		DestroyVehicle(PlayerInfo[playerid][pTruckerCarID]);
		PlayerInfo[playerid][pTruckerCarID] = 0;
		DisablePlayerCheckpoint(playerid);
		CP[playerid][ID] = 0;
		PlayerInfo[playerid][pTruckerMoney] = 0;
		PlayerInfo[playerid][pTruckerPos] = 0;
		if(PlayerInfo[playerid][pTruckerStatus] == 2)
		{
			TruckerTrailerTimer[PlayerInfo[playerid][pTruckerTrailerID]] = 0;
			TruckerTrailerPlayerID[PlayerInfo[playerid][pTruckerTrailerID]] = -1;
			DestroyVehicle(PlayerInfo[playerid][pTruckerTrailerID]);
			PlayerInfo[playerid][pTruckerTrailerID] = 0;
		}
		PlayerInfo[playerid][pTruckerStatus] = 0;
		PlayerInfo[playerid][pCanQuitJob] = 0;
		SCM(playerid, COLOR_GREY, "**Ai anulat job-ul.");
	}
	if(PRentCarID[playerid] != 0)
	{
		DestroyVehicle(PRentCarID[playerid]);
		RentCarTimer[PRentCarID[playerid]] = 0;
		RentCarPID[PRentCarID[playerid]] = -1;
		PRentCarID[playerid] = 0;
	}
	if(FarmerTimer[playerid] > 0)
	{
		DestroyVehicle(FarmerCarID[playerid]);
		FarmerTimer[playerid] = 0;
		PlayerInfo[playerid][pCanQuitJob] = 0;
		StopFarmerTXD(playerid);
		SendClientMessage(playerid, -1, "{9843c6}**Fermierul {bcb005}Ion {75bc04}Ceaun {9843c6}este foarte nemultumit de tine.");
		FarmerCarID[playerid] = 0;
	}
	for(new i = 0; i <= MAX_PLAYERS; i++)
	{
		SellDrugsInfo[playerid][i] = 0;
		SellDrugsInfo[i][playerid] = 0;
		LawyerPrice[i][playerid] = 0;
	}
	for(new i = 0; i <= 10000; i++)
		PVLock[i][playerid] = 0;
	for(new i = 0; i <= 9; i++)
	{
		if(PlayerInfo[playerid][pCarPos][i] != 0)
		{
			for(new j = 0; j <= MAX_PLAYERS; j++)
				PVLock[PlayerInfo[playerid][pCarPos][i]][j] = 0;
			EmptyPersonalCars[PlayerInfo[playerid][pCarPos][i]] = 0;
			if(PersonalCars[PlayerInfo[playerid][pCarPos][i]][Spawned] == 1)
			{
				new vehid, pos;
				pos = PlayerInfo[playerid][pCarPos][i];
				if(PersonalCars[pos][VStatus] == 1) DestroyObject(PersonalCars[pos][ObjectID]);
				PersonalCars[pos][VStatus] = 0;
				vehid = PersonalCars[pos][CarID];
				PersonalCars[pos][CarID] = 0;
				PersonalSCars[vehid] = 0;
				if(PersonalCars[pos][Spawned] == 1) DestroyVehicle(vehid);
				PersonalCars[pos][Spawned] = 0;
				PersonalCars[pos][Timer] = 0;
				
			}
		}
	}
	
	if(dmStatus == 1 && PlayerInfo[playerid][pInDM] == 1)
	{
		dmMaxKills = 0;
		for(new i = 0 ; i <= MAX_PLAYERS; i++)
			if(PlayerInfo[i][pDmKills] > dmMaxKills && i != playerid)
			{
				dmMaxKills = PlayerInfo[i][pDmKills];
				dmMXID = i;
			}
	}
	if(WarStatus == 1 && PlayerInfo[playerid][pFaction] >= 4 && PlayerInfo[playerid][pFaction] <= 9)
	{
		Update(playerid, pWKills);
		Update(playerid, pWDeaths);
		Update(playerid, pLWarID);
	}
	new
        day,
        year,
        month,
        hours,
        minute,
        sec
    ;
    getdate(year, month, day);
    gettime(hours,minute,sec);
    PlayerInfo[playerid][pLastOnlineYear] = year;
    PlayerInfo[playerid][pLastOnlineMonth] = month;
    PlayerInfo[playerid][pLastOnlineDay] = day;
    PlayerInfo[playerid][pLastOnlineMinute] = minute;
    PlayerInfo[playerid][pLastOnlineHour] = hours;
    Update(playerid,pLastOnlineYear);
    Update(playerid,pLastOnlineHour);
    Update(playerid,pLastOnlineMinute);
    Update(playerid,pLastOnlineDay);
    Update(playerid,pLastOnlineMonth);
    Update(playerid,pLastMission);
    Update(playerid,pMissionF);
	new string[255];
	format(string,sizeof(string),"Suspectul %s cu wanted %d s-a deconectat de pe server .",GetName(playerid),PlayerInfo[playerid][pWanted]);
	if(PlayerInfo[playerid][pWanted]>0)
	{
	    foreach(new i : Player)
	    {
	        if(PlayerInfo[playerid][pWanted] > 0 && PlayerInfo[i][pFaction] >= 1 && PlayerInfo[i][pFaction] <= 3)
	            SCM(i,COLOR_LGREEN,string);
	        if(CP[i][ID]==1)
	        {
	            if(CP[i][Player]==playerid)
	            {
					DisablePlayerCheckpoint(i);
	           	    SendClientMessage(i,COLOR_BLUE,"Suspectul s-a deconectat de pe server");
	           	    CP[i][ID]=0;
	           	    CP[i][Player]=-1;
				}
	        }
	    }
	}
	if(PlayerInfo[playerid][pFaction] >= 1 && PlayerInfo[playerid][pFaction] <= 3)
	{
	    Update(playerid, pKills);
	    Update(playerid, pAssists);
	    Update(playerid, pArrests);
	    Update(playerid, pTickets);
	}
	else if(PlayerInfo[playerid][pFaction] == 10)
	{
		Update(playerid,pPillsSold);
		Update(playerid,pHealP);
		foreach(new i : Player)
			if(PlayerInfo[i][pPillsnumber] > 0)
			    if(PlayerInfo[i][pPillsid] == playerid)
			    {
			        PlayerInfo[i][pPillsid] = 0;
			        PlayerInfo[i][pPillsnumber] = 0;
			        SCM(i,COLOR_GREY,"Medicul care ti-a oferit pills s-a deconectat.");
			    }
	}
	mysql_format(handle, string, sizeof(string), "UPDATE `users` SET `Mute`='%d' WHERE BINARY `Name`= BINARY '%s'", Mute[playerid], GetName(playerid));
	mysql_query(handle,string);
	mysql_format(handle, string, sizeof(string), "UPDATE `users` SET `FMute`='%d' WHERE BINARY `Name`= BINARY '%s'", FMute[playerid], GetName(playerid));
	mysql_query(handle,string);
	mysql_format(handle, string, sizeof(string), "UPDATE `users` SET `CMute`='%d' WHERE BINARY `Name`= BINARY '%s'", CMute[playerid], GetName(playerid));
	mysql_query(handle,string);
	mysql_format(handle, string, sizeof(string), "UPDATE `users` SET `Wanted`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pWanted], GetName(playerid));
    mysql_query(handle,string);
    mysql_format(handle, string, sizeof(string), "UPDATE `users` SET `JailTime`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pJailTime], GetName(playerid));
    mysql_query(handle,string);
    PlayerInfo[playerid][pTicketMoney]=0;
	PlayerInfo[playerid][pTicketid]=0;
	// MESAJ DECONECTARE
 	new wakaname2[25];
	new string2[64];
	GetPlayerName(playerid, wakaname2, sizeof(wakaname2));
	switch(reason)
    {
        case 0: format(string2,sizeof(string2),"%s a iesit de pe server (Crash).",wakaname2);
        case 1: format(string2,sizeof(string2),"%s a iesit de pe server (/q).",wakaname2);
        case 2: format(string2,sizeof(string2),"%s a iesit de pe server (Kicked/Banned).",wakaname2);
    }
    new
		Float:x,
		Float:y,
		Float:z;
    GetPlayerPos(playerid,x,y,z);
    foreach(new i : Player)
    {
		if(IsPlayerInRangeOfPoint(i,20,x,y,z)) SCM(i,COLOR_CLIENT,string2);
    }
    TextDrawHideForPlayer(playerid, ServerTextDraw);
    TimeAFK[playerid] = 0;
	return 1;
}

public OnPlayerSpawn(playerid)
{
	TogglePlayerControllable(playerid, 1);
	CanCLineNr[playerid] = 0;
	if(PlayerInfo[playerid][pCanQuitJob] == 1)
	{
		if(PlayerInfo[playerid][pJob] == 5)
		{
			PlayerInfo[playerid][pCanQuitJob] = 0;
			RemovePlayerAttachedObject(playerid,2);
			RemovePlayerAttachedObject(playerid,3);
			StopWoodCutterTXD(playerid);
			new money;
			money = PlayerInfo[playerid][pBusteni] * 1000;
			GivePlayerMoney(playerid, money);
			PlayerInfo[playerid][pMoney] += money;
			new string[256];
			format(string, sizeof(string), "{00a1ff}** Ai primit {a8abad}%d {00a1ff}$ pentru munca depusa la fabrica.", money);
			SCM(playerid, -1, string);
			PlayerInfo[playerid][pBusteni] = 0;
			PlayerInfo[playerid][pBusteniT] = 0;
			DisablePlayerCheckpoint(playerid);
			CP[playerid][ID] = 0;
			ClearAnimations(playerid);
			TogglePlayerControllable(playerid, 1);
		}
		if(PlayerInfo[playerid][pJob] == 6)
		{
			PlayerInfo[playerid][pCanQuitJob] = 0;
			RemovePlayerAttachedObject(playerid,2);
			StopMinerTXD(playerid);
			new money;
			money = PlayerInfo[playerid][pMinerAur] * 300 + PlayerInfo[playerid][pMinerArgint] * 150 + PlayerInfo[playerid][pMinerCupru]* 50 + PlayerInfo[playerid][pMinerFier] * 25;
			GivePlayerMoney(playerid, money);
			PlayerInfo[playerid][pMoney] += money;
			new string[256];
			format(string, sizeof(string), "{00a1ff}** Ai primit {a8abad}%d {00a1ff}$ pentru munca depusa.", money);
			SCM(playerid, -1, string);
			PlayerInfo[playerid][pMinerAur] = 0;
			PlayerInfo[playerid][pMinerArgint] = 0;
			PlayerInfo[playerid][pMinerCupru] = 0;
			PlayerInfo[playerid][pMinerFier] = 0;
			DisablePlayerCheckpoint(playerid);
			CP[playerid][ID] = 0;
			ClearAnimations(playerid);
			TogglePlayerControllable(playerid, 1);
		}
	}
	PlayerInfo[playerid][pIdConT] = 1;
	RemovePlayerAttachedObject(playerid,0);
	RemovePlayerAttachedObject(playerid,1);
	RemovePlayerAttachedObject(playerid,2);
	RemovePlayerAttachedObject(playerid,3);
	RemovePlayerAttachedObject(playerid,4);
	RemovePlayerAttachedObject(playerid,5);
	RemovePlayerAttachedObject(playerid,6);
	RemovePlayerAttachedObject(playerid,7);
	RemovePlayerAttachedObject(playerid,8);
	RemovePlayerAttachedObject(playerid,9);
	SetPlayerHealth(playerid, 100);
	SetPlayerArmour(playerid, 0);
	if(WarStatus == 1 && IsGang(playerid) == 0) StopWarTXD(playerid); 
	SetPlayerSkin(playerid,PlayerInfo[playerid][pSkin]);
    SetPlayerScore(playerid, PlayerInfo[playerid][pLvl]);
	SetPlayerPos(playerid, 477.9671,-1499.2740,20.4896);
	CheckColor(playerid);
	SetPlayerCameraPos(playerid, 1799.5288,-1865.5853,13.5725);
	PlayerInfo[playerid][pVW]=0;
	PlayerInfo[playerid][pInterior]=0;
	SetPlayerVirtualWorld(playerid,0);
	SetPlayerInterior(playerid,0);
	if(IsGang(playerid) && PlayerInfo[playerid][pJailTime] == 0) GivePlayerWeapon(playerid, 24, 140);
	if(PlayerInfo[playerid][pJailTime]!=0)
	{
		if(PlayerInfo[playerid][pClub] == 1) PlayerInfo[playerid][pBounty] = 0;
	    SetPlayerPos(playerid, 223.1602,114.7808,999.0156);
		SetPlayerVirtualWorld(playerid,15);
		SetPlayerInterior(playerid,10);
		PlayerInfo[playerid][pVW]=15;
		PlayerInfo[playerid][pInterior]=10;
	}
	else if(PlayerInfo[playerid][pSpawnType] == 1)
	{
		new houseid = PlayerInfo[playerid][pHouseID];
		if(PlayerInfo[playerid][pWanted] != 0)
			SetPlayerPos(playerid, svHouse[houseid][hX1],svHouse[houseid][hY1],svHouse[houseid][hZ1]);
		else
		{
			SetPlayerPos(playerid, svHouse[houseid][hX2],svHouse[houseid][hY2],svHouse[houseid][hZ2]);
			SetPlayerVirtualWorld(playerid,svHouse[houseid][hVW]);
			SetPlayerInterior(playerid,svHouse[houseid][hInteriorID1]);
			PlayerInfo[playerid][pVW]=svHouse[houseid][hVW];
			PlayerInfo[playerid][pInterior]=svHouse[houseid][hInteriorID1];
		}
	}
 	else if(PlayerInfo[playerid][pFaction]==1)
	{
		SetPlayerPos(playerid, 1529.5177,-1678.2249,5.8906);
		///SetPlayerCameraPos(playerid, 1799.5288,-1865.5853,13.5725);
 	}
 	else if(PlayerInfo[playerid][pFaction]==2)
	{
		SetPlayerPos(playerid, 302.0882,-1529.0717,24.9219);
		///SetPlayerCameraPos(playerid, 1799.5288,-1865.5853,13.5725);
 	}
 	else if(PlayerInfo[playerid][pFaction]==3)
	{
		SetPlayerPos(playerid, -1346.1290,492.2082,11.2027);
		///SetPlayerCameraPos(playerid, 1799.5288,-1865.5853,13.5725);
 	}
 	else if(PlayerInfo[playerid][pFaction]==4)
	{
		SetPlayerPos(playerid, 2494.4402,-1665.7147,13.3438);
		///SetPlayerCameraPos(playerid, 1799.5288,-1865.5853,13.5725);
 	}
 	else if(PlayerInfo[playerid][pFaction]==5)
	{
		SetPlayerPos(playerid, 2769.0896,-1951.9033,13.3703);
		///SetPlayerCameraPos(playerid, 1799.5288,-1865.5853,13.5725);
 	}
 	else if(PlayerInfo[playerid][pFaction]==6)
	{
		SetPlayerPos(playerid, -2182.7080,645.6818,49.4375);
		///SetPlayerCameraPos(playerid, 1799.5288,-1865.5853,13.5725);
 	}
 	else if(PlayerInfo[playerid][pFaction]==7)
	{
		SetPlayerPos(playerid, 2125.2771,-1454.2634,24.0000);
		///SetPlayerCameraPos(playerid, 1799.5288,-1865.5853,13.5725);
 	}
 	else if(PlayerInfo[playerid][pFaction]==8)
	{
		SetPlayerPos(playerid, 664.8812,-1279.0140,13.4609);
		///SetPlayerCameraPos(playerid, 1799.5288,-1865.5853,13.5725);
 	}
    else if(PlayerInfo[playerid][pFaction]==9)
	{
		SetPlayerPos(playerid, 2020.6057,1007.5317,10.8203);
		///SetPlayerCameraPos(playerid, 1799.5288,-1865.5853,13.5725);
 	}
 	else if(PlayerInfo[playerid][pFaction]==10)
	{
		SetPlayerPos(playerid, -2654.0222,636.6705,14.4531);
		///SetPlayerCameraPos(playerid, 1799.5288,-1865.5853,13.5725);
 	}
 	else if(PlayerInfo[playerid][pFaction]==11)
	{
		SetPlayerPos(playerid, 1109.4873,-306.1848,73.9922);
		///SetPlayerCameraPos(playerid, 1799.5288,-1865.5853,13.5725);
 	}
 	else if(PlayerInfo[playerid][pFaction]==12)
	{
		SetPlayerPos(playerid, -2029.8021,-125.6167,35.2215);
		///SetPlayerCameraPos(playerid, 1799.5288,-1865.5853,13.5725);
 	}
    else if(PlayerInfo[playerid][pFaction]==13)
	{
		SetPlayerPos(playerid, -1973.9686,120.2171,27.6875);
		///SetPlayerCameraPos(playerid, 1799.5288,-1865.5853,13.5725);
 	}
 	else if(PlayerInfo[playerid][pFaction]==14)
	{
		SetPlayerPos(playerid, -2052.9856,463.4545,35.1719);
		///SetPlayerCameraPos(playerid, 1799.5288,-1865.5853,13.5725);
 	}
	if(IsGang(playerid) && WarStatus  == 1)
	{
		if(PlayerInfo[playerid][pFaction] >= 4 && PlayerInfo[playerid][pFaction] <= 6) SetPlayerPos(playerid, 2494.2385,-1668.4248,13.3438);
		else SetPlayerPos(playerid, 2028.5229,1007.7347,10.8203);
		SetPlayerVirtualWorld(playerid, 2019);
		StopWarTXD(playerid);
		StartWarTXD(playerid);
	}
	if(IsGang(playerid) && CanTurf[PlayerInfo[playerid][pFaction]] == 2)
	{
		SetPlayerVirtualWorld(playerid, TurfsInfo[FactionTurf[PlayerInfo[playerid][pFaction]]][tVW]);
		new Float:x, Float:y, Float:z;
		new Alliance;
		if(PlayerInfo[playerid][pFaction] <= 6) Alliance = 1;
			else Alliance = 2;
		x = TurfSpawn[Alliance][TurfsInfo[FactionTurf[PlayerInfo[playerid][pFaction]]][tCity]][tX];
		y = TurfSpawn[Alliance][TurfsInfo[FactionTurf[PlayerInfo[playerid][pFaction]]][tCity]][tY];
		z = TurfSpawn[Alliance][TurfsInfo[FactionTurf[PlayerInfo[playerid][pFaction]]][tCity]][tZ];
		SetPlayerPos(playerid, x, y, z);
		PlayerTextDrawHide(playerid, TextTurf0[playerid]);
		PlayerTextDrawHide(playerid, TextTurf1[playerid]);
		new string[256];
		format(string, sizeof(string), "Time Left: %d s", TurfsInfo[FactionTurf[PlayerInfo[playerid][pFaction]]][tTimer]);
		PlayerTextDrawSetString(playerid, TextTurf0[playerid], string);	
		if(Alliance == 1) format(string, sizeof(string), "Team Kills: %d", TurfsInfo[ FactionTurf[PlayerInfo[playerid][pFaction]] ][tKills1]);
		else format(string, sizeof(string), "Team Kills: %d", TurfsInfo[ FactionTurf[PlayerInfo[playerid][pFaction]]][tKills2]);
		PlayerTextDrawSetString(playerid, TextTurf1[playerid], string);	
		PlayerTextDrawShow(playerid, TextTurf0[playerid]);
		PlayerTextDrawShow(playerid, TextTurf1[playerid]);
	}
	if(dmStatus == 1 && PlayerInfo[playerid][pInDM] == 1)
	{
		new sId;
		sId = random(24);
		SetPlayerVirtualWorld(playerid, 2018);
		SetPlayerPos(playerid, dmSpawnPoints[sId][dX], dmSpawnPoints[sId][dY], dmSpawnPoints[sId][dZ]);
		if(dmID == 1)
		{
			GivePlayerWeapon(playerid, 24, 999);
			GivePlayerWeapon(playerid, 31, 999);
			GivePlayerWeapon(playerid, 29, 999);
			SetPlayerArmour(playerid, 100);
			SetPlayerColor(playerid, COLOR_STEELBLUE);
		}
	}
	return 1;
}
function TaxiUpFare(driver, playerid)
{
	TaxiPrice[playerid] += TaxiFare[driver];
	if(PlayerInfo[playerid][pMoney] < TaxiPrice[playerid]) 
	{
		Slap(playerid);
    	SCM(playerid, COLOR_GREY, "You don't have enought money.");
    	return 0;
	} 
	new string[256];
	format(string, sizeof(string), "Fare: %d $", TaxiPrice[playerid]);
	GameTextForPlayer(playerid, string, 1500, 5);
	return 0;
}
function IsCop(playerid)
{
	if(PlayerInfo[playerid][pFaction] == 1 ) return 1;
	if(PlayerInfo[playerid][pFaction] == 2 ) return 1;
	if(PlayerInfo[playerid][pFaction] == 3 ) return 1;
	return 0;
}
function IsGang(playerid)
{
	if(PlayerInfo[playerid][pFaction] >= 4 && PlayerInfo[playerid][pFaction] <= 9 ) return 1;
	return 0;
}
function IsWarZone(playerid)
{
	new Float:pX; new Float: pY; new Float: pZ;
	GetPlayerPos(playerid, pX, pY, pZ);
	if(pX > WarInfo[WarID][x1] && pX < WarInfo[WarID][x2] && pY > WarInfo[WarID][y1] && pY < WarInfo[WarID][y2]) return 1;
	return 0;
}
function IsTurfZone(playerid)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	new TurfZone;
	TurfZone = FactionTurf[PlayerInfo[playerid][pFaction]];
	if(x > TurfsInfo[TurfZone][tMinX] && x < TurfsInfo[TurfZone][tMaxX] && y > TurfsInfo[TurfZone][tMinY] && y < TurfsInfo[TurfZone][tMaxY]) return 1;
	return 0;

}
public OnPlayerDeath(playerid, killerid, reason)
{
	new String[128], hascontractforplayerid;
	hascontractforplayerid = 0;
	if(IsGang(playerid) && IsGang(killerid))
	{
		new string[256];
		format(string, sizeof(string), "{0aa7af}* %s {ffffff}%s {0aa7af}has killed %s {ffffff}%s {0aa7af}and receive 500$", PlayerInfo[killerid][pFacName], GetName(killerid), PlayerInfo[playerid][pFacName], GetName(playerid));
		new string1[256];
		format(string1, sizeof(string1), "{0918bc}* %s {ffffff}%s {0918bc}was pwned by %s {ffffff}%s {0918bc}and lose 500$", PlayerInfo[playerid][pFacName], GetName(playerid), PlayerInfo[killerid][pFacName], GetName(killerid));
		PlayerInfo[playerid][pMoney] -= 500;
		GivePlayerMoney(playerid, -500);
		PlayerInfo[killerid][pMoney] += 500;
		GivePlayerMoney(killerid, 500);
		for(new i = 0; i <= MAX_PLAYERS; i++)
			if(IsPlayerConnected(i))
				if(PlayerInfo[i][pFaction] == PlayerInfo[playerid][pFaction])
					SCM(i, COLOR_GREY, string1);
				else if(PlayerInfo[i][pFaction] == PlayerInfo[killerid][pFaction])
					SCM(i, COLOR_GREY, string);

	}
	if(IsGang(playerid) && CanTurf[PlayerInfo[playerid][pFaction]] == 2 && IsGang(killerid) && CanTurf[PlayerInfo[killerid][pFaction]] == 2 && PlayerInfo[playerid][pFaction] != PlayerInfo[killerid][pFaction])
	{
		if(IsTurfZone(playerid) && IsTurfZone(killerid) && FactionTurf[PlayerInfo[playerid][pFaction]] == FactionTurf[PlayerInfo[killerid][pFaction]])
		{
			new kFaction;
			kFaction = PlayerInfo[killerid][pFaction];
			if(kFaction <= 6 && kFaction >= 4)
				TurfsInfo[FactionTurf[kFaction]][tKills1]++;
			else TurfsInfo[FactionTurf[kFaction]][tKills2]++;
			for(new j = 0; j <= MAX_PLAYERS; j++)
			{
				if(IsPlayerConnected(j) && PlayerInfo[j][pFaction] == kFaction)
				{
					PlayerTextDrawHide(j, TextTurf0[j]);
					new string[256];
					if(kFaction <= 6 && kFaction >= 4) format(string, sizeof(string), "Team Kills: %d", TurfsInfo[FactionTurf[kFaction]][tKills1]);
					else format(string, sizeof(string), "Team Kills: %d", TurfsInfo[FactionTurf[kFaction]][tKills2]);
					PlayerTextDrawSetString(j, TextTurf1[j], string);
					PlayerTextDrawShow(j, TextTurf0[j]);
				}
			}
		}
	}
	if(WarStatus == 1)
	{
		if(IsGang(killerid) && IsGang(playerid))
		{
			new aliance1, aliance;
			if(PlayerInfo[killerid][pFaction] >= 4 && PlayerInfo[killerid][pFaction] <= 6) aliance = 1;
			else aliance = 2;
			if(PlayerInfo[playerid][pFaction] >= 4 && PlayerInfo[playerid][pFaction] <= 6) aliance1 = 1;
			else aliance1 = 2;
			if(IsWarZone(playerid) && IsWarZone(killerid) && aliance != aliance1)
			{
				PlayerInfo[playerid][pWDeaths]++;
				PlayerInfo[killerid][pWKills]++;
				UpdatePWarTXD(killerid, playerid);
				if(PlayerInfo[killerid][pFaction] >= 4 && PlayerInfo[killerid][pFaction] <= 6) WarAlianceKills1++;
				else WarAlianceKills2++;
				UpdateAWarTXD();
				if(PlayerInfo[killerid][pWKills] > lWarBestKills) 
				{
					lWarBestKills = PlayerInfo[killerid][pWKills];
					format(lWarBestKiller, sizeof(lWarBestKiller), GetName(killerid));
				}
			}
		}
	}
	if(PlayerInfo[playerid][pMissionid] != 0 )
	{
		DisablePlayerCheckpoint(playerid);
		GameTextForPlayer(playerid, "MISSION FAILED", 2000, 0);
		CP[playerid][ID]=0;
		PlayerInfo[playerid][pMissionCP] = 0;
		PlayerInfo[playerid][pMissionid] = 0;

	}
	if(killerid == INVALID_PLAYER_ID)
		SendClientMessage(playerid,COLOR_WHITE,"Te-ai sinucis.");
	else if(PlayerInfo[killerid][pHasContract] != playerid)
	{
		format(String, sizeof(String), "Ai fost omorat de catre %s", GetName(killerid));
		SendClientMessage(playerid, COLOR_GREY, String);
		if(PlayerInfo[playerid][pHasContract] == killerid)
		{
			hascontractforplayerid = 1;
			PlayerInfo[playerid][pFailContracts]++;
			PlayerInfo[playerid][pHasContract] = -1;
			GivePlayerMoney(killerid, PlayerInfo[playerid][pContractMoney]);
			PlayerInfo[killerid][pMoney] += PlayerInfo[playerid][pContractMoney];
			CP[playerid][ID] = 0;
			DisablePlayerCheckpoint(playerid);
			new string[256];
			format(string, sizeof(string), "{adadad}[HITMAN] {e0e0e0}Agentul %s a fost eliminat de catre propria tinta.", GetName(playerid));
			for(new i = 0; i <= 1000; i++)
				if(IsPlayerConnected(i) && PlayerInfo[i][pFaction] == 11)
					SCM(i, -1, string);
		}
	}
	else 
	{
		hascontractforplayerid = 1;
		SCM(playerid, COLOR_GREY, "Ai fost omorat de catre un hitman.");
		PlayerInfo[killerid][pDoneContracts]++;
		PlayerInfo[killerid][pHasContract] = -1;
		GivePlayerMoney(killerid, PlayerInfo[killerid][pContractMoney]);
		PlayerInfo[killerid][pMoney] += PlayerInfo[killerid][pContractMoney];
		CP[killerid][ID] = 0;
		DisablePlayerCheckpoint(killerid);
		new string[256];
		format(string, sizeof(string), "{adadad}[HITMAN] {e0e0e0}Agentul %s a eliminat tinta cu succes.", GetName(killerid));
		for(new i = 0; i <= 1000; i++)
			if(IsPlayerConnected(i) && PlayerInfo[i][pFaction] == 11)
				SCM(i, -1, string);
	}
	if(killerid != INVALID_PLAYER_ID)
	{
		if(PlayerInfo[playerid][pInDM] == 1 && PlayerInfo[killerid][pInDM] == 1)
		{
			new Float:x11;
			new Float:y11;
			new Float:z11;
			new Float:x22;
			new Float:y22;
			new Float:z22;
			GetPlayerPos(playerid, x11, y11, z11);

			GetPlayerPos(killerid, x22, y22, z22);
			if(x11 >= 1251 && x22 >= 1251 && x11  <= 1693 && x22 <= 1693 && y11 >= -1166 && y22 >= -1166 && y11 <= -924 && y22 <= -924)
			{
				PlayerInfo[killerid][pDmKills]++;
				new localString[256];
				format(localString, sizeof(localString), "{B300FF}Ai {FFFF00}%d{B300FF} kills.", PlayerInfo[killerid][pDmKills]);
				SendClientMessage(killerid, -1, localString);
				if(dmMaxKills < PlayerInfo[killerid][pDmKills]) 
				{
					format(localString, sizeof(localString), "{6600FF}%s {B300FF}este lider cu {FFFF00}%d{B300FF} kills.",GetName(killerid), PlayerInfo[killerid][pDmKills]);
					for(new i = 0 ; i< MAX_PLAYERS; i++)
						if(PlayerInfo[i][pInDM] == 1)
							SendClientMessage(i, -1, localString);
					dmMaxKills = PlayerInfo[killerid][pDmKills];
					dmMXID = killerid;
				}
			}
		}
	    else if(!IsCop(killerid) )
	    {
	    	if(hascontractforplayerid == 1) return 1;
	        new Float:x;
	        new Float:y;
	        new Float:z;
	        GetPlayerPos(killerid,x,y,z);
	        if(IsGang(playerid) && !IsGang(killerid))
	        {
	            new cnt=0;
	            foreach(new i : Player)
	            {
	                if(IsPlayerConnected(i) )
	                {
	                    if(IsPlayerInRangeOfPoint(i,100,x,y,z) && i != playerid && i != killerid)
	                    cnt++;
	                }
	            }
	            if(cnt > 0 )
	            {
	            	format(PlayerInfo[killerid][pWantedReason], 60 ,"Murder");
	       	        Update(killerid,pWantedReason);
					PlayerInfo[killerid][pWanted]++;
					PlayerInfo[killerid][pWantedMinute]=5;
					SetPlayerWantedLevel(killerid, PlayerInfo[killerid][pWanted]);
					UpdatePlayerWantedLevel( killerid, PlayerInfo[killerid][pWanted] - 1, PlayerInfo[killerid][pWanted] );
					new str1[256];
					format(str1, sizeof(str1),"WANTED SCADE IN: %d MINUTE", PlayerInfo[killerid][pWantedMinute]);
					PlayerTextDrawSetString(killerid, wantedscade[killerid], str1);
					PlayerTextDrawShow(killerid, wantedscade[killerid]);
					format(str1, sizeof(str1),"Ai mai primit wanted, motiv: Murder");
					SCM(killerid,COLOR_YELLOW,str1);
				}
	        
	        }
         	if(!IsGang(playerid) && IsGang(killerid))
	        {
	            new cnt=0;
	            foreach(new i : Player)
	            {
	                if(IsPlayerConnected(i) )
	                {
	                    if(IsPlayerInRangeOfPoint(i,100,x,y,z) && i != playerid && i != killerid)
	                    cnt++;
	                }
	            }
	            if(cnt > 0 )
	            {
	            	format(PlayerInfo[killerid][pWantedReason], 60 ,"Murder");
	       	        Update(killerid,pWantedReason);
					PlayerInfo[killerid][pWanted]++;
					PlayerInfo[killerid][pWantedMinute]=5;
					SetPlayerWantedLevel(killerid, PlayerInfo[killerid][pWanted]);
					UpdatePlayerWantedLevel( killerid, PlayerInfo[killerid][pWanted] - 1, PlayerInfo[killerid][pWanted] );
					new str1[256];
					format(str1, sizeof(str1),"WANTED SCADE IN: %d MINUTE", PlayerInfo[killerid][pWantedMinute]);
					PlayerTextDrawSetString(killerid, wantedscade[killerid], str1);
					PlayerTextDrawShow(killerid, wantedscade[killerid]);
					format(str1, sizeof(str1),"Ai mai primit wanted, motiv: Murder");
					SCM(killerid,COLOR_YELLOW,str1);
				}
	        }
			if(!IsGang(playerid) && !IsGang(killerid) )
	        {
	            new cnt=0;
	            foreach(new i : Player)
	            {
	                if(IsPlayerConnected(i) )
	                {
	                    if(IsPlayerInRangeOfPoint(i,100,x,y,z) && i != playerid && i != killerid)
	                    cnt++;
	                }
	            }
	            if(cnt > 0 )
	            {
	            	format(PlayerInfo[killerid][pWantedReason], 60 ,"Murder");
	       	        Update(killerid,pWantedReason);
					PlayerInfo[killerid][pWanted]++;
					PlayerInfo[killerid][pWantedMinute]=5;
					SetPlayerWantedLevel(killerid, PlayerInfo[killerid][pWanted]);
					UpdatePlayerWantedLevel( killerid, PlayerInfo[killerid][pWanted] - 1, PlayerInfo[killerid][pWanted] );
					new str1[256];
					format(str1, sizeof(str1),"WANTED SCADE IN: %d MINUTE", PlayerInfo[killerid][pWantedMinute]);
					PlayerTextDrawSetString(killerid, wantedscade[killerid], str1);
					PlayerTextDrawShow(killerid, wantedscade[killerid]);
					format(str1, sizeof(str1),"Ai mai primit wanted, motiv: Murder");
					SCM(killerid,COLOR_YELLOW,str1);
				}
	        }
	    }
	}
	if(PlayerInfo[playerid][pWanted]!=0)
	{
		new
		    Float: Pos1,
		    Float: Pos2,
		    Float: Pos3,
			count;
		GetPlayerPos(playerid,Pos1,Pos2,Pos3);
		if(killerid != INVALID_PLAYER_ID) PlayerInfo[killerid][pKills]++;
		foreach(new i : Player)
		{
				if(i == killerid ) continue;
			    if(IsPlayerInRangeOfPoint(i,50,Pos1,Pos2,Pos3))
				{
				    if(PlayerInfo[i][pFaction]<=3&&PlayerInfo[i][pFaction]>=1)
				    {
				        count++;//aici pun sa primeasca copu cv
				        PlayerInfo[i][pAssists]++;
				        
					}
				}
		}
		PlayerInfo[playerid][pJailTime]=400*PlayerInfo[playerid][pWanted];
		UpdatePlayerWantedLevel( playerid, PlayerInfo[playerid][pWanted], 0);
	  	PlayerInfo[playerid][pWanted]=0;
	  	PlayerInfo[playerid][pWantedMinute]=0;
	  	SpawnPlayer(playerid);
	    new str1[256];
		format(str1, sizeof(str1),"Jail Time: %d", PlayerInfo[playerid][pJailTime]);
		PlayerTextDrawSetString(playerid, jailtime[playerid], str1);
		PlayerTextDrawShow(playerid, jailtime[playerid]);
		PlayerTextDrawHide(playerid,  wantedscade[playerid]);
        SetPlayerWantedLevel(playerid, 0);
        SetPlayerHealth(playerid,100);
        new string[256];
        mysql_format(handle, string, sizeof(string), "UPDATE `users` SET `JailTime`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pJailTime], GetName(playerid));
  		mysql_query(handle,string);
	}
	return 1;
}
public OnPlayerStartAim(playerid, weaponid)
{
	return 1;
}
public OnPlayerStopAim(playerid)
{
	return 1;
}
public OnVehicleSpawn(vehicleid)
{
	if(PersonalSCars[vehicleid] != 0)
	{
		new vehid, pos;
		vehid = vehicleid;
		pos = PersonalSCars[vehicleid];
		AddVehicleComponent(vehid, PersonalCars[pos][Mode1]);
		AddVehicleComponent(vehid, PersonalCars[pos][Mode2]);
		AddVehicleComponent(vehid, PersonalCars[pos][Mode3]);
		AddVehicleComponent(vehid, PersonalCars[pos][Mode4]);
		AddVehicleComponent(vehid, PersonalCars[pos][Mode5]);
		AddVehicleComponent(vehid, PersonalCars[pos][Mode6]);
		AddVehicleComponent(vehid, PersonalCars[pos][Mode7]);
		AddVehicleComponent(vehid, PersonalCars[pos][Mode8]);
		AddVehicleComponent(vehid, PersonalCars[pos][Mode9]);
		AddVehicleComponent(vehid, PersonalCars[pos][Mode10]);
		AddVehicleComponent(vehid, PersonalCars[pos][Mode11]);
		AddVehicleComponent(vehid, PersonalCars[pos][Mode12]);
		AddVehicleComponent(vehid, PersonalCars[pos][Mode13]);
		AddVehicleComponent(vehid, PersonalCars[pos][Mode14]);
		ChangeVehiclePaintjob(vehid, PersonalCars[pos][PaintJob]);
		SetVehicleNumberPlate(vehid, PersonalCars[pos][Plate]);
	}	
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	if(TruckerCarPlayerID[vehicleid] != -1)
	{
		new playerid = TruckerCarPlayerID[vehicleid];
		if(PlayerInfo[playerid][pJob] == 7 && PlayerInfo[playerid][pCanQuitJob] == 1)
		{
			StopTruckerTXD(playerid);
			TruckerCarPlayerID[PlayerInfo[playerid][pTruckerCarID]] = -1;
			DestroyVehicle(PlayerInfo[playerid][pTruckerCarID]);
			PlayerInfo[playerid][pTruckerCarID] = 0;
			DisablePlayerCheckpoint(playerid);
			CP[playerid][ID] = 0;
			PlayerInfo[playerid][pTruckerMoney] = 0;
			PlayerInfo[playerid][pTruckerPos] = 0;
			if(PlayerInfo[playerid][pTruckerStatus] == 2)
			{
				TruckerTrailerTimer[PlayerInfo[playerid][pTruckerTrailerID]] = 0;
				TruckerTrailerPlayerID[PlayerInfo[playerid][pTruckerTrailerID]] = -1;
				DestroyVehicle(PlayerInfo[playerid][pTruckerTrailerID]);
				PlayerInfo[playerid][pTruckerTrailerID] = 0;

			}
			PlayerInfo[playerid][pTruckerStatus] = 0;
			PlayerInfo[playerid][pCanQuitJob] = 0;
			SCM(playerid, COLOR_GREY, "**Ai anulat job-ul.");
		}
	}
	if(TruckerTrailerPlayerID[vehicleid] != -1)
	{
		new playerid = TruckerCarPlayerID[vehicleid];
		if(PlayerInfo[playerid][pJob] == 7 && PlayerInfo[playerid][pCanQuitJob] == 1)
		{
			DisablePlayerCheckpoint(playerid);
			CP[playerid][ID] = 0;
			PlayerInfo[playerid][pTruckerMoney] = 0;
			PlayerInfo[playerid][pTruckerPos] = 0;
			if(PlayerInfo[playerid][pTruckerStatus] == 2)
			{
				TruckerTrailerTimer[PlayerInfo[playerid][pTruckerTrailerID]] = 0;
				TruckerTrailerPlayerID[PlayerInfo[playerid][pTruckerTrailerID]] = -1;
				DestroyVehicle(PlayerInfo[playerid][pTruckerTrailerID]);
				PlayerInfo[playerid][pTruckerTrailerID] = 0;

			}
			PlayerInfo[playerid][pTruckerStatus] = 1;
			PlayerInfo[playerid][pCanQuitJob] = 1;
			SCM(playerid, COLOR_GREY, "**Ai pierdut cursa.");
			UpdateTruckerTXD(playerid);
		}
	}
	if(RentCarPID[vehicleid] != -1)
	{
		DestroyVehicle(vehicleid);
		RentCarTimer[vehicleid] = 0;
		PRentCarID[RentCarPID[vehicleid]] = 0;
		SCM(RentCarPID[vehicleid], COLOR_GREY, "Masina de la rent s-a despawnat.");
		RentCarPID[vehicleid] = -1;
	}
	new playerid = -1;

	for(new i = 0; i <= MAX_PLAYERS; i++)
		if(FarmerCarID[i] == vehicleid)
			playerid = i;

	if(playerid != -1)
	{
		if(FarmerCarID[playerid] == vehicleid)
		{
			DestroyVehicle(FarmerCarID[playerid]);
			FarmerTimer[playerid] = 0;
			PlayerInfo[playerid][pCanQuitJob] = 0;
			StopFarmerTXD(playerid);
			SendClientMessage(playerid, -1, "{9843c6}**Fermierul {bcb005}Ion {75bc04}Ceaun {9843c6}este foarte nemultumit de tine.");
			FarmerCarID[playerid] = 0;
		}
	}

	return 1;
}

public OnPlayerText(playerid, text[])
{
    if(Mute[playerid] >= 1)
	{
		new string[50];
		format(string, sizeof(string), "You're muted.", Mute[playerid]);
		SendClientMessage(playerid, 0xFFFFFFFF, string);
		return 0;
	}
	new sendername[256];
	new string[256];
	GetPlayerName(playerid, sendername, sizeof(sendername));
 	format(string, sizeof(string), "%s: %s", sendername,text);
	new Float: x;
	new Float: y;
	new Float: z;
	GetPlayerPos(playerid,x,y,z);
  	foreach(new i : Player)
  	{
		if(IsPlayerInRangeOfPoint(i,20,x,y,z))
		{
		    SendClientMessage(i,COLOR_WHITE,string);
		}
  	}
	return 0;
}
function GetDriverID(vehicleid)
{
	for(new i = 0; i <= MAX_PLAYERS; i++)
		if(IsPlayerConnected(i))
		{
			if(IsPlayerInVehicle(i, vehicleid) && GetPlayerVehicleSeat(i) == 0)
				return i;
		}
	return -1;
}
function EndTaxiFare(driverid, playerid)
{
	KillTimer(TaxiTimer[playerid]);
	if(!IsPlayerConnected(driverid))
	{
		TaxiPrice[playerid] = 0;
		return 1;
	}
	new string[256], cost;
	if(PlayerInfo[playerid][pMoney] < TaxiPrice[playerid]) cost = PlayerInfo[playerid][pMoney];
	else cost = TaxiPrice[playerid];
	PlayerInfo[playerid][pMoney] -= cost;
	GivePlayerMoney(playerid, -cost);
	TaxiPrice[playerid] = 0;
	GivePlayerMoney(driverid, cost);
	format(string, sizeof(string), "**Ai platit taximetristului %s %d$ pentru cursa.", GetName(driverid), cost);
	SCM(playerid, COLOR_GREY, string);
	format(string, sizeof(string), "**Ai primit de la clientul %s %d$ pentru cursa.", GetName(playerid), cost);
	SCM(driverid, COLOR_GREY, string);
	return 1;
}
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	new string[256];
	LastCarID[playerid] = vehicleid;
	if(ispassenger == 1)
	{
		new driverid;
		driverid = GetDriverID(vehicleid);
		if(driverid != -1) PlayRadioForPlayer(playerid, CarRadioID[driverid]);
		if(driverid != -1 && IsPlayerConnected(driverid) && PlayerInfo[driverid][pFaction] == 13)
		{
			if(TaxiFare[driverid] != 0) TaxiTimer[playerid] = SetTimerEx("TaxiUpFare", 5000, true, "uu" , driverid, playerid);
			if(TaxiPlayerC[driverid] == playerid) TaxiPlayerC[driverid] = -1;
		}
	}
	if(ispassenger == 0)
	{
		PlayRadioForPlayer(playerid, CarRadioID[playerid]);
		if(RentCarPID[vehicleid] != -1 && RentCarPID[vehicleid] != playerid)
		{
			ClearAnimations(playerid);
		    SCM(playerid,COLOR_YELLOW,"Doar cel care a inchiriat aceasta masina o poate conduce.");
		}
		if(PlayerInfo[playerid][pBoatLic] == 0 && IsABoat(vehicleid) )
		{
		    ClearAnimations(playerid);
		    SCM(playerid,COLOR_YELLOW,"Nu ai licenta de navigatie.");
		}
		else if(PlayerInfo[playerid][pFlyLic] == 0 && IsAPlane(vehicleid) )
		{
		    ClearAnimations(playerid);
		    SCM(playerid,COLOR_YELLOW,"Nu ai licenta de zbor.");
		}
		else if(PlayerInfo[playerid][pCarLic] != 0 && !IsABike(vehicleid))
		{
		    ClearAnimations(playerid);
	        SCM(playerid,COLOR_YELLOW,"Nu ai permis.");
		}
		if(CarHouse[vehicleid] != 0 && PlayerInfo[playerid][pHouseID] != CarHouse[vehicleid])
		{
			ClearAnimations(playerid);
	        SCM(playerid,COLOR_YELLOW,"Doar chiriasii casei pot conduce aceasta masina.");
		}
		if(PersonalSCars[vehicleid] != 0)
		{
			if(PVLock[PersonalSCars[vehicleid]][playerid] == 0)
			{
				ClearAnimations(playerid);
				format(string, sizeof(string), "{c6c9c3}Vehicul privat al jucatorului {ffffff}%s", GetName(PersonalCars[PersonalSCars[vehicleid]][OwnerID]));
				SCM(playerid, COLOR_GREY, string);
			}
		}
		if(WarStatus == 1)
		{
			new alianceID = 0;
			if(PlayerInfo[playerid][pFaction] >= 4 &&  PlayerInfo[playerid][pFaction] <= 6) alianceID = 1;
			if(PlayerInfo[playerid][pFaction] >= 7 &&  PlayerInfo[playerid][pFaction] <= 9) alianceID = 2;
			if(WarCars[vehicleid][1] != alianceID && WarCars[vehicleid][1] != 0)
			{
					format(string, sizeof(string), "Acest vehicul de war poate fi condus doar de membrii factiunii.");
					SendClientMessage(playerid, COLOR_GREY, string);
					ClearAnimations(playerid);
			}
		}
		if(CanTurf[PlayerInfo[playerid][pFaction]] == 2)
		{
			new EnemyID;
			for(new i = 4; i <= 9; i++)
				if(CanTurf[i] == 2 && FactionTurf[i] == FactionTurf[PlayerInfo[playerid][pFaction]] && i != PlayerInfo[playerid][pFaction])
					EnemyID = i;
			if(vehicleid == TurfCarID[EnemyID][1]) 
			{
				ClearAnimations(playerid);
				format(string, sizeof(string), "Acest vehicul de turf poate fi condus doar de membrii factiunii.");
				SendClientMessage(playerid, COLOR_GREY, string);
			}
			if(vehicleid == TurfCarID[EnemyID][1]) 
			{
				ClearAnimations(playerid);
				format(string, sizeof(string), "Acest vehicul de turf poate fi condus doar de membrii factiunii.");
				SendClientMessage(playerid, COLOR_GREY, string);
			}
			if(vehicleid == TurfCarID[EnemyID][2]) 
			{
				ClearAnimations(playerid);
				format(string, sizeof(string), "Acest vehicul de turf poate fi condus doar de membrii factiunii.");
				SendClientMessage(playerid, COLOR_GREY, string);
			}
			if(vehicleid == TurfCarID[EnemyID][3]) 
			{
				ClearAnimations(playerid);
				format(string, sizeof(string), "Acest vehicul de turf poate fi condus doar de membrii factiunii.");
				SendClientMessage(playerid, COLOR_GREY, string);
			}
			if(vehicleid == TurfCarID[EnemyID][4]) 
			{
				ClearAnimations(playerid);
				format(string, sizeof(string), "Acest vehicul de turf poate fi condus doar de membrii factiunii.");
				SendClientMessage(playerid, COLOR_GREY, string);
			}
			if(vehicleid == TurfCarID[EnemyID][5]) 
			{
				ClearAnimations(playerid);
				format(string, sizeof(string), "Acest vehicul de turf poate fi condus doar de membrii factiunii.");
				SendClientMessage(playerid, COLOR_GREY, string);
			}
			if(vehicleid == TurfCarID[EnemyID][6]) 
			{
				ClearAnimations(playerid);
				format(string, sizeof(string), "Acest vehicul de turf poate fi condus doar de membrii factiunii.");
				SendClientMessage(playerid, COLOR_GREY, string);
			}
		}
		if(ServerVehicles[vehicleid][vID] != 0) {
			    if(ServerVehicles[vehicleid][vFaction] != PlayerInfo[playerid][pFaction] && ServerVehicles[vehicleid][vFaction] != 0) {
		            format(string, sizeof(string), "Acest vehicul poate fi condus doar de membrii factiunii.");
					SendClientMessage(playerid, COLOR_GREY, string);
					ClearAnimations(playerid);
			    }
	      		if(ServerVehicles[vehicleid][vRank] > PlayerInfo[playerid][pRFaction]) {
			            format(string, sizeof(string), "Acest vehicul poate fi condus doar de membrii cu rank %d.", ServerVehicles[vehicleid][vRank]);
						SendClientMessage(playerid, COLOR_GREY, string);
				        ClearAnimations(playerid);
				    }
	        }
	}
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	if(FarmerCarID[playerid] == vehicleid)
	{
		DestroyVehicle(FarmerCarID[playerid]);
		FarmerTimer[playerid] = 0;
		PlayerInfo[playerid][pCanQuitJob] = 0;
		StopFarmerTXD(playerid);
		SendClientMessage(playerid, -1, "{9843c6}**Fermierul {bcb005}Ion {75bc04}Ceaun {9843c6}este foarte nemultumit de tine.");
		FarmerCarID[playerid] = 0;
	}
	return 1;
}
function Slap(playerid)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	SetPlayerPos(playerid, x, y, z+3);
	return 1;
}
public OnPlayerStateChange(playerid, newstate, oldstate)
{
    new string[256];
    if(oldstate == PLAYER_STATE_DRIVER)
    {
    	StopAudioStreamForPlayer(playerid);
    	if(PlayerInfo[playerid][pFaction] == 13 && TaxiFare[playerid] != 0)
    	{
    		TaxiFare[playerid] = 0;
    		new vehicle = LastCarID[playerid];
    		for(new i = 0; i <= MAX_PLAYERS; i++)
    			if(IsPlayerConnected(i))
    				if(IsPlayerInVehicle(i, vehicle))
    					if(GetPlayerVehicleSeat(i) != 0)
    					{
    						KillTimer(TaxiTimer[i]);
    						TaxiTimer[i]= 0;
    						TaxiPrice[i] = 0;
    						SCM(i, COLOR_GREY, "Taximetristul a iesit din taxi.");
    					}
    	}
    }
    if(oldstate == PLAYER_STATE_PASSENGER)
    {
    	StopAudioStreamForPlayer(playerid);
    	if(TaxiPrice[playerid] != 0)
    	{
    		KillTimer(TaxiTimer[playerid]);
    		TaxiTimer[playerid]= 0;
    		new taxidriverid, money;
    		money = TaxiPrice[playerid];
    		TaxiPrice[playerid] = 0;
    		taxidriverid = GetDriverID(LastCarID[playerid]);
    		PlayerInfo[playerid][pMoney] -= money;
    		GivePlayerMoney(playerid, -money);
    		PlayerInfo[taxidriverid][pMoney] += money;
    		format(string, sizeof(string), "**Ai platit %d $ pentru cursa.", money);
    		SCM(playerid, COLOR_GREY, string);
    		format(string, sizeof(string), "**Ai primit de la %s %d $ pentru cursa.", GetName(playerid), money);
    		SCM(taxidriverid, COLOR_GREY, string);
    		PlayerInfo[taxidriverid][pTaxiRaport]++;
    	}
    }
	if(FarmerTimer[playerid] != 0)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(FarmerCarID[playerid] != vehicleid || vehicleid == 0)
		{
			DestroyVehicle(FarmerCarID[playerid]);
			FarmerTimer[playerid] = 0;
			PlayerInfo[playerid][pCanQuitJob] = 0;
			StopFarmerTXD(playerid);
			FarmerCarID[playerid] = 0;
		}
	}
	if(PlayerInfo[playerid][pJob] == 7 && PlayerInfo[playerid][pCanQuitJob] == 1 && newstate != PLAYER_STATE_DRIVER)
	{
		StopTruckerTXD(playerid);
		TruckerCarPlayerID[PlayerInfo[playerid][pTruckerCarID]] = -1;
		DestroyVehicle(PlayerInfo[playerid][pTruckerCarID]);
		PlayerInfo[playerid][pTruckerCarID] = 0;
		DisablePlayerCheckpoint(playerid);
		CP[playerid][ID] = 0;
		PlayerInfo[playerid][pTruckerMoney] = 0;
		PlayerInfo[playerid][pTruckerPos] = 0;
		if(PlayerInfo[playerid][pTruckerStatus] == 2)
		{
			TruckerTrailerTimer[PlayerInfo[playerid][pTruckerTrailerID]] = 0;
			TruckerTrailerPlayerID[PlayerInfo[playerid][pTruckerTrailerID]] = -1;
			DestroyVehicle(PlayerInfo[playerid][pTruckerTrailerID]);
			PlayerInfo[playerid][pTruckerTrailerID] = 0;

		}
		PlayerInfo[playerid][pTruckerStatus] = 0;
		PlayerInfo[playerid][pCanQuitJob] = 0;
		SCM(playerid, COLOR_GREY, "**Ai anulat job-ul.");
	}
	if(newstate == PLAYER_STATE_DRIVER)
	{
			new vehicleid = GetPlayerVehicleID(playerid);
	   	    PlayerTextDrawShow(playerid,SpeedText[playerid][UseBox]);
	     	PlayerTextDrawShow(playerid,SpeedText[playerid][White1]);
	     	PlayerTextDrawShow(playerid,SpeedText[playerid][White2]);
	     	PlayerTextDrawShow(playerid,SpeedText[playerid][White3]);
	   	    PlayerTextDrawShow(playerid,SpeedText[playerid][White4]);

			new vehicle = GetPlayerVehicleID(playerid);
			new Float:health;
	        if(!IsABike(vehicleid) && !IsABoat(vehicleid) && !IsAPlane(vehicleid) )
	 		{
		  		new oldspeed = 0;
				new newspeed = GetVehicleSpeed(vehicle);
				PlayerInfo[playerid][Speed]=newspeed;
				new acceleration = abs(newspeed - oldspeed);
		 		new Consume = (((acceleration / 10) + 1) * (newspeed / 20));
				format(string,sizeof(string),"Fuel: %.1f C:%d",fuel[vehicle],Consume);
				PlayerTextDrawSetString(playerid, SpeedText[playerid][Fuel], string);
				PlayerTextDrawShow(playerid,SpeedText[playerid][Fuel]);
			}
			format(string,sizeof(string),VehicleNames[GetVehicleModel(vehicle)-400]);
			PlayerTextDrawSetString(playerid, SpeedText[playerid][Car], string);
			PlayerTextDrawShow(playerid, SpeedText[playerid][Car]);

			format(string,sizeof(string),"Speed: %d MPH",GetVehicleSpeed(vehicle));
			PlayerTextDrawSetString(playerid, SpeedText[playerid][Speed], string);
			PlayerTextDrawShow(playerid, SpeedText[playerid][Speed]);

			GetVehicleHealth(vehicle,health);

			format(string,sizeof(string),"Health: %.2f",health);
			PlayerTextDrawSetString(playerid, SpeedText[playerid][Health], string);
			PlayerTextDrawShow(playerid, SpeedText[playerid][Health]);
     }
	return 1;
}
function StopWoodCutterChain(playerid)
{
	if(PlayerInfo[playerid][pJob] != 5 || PlayerInfo[playerid][pCanQuitJob] == 0) return 1;
	TogglePlayerControllable(playerid, 1);
	SetPlayerCheckpoint(playerid, -2000.6581,-2368.5271,30.6250, 3);
	CP[playerid][ID] = 6;
	PlayerInfo[playerid][pBusteniT] = (2 + random(4));
	new string[256];
	format(string, sizeof(string), "{81ef2d}**Ai taiat {a8abad}%d {81ef2d}busteni. Transporta-i la fabrica.", PlayerInfo[playerid][pBusteniT]);
	SCM(playerid, COLOR_GREY, string);
	UpdateWoodCutterTXD(playerid);
	ClearAnimations(playerid);
	RemovePlayerAttachedObject(playerid,9);
	SetPlayerAttachedObject(playerid,2, 1458, 1, -1.034844, 1.116571, -0.065124, 76.480148, 75.781570, 280.952545, 0.575599, 0.604554, 0.624122);
    SetPlayerAttachedObject(playerid,3, 1463, 1, -0.205007, 1.545087, -0.014800, 171.406829, 96.114616, 0.066009, 0.403667, 1.000000, 1.021239 );
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
    return 1;
}
function WoodCutterCP(playerid)
{
		new var; var = random(9);
		if(var == 0)
		{
			SetPlayerCheckpoint(playerid, -1931.3807,-2361.4666,30.8452, 1);
		}
		else if(var == 1)
		{
			SetPlayerCheckpoint(playerid, -1932.0576,-2346.1526,33.1779, 1);
		}
		else if(var == 2)
		{
			SetPlayerCheckpoint(playerid, -1918.9552,-2352.7754,30.9004, 1);
		}
		else if(var == 3)
		{
			SetPlayerCheckpoint(playerid, -1914.3473,-2368.6514,29.8125, 1);
		}
		else if(var == 4)
		{
			SetPlayerCheckpoint(playerid, -1903.3979,-2371.4641,30.9230, 1);
		}
		else if(var == 5)
		{
			SetPlayerCheckpoint(playerid, -1903.7625,-2361.4548,31.1642, 1);
		}
		else if(var == 6)
		{
			SetPlayerCheckpoint(playerid, -1919.5613,-2406.1536,30.1000, 1);
		}
		else if(var == 7)
		{
			SetPlayerCheckpoint(playerid, -1937.3892,-2415.2402,30.6250, 1);
		}
		else if(var == 8)
		{
			SetPlayerCheckpoint(playerid, -1950.2982,-2407.8999,30.6250, 1);
		}
		CP[playerid][ID] = 5;
		return 1;	
}
function StopMining(playerid)
{
	if(PlayerInfo[playerid][pJob] != 6 || PlayerInfo[playerid][pCanQuitJob] == 0) return 1;
	TogglePlayerControllable(playerid, 1);
	new string[256];
	new var = random(2);
	new var1;
	new cnt = 0;
	if(var == 1)
	{
		cnt++;
		var1 = 1 + random(5);
		PlayerInfo[playerid][pMinerAur] += var1;
		format(string, sizeof(string), " Aur %dg", var1);
	}
	var = random(2);
	if(var == 1)
	{
		cnt++;
		var1 = 1 + random(10);
		PlayerInfo[playerid][pMinerArgint] += var1;
		format(string, sizeof(string), "%s Argint %dg",string, var1);
	}
	var = random(2);
	if(var == 1)
	{
		cnt++;
		var1 = 1 + random(20);
		PlayerInfo[playerid][pMinerCupru] += var1;
		format(string, sizeof(string), "%s Cupru %dg",string, var1);
	}
	var = random(2);
	if(var == 1)
	{
		cnt++;
		var1 = 1 + random(20);
		PlayerInfo[playerid][pMinerFier] += var1;
		format(string, sizeof(string), "%s Fier %dg",string, var1);
	}
	if(cnt == 0) format(string, sizeof(string), "Nu ai gasit nimic.");
	else format(string, sizeof(string), "Ai gasit%s", string);
	SCM(playerid, COLOR_GREY, string);
	UpdateMinerTXD(playerid);
	ClearAnimations(playerid);
	RemovePlayerAttachedObject(playerid,2);
    var = random(9);
	if(var == 0)
	{
		SetPlayerCheckpoint(playerid, -1810.3282,-1646.8640,22.8473, 1);
	}
	else if(var == 1)
	{
		SetPlayerCheckpoint(playerid, -1797.4072,-1656.6472,28.9579, 1);
	}
	else if(var == 2)
	{
		SetPlayerCheckpoint(playerid, -1785.8064,-1653.8997,26.0740, 1);
	}
	else if(var == 3)
	{
		SetPlayerCheckpoint(playerid, -1771.7822,-1647.9310,25.8311, 1);
	}
	else if(var == 4)
	{
		SetPlayerCheckpoint(playerid, -1782.3867,-1645.1805,32.7344, 1);
	}
	else if(var == 5)
	{
		SetPlayerCheckpoint(playerid, -1852.1948,-1654.5300,23.4745, 1);
	}
	else if(var == 6)
	{
		SetPlayerCheckpoint(playerid, -1855.0757,-1646.1533,24.8496, 1);
	}
	else if(var == 7)
	{
		SetPlayerCheckpoint(playerid, -1864.4315,-1649.5781,24.6766, 1);
	}
	else if(var == 8)
	{
		SetPlayerCheckpoint(playerid, -1864.4104,-1659.4810,22.4337, 1);
	}	
	return 1;
}
public OnPlayerEnterCheckpoint(playerid)
{
	if(CP[playerid][ID] == 7)
	{
		if(PlayerInfo[playerid][pJob] == 7 && PlayerInfo[playerid][pCanQuitJob] == 1 && PlayerInfo[playerid][pTruckerStatus] == 2)
		{
			if(IsPlayerInVehicle(playerid, PlayerInfo[playerid][pTruckerCarID]) && GetVehicleTrailer(PlayerInfo[playerid][pTruckerCarID]) == PlayerInfo[playerid][pTruckerTrailerID])
			{
				DisablePlayerCheckpoint(playerid);
				CP[playerid][ID] = 0;
				PlayerInfo[playerid][pTruckerStatus] = 1;
				GivePlayerMoney(playerid, PlayerInfo[playerid][pTruckerMoney]);
				PlayerInfo[playerid][pMoney] += PlayerInfo[playerid][pTruckerMoney];
				new string[256];
				format(string, sizeof(string), "{5bc1be}**Ai primit {bababa}%d {5bc1be}$ pentru aceasta cursa.", PlayerInfo[playerid][pTruckerMoney]);
				SCM(playerid, -1, string);
				PlayerInfo[playerid][pTruckerMoney] = 0;
				TruckerTrailerPlayerID[PlayerInfo[playerid][pTruckerTrailerID]] = -1;
				TruckerTrailerTimer[PlayerInfo[playerid][pTruckerTrailerID]] = 0;
				DestroyVehicle(PlayerInfo[playerid][pTruckerTrailerID]);
				PlayerInfo[playerid][pTruckerTrailerID] = 0;
				PlayerInfo[playerid][pTruckerPos] = 0;
				UpdateTruckerTXD(playerid);

			}
		}
	}
	if(CP[playerid][ID] == 6 && !IsPlayerInAnyVehicle(playerid) && PlayerInfo[playerid][pJob] == 5)
	{
		DisablePlayerCheckpoint(playerid);
		RemovePlayerAttachedObject(playerid,2);
		RemovePlayerAttachedObject(playerid,3);
		PlayerInfo[playerid][pBusteni] += PlayerInfo[playerid][pBusteniT];
		UpdateWoodCutterTXD(playerid);
		SetPlayerSpecialAction(playerid, 0);
		SetTimerEx("WoodCutterCP", 1000, 0, "u", playerid);
	}
	if(CP[playerid][ID] == 5  && !IsPlayerInAnyVehicle(playerid))
	{
		if(PlayerInfo[playerid][pJob] == 5)
		{
			CP[playerid][ID] = 6;
			DisablePlayerCheckpoint(playerid);
			ClearAnimations(playerid);
		    SetPlayerAttachedObject(playerid, 9, 341, 14, 0.301943, 0.011442, 0.010348, 106.050292, 330.509094, 3.293162, 1.000000, 1.000000, 1.000000 );
		    TogglePlayerControllable(playerid, 0);
		    ApplyAnimation(playerid,"PED","handscower",4.1, 1, 1, 1, 1, 1 ,1);
	       // ApplyAnimation(playerid,"CHAINSAW","CSAW_G",4.1,0,0,0,0,10000,1);
			GameTextForPlayer(playerid, "Cutting...", 10000, 5);
			SetTimerEx("StopWoodCutterChain", 10000, 0, "u", playerid);
		}
		else if(PlayerInfo[playerid][pJob] == 6)
		{
			DisablePlayerCheckpoint(playerid);
			ClearAnimations(playerid);
		    TogglePlayerControllable(playerid, 0);
		    ApplyAnimation(playerid, "SWORD", "sword_4", 4.0, 0,0,0,0,10000,1);
		    SetPlayerAttachedObject(playerid, 2, 18634, 14, 0.301943, 0.011442, 0.010348, 106.050292, 330.509094, 270.293162, 1.000000, 1.000000, 1.000000);
			GameTextForPlayer(playerid, "Mining...", 10000, 5);
			SetTimerEx("StopMining", 10000, 0, "u", playerid);
		}
		
	}
	if(CP[playerid][ID] == 4)
	{
		DisablePlayerCheckpoint(playerid);
		CP[playerid][ID] = 0;
	}
	if(CP[playerid][ID] == 3)
	{
		
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid)==PLAYER_STATE_DRIVER)
		{
			new vehid, model;
			vehid = GetPlayerVehicleID(playerid);
			model = GetVehicleModel(vehid);
			if(model == 522 ) // aici pun toate bike-urile de la bikers
			{
				CP[playerid][ID] = 0;
				new string[256];
				if(BikersN1 == 0)
				{
					DisablePlayerCheckpoint(playerid);
					PlayerInfo[playerid][pBP] += BikersPrize1;
					BikersN1 = 1;
					format(BikersNume1, 256, GetName(playerid));
					format(string, sizeof(string), "%s a terminat primul stunt-ul si a primit %d BP.", GetName(playerid), BikersPrize1);
					foreach(new i : Player)
					{
						if(IsPlayerConnected(i))
						{
							if(PlayerInfo[i][pClub] == 3)
								SCM(i, COLOR_TURQUOISE, string);
						}
					}
					Update(playerid, pBP);

				}
				else if(BikersN2 == 0)
				{
					DisablePlayerCheckpoint(playerid);
					PlayerInfo[playerid][pBP] += BikersPrize2;
					BikersN2 = 1;
					format(BikersNume2, 256, GetName(playerid));
					format(string, sizeof(string), "%s a terminat al doilea stunt-ul si a primit %d BP.", GetName(playerid), BikersPrize2);
					foreach(new i : Player)
					{
						if(IsPlayerConnected(i))
						{
							if(PlayerInfo[i][pClub] == 3)
								SCM(i, COLOR_TURQUOISE, string);
						}
					}
					Update(playerid, pBP);
				}
				else if(BikersN3 == 0)
				{
					DisablePlayerCheckpoint(playerid);
					PlayerInfo[playerid][pBP] += BikersPrize3;
					BikersN3 = 1;
					format(BikersNume3, 256, GetName(playerid));
					format(string, sizeof(string), "%s a terminat al doilea stunt-ul si a primit %d BP. Eventul s-a terminat.", GetName(playerid), BikersPrize3);
					foreach(new i : Player)
					{
						if(IsPlayerConnected(i))
						{
							if(PlayerInfo[i][pClub] == 3)
								SCM(i, COLOR_TURQUOISE, string);
						}
					}
					Update(playerid, pBP);
					BikersActive = 0;
				}
			}
		}

	}
	else if(PlayerInfo[playerid][pMissionid] !=0 )
	{
		new string[256];
		DisablePlayerCheckpoint(playerid);
		if(PlayerInfo[playerid][pMissionid] != CurrentMission) 
		{
			CheckColor(playerid);
			PlayerInfo[playerid][pMissionid] =0;
			PlayerInfo[playerid][pMissionCP] =0;
			CP[playerid][ID]=0;
			return SCM(playerid,COLOR_RED,"Misiunea a expirat .");

		}

		if(PlayerInfo[playerid][pMissionCP] == 1)
		{
			PlayerInfo[playerid][pMissionCP] = 2;
			GameTextForPlayer(playerid, Missions[CurrentMission][Text1], 2000, 0);
			SetPlayerCheckpoint(playerid, Missions[CurrentMission][CP2X], Missions[CurrentMission][CP2Y], Missions[CurrentMission][CP2Z], 5);
		}
		else if(PlayerInfo[playerid][pMissionCP] == 2)
		{
			PlayerInfo[playerid][pMissionCP] = 3;
			GameTextForPlayer(playerid, Missions[CurrentMission][Text2], 2000, 0);
			SetPlayerCheckpoint(playerid, Missions[CurrentMission][CP3X], Missions[CurrentMission][CP3Y], Missions[CurrentMission][CP3Z], 5);
		}
		else if(PlayerInfo[playerid][pMissionCP] == 3)
		{
			PlayerInfo[playerid][pMissionCP] = 4;
			GameTextForPlayer(playerid, Missions[CurrentMission][Text3], 2000, 0);
			SetPlayerCheckpoint(playerid, Missions[CurrentMission][CP4X], Missions[CurrentMission][CP4Y], Missions[CurrentMission][CP4Z], 5);
		}
		else if(PlayerInfo[playerid][pMissionCP] == 4)
		{
			PlayerInfo[playerid][pMissionCP] = 5;
			GameTextForPlayer(playerid, Missions[CurrentMission][Text4], 2000, 0);
			SetPlayerCheckpoint(playerid, Missions[CurrentMission][CP5X], Missions[CurrentMission][CP5Y], Missions[CurrentMission][CP5Z], 5);
		}
		else if(PlayerInfo[playerid][pMissionCP] == 5)
		{
			PlayerInfo[playerid][pMissionCP] = 6;
			GameTextForPlayer(playerid, Missions[CurrentMission][Text5], 2000, 0);
			SetPlayerCheckpoint(playerid, Missions[CurrentMission][CP6X], Missions[CurrentMission][CP6Y], Missions[CurrentMission][CP6Z], 5);
		}
		else if(PlayerInfo[playerid][pMissionCP] == 6)
		{
			CP[playerid][ID]=0;
			PlayerInfo[playerid][pMissionCP] = 0;
			PlayerInfo[playerid][pMissionid] = 0;
			PlayerInfo[playerid][pMissionF]++;
			PlayerInfo[playerid][pLastMission]=CurrentMission;
			Update(playerid,pLastMission);
			CheckColor(playerid);
			GameTextForPlayer(playerid, Missions[CurrentMission][Text6], 2000, 0);
			format(string,sizeof(string),"{009900} FELICITARI !!! {ffffff} Ai terminat misiunea: %s | Reward: %d $ | Difficulty : %s",Missions[CurrentMission][Title],Missions[CurrentMission][Reward],Missions[CurrentMission][Difficulty]);
			SCM(playerid,COLOR_WHITE,string);
			///aici pun nr de misiuni terminate.
		}
	}
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}
public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}
public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}
public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	PaintJobP[vehicleid] = paintjobid;
	return 1;
}
forward CheckMoneyPNS(playerid);
public CheckMoneyPNS(playerid)
{
	if(GetPlayerMoney(playerid) > PlayerInfo[playerid][pMoney])  PlayerInfo[playerid][pMoney] +=100;
	return 1;
}
public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	PColor1[vehicleid] = color1;
	PColor2[vehicleid] = color2;
	if(color1 == color2 && color1 == -1 && GetPlayerVehicleSeat(playerid) == 0)
	{
		PlayerInfo[playerid][pMoney] -=100;
		SetTimer("CheckMoneyPNS", 1000, false);
	}
	return 1; 

}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if ((oldkeys & KEY_FIRE) && (newkeys & KEY_CROUCH))
	{
		new weapon = GetPlayerWeapon(playerid);
		if(weapon == 24 || weapon == 33) // weapon == 24 este deagle , daca vreti sa se blocheze c-bugul si la alte arme faceti in felul urmator: if(weapon == 24 || weapon == id la arma )
		{
			ApplyAnimation(playerid,"GYMNASIUM","gym_tread_falloff",1.0,0,0,0,0,0);
			SCM(playerid, -1, "{ad0303}ATENTIE!! {adadad}Nu mai abuza de C-Bug.");
		}
	}
	if(newkeys & KEY_SECONDARY_ATTACK)
	{
		new Float:x;
		new Float:y;
		new Float:z;
		new playerstate=GetPlayerState(playerid);
		if(playerstate == PLAYER_STATE_ONFOOT)
		{
				new i;
				GetPlayerPos(playerid, x, y, z);
				for(i = 1; i <= nrBiz; i++)
				{
					if(IsPlayerInRangeOfPoint(playerid, 2, BizInfo[i][bX], BizInfo[i][bY], BizInfo[i][bZ]) && BizInfo[i][CanEnter] == 1)
					{
						if(PlayerInfo[playerid][pWanted] != 0) return SCM(playerid, COLOR_GREY, "Ai wanted.");
						SetPlayerPos(playerid, BizInfo[i][iX], BizInfo[i][iY], BizInfo[i][iZ]);
						SetPlayerInterior(playerid, BizInfo[i][Interior]);
						SetPlayerVirtualWorld(playerid, BizInfo[i][VW]);
						if(PlayerInfo[playerid][pFishKG] != 0 && BizInfo[i][Type] == 1)
						{
							new string[256];
							format(string, sizeof(string), "{64e000}**Ai primit{acadab} %d ${64e000} pentru pestele tau de {acadab}%d{64e000}g.",PlayerInfo[playerid][pFishKG]/2, PlayerInfo[playerid][pFishKG]);
							SCM(playerid, COLOR_GREY, string);
							GivePlayerMoney(playerid, PlayerInfo[playerid][pFishKG] / 2);
							PlayerInfo[playerid][pMoney] += (PlayerInfo[playerid][pFishKG] / 2);
							PlayerInfo[playerid][pFishKG] = 0;
						}
						return 1;
					}
					if(IsPlayerInRangeOfPoint(playerid, 2, BizInfo[i][iX], BizInfo[i][iY], BizInfo[i][iZ]) && BizInfo[i][CanEnter] == 1 && GetPlayerVirtualWorld(playerid) == BizInfo[i][VW] && GetPlayerInterior(playerid) == BizInfo[i][Interior])
					{
						SetPlayerPos(playerid, BizInfo[i][bX], BizInfo[i][bY], BizInfo[i][bZ]);
						SetPlayerInterior(playerid, 0);
						SetPlayerVirtualWorld(playerid, 0);
						return 1;
					}
				}
				for(i=1;i<=nrhq;i++)
				{
			        if(IsPlayerInRangeOfPoint(playerid,2,SvHq[i][X1],SvHq[i][Y1],SvHq[i][Z1]))
			        {
			        	if(PlayerInfo[playerid][pVW] == SvHq[i][VW1])
						{	
							if(PlayerInfo[playerid][pWanted] != 0) return SCM(playerid,COLOR_GREY,"Ai wanted.");
		                    SetPlayerPos(playerid, SvHq[i][X2], SvHq[i][Y2], SvHq[i][Z2]);
							SetPlayerVirtualWorld(playerid, SvHq[i][VW2]);
							SetPlayerInterior(playerid,SvHq[i][Interior2]);
							PlayerInfo[playerid][pVW]=SvHq[i][VW2];
							PlayerInfo[playerid][pInterior]=SvHq[i][Interior2];
							return 1;
						}
					
					}
			    }
			    for(i=1;i<=nrhq;i++)
				{
			        if(IsPlayerInRangeOfPoint(playerid,2,SvHq[i][X2],SvHq[i][Y2],SvHq[i][Z2]))
			        {
			        	if(PlayerInfo[playerid][pVW] == SvHq[i][VW2])
						{	
		                    SetPlayerPos(playerid, SvHq[i][X1], SvHq[i][Y1], SvHq[i][Z1]);
							SetPlayerVirtualWorld(playerid, SvHq[i][VW1]);
							SetPlayerInterior(playerid,SvHq[i][Interior1]);
							PlayerInfo[playerid][pVW]=SvHq[i][VW1];
							PlayerInfo[playerid][pInterior]=SvHq[i][Interior1];
							return 1;
						}
					
					}
			    }
			    for(i=1;i<=HouseNumber;i++)
				{
			        if(IsPlayerInRangeOfPoint(playerid,2,svHouse[i][hX1],svHouse[i][hY1],svHouse[i][hZ1]))
			        {
			        	if(PlayerInfo[playerid][pVW] == 0)
			        	{
							if(PlayerInfo[playerid][pWanted] != 0) return SCM(playerid,COLOR_GREY,"Ai wanted.");
		                    SetPlayerPos(playerid, svHouse[i][hX2], svHouse[i][hY2], svHouse[i][hZ2]);
							SetPlayerVirtualWorld(playerid, svHouse[i][hVW]);
							SetPlayerInterior(playerid,svHouse[i][hInteriorID1]);
							PlayerInfo[playerid][pVW]=svHouse[i][hVW];
							PlayerInfo[playerid][pInterior]=svHouse[i][hInteriorID1];
							return 1;
						}
					
					}
			    }
			    for(i=1;i<=HouseNumber;i++)
				{
			        if(IsPlayerInRangeOfPoint(playerid,2,svHouse[i][hX2],svHouse[i][hY2],svHouse[i][hZ2]))
			        {		
			        		if(PlayerInfo[playerid][pVW] == svHouse[i][hVW])
			                {
			                    SetPlayerPos(playerid, svHouse[i][hX1], svHouse[i][hY1], svHouse[i][hZ1]);
								SetPlayerVirtualWorld(playerid, 0);
								SetPlayerInterior(playerid,0);
								PlayerInfo[playerid][pVW]=0;
								PlayerInfo[playerid][pInterior]=0;
								return 1;
							}
						
					}
			    }
		}
	}
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}
public ResetLicenseTimer(playerid)
{
	if(PlayerInfo[playerid][pLicMoney] != 0 )
	{
	    PlayerInfo[playerid][pLicMoney] = 0;
	    SCM(PlayerInfo[playerid][pLicID],COLOR_BLUE,"A expirat oferta de licente.");
	    SCM(playerid,COLOR_BLUE,"Ai avut o oferta de licente dar a expirat.");
	}
	return 1;
}
public CreateWarCars()
{

	//TT-LSV-GROOVE CARS
	new carid;
	carid = AddStaticVehicle(536,2471.3301,-1653.3054,13.1243,89.5644,86,86); // 
	SetVehicleVirtualWorld(carid, 2019);
	WarCars[carid][1] = 1;
	carid = AddStaticVehicle(536,2485.7107,-1653.7830,13.1193,87.3616,86,86); //
	SetVehicleVirtualWorld(carid, 2019); 
	WarCars[carid][1] = 1;
	carid = AddStaticVehicle(567,2496.3752,-1647.5176,13.3711,181.1191,86,86); //
	SetVehicleVirtualWorld(carid, 2019);
	WarCars[carid][1] = 1; 
	carid = AddStaticVehicle(492,2506.3530,-1651.2087,13.4280,142.0237,86,86); // 
	SetVehicleVirtualWorld(carid, 2019);
	WarCars[carid][1] = 1;
	carid = AddStaticVehicle(567,2509.1638,-1666.5454,13.3464,185.8201,86,86); //
	SetVehicleVirtualWorld(carid, 2019);
	WarCars[carid][1] = 1; 
	carid = AddStaticVehicle(567,2507.3149,-1677.1852,13.3295,142.4968,86,86); // 
	SetVehicleVirtualWorld(carid, 2019);
	WarCars[carid][1] = 1;
	carid = AddStaticVehicle(492,2468.6650,-1670.8488,13.1698,12.1747,86,86); // 
	SetVehicleVirtualWorld(carid, 2019);
	WarCars[carid][1] = 1;
	carid = AddStaticVehicle(482,2473.3962,-1691.4586,13.6693,359.4340,86,86); // 
	SetVehicleVirtualWorld(carid, 2019);
	WarCars[carid][1] = 1;
	carid = AddStaticVehicle(451,2483.0364,-1684.0825,13.1225,83.7904,86,86); // 
	SetVehicleVirtualWorld(carid, 2019);
	WarCars[carid][1] = 1;

	//TM - VLA - BALLAS
	carid = AddStaticVehicle(451,2025.7949,1018.2701,10.5387,268.2892,3,3); // 
	SetVehicleVirtualWorld(carid, 2019);
	WarCars[carid][1] = 2;
	carid = AddStaticVehicle(545,2025.3586,1027.7443,10.5907,272.5486,3,3); // 
	SetVehicleVirtualWorld(carid, 2019);
	WarCars[carid][1] = 2;
	carid = AddStaticVehicle(580,2024.5300,1037.4010,10.6464,270.0550,3,3); // 
	SetVehicleVirtualWorld(carid, 2019);
	WarCars[carid][1] = 2;
	carid = AddStaticVehicle(580,2024.5000,1044.0709,10.6464,269.8430,3,3); // 
	SetVehicleVirtualWorld(carid, 2019);
	WarCars[carid][1] = 2;
	carid = AddStaticVehicle(580,2024.5397,1052.7710,10.6389,271.4725,3,3); // 
	SetVehicleVirtualWorld(carid, 2019);
	WarCars[carid][1] = 2;
	carid = AddStaticVehicle(482,2026.2368,996.8224,10.9709,270.6387,3,3); // 
	SetVehicleVirtualWorld(carid, 2019);
	WarCars[carid][1] = 2;
	carid = AddStaticVehicle(545,2025.8282,988.0822,10.5869,271.9834,3,3); // 
	SetVehicleVirtualWorld(carid, 2019);
	WarCars[carid][1] = 2;
	carid = AddStaticVehicle(545,2019.2837,985.6708,10.5807,179.6224,3,3); // 
	SetVehicleVirtualWorld(carid, 2019);
	WarCars[carid][1] = 2;
	return 1;
}
public StartWarTXD(playerid)
{
	PlayerTextDrawShow(playerid, wTextdraw0[playerid]);
	PlayerTextDrawShow(playerid, wTextdraw1[playerid]);
	PlayerTextDrawShow(playerid, wTextdraw2[playerid]);
	PlayerTextDrawShow(playerid, wTextdraw3[playerid]);
	PlayerTextDrawShow(playerid, wTextdraw4[playerid]);
	PlayerTextDrawShow(playerid, wTextdraw5[playerid]);
	PlayerTextDrawShow(playerid, wTextdraw6[playerid]);
	PlayerTextDrawShow(playerid, wTextdraw7[playerid]);
	PlayerTextDrawShow(playerid, wTextdraw8[playerid]);
	PlayerTextDrawShow(playerid, wTextdraw9[playerid]);
	return 1;
}
public StopWarTXD(playerid)
{
	PlayerTextDrawHide(playerid, wTextdraw0[playerid]);
	PlayerTextDrawHide(playerid, wTextdraw1[playerid]);
	PlayerTextDrawHide(playerid, wTextdraw2[playerid]);
	PlayerTextDrawHide(playerid, wTextdraw3[playerid]);
	PlayerTextDrawHide(playerid, wTextdraw4[playerid]);
	PlayerTextDrawHide(playerid, wTextdraw5[playerid]);
	PlayerTextDrawHide(playerid, wTextdraw6[playerid]);
	PlayerTextDrawHide(playerid, wTextdraw7[playerid]);
	PlayerTextDrawHide(playerid, wTextdraw8[playerid]);
	PlayerTextDrawHide(playerid, wTextdraw9[playerid]);
	return 1;
}
public UpdateAWarTXD()
{
	new string[256];
	new string1[256];
	for (new i = 0; i <= MAX_PLAYERS; i++)
		if(IsPlayerConnected(i))
		{	
			if(PlayerInfo[i][pFaction] >= 4 && PlayerInfo[i][pFaction] <= 6)
			{
				PlayerTextDrawHide(i, wTextdraw8[i]);
				PlayerTextDrawHide(i, wTextdraw9[i]);
				format(string, sizeof(string), "Aliance Kills:%d", WarAlianceKills1);
				format(string1, sizeof(string1), "Enemy Kills:%d", WarAlianceKills2);
				PlayerTextDrawSetString(i, wTextdraw8[i], string);
				PlayerTextDrawSetString(i, wTextdraw9[i], string1);
				PlayerTextDrawShow( i, wTextdraw8[i] );
				PlayerTextDrawShow( i, wTextdraw9[i] );

			}
			else if(PlayerInfo[i][pFaction] >= 7 && PlayerInfo[i][pFaction] <= 9)
			{
				PlayerTextDrawHide(i, wTextdraw8[i]);
				PlayerTextDrawHide(i, wTextdraw9[i]);
				format(string, sizeof(string), "Aliance Kills:%d", WarAlianceKills2);
				format(string1, sizeof(string1), "Enemy Kills:%d", WarAlianceKills1);
				PlayerTextDrawSetString(i, wTextdraw8[i], string);
				PlayerTextDrawSetString(i, wTextdraw9[i], string1);
				PlayerTextDrawShow( i, wTextdraw8[i] );
				PlayerTextDrawShow( i, wTextdraw9[i] );
			}
		}
	return 1;
}
public UpdatePWarTXD(killerid, deathid)
{
	new string[256];

	PlayerTextDrawHide(killerid, wTextdraw6[killerid]);
	format(string, sizeof(string), "Kills:%d", PlayerInfo[killerid][pWKills]);
	PlayerTextDrawSetString(killerid, wTextdraw6[killerid], string);
	PlayerTextDrawShow( killerid, wTextdraw6[killerid] );

	PlayerTextDrawHide(deathid, wTextdraw7[deathid]);
	format(string, sizeof(string), "Deaths:%d", PlayerInfo[deathid][pWDeaths]);
	PlayerTextDrawSetString(deathid, wTextdraw7[deathid], string);
	PlayerTextDrawShow( deathid, wTextdraw7[deathid] );
	return 1;
}
public OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
	if(IsPlayerConnected(playerid) && IsPlayerInAnyVehicle(playerid))
	{
		PlayerInfo[playerid][pEditVName] = 0;
		new vehid = GetPlayerVehicleID(playerid);
		new pos = PersonalSCars[vehid];
		if(response  == 1)
		{
			new Float:q[4];
    		GetVehicleRotationQuat(vehid, q[0], q[1], q[2], q[3]);
			new Float:a[3], Float:ar[3];
			a[0] = fX;
		    a[1] = fY;
		    a[2] = fZ;
		    ar[0] = fRotX;
		    ar[1] = fRotY;
		    ar[2] = fRotZ;
		    /*GetObjectPos(objectid, a[0], a[1], a[2]);
		    GetObjectRot(objectid, ar[0], ar[1], ar[2]);*/
		    
		    new Float:x, Float:y, Float:z;
		    GetVehiclePos(GetPlayerVehicleID(playerid), x, y, z);
		    a[0] -= x;
		    a[1] -= y;
		    a[2] -= z;
		    
		    VectorAbsToRelQuat(q, a, a); //a is now a vehicle-relative vector
		    RotationAbsToRelQuat(q, ar, ar); //a is now a vehicle-relative rotation
		    if(a[0] < 5 && a[0] > -5 && a[1] < 5 && a[1] > -5 && a[2] < 5 && a[2] > -5)
		    {
		    	PersonalCars[pos][vX] = a[0];
				PersonalCars[pos][vY] = a[1];
				PersonalCars[pos][vZ] = a[2];
				PersonalCars[pos][rX] = ar[0];
				PersonalCars[pos][rY] = ar[1];
				PersonalCars[pos][rZ] = ar[2];
		    }
		    else SCM(playerid, COLOR_GREY, "Textul trebuie sa fie pe masina.");
			
			AttachObjectToVehicle(objectid, GetPlayerVehicleID(playerid), PersonalCars[pos][vX], PersonalCars[pos][vY], PersonalCars[pos][vZ], PersonalCars[pos][rX], PersonalCars[pos][rY], PersonalCars[pos][rZ]);
			new string[256];
			format(string, sizeof(string), "UPDATE `personalcars` SET `vX`= '%f',`vY`= '%f',`vZ`= '%f',`rX`= '%f',`rY`= '%f',`rZ`= '%f' WHERE ID = %d",PersonalCars[pos][vX], PersonalCars[pos][vY], PersonalCars[pos][vZ], PersonalCars[pos][rX], PersonalCars[pos][rY], PersonalCars[pos][rZ], PersonalCars[pos][ID]);
    		mysql_query(handle, string);
		}

	}
	//TogglePlayerControllable(playerid, 0);
	return 1;
}
function pow(base, power)
{
	new var = 1;
	for(new i = 1; i <= power; i++)
		var *= base;
	return var;
}
function HexToDec(hex[]) 
{
  	new length;
 	length = strlen(hex);
 	new decnum = 0;
 	for(new i = 0; i < length; i++)
 	{
 		if(hex[i] >= 48 && hex[i] <= 57)
 			decnum += ((hex[i] - 48) * pow(16, length - i - 1));
 		else if (hex[i] >= 65 && hex[i] <= 70)   
 			decnum += ((hex[i] - 55) * pow(16, length - i - 1));
 		else if (hex[i] >= 97 && hex[i] <= 102)
 			decnum += ((hex[i] - 87) * pow(16, length - i - 1));
 	}
    return decnum;
}
function PlayRadioForPlayer(playerid, radioid)
{
	if(radioid == 1)
	{
		StopAudioStreamForPlayer(playerid);
        PlayAudioStreamForPlayer(playerid, "http://stream.profm.ro:8012/profm.mp3");
	}
	else if(radioid == 2)
	{
		StopAudioStreamForPlayer(playerid);
        PlayAudioStreamForPlayer(playerid, "http://www.radiotaraf.ro/live.m3u");
	}
	else if(radioid == 3)
	{
		StopAudioStreamForPlayer(playerid);
        PlayAudioStreamForPlayer(playerid, "http://live.radiogangsta.ro:8800");
	}
	else if(radioid == 4)
	{
		StopAudioStreamForPlayer(playerid);
        PlayAudioStreamForPlayer(playerid, "http://www.radio-hit.ro/asculta.m3u");
	}
	return 1;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	new lString[25];
    switch(dialogid)
    {
    	case DIALOG_FACTIONS:
    	{
    		return 1;
    	}
    	case DIALOG_CHOSERADIO:
    	{
    		if(response)
    		{
    			listitem++;
    			CarRadioID[playerid] = listitem;
    			if(IsPlayerInAnyVehicle(playerid) && GetPlayerVehicleSeat(playerid) == 0)
    			{
    				new vehicleid = GetPlayerVehicleID(playerid);
    				for(new i = 0; i <= MAX_PLAYERS; i++)
    					if(IsPlayerConnected(i))
    						if(GetPlayerVehicleID(i) == vehicleid)
    							PlayRadioForPlayer(i, listitem);
    			}
    		}
    		return 1;
    	}
    	case DIALOG_JOBHELP:
    	{
    		return 1;
    	}
        case DIALOG_GPS2:
        {
			if(response)
			{
			    if(CP[playerid][ID] != 0) return SCM(playerid, COLOR_GREY, "**Ai deja un chekpoint activ.");
			    listitem++;
			    new var = 1, i = 1;
			    for(i = 1; i <= nrGPS && var != listitem; i++)
				{
    				if(GpsInfo[i][Type] == GPSID[playerid])
					        var++;
				}
				SetPlayerCheckpoint(playerid, GpsInfo[i][gpX], GpsInfo[i][gpY], GpsInfo[i][gpZ], 4);
				CP[playerid][ID] = 4;
			}
			return 1;
		}
		case DIALOG_GPS1:
		{
		    if(response)
		    {
				if(listitem == 0)
				{
					new string[1024];
					for(new i = 1; i <= nrGPS; i++)
					{
					    if(GpsInfo[i][Type] == 1)
					        format(string, sizeof(string), "%s%s\n", string, GpsInfo[i][Name]);
					}
					GPSID[playerid] = 1;
      				ShowPlayerDialog(playerid, DIALOG_GPS2, DIALOG_STYLE_LIST, "Select LS Locations:", string, "Select", "Cancel");
				}
				else if(listitem == 1)
				{
				    new string[1024];
					for(new i = 1; i <= nrGPS; i++)
					{
					    if(GpsInfo[i][Type] == 2)
					        format(string, sizeof(string), "%s%s\n", string, GpsInfo[i][Name]);
					}
					GPSID[playerid] = 2;
					ShowPlayerDialog(playerid, DIALOG_GPS2, DIALOG_STYLE_LIST, "Select LV Locations:", string, "Select", "Cancel");
				}
				else if(listitem == 2)
				{
				    new string[1024];
					for(new i = 1; i <= nrGPS; i++)
					{
					    if(GpsInfo[i][Type] == 3)
					        format(string, sizeof(string), "%s%s\n", string, GpsInfo[i][Name]);
					}
					GPSID[playerid] = 3;
					ShowPlayerDialog(playerid, DIALOG_GPS2, DIALOG_STYLE_LIST, "Select SF Locations:", string, "Select", "Cancel");
				}
		    }
			return 1;
		}
    	case DIALOG_JOBSLOCATION:
    	{
    		if(response)
    		{
    			if(CP[playerid][ID] != 0) return SCM(playerid, COLOR_GREY, "**Ai un checkpoint activ.");
    			CP[playerid][ID] = 4;
    			if(listitem == 0) SetPlayerCheckpoint(playerid, 1365.0842,-1275.0449,13.5469, 4);
    			else if(listitem == 1) SetPlayerCheckpoint(playerid, 2166.6367,-1677.7665,15.0859, 4);
    			else if(listitem == 2) SetPlayerCheckpoint(playerid, -382.8611,-1426.3734,26.2900, 4);
    			else if(listitem == 3) SetPlayerCheckpoint(playerid, 376.4070,-2054.5667,8.0156, 4);
    			else if(listitem == 4) SetPlayerCheckpoint(playerid, -1992.9341,-2387.8445,30.6250, 4);
    			else if(listitem == 5) SetPlayerCheckpoint(playerid, -1864.4252,-1559.7217,21.7500, 4);
    			else if(listitem == 6) SetPlayerCheckpoint(playerid, 2813.8909,972.8784,10.7500, 4);
    			else if(listitem == 7) SetPlayerCheckpoint(playerid,1547.4502,-1669.6681,13.5669, 4);
    		}
    		return 1;
    	}
    	case DIALOG_LOADCARGO:
    	{
    		if(response)
    		{
    			if(PlayerInfo[playerid][pJob] != 7) return SCM(playerid, COLOR_GREY, "Nu este trucker.");
				if(PlayerInfo[playerid][pCanQuitJob] == 0) return SCM(playerid, COLOR_GREY, "Nu muncesti.");
				if(CP[playerid][ID] != 0) return SCM(playerid, COLOR_GREY, "Ai un checkpoint activ.");
				if(PlayerInfo[playerid][pTruckerStatus] != 1) return SCM(playerid, COLOR_GREY, "Transporta trailer-ul la destinatie.");
    			new loadcargoid;
				if(IsPlayerInRangeOfPoint(playerid, 5, -235.4882,-256.6768,1.4297)) loadcargoid = 1;
				if(IsPlayerInRangeOfPoint(playerid, 5, -1039.1711,-590.1835,32.0078)) loadcargoid = 2;
				if(IsPlayerInRangeOfPoint(playerid, 5, -1929.8365,-1757.9303,24.1367)) loadcargoid = 3;
				if(IsPlayerInRangeOfPoint(playerid, 5, -1962.2478,-2477.5640,30.6250)) loadcargoid = 4;
				listitem++;
				new cnt, pos;
				cnt = 0;
				for(new i = 1; i <= 99 && cnt != listitem; i++)
					if(TCargoInfo[i][ID] == loadcargoid)
					{
						cnt++;
						pos = i;
					}
				PlayerInfo[playerid][pTruckerStatus] = 2;
				PlayerInfo[playerid][pTruckerPos] = pos;
				if(loadcargoid == 1)
				{
					new var, vehid;
					var = random(7);
					if(var == 0) vehid = CreateVehicle(591, -233.6456,-193.3850,1.5630,180.5181, 1, 1, 0);
					else if(var == 1) vehid = CreateVehicle(591, -226.5431,-193.5559,1.5630,180.0017, 1, 1, 0);
					else if(var == 2) vehid = CreateVehicle(591, -218.3686,-197.5208,1.5634,180.9399, 1, 1, 0);
					else if(var == 3) vehid = CreateVehicle(591, -209.5082,-197.5119,1.5630,181.3829, 1, 1, 0);
					else if(var == 4) vehid = CreateVehicle(591, -187.3542,-240.4303,1.5552,0.1034, 1, 1, 0);
					else if(var == 5) vehid = CreateVehicle(591, -178.8673,-240.3957,1.5552,0.0000, 1, 1, 0);
					else if(var == 6) vehid = CreateVehicle(591, -171.7071,-240.5037,1.5639,0.0182, 1, 1, 0);
					PlayerInfo[playerid][pTruckerTrailerID] = vehid;
					TruckerTrailerTimer[vehid] = 60;
					TruckerTrailerPlayerID[vehid] = playerid;
					PlayerInfo[playerid][pTruckerMoney] = floatround(GetPlayerDistanceFromPoint(playerid, TCargoInfo[pos][trX], TCargoInfo[pos][trY], TCargoInfo[pos][trZ]))  * 5;
					new string[256];
					format(string, sizeof(string), "{a2c435}**Livreaza trailer-ul si vei primi {bababa}%d{a2c435}$.", PlayerInfo[playerid][pTruckerMoney]);
					SCM(playerid, -1, string);
				}
				if(loadcargoid == 2)
				{
					new var, vehid;
					var = random(7);
					if(var == 0) vehid = CreateVehicle(584, -1029.8011,-679.2112,32.1125,269.5327, 1, 1, 0);
					else if(var == 1) vehid = CreateVehicle(584, -1029.7843,-666.4933,32.1143,270.9288, 1, 1, 0);
					else if(var == 2) vehid = CreateVehicle(584, -1029.8151,-651.2927,32.1053,269.5036, 1, 1, 0);
					else if(var == 3) vehid = CreateVehicle(584, -982.9764,-676.1980,32.1063,89.6596, 1, 1, 0);
					else if(var == 4) vehid = CreateVehicle(584, -983.7099,-661.5408,32.1151,89.9216, 1, 1, 0);
					else if(var == 5) vehid = CreateVehicle(584, -983.1908,-650.7489,32.1205,91.1629, 1, 1, 0);
					else if(var == 6) vehid = CreateVehicle(584, -983.7316,-623.0239,32.1075,90.6861, 1, 1, 0);
					PlayerInfo[playerid][pTruckerTrailerID] = vehid;
					TruckerTrailerTimer[vehid] = 60;
					TruckerTrailerPlayerID[vehid] = playerid;
					PlayerInfo[playerid][pTruckerMoney] = floatround(GetPlayerDistanceFromPoint(playerid, TCargoInfo[pos][trX], TCargoInfo[pos][trY], TCargoInfo[pos][trZ]))  * 5;
					new string[256];
					format(string, sizeof(string), "{a2c435}**Livreaza trailer-ul si vei primi {bababa}%d{a2c435}$.", PlayerInfo[playerid][pTruckerMoney]);
					SCM(playerid, -1, string);
				}
				if(loadcargoid == 3)
				{
					new var, vehid;
					var = random(6);
					if(var == 0) vehid = CreateVehicle(450, -1916.5334,-1706.7644,21.8529,185.2562, 1, 1, 0);
					else if(var == 1) vehid = CreateVehicle(450, -1909.1479,-1705.9597,21.8508,185.0030, 1, 1, 0);
					else if(var == 2) vehid = CreateVehicle(450, -1901.3376,-1705.2390,21.8553,184.6758, 1, 1, 0);
					else if(var == 3) vehid = CreateVehicle(450, -1866.8176,-1708.2874,21.8506,127.0448, 1, 1, 0);
					else if(var == 4) vehid = CreateVehicle(450, -1859.6396,-1718.2349,21.8555,122.7120, 1, 1, 0);
					else if(var == 5) vehid = CreateVehicle(450, -1855.8228,-1724.0878,21.8511,126.0972, 1, 1, 0);
					PlayerInfo[playerid][pTruckerTrailerID] = vehid;
					TruckerTrailerTimer[vehid] = 60;
					TruckerTrailerPlayerID[vehid] = playerid;
					PlayerInfo[playerid][pTruckerMoney] = floatround(GetPlayerDistanceFromPoint(playerid, TCargoInfo[pos][trX], TCargoInfo[pos][trY], TCargoInfo[pos][trZ]))  * 5;
					new string[256];
					format(string, sizeof(string), "{a2c435}**Livreaza trailer-ul si vei primi {bababa}%d{a2c435}$.", PlayerInfo[playerid][pTruckerMoney]);
					SCM(playerid, -1, string);
				}
				if(loadcargoid == 4)
				{
					new var, vehid;
					var = random(6);
					if(var == 0) vehid = CreateVehicle(435, -1971.6877,-2432.7512,30.7252,135.5740, 1, 1, 0);
					else if(var == 1) vehid = CreateVehicle(435, -1967.6749,-2436.8040,30.7286,136.0223, 1, 1, 0);
					else if(var == 2) vehid = CreateVehicle(435, -1964.6033,-2440.6738,30.7292,134.7956, 1, 1, 0);
					else if(var == 3) vehid = CreateVehicle(435, -1960.1555,-2444.4897,30.7317,135.8936, 1, 1, 0);
					else if(var == 4) vehid = CreateVehicle(435, -1947.5658,-2429.8792,30.7285,226.5773, 1, 1, 0);
					else if(var == 5) vehid = CreateVehicle(435, -1943.9060,-2425.3596,30.7253,226.9926, 1, 1, 0);
					PlayerInfo[playerid][pTruckerTrailerID] = vehid;
					TruckerTrailerTimer[vehid] = 60;
					TruckerTrailerPlayerID[vehid] = playerid;
					PlayerInfo[playerid][pTruckerMoney] = floatround(GetPlayerDistanceFromPoint(playerid, TCargoInfo[pos][trX], TCargoInfo[pos][trY], TCargoInfo[pos][trZ]))  * 5;
					new string[256];
					format(string, sizeof(string), "{a2c435}**Livreaza trailer-ul si vei primi {bababa}%d{a2c435}$.", PlayerInfo[playerid][pTruckerMoney]);
					SCM(playerid, -1, string);
				}

    		}
    		UpdateTruckerTXD(playerid);
    		return 1;
    	}
    	case DIALOG_TLOCATIONS:
    	{
    		if(response)
    		{
    			if(CP[playerid][ID] != 0) return SCM(playerid, COLOR_GREY, "Ai deja un checkpoint activ.");
    			if(PlayerInfo[playerid][pJob] != 7) return SCM(playerid, COLOR_GREY, "Nu esti trucker.");
    			if(PlayerInfo[playerid][pCanQuitJob] == 0) return SCM(playerid, COLOR_GREY, "Nu muncesti.");
    			if(PlayerInfo[playerid][pTruckerStatus] != 1) return SCM(playerid, COLOR_GREY, "Ai deja un trailer.");
    			if(listitem == 0) SetPlayerCheckpoint(playerid, -235.4882,-256.6768,1.4297, 5);
    			else if(listitem == 1) SetPlayerCheckpoint(playerid, -1039.1711,-590.1835,32.0078, 5);
    			else if(listitem == 2) SetPlayerCheckpoint(playerid, -1929.8365,-1757.9303,24.1367, 5);
    			else if(listitem == 3) SetPlayerCheckpoint(playerid, -1962.2478,-2477.5640,30.6250, 5);
    			CP[playerid][ID] = 4;
    		}
    		return 1;
    	}
    	case DIALOG_RENTCAR:
    	{
    		if(response)
    		{
    			if(IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_GREY, "Iesi din masina.");
    			new bizid = 0;
    			for(new i = 1; i <= nrBiz; i++)
					if(BizInfo[i][Type] == 2 && IsPlayerInRangeOfPoint(playerid, 4, BizInfo[i][bX], BizInfo[i][bY], BizInfo[i][bZ])) 
					{
						bizid = i;
						break;
					}
				if(bizid == 0) return SCM(playerid, COLOR_GREY, "Nu esti la rent car");
    			if(PlayerInfo[playerid][pMoney] < BizInfo[bizid][Fee]) return SCM(playerid, COLOR_GREY, "Nu ai destui bani.");
    			new model, vehid;
    			listitem++;
    			if(listitem == 1) model = 560;
    			else if(listitem == 2) model = 402;
    			else if(listitem == 3) model = 429;
    			else if(listitem == 4) model = 559;
    			else if(listitem == 5) model = 562;
    			else if(listitem == 6) model = 565;
    			else if(listitem == 7) model = 415;
				BizInfo[bizid][Money] += BizInfo[bizid][Fee];
    			PlayerInfo[playerid][pMoney] -= BizInfo[bizid][Fee];
    			GivePlayerMoney(playerid, -BizInfo[bizid][Fee]);
    			
    			if(bizid ==  9)
    			{
    				new var = random(8);
	    			if(var == 0) vehid = CreateVehicle(model, 554.3959,-1289.6140,16.8937,1.1015, 1, 1, 0);
	    			else if(var == 1) vehid = CreateVehicle(model, 548.9695,-1288.9006,16.8925,1.3676,  1, 1, 0);
	    			else if(var == 2) vehid = CreateVehicle(model, 542.7685,-1288.8342,16.9140,1.5695,  1, 1, 0);
	    			else if(var == 3) vehid = CreateVehicle(model, 532.9791,-1289.0065,16.9184,0.2973,  1, 1, 0);
	    			else if(var == 4) vehid = CreateVehicle(model, 564.5876,-1280.2833,16.8884,95.8080,  1, 1, 0);
	    			else if(var == 5) vehid = CreateVehicle(model, 561.1576,-1265.8152,16.9183,101.1543,  1, 1, 0);
	    			else if(var == 6) vehid = CreateVehicle(model, 550.5007,-1265.8193,16.8874,209.4797,  1, 1, 0);
	    			else if(var == 7) vehid = CreateVehicle(model, 540.2029,-1273.1042,16.9192,219.9660,  1, 1, 0);
	    			SetVehicleNumberPlate(vehid, "Rent Car LS");
	    		}
	    		else if(bizid == 10)
	    		{
	    			new var = random(8);
	    			if(var == 0) vehid = CreateVehicle(model, -1987.9819,275.4219,34.8206,269.9216, 1, 1, 0);
	    			else if(var == 1) vehid = CreateVehicle(model, -1987.6528,270.8116,35.0538,266.4091,  1, 1, 0);
	    			else if(var == 2) vehid = CreateVehicle(model, -1988.2549,266.3003,35.0555,265.9063,  1, 1, 0);
	    			else if(var == 3) vehid = CreateVehicle(model, -1987.5919,260.7792,35.0552,265.8589,  1, 1, 0);
	    			else if(var == 4) vehid = CreateVehicle(model, -1988.2423,256.8065,35.0485,263.8300,  1, 1, 0);
	    			else if(var == 5) vehid = CreateVehicle(model, -1989.3004,251.3980,35.0475,262.5686,  1, 1, 0);
	    			else if(var == 6) vehid = CreateVehicle(model, -1990.9214,246.3372,35.0485,260.9313,  1, 1, 0);
	    			else if(var == 7) vehid = CreateVehicle(model, -1983.4932,243.8396,35.0482,355.1196,  1, 1, 0);
	    			SetVehicleNumberPlate(vehid, "Rent Car SF");
	    		}
    			RentCarPID[vehid] = playerid;
    			PRentCarID[playerid] = vehid;
    			RentCarTimer[vehid] = 300;
    			PutPlayerInVehicle(playerid, vehid, 0);
    			new string[256];
    			format(string, sizeof(string), "{a8b707}**Ai inchiriat un {8c8c8c}%s {a8b707}pentru %d$. Masina se va respawna dupa 5min de la ultima folosire.", VehicleNames[model-400], BizInfo[bizid][Fee]);
    			SCM(playerid, -1, string);
    			format(string, sizeof(string), "UPDATE `bizinfo` SET `Money`=%d WHERE `ID`=%d",BizInfo[bizid][Money], bizid);
    			mysql_query(handle, string);
    		}
    		return 1;
    	}
    	case DIALOG_MYCARSPLATE:
    	{
    		if(response)
    		{
    			new pos;
    			pos = MyCarID[playerid];
    			if(PersonalCars[pos][OwnerID] != playerid) return SCM(playerid, COLOR_GREY, "Masina nu iti apartine.");
    			if(PersonalCars[pos][Spawned] == 0) return SCM(playerid, COLOR_GREY, "Nu ai masina spawnata.");
    			new nrr;
    			nrr = strlen(inputtext);
    			if(nrr >= 32) return SCM(playerid, COLOR_GREY, "License Plate este prea mare");
    			if(nrr < 1) return SCM(playerid, COLOR_GREY, "License Plate este prea mic");
    			format(PersonalCars[pos][Plate], 256, inputtext);
    			SetVehicleNumberPlate(PersonalCars[pos][CarID], PersonalCars[pos][Plate]);
    			new string[256];
    			format(string, sizeof(string), "UPDATE `personalcars` SET `Plate`= '%s' WHERE ID = %d", PersonalCars[pos][Plate], PersonalCars[pos][ID]);
    			mysql_query(handle, string);
    		}
    		return 1;
    	}
    	case DIALOG_GIVEPKEY:
    	{
    		if (response)
    		{
    			new giverid;
				giverid = GivePSkey[playerid];
				if(!IsPlayerConnected(giverid)) return SCM(playerid, COLOR_GREY, "Acel jucator nu este conectat.");
				new Float:x, Float:y, Float:z;
				GetPlayerPos(playerid, x, y, z);
				if(!IsPlayerInRangeOfPoint(giverid, 10, x, y, z)) return SCM(playerid, COLOR_GREY, "Acel jucator nu este langa tine.");
				new vw = GetPlayerVirtualWorld(playerid);
				if(vw != GetPlayerVirtualWorld(giverid)) return SCM(playerid, COLOR_GREY, "Acel jucator nu este langa tine.");
    			new pos, var = -1;
    			for(new i = 0; i <= 9 && var != listitem; i++)
					if(PlayerInfo[playerid][pCarPos][i] > 0)
					{
						var++;
						pos = PlayerInfo[playerid][pCarPos][i];
					}
				if(PersonalCars[pos][OwnerID] != playerid) return SCM(playerid, COLOR_GREY, "Masina nu iti apartine.");
				if(PVLock[pos][giverid] == 1) return SCM(playerid, COLOR_GREY, "Acel jucator are deja cheile de la acea masina.");
				PVLock[pos][giverid] = 1;
				new string[256];
				format(string, sizeof(string), "{ffffff}Jucatorul {bcbcba}%s {ffffff} ti-a oferit cheile de la masina sa personala {bcbcba}%s", GetName(playerid), VehicleNames[PersonalCars[pos][Model]-400]);
				SCM(giverid, COLOR_GREY, string);
				format(string, sizeof(string), "{ffffff}Jucatorul {bcbcba}%s {ffffff} a primit cheile de la masina ta personala {bcbcba}%s", GetName(giverid), VehicleNames[PersonalCars[pos][Model]-400]);
				SCM(playerid, COLOR_GREY, string);
    		}
    		return 1;
    	}
    	case DIALOG_VIPCOLOR: //de updatat
    	{
    		if(response)
    		{
    			new pos, nrr;
    			pos = MyCarID[playerid];
    			if(PersonalCars[pos][OwnerID] != playerid) return SCM(playerid, COLOR_GREY, "Masina nu iti apartine.");
    			nrr = strlen(inputtext);
    			if(nrr != 6) return SCM(playerid, COLOR_GREY, "Introdu o culoare valida");
    			format(PersonalCars[pos][VColor], 256, inputtext);
    			new string[256];
	    		format(string, sizeof(string), "FF%s",PersonalCars[pos][VColor]);
	    		new color = HexToDec(string);
    			SetObjectMaterialText(PersonalCars[pos][ObjectID], PersonalCars[pos][VText] , 0, 140, "Arial", 60, 1, color , 0, 1);
    			format(string, sizeof(string), "UPDATE `personalcars` SET `VColor`= '%s' WHERE ID = %d", PersonalCars[pos][VColor], PersonalCars[pos][ID]);
    			mysql_query(handle, string);
    		}
    		return 1;
    	}
    	case DIALOG_VIPNAME: //de updatat
    	{
    		if(response)
    		{
    			new pos, nrr;
    			pos = MyCarID[playerid];
    			if(PersonalCars[pos][OwnerID] != playerid) return SCM(playerid, COLOR_GREY, "Masina nu iti apartine.");
    			nrr = strlen(inputtext);
    			if(nrr < 1) return SCM(playerid, COLOR_GREY, "Introdu un text valid.");
    			format(PersonalCars[pos][VText], 256, inputtext);
    			new string[256];
	    		format(string, sizeof(string), "FF%s",PersonalCars[pos][VColor]);
	    		new color = HexToDec(string);
	    		SetObjectMaterialText(PersonalCars[pos][ObjectID], PersonalCars[pos][VText] , 0, 140, "Arial", 60, 1, color , 0, 1);
    			format(string, sizeof(string), "UPDATE `personalcars` SET `VText`= '%s' WHERE ID = %d", PersonalCars[pos][VText], PersonalCars[pos][ID]);
    			mysql_query(handle, string);
    		}
    		return 1;
    	}
    	case DIALOG_VIPCARS:
    	{
    		if(response)
    		{
    			listitem++;
	    		new pos;
	    		pos = MyCarID[playerid];
	    		if(PersonalCars[pos][OwnerID] != playerid) return SCM(playerid, COLOR_GREY, "Masina nu iti apartine.");
	    		if(listitem == 1)
	    		{
	    			if(PersonalCars[pos][VStatus] == 0) 
	    			{
	    				PersonalCars[pos][VStatus] = 1;
	    				PersonalCars[pos][ObjectID] = CreateObject(19327, 0, 0, 0, 0, 0, 0, 40);
	    				new string[256];
		    			format(string, sizeof(string), "FF%s",PersonalCars[pos][VColor]);
		    			new color = HexToDec(string);
		    			SetObjectMaterialText(PersonalCars[pos][ObjectID], PersonalCars[pos][VText] , 0, 140, "Arial", 60, 1, color , 0, 1);
	    				AttachObjectToVehicle(PersonalCars[pos][ObjectID], PersonalCars[pos][CarID], PersonalCars[pos][vX], PersonalCars[pos][vY], PersonalCars[pos][vZ], PersonalCars[pos][rX], PersonalCars[pos][rY], PersonalCars[pos][rZ]);
	    			}
	    			else 
	    			{
	    				PersonalCars[pos][VStatus] = 0;
	    				DestroyObject(PersonalCars[pos][ObjectID]);
	    			}
	    		}
	    		if(listitem == 2) ShowPlayerDialog(playerid, DIALOG_VIPCOLOR, DIALOG_STYLE_INPUT, "VIP Change Color", "Please enter your new hex color(ex: FFFFFFF):", "Select", "Cancel");
	    		if(listitem == 3) ShowPlayerDialog(playerid, DIALOG_VIPNAME, DIALOG_STYLE_INPUT, "VIP Change Text", "Please enter your new TEXT:", "Select", "Cancel");
	    		if(listitem == 4)
	    		{
	    			if(PersonalCars[pos][Spawned] == 0) return SCM(playerid, COLOR_GREY, "Nu ai masina spawnata.");
	    			if(PersonalCars[pos][VStatus] == 0) return SCM(playerid, COLOR_GREY, "Nu ai vip text-ul activat.");
	    			if(PersonalCars[pos][CarID] != GetPlayerVehicleID(playerid) && GetPlayerVehicleSeat(playerid) != 0)
	    				return SCM(playerid, COLOR_GREY, "Nu conduci masina respectiva.");
	    			PlayerInfo[playerid][pEditVName] = 1;
	    			///TogglePlayerControllable(playerid, 0);
	    			DestroyObject(PersonalCars[pos][ObjectID]);
	    			///
	    			///
	    			new Float:vx, Float:vy, Float:vz;
	    			GetVehiclePos(PersonalCars[pos][CarID], vx, vy, vz);
	    			PersonalCars[pos][ObjectID] = CreateObject(19327, vx, vy, vz, 0, 0, 0, 40);
	    			new string[256];
	    			format(string, sizeof(string), "FF%s",PersonalCars[pos][VColor]);
	    			new color = HexToDec(string);
	    			SetObjectMaterialText(PersonalCars[pos][ObjectID], PersonalCars[pos][VText] , 0, 140, "Arial", 60, 1, color , 0, 1);
	    			EditObject(playerid, PersonalCars[pos][ObjectID]);
	    			
	    		}
    		}
    		return 1;
    	}
    	case DIALOG_MYCARSACTION:
    	{
    		if (response)
    		{
    			if(PersonalCars[MyCarID[playerid]][OwnerID] != playerid) return SCM(playerid, COLOR_GREY, "Masina nu iti apartine.");
    			listitem++;
    			if(listitem == 1)
    			{
    				if(PlayerInfo[playerid][pMoney] - 500 < 0) return SCM(playerid, COLOR_GREY, "Nu ai destui bani ca sa iti spawnezi masina.");
    				PlayerInfo[playerid][pMoney] -=500;
    				GivePlayerMoney(playerid, -500);
    				if(PersonalCars[MyCarID[playerid]][Spawned] == 0)
    					SpawnPersonalCar(playerid);
    				else SetVehicleToRespawn(PersonalCars[MyCarID[playerid]][CarID]);
    			}
    			if(listitem == 2)
    				DespawnPersonalCar(playerid);
    			if(listitem == 3)
    			{
    				new vehid, pos;
    				pos = MyCarID[playerid];
    				vehid = PersonalCars[pos][CarID];
    				if(!IsPlayerInVehicle(playerid, vehid)) return SCM(playerid, COLOR_GREY, "Nu esti in acea masina.");
    				GetVehiclePos(vehid, PersonalCars[pos][cX], PersonalCars[pos][cY], PersonalCars[pos][cZ]);
    				GetVehicleZAngle(vehid, PersonalCars[pos][cR]);
    				UpdatePersonalCar(playerid);
    				DestroyVehicle(vehid);
    				new query[256];
    				format(query, sizeof(query), "UPDATE `personalcars` SET `X`=%f,`Y`=%f,`Z`=%f,`R`=%f WHERE `ID` =%d", PersonalCars[pos][cX], PersonalCars[pos][cY], PersonalCars[pos][cZ], PersonalCars[pos][cR], PersonalCars[pos][ID]);
    				mysql_query(handle, query);
    				PersonalSCars[vehid] = 0;
    				PersonalCars[pos][CarID] = 0;
    				PersonalCars[pos][Spawned] = 0;
    				SpawnPersonalCar(playerid);
    			}
    			if(listitem == 4)
    			{
    				new pos;
    				pos = MyCarID[playerid];
    				if(PersonalCars[pos][RainBow] == 0)
    				{
    					///aici scad pp
    					PersonalCars[pos][RainBow] = 1;
    					new query[256];
	    				format(query, sizeof(query), "UPDATE `personalcars` SET `RainBow`=1 WHERE `ID` =%d",PersonalCars[pos][ID]);
	    				mysql_query(handle, query);
	    				SCM(playerid, COLOR_GREY, "Ai cumparat rainbow pentru masina ta.");
    				}
    				else if(PersonalCars[pos][Spawned] == 0) return SCM(playerid, COLOR_GREY, "Nu ai masina spawnata.");
    				else if(PersonalCars[pos][RainBowI] == 0) PersonalCars[pos][RainBowI] = 1;
    				else if(PersonalCars[pos][RainBowI] == 1) 
    				{
    					PersonalCars[pos][RainBowI] = 0;
    					ChangeVehicleColor(PersonalCars[pos][CarID], PersonalCars[pos][Color1], PersonalCars[pos][Color2]);
    				}
    			}
    			if(listitem == 5)
    			{
    				new pos;
    				pos = MyCarID[playerid];
    				if(PersonalCars[pos][Spawned] == 0) return SCM(playerid, COLOR_GREY, "Nu ai masina spawnata.");
    				new vehid = PersonalCars[pos][CarID];
    				RemoveVehicleComponent(vehid, PersonalCars[pos][Mode1]);
					RemoveVehicleComponent(vehid, PersonalCars[pos][Mode2]);
					RemoveVehicleComponent(vehid, PersonalCars[pos][Mode3]);
					RemoveVehicleComponent(vehid, PersonalCars[pos][Mode4]);
					RemoveVehicleComponent(vehid, PersonalCars[pos][Mode5]);
					RemoveVehicleComponent(vehid, PersonalCars[pos][Mode6]);
					RemoveVehicleComponent(vehid, PersonalCars[pos][Mode7]);
					RemoveVehicleComponent(vehid, PersonalCars[pos][Mode8]);
					RemoveVehicleComponent(vehid, PersonalCars[pos][Mode9]);
					RemoveVehicleComponent(vehid, PersonalCars[pos][Mode10]);
					RemoveVehicleComponent(vehid, PersonalCars[pos][Mode11]);
					RemoveVehicleComponent(vehid, PersonalCars[pos][Mode12]);
					RemoveVehicleComponent(vehid, PersonalCars[pos][Mode13]);
					RemoveVehicleComponent(vehid, PersonalCars[pos][Mode14]);
    				PersonalCars[pos][PaintJob] = -1;
					ChangeVehiclePaintjob(vehid, 4);
					SCM(playerid, COLOR_GREY, "Tunning removed");
    			}
    			if(listitem == 6)
    			{
    				new pos;
    				pos = MyCarID[playerid];
    				new Float:vx, Float:vy, Float:vz;
    				if(CP[playerid][ID] != 0) return SCM(playerid, COLOR_GREY, "Ai deja un CP activ, foloseste /killcp pentru a anula CP-ul");
    				CP[playerid][ID] = 4;
    				if(PersonalCars[pos][Spawned] == 0) return SCM(playerid, COLOR_GREY, "Masina nu este spawnata");
    				GetVehiclePos(PersonalCars[pos][CarID], vx, vy, vz);
    				SetPlayerCheckpoint(playerid, vx, vy, vz, 5);
    				SCM(playerid, COLOR_GREY, "Ai setat un CP catre locatia masinii.");
    			}
    			if(listitem == 7)
    			{
    				new pos;
    				pos = MyCarID[playerid];
    				new string[256];
    				if(PersonalCars[pos][Spawned] == 0) return SCM(playerid, COLOR_GREY, "Masina nu este spawnata");
    				if(PersonalCars[pos][Vip] == 0)
    				{
    					SCM(playerid, COLOR_GREY, "Tocmai ai cumparat vip pentru masina ta.");
    					PersonalCars[pos][Vip] = 1;
    					///sa add pp
    					format(string, sizeof(string), "UPDATE `personalcars` SET `Vip`=1 WHERE `ID`=%d", PersonalCars[pos][ID]);
    					mysql_query(handle, string);
    				}
    				else 
    				{
    					if(PersonalCars[pos][VStatus] == 0) format(string, sizeof(string), "Stats:\t{FF0000}OFF");
    					else format(string, sizeof(string), "Stats:\t{33AA33}ON");
    					format(string, sizeof(string), "%s\nText Color:\t{%s}%s\nText:\t%s\nText position",string, PersonalCars[pos][VColor], PersonalCars[pos][VColor], PersonalCars[pos][VText]);
    					ShowPlayerDialog(playerid, DIALOG_VIPCARS, DIALOG_STYLE_TABLIST, "VIP vehicle", string , "Select", "Cancel");
    				}
    			}
    			if(listitem == 8)
    			{
    				new pos;
    				pos = MyCarID[playerid];
    				if(PersonalCars[pos][Spawned] == 0) return SCM(playerid, COLOR_GREY, "Masina nu este spawnata");
    				ShowPlayerDialog(playerid, DIALOG_MYCARSPLATE, DIALOG_STYLE_INPUT, "Change Plate", "Please enter your new license plate number:", "Select", "Cancel");
    			}
    			if(listitem == 9)
    			{
    				new pos;
    				pos = MyCarID[playerid];
    				if(PersonalCars[pos][Spawned] == 0) return SCM(playerid, COLOR_GREY, "Masina nu este spawnata");
    				new Float:xxx , Float:yyy, FLoat:zzz;
					GetPlayerPos(playerid, Float:xxx, Float:yyy, Float:zzz);
					SetVehiclePos(PersonalCars[pos][CarID], Float:xxx, Float:yyy, Float:zzz);
					SCM(playerid, COLOR_GREY, "Masina a fost teleportata");
    			}

    		}
    		return 1;
    	}
    	case DIALOG_MYCARS:
    	{
    		if (response)
    		{
    			new pos, var = -1;
    			for(new i = 0; i <= 9 && var != listitem; i++)
					if(PlayerInfo[playerid][pCarPos][i] > 0)
					{
						var++;
						pos = PlayerInfo[playerid][pCarPos][i];
					}
				MyCarID[playerid] = pos;
				new string[512];
				format(string, sizeof(string), "{33AA33}%s options", VehicleNames[PersonalCars[pos][Model]-400]);
				new string1[512];
				if(PersonalCars[pos][RainBow] == 0) format(string1, sizeof(string1), "Tow Vehicle\t {FF0000}500 $\nDespawn Vehicle\t{33AA33}Free\nPark Vehicle\t{33AA33}Free\nRainBow\t{FF0000}100PP" );
				else if(PersonalCars[pos][RainBowI] == 0) format(string1, sizeof(string1), "Tow Vehicle\t {FF0000}500 $\nDespawn Vehicle\t{33AA33}Free\nPark Vehicle\t{33AA33}Free\nRainBow Status\t{FF0000}OFF" );
				else if(PersonalCars[pos][RainBowI] == 1) format(string1, sizeof(string1), "Tow Vehicle\t {FF0000}500 $\nDespawn Vehicle\t{33AA33}Free\nPark Vehicle\t{33AA33}Free\nRainBow Status\t{33AA33}ON" );
				format(string1, sizeof(string1) ,"%s\nRemove Tunning\t{33AA33}Free\nFind Vehicle\t{33AA33}Free\n", string1);
				if(PersonalCars[pos][Vip] == 0) format(string1, sizeof(string1) ,"%s\nVIP Vehicle\t{FF0000}300 PP", string1);
				else format(string1, sizeof(string1) ,"%s\nVIP vehicle settings", string1);
				format(string1, sizeof(string1) ,"%s\nChange License Plate", string1);
				if(PlayerInfo[playerid][pAdmin] > 2)format(string1, sizeof(string1) ,"%s\nTeleport vehicle to me",string1);
				ShowPlayerDialog(playerid, DIALOG_MYCARSACTION, DIALOG_STYLE_TABLIST, string, string1, "Select", "Cancel");
			}
    		return 1;
    	}
    	case DIALOG_SELECTWAR:
    	{
    		if (response)
    		{
    			if(WarStatus == 1)
    			{
    				SendClientMessage(playerid, COLOR_LIGHTRED, "War-ul este deja pornit");
    				return 1;
    			}
    			WarStatus = 1;
    			///datele de la war history
    			new h, mn, s, d, m, y;
    			lWarID++;
    			lWarZID = listitem + 1;
    			getdate(y, m, d);
    			gettime(h, mn, s);
    			format(lWarTime, sizeof(lWarTime), "Ora: %d:%d | Data %d/%d/%d", h, mn, d,m,y);
    			new query[256];
    			SendClientMessage(playerid, COLOR_GREY, lWarTime);
    			format(query, sizeof(query), "INSERT INTO `warhistory`(`ID`, `warid`, `time`) VALUES ('%d', '%d', '%s')", lWarID, lWarZID, lWarTime);
    			mysql_query(handle, query);
    			///
    			lWarBestKills = 0;
    			format(lWarBestKiller, sizeof(lWarBestKiller), "No-One");
    			CreateWarCars(); ///de facut functie
    			listitem++;
    			WarID = listitem;
    			WarZone = GangZoneCreate(WarInfo[listitem][x1], WarInfo[listitem][y1], WarInfo[listitem][x2], WarInfo[listitem][y2]);
    			WarAlianceKills1 = WarAlianceKills2 = 0;
    			for(new i = 0; i <= MAX_PLAYERS; i++)
    				if(IsPlayerConnected(i))
    					if(PlayerInfo[i][pFaction] >= 4 && PlayerInfo[i][pFaction] <= 9)
    					{
    						PlayerInfo[i][pLWarID] = lWarID;
    						if(PlayerInfo[i][pInDM] == 1) 
    						{
	    						dmMaxKills = 0;
								for(new j = 0 ; j < MAX_PLAYERS; j++)
									if(PlayerInfo[j][pDmKills] > dmMaxKills && j != i)
									{
										dmMaxKills = PlayerInfo[j][pDmKills];
										dmMXID = j;
									}
	    						ExitDmEvent(i);
    						}
    						Slap(i);
    						SpawnPlayer(i);
    						GangZoneShowForPlayer(i, WarZone, COLOR_RED);
    						GangZoneFlashForPlayer(i, WarZone, COLOR_LIGHTRED);
    						PlayerInfo[i][pWKills] = 0;
    						PlayerInfo[i][pWDeaths] = 0;
    						PlayerInfo[i][pLWarID] = lWarID;
    						StartWarTXD(i);
    						UpdatePWarTXD(i, i);
    						UpdateAWarTXD();
    						DisablePlayerCheckpoint(i);
							CP[i][ID]=0;
							PlayerInfo[i][pMissionCP] = 0;
							PlayerInfo[i][pMissionid] = 0;
							UpdatePlayerWantedLevel( i, PlayerInfo[i][pWanted], 0);
							PlayerInfo[i][pWanted]=0;
							PlayerInfo[i][pWantedMinute]=0;
							PlayerTextDrawHide(i,  wantedscade[i]);
							SetPlayerWantedLevel(i, 0);
    					}
    			SendClientMessageToAll(COLOR_GREY, "==============================================");
    			SendClientMessageToAll(COLOR_SKYBLUE, "WAR STARTED" );
    			SendClientMessageToAll(COLOR_SKYBLUE, "Membrii Gang-urilor cu wanted au fost ajutati sa evadeze." );
    			SendClientMessageToAll(COLOR_GREY, "==============================================");
    			new Hours, Minutes, Seconds;
    			gettime(Hours, Minutes, Seconds);
    			Minutes += 60;
    			Hours += Minutes / 60;
    			Minutes = Minutes % 60;
    			WarEndH = Hours;
    			WarEndM = Minutes;
    		}
    		return 1;
    	}
    	case DIALOG_WARSTATS:
        {
            return 1;
        }
        case DIALOG_REGISTER:
        {
            if(!response)
                    return Kick(playerid);

            if(response)
            {
              // InitRegister (playerid);
                if(strlen(inputtext) < 8 || strlen(inputtext) > 24)
				{
    				format(gString, sizeof(gString), "Introdu o parola ce contine minim 8 caractere si maxim 24 de caractere.\nScrie o parola in chenarul de mai jos ce sa contina cerintele.", GetName(playerid));
        			ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, " ", gString, "Ok", "");
        			return 1;
                }
                GetPlayerIp(playerid, lString, sizeof(lString));
                mysql_format(handle, gQuery, sizeof(gQuery), "INSERT INTO users (Name, Password, IP) VALUES ('%s', '%e', '%s')", GetName(playerid), inputtext, lString);
                mysql_query(handle, gQuery);
                ShowPlayerDialog(playerid, DIALOG_EMAIL, DIALOG_STYLE_INPUT, "Email:", "Introdu adresa ta de email mai jos.\nAceasta este necesara pentru securitatea contului.\n", "Ok", "");
            }
            return 1;
        }
		case DIALOG_LICSELL:
		{
			if(!response)
			{
				LicenseID[playerid][ID]=0;
				return 1;
			}
			else
			{
			    if(listitem == 0)
			    {
					LicenseID[playerid][LicID] = 0;
                    ShowPlayerDialog(playerid, DIALOG_LICSELLM, DIALOG_STYLE_INPUT, "Price", "Alege pretul licentei acordate:", "Ok", "Cancel");
			    }
			    else if(listitem == 1)
			    {
					LicenseID[playerid][LicID] = 1;
                    ShowPlayerDialog(playerid, DIALOG_LICSELLM, DIALOG_STYLE_INPUT, "Price", "Alege pretul licentei acordate:", "Ok", "Cancel");
			    }
			    else if(listitem == 2)
			    {
					LicenseID[playerid][LicID] = 2;
                    ShowPlayerDialog(playerid, DIALOG_LICSELLM, DIALOG_STYLE_INPUT, "Price", "Alege pretul licentei acordate:", "Ok", "Cancel");
			    }
                else if(listitem == 3)
			    {
					LicenseID[playerid][LicID] = 3;
                    ShowPlayerDialog(playerid, DIALOG_LICSELLM, DIALOG_STYLE_INPUT, "Price", "Alege pretul licentei acordate:", "Ok", "Cancel");
			    }
			}
		}
		case DIALOG_LICSELLM:
		{
		    if(!response)
			{
				LicenseID[playerid][ID]=0;
				LicenseID[playerid][LicID] = 0;
				return 1;
			}
			if(strlen(inputtext) == 0)
			{
				ShowPlayerDialog(playerid, DIALOG_LICSELLM, DIALOG_STYLE_INPUT, "Price", "Pretul licentei acordate trebuie sa fie intre 10.000$ si 100.000$:", "Ok", "Cancel");
				return 1;
			}
			new var=0;
			for(new i = 0 ;inputtext[i] != 0 ; i++)
			{
				if(inputtext[i] > '9' || inputtext[i] < '0')
				{
					ShowPlayerDialog(playerid, DIALOG_LICSELLM, DIALOG_STYLE_INPUT, "Price", "Pretul licentei acordate trebuie sa fie intre 10.000$ si 100.000$:", "Ok", "Cancel");
					return 1;
				}
				var=var*10+inputtext[i]-'0';
			}
			if(var < 10000 || var > 100000 )
			{
				ShowPlayerDialog(playerid, DIALOG_LICSELLM, DIALOG_STYLE_INPUT, "Price", "Pretul licentei acordate trebuie sa fie intre 10.000$ si 100.000$:", "Ok", "Cancel");
				return 1;
			}
			if(IsPlayerConnected(LicenseID[playerid][ID]) )
			{
                new Float:x;
				new Float:y;
				new Float:z;
				new id=LicenseID[playerid][ID];
				GetPlayerPos(playerid,x,y,z);
				if(IsPlayerInRangeOfPoint(id,10,x,y,z) )
				{
				    if(PlayerInfo[id][pMoney] - var < 0)
				    {
				        LicenseID[playerid][ID]=0;
						LicenseID[playerid][LicID] = 0;
						ShowPlayerDialog(playerid, DIALOG_ERROR, DIALOG_STYLE_MSGBOX, "Error", "Jucatorul nu are destui bani.", "Ok", "");
						return 1;
				    }
				    if(LicenseID[playerid][LicID] == 0)
				    {
				        if(PlayerInfo[id][pWeaponLic] > 1200 )  return ShowPlayerDialog(playerid, DIALOG_ERROR, DIALOG_STYLE_MSGBOX, "Error", "Jucatorul are deja licente.", "Ok", "");
						SetTimerEx("ResetLicenseTimer", 60000, false, "u", playerid);
				        PlayerInfo[id][pLicID]=playerid;
				        PlayerInfo[id][pLicNumber]=0;
				        PlayerInfo[id][pLicMoney]=var;
				        new string[256];
				        format(string,sizeof(string),"Instructorul %s iti acorda licenta de arme contra sumei de %d $. /acceptlicenses | /denylicenses",GetName(playerid),var);
				        SCM(id,COLOR_BLUE,string);
				        format(string,sizeof(string),"I-ai acordat jucatorului %s licenta de arme contra sumei de %d $.",GetName(id),var);
						SCM(playerid,COLOR_BLUE,string);
						return 1;
				    }
				    if(LicenseID[playerid][LicID] == 1)
				    {
				        if(PlayerInfo[id][pFlyLic] > 1200 )  return ShowPlayerDialog(playerid, DIALOG_ERROR, DIALOG_STYLE_MSGBOX, "Error", "Jucatorul are deja licente.", "Ok", "");
				    	SetTimerEx("ResetLicenseTimer", 60000, false, "u", playerid);
				        PlayerInfo[id][pLicID]=playerid;
				        PlayerInfo[id][pLicNumber]=1;
				        PlayerInfo[id][pLicMoney]=var;
				        new string[256];
				        format(string,sizeof(string),"Instructorul %s iti acorda licenta de zbor contra sumei de %d $. /acceptlicenses | /denylicenses",GetName(playerid),var);
				        SCM(id,COLOR_BLUE,string);
				        format(string,sizeof(string),"I-ai acordat jucatorului %s licenta de zbor contra sumei de %d $.",GetName(id),var);
						SCM(playerid,COLOR_BLUE,string);
						return 1;
				    }
				    if(LicenseID[playerid][LicID] == 2)
				    {
				        if(PlayerInfo[id][pBoatLic] > 1200 )  return ShowPlayerDialog(playerid, DIALOG_ERROR, DIALOG_STYLE_MSGBOX, "Error", "Jucatorul are deja licente.", "Ok", "");
				        SetTimerEx("ResetLicenseTimer", 60000, false, "u", playerid);				        PlayerInfo[id][pLicID]=playerid;
				        PlayerInfo[id][pLicNumber]=2;
				        PlayerInfo[id][pLicMoney]=var;
				        new string[256];
				        format(string,sizeof(string),"Instructorul %s iti acorda licenta de navigatie contra sumei de %d $. /acceptlicenses | /denylicenses",GetName(playerid),var);
				        SCM(id,COLOR_BLUE,string);
				        format(string,sizeof(string),"I-ai acordat jucatorului %s licenta de navigatie contra sumei de %d $.",GetName(id),var);
						SCM(playerid,COLOR_BLUE,string);
						return 1;
				    }
				    if(LicenseID[playerid][LicID] == 3)
				    {
				        if(PlayerInfo[id][pWeaponLic] > 1200 )  return ShowPlayerDialog(playerid, DIALOG_ERROR, DIALOG_STYLE_MSGBOX, "Error", "Jucatorul are deja licente.", "Ok", "");
				        if(PlayerInfo[id][pFlyLic] > 1200 )  return ShowPlayerDialog(playerid, DIALOG_ERROR, DIALOG_STYLE_MSGBOX, "Error", "Jucatorul are deja licente.", "Ok", "");
				        if(PlayerInfo[id][pBoatLic] > 1200 )  return ShowPlayerDialog(playerid, DIALOG_ERROR, DIALOG_STYLE_MSGBOX, "Error", "Jucatorul are deja licente.", "Ok", "");
				        SetTimerEx("ResetLicenseTimer", 60000, false, "u", playerid);
				        PlayerInfo[id][pLicID]=playerid;
				        PlayerInfo[id][pLicNumber]=3;
				        PlayerInfo[id][pLicMoney]=var;
				        new string[256];
				        format(string,sizeof(string),"Instructorul %s iti acorda toate licentele contra sumei de %d $. /acceptlicenses | /denylicenses",GetName(playerid),var);
				        SCM(id,COLOR_BLUE,string);
				        format(string,sizeof(string),"I-ai acordat jucatorului %s toate licentele contra sumei de %d $.",GetName(id),var);
						SCM(playerid,COLOR_BLUE,string);
						return 1;
				    }
				    
				}
				else
				{
				    LicenseID[playerid][ID]=0;
					LicenseID[playerid][LicID] = 0;
					ShowPlayerDialog(playerid, DIALOG_ERROR, DIALOG_STYLE_MSGBOX, "Error", "Jucatorul a nu mai este langa tine.", "Ok", "");
					return 1;
				}
			}
			else
			{
			    LicenseID[playerid][ID]=0;
				LicenseID[playerid][LicID] = 0;
				ShowPlayerDialog(playerid, DIALOG_ERROR, DIALOG_STYLE_MSGBOX, "Error", "Jucatorul a iesit de pe server.", "Ok", "");
				return 1;
			}
			
			
		}
        case DIALOG_LOGIN:
        {
            if(!response)
					return Kick(playerid);

            if(response)
            {
                if(!strlen(inputtext))
                {
    				format(gString, sizeof(gString), "Parola gresita.\nDaca ti-ai uitat parola, o poti recupera pe panel: www.sa-mp.ro/panel\n\nIncearca din nou. Mai ai doar %d incercari.", 5 - Tentative[playerid]);
    				ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, " ", gString, "Submit", "Leave");

					Tentative[playerid] += 1;
					if(Tentative[playerid] > 5)
					{
					    SendClientMessage(playerid, COLOR_LIGHTRED, "Ai fost deconectat deoarece ai gresit parola de mai multe ori.");
						Kick(playerid);
						return 1;
					}
    	        }

                mysql_format(handle, gQuery, sizeof(gQuery), "SELECT * FROM `users` WHERE BINARY `Name`= BINARY '%e' AND BINARY `Password` = BINARY '%e'", GetName(playerid),inputtext);
				mysql_tquery(handle, gQuery, "WhenPlayerLogin", "i", playerid);

            }
            return 1;
        }
		case DIALOG_UNDERCOVER:
		{
		    if(response)
			{
			    SetPlayerSkin(playerid,UNDERCOVER_MODELS[listitem]);
			    SetPlayerArmour(playerid,0);
			    SetPlayerHealth(playerid,100);
                SetPlayerColor(playerid,0xFFFFFFAA);
			}
		    return 1;
		}
        case DIALOG_EMAIL:
		{
		    if(response)
		    {
		        if(strlen(inputtext) < 10 || strlen(inputtext) > 120)
				{
    				SendClientMessage(playerid, COLOR_SERVER, "SERVER:{FFFFFF} Trebuie sa introduci o adresa de email cuprinsa intre 10 si 120 de caractere.");
                    ShowPlayerDialog(playerid, DIALOG_EMAIL, DIALOG_STYLE_INPUT, "Email:", "Introdu adresa ta de email mai jos.\nAceasta este necesara pentru securitatea contului.\n", "Ok", "");
					return 1;
				}

		        strmid(PlayerInfo[playerid][pEmail],inputtext, 0, strlen(inputtext), 100), Update(playerid, pEmail);

		        PlayerInfo[playerid][pRegisterStep] = 1, Update(playerid, pRegisterStep);

		        format(gString, sizeof(gString), "SERVER:{FFFFFF} Email setat ca %s.", PlayerInfo[playerid][pEmail]);
        		SendClientMessage(playerid, COLOR_SERVER, gString);
				SendClientMessage(playerid, COLOR_SERVER, "SERVER:{FFFFFF} Daca doresti sa schimbi adresa de email, viziteaza: www.sa-mp.ro/panel");

				ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_MSGBOX, "Genul:", "Alege-ti genul mai jos:", "Baiat", "Fata");
		    }
		}

		case DIALOG_GENDER:
		{
		    if(response)
		    {
		        PlayerInfo[playerid][pGender] = 1, Update(playerid, pGender);
				PlayerInfo[playerid][pSkin]=Skins[0][7];

				Update(playerid,pSkin);
		        PlayerInfo[playerid][pRegisterStep] = 2, Update(playerid, pRegisterStep);

		        SendClientMessage(playerid, COLOR_SERVER, "SERVER:{FFFFFF} Gen setat ca baiat.");
		        ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Varsta:", "Indrodu in chenarul de mai jos varsta ta:", "Ok", "");
		    }

		    if(!response)
		    {
		        PlayerInfo[playerid][pGender] = 2, Update(playerid, pGender);

		        PlayerInfo[playerid][pRegisterStep] = 2, Update(playerid, pRegisterStep);
				PlayerInfo[playerid][pSkin]=Skins[0][8];

				Update(playerid,pSkin);
		        SendClientMessage(playerid, COLOR_SERVER, "SERVER:{FFFFFF} Gen setat ca fata.");
		        ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Varsta:", "Indrodu in chenarul de mai jos varsta ta:", "Ok", "");
		    }
		}

		case DIALOG_AGE:
		{
		    if(!response)
		        return Kick(playerid);

		    if(response)
		    {
		        new age = strval(inputtext);

		        if(age < 14 || age > 65)
				{
    				SendClientMessage(playerid, COLOR_SERVER, "SERVER:{FFFFFF} Indrodu o varsta cuprinsa intre 14 si 65 de ani.");
				    ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Varsta:", "Introdu in chenarul de mai jos varsta ta:", "Ok", "");
				    return 1;
				}

		        PlayerInfo[playerid][pAge] = age, Update(playerid, pAge);

		        PlayerInfo[playerid][pRegisterStep] = 3, Update(playerid, pRegisterStep);

          		format(gString, sizeof(gString), "SERVER:{FFFFFF} Varsta setata ca %d.", age);
          		SendClientMessage(playerid, COLOR_SERVER, gString);
		        ShowPlayerDialog(playerid, DIALOG_REFFERAL, DIALOG_STYLE_MSGBOX, "Refferal:", "Ai fost adus de cineva pe serverul nostru?", "Da", "Nu");
		    }
		}

		case DIALOG_REFFERAL:
		{
		    if(response)
				return ShowPlayerDialog(playerid, DIALOG_REFFERAL2, DIALOG_STYLE_INPUT, "Refferal:", "Cine te-a adus pe server?\n\nScrie numele complet in chenarul de mai jos.", "Ok", "Back");

		    if(!response)
		    {
                PlayerInfo[playerid][pRegisterStep] = 4, Update(playerid, pRegisterStep);

                SendClientMessage(playerid, COLOR_SERVER, "SERVER:{FFFFFF} Nu ai fost adus de nimeni pe serverul nostru.");
                PlayerInfo[playerid][pAdmin]=0;
				PlayerInfo[playerid][pHelper]=0;
                SpawnPlayer(playerid);
				return 1;
		    }
		}
        case DIALOG_WANTEDON:
		{
		    if(!response) return 1;
        	new id = SelectedPlayer[playerid][listitem];
			if(PlayerInfo[id][pWanted] == 0) return SCM(playerid, COLOR_LGREEN, "Eroare: Acel player nu mai are wanted!");
			if(!IsPlayerConnected(id)) return SCM(playerid,COLOR_LGREEN,"Eroare: Acel player nu mai este pe server!");
			DisablePlayerCheckpoint(playerid);
			new Float:x;
			new Float:y;
			new Float:z;
			CP[playerid][ID]=1;
			CP[playerid][Player]=id;
			GetPlayerPos(id,x,y,z);
			SetPlayerCheckpoint(playerid,x,y,z,3.0);
			return 1;
		}
		case DIALOG_REFFERAL2:
		{
			if(!response)
			    return ShowPlayerDialog(playerid, DIALOG_REFFERAL, DIALOG_STYLE_MSGBOX, "Refferal:", "Ai fost adus de cineva pe serverul nostru?", "Da", "Nu");

		    if(response)
		    {
		        mysql_format(handle, gQuery, sizeof(gQuery), "SELECT * FROM `users` WHERE BINARY `Name` = BINARY '%e'",inputtext);
		        mysql_query(handle, gQuery);

				new rows;
		        cache_get_row_count(rows);
		        if(rows)
		        {
		            strmid(PlayerInfo[playerid][pRefferal], inputtext, 0, strlen(inputtext), 25), Update(playerid, pRefferal);

		            PlayerInfo[playerid][pRegisterStep] = 4, Update(playerid, pRegisterStep);

		            format(gString, sizeof(gString), "SERVER:{FFFFFF} Ai fost adus de jucatorul %s.", inputtext);
		            SendClientMessage(playerid, COLOR_SERVER, gString);
                    PlayerInfo[playerid][pAdmin]=0;
					PlayerInfo[playerid][pHelper]=0;
		            SpawnPlayer(playerid);
		        }
		        else
		        {
     				format(gString, sizeof(gString), "SERVER:{FFFFFF} Jucatorul %s nu exista, verifica daca ai scris numele corect..", inputtext);
		            ShowPlayerDialog(playerid, DIALOG_REFFERAL2, DIALOG_STYLE_INPUT, "Refferal:", "Cine te-a adus pe server?\n\nScrie numele complet in chenarul de mai jos", "Ok", "Back");
		        }
		    }
		}
	}
	return 1;
}
stock IsABike(carid)
{
	switch(GetVehicleModel(carid))
	{
		case 481,509,510,462: return 1;
	}
	return 0;
}

stock IsABoat(carid)
{
	switch(GetVehicleModel(carid))
	{
		case 430,446,452,453,454,472,473,484,493,595: return 1;
	}
	return 0;
}

stock IsAPlane(carid)
{
	switch(GetVehicleModel(carid))
	{
		case 460,476,511,512,513,519,520,553,577,592,593,487,488,497,548,563,417,425,447,469: return 1;
	}
	return 0;
}
public InitRegister(playerid)
{
    SetPlayerColor(playerid, 0xFFFFFFAA);
	PlayerInfo[playerid][pAdmin] = 0 ;
	PlayerInfo[playerid][pHelper] = 0 ;
	PlayerInfo[playerid][pClub] = 0 ;
	PlayerInfo[playerid][pRClub] = 0 ;
	PlayerInfo[playerid][pFaction] = 0 ;
	PlayerInfo[playerid][pRFaction] = 0 ;
	PlayerInfo[playerid][pXp] = 0 ;
	PlayerInfo[playerid][pLvl] = 1 ;
	PlayerInfo[playerid][pMoney] = 50000 ;
	PlayerInfo[playerid][pSkin] = 0 ;
	PlayerInfo[playerid][pWanted] = 0 ;
	PlayerInfo[playerid][pWantedMinute] = 0 ;
	PlayerInfo[playerid][pInterior] = 0 ;
	PlayerInfo[playerid][pVW] = 0 ;
	PlayerInfo[playerid][pJailTime] = 0 ;
	PlayerInfo[playerid][pDuty] = 0 ;
	PlayerInfo[playerid][pUndercover] = 0 ;
	PlayerInfo[playerid][pCuff] = 0 ;
	PlayerInfo[playerid][pTicketid] = 0 ;
	PlayerInfo[playerid][pTicketMoney] = 0 ;
	PlayerInfo[playerid][Speed] = 0 ;
	PlayerInfo[playerid][pKills] = 0 ;
	PlayerInfo[playerid][pArrests] = 0 ;
	PlayerInfo[playerid][pTickets] = 0 ;
	PlayerInfo[playerid][pAssists] = 0 ;
	PlayerInfo[playerid][pFW] = 0 ;
	PlayerInfo[playerid][pPills] = 0 ;
	PlayerInfo[playerid][pPillsSold] = 0 ;
	PlayerInfo[playerid][pPillsnumber] = 0 ;
	PlayerInfo[playerid][pPillsid] = 0 ;
	PlayerInfo[playerid][pCarLic] = 0 ;
	PlayerInfo[playerid][pWeaponLic] = 0 ;
	PlayerInfo[playerid][pFlyLic] = 0 ;
	PlayerInfo[playerid][pBoatLic] = 0 ;
	PlayerInfo[playerid][pLicID] = 0 ;
	PlayerInfo[playerid][pLicNumber] = 0 ;
	PlayerInfo[playerid][pLicMoney] = 0 ;
	PlayerInfo[playerid][pLicenseSold] = 0 ;
	PlayerInfo[playerid][pMissionid] = 0 ;
	PlayerInfo[playerid][pMissionCP] = 0 ;
	PlayerInfo[playerid][pMissionF] = 0 ;
	PlayerInfo[playerid][pLastMission] = 0;
	PlayerInfo[playerid][pLastOnlineYear] = 0;
    PlayerInfo[playerid][pLastOnlineMonth] = 0;
    PlayerInfo[playerid][pLastOnlineDay] = 0;
    PlayerInfo[playerid][pLastOnlineMinute] = 0;
    PlayerInfo[playerid][pLastOnlineHour] = 0;
    PlayerInfo[playerid][pHouseID] = 0;
    PlayerInfo[playerid][pTypeHome] = 0;
    PlayerInfo[playerid][pSpawnType] = 0;
    PlayerInfo[playerid][pChangeSpawnTimer] = 0;
    PlayerInfo[playerid][pBP] = 0;
    PlayerInfo[playerid][pBounty] = 0;
    PlayerInfo[playerid][pMarkX] = 999999;
	PlayerInfo[playerid][pMarkY] = 999999;
	PlayerInfo[playerid][pMarkZ] = 999999;
	PlayerInfo[playerid][pMarkInterior] = 0;
	PlayerInfo[playerid][pMarkVW] = 0;
    Mute[playerid] = 0;
    CMute[playerid] = 0;
    FMute[playerid] = 0;
    PlayerInfo[playerid][pWKills] = 0;
	PlayerInfo[playerid][pWDeaths] = 0;
	PlayerInfo[playerid][pLWarID] = 0;
	PlayerInfo[playerid][pMaxCars] = 2;
	PlayerInfo[playerid][pCarPos][0] = 0;
	PlayerInfo[playerid][pCarPos][1] = 0;
	PlayerInfo[playerid][pCarPos][2] = 0;
	PlayerInfo[playerid][pCarPos][3] = 0;
	PlayerInfo[playerid][pCarPos][4] = 0;
	PlayerInfo[playerid][pCarPos][5] = 0;
	PlayerInfo[playerid][pCarPos][6] = 0;
	PlayerInfo[playerid][pCarPos][7] = 0;
	PlayerInfo[playerid][pCarPos][8] = 0;
	PlayerInfo[playerid][pCarPos][9] = 0;
	PlayerInfo[playerid][pEditVName] = 0;
	PlayerInfo[playerid][pDrugs] = 0;
	PlayerInfo[playerid][pSeifDrugs] = 0;
	PlayerInfo[playerid][pMats] = 0;
	PlayerInfo[playerid][pSeifMats] = 0;
	PlayerInfo[playerid][pMatsP] = 0;
	PlayerInfo[playerid][pDrugsSkill] = 0;
	PlayerInfo[playerid][pCanQuitJob] = 0;
	PlayerInfo[playerid][pFaina] = 0;
	PlayerInfo[playerid][pBizID] = 0;
	PlayerInfo[playerid][pFishKG] = 0;
	CarRadioID[playerid] = 0;
	PlayerInfo[playerid][pContractMoney] = 0;
	PlayerInfo[playerid][pDoneContracts] = 0;
	PlayerInfo[playerid][pCancelContracts] = 0;
	PlayerInfo[playerid][pFailContracts] = 0;
	PlayerInfo[playerid][pHasContract] = -1;
	DrugsTimer[playerid] = 0;
	PlayerInfo[playerid][pPremiumPoints] = 0;
	PlayerInfo[playerid][pVIP] = 0;
	PlayerInfo[playerid][pOnlineSeconds] = -1;
	PlayerInfo[playerid][pPSeconds] = 0;
	return 1;
}
public ExitDmEvent(playerid)
{
	GangZoneHideForPlayer(playerid, dmEventGangZone);
	PlayerInfo[playerid][pInDM] = 0;
	PlayerInfo[playerid][pDmKills] = 0;
	PlayerTextDrawHide(playerid, dmTxd0[playerid]);
	PlayerTextDrawHide(playerid, dmTxd1[playerid]);
	PlayerTextDrawHide(playerid, dmTxd2[playerid]);
	PlayerTextDrawHide(playerid, dmTxd3[playerid]);
	SpawnPlayer(playerid);
	SetPlayerArmour(playerid, 0);
	return 1;
}
function TDestroyCar(fac1, fac2);
function CheckAFK()
{
	for(new i = 0; i <= 1001; i++)
		if(IsPlayerConnected(i))
		{
			if(IsPlayerInRangeOfPoint(i, 0.5, PlayerPos[i][0], PlayerPos[i][1], PlayerPos[i][2]))
			{
				TimeAFK[i]++;
				if(TimeAFK[i] == 120) SCM(i, -1, "{03ddff}You are now AFK.");
				if(PlayerInfo[i][pWanted] != 0 && TimeAFK[i] == 300) 
				{
					new string[256];
					format(string, sizeof(string), "AdmCmd: %s a primti kick de la AdmBot, motiv: AFK", GetName(i));
					SendClientMessageToAll(COLOR_RED, string);
					KickEx(i);
				}
			}
			else 
			{
				if(TimeAFK[i] >= 120)
				{
					new string[256];
					format(string, sizeof(string), "{03ddff}You were AFK for %d Minutes %d Seconds", TimeAFK[i] / 60, TimeAFK[i] % 60);
					SCM(i, -1, string);
					TimeAFK[i] = 0;
				}
				else TimeAFK[i] = 0;
			}
			new Float:varX, Float:varY, Float:varZ;
			GetPlayerPos(i, varX, varY, varZ);
			PlayerPos[i][0] = varX;
			PlayerPos[i][1] = varY;
			PlayerPos[i][2]	= varZ;
			if(TimeAFK[i] < 120 && PlayerInfo[i][pOnlineSeconds] != -1)
			{
				PlayerInfo[i][pOnlineSeconds]++;
				PlayerInfo[i][pPSeconds]++;
				UpdateOnlineTXD(i);
			}
		}
}
function UpdateOnlineTXD(playerid)
{
	PlayerTextDrawHide(playerid, OnlineTXD[playerid]);
	new minutes, seconds;
	minutes = PlayerInfo[playerid][pOnlineSeconds] / 60;
	seconds = PlayerInfo[playerid][pOnlineSeconds] % 60;
	new string[256];

	if(minutes < 10) 
		format(string, sizeof(string), "Online Time: 0%d", minutes);
	else 
		format(string, sizeof(string), "Online Time: %d", minutes);

	if(seconds < 10) format(string, sizeof(string), "%s:0%d",string, seconds);
	else format(string, sizeof(string), "%s:%d",string, seconds);

	PlayerTextDrawSetString(playerid, OnlineTXD[playerid], string);
	PlayerTextDrawShow(playerid, OnlineTXD[playerid]);
	return 1;
}
public SecondTimer()
{
	CheckCP();
	CheckAFK();
	if(dmTimeLeft > 0)
	{
		dmTimeLeft--;
		if(dmTimeLeft == 0)
		{
			for (new i = 0; i < MAX_PLAYERS; i++)
				if(PlayerInfo[i][pInDM] == 1)
               		 ExitDmEvent(i);
            dmStatus = 0;
            new string[256];
            format(string, sizeof(string), "DM WINNER : %s | Kills %d", GetName(dmMXID), dmMaxKills);
            SendClientMessageToAll(COLOR_DARKGOLDENROD, string);
		}
	}
	for(new i = 0; i <= TurfsNumber; i++)
		if(TurfsInfo[i][tTimer] != 0)
		{
			TurfsInfo[i][tTimer]--;
			if(TurfsInfo[i][tTimer] == 0)
			{
				new fac1, fac2;
				fac1 = fac2 = 0;
				for(new j = 4; j <= 9; j++)
					if(FactionTurf[j] == i)
						if(fac1 == 0)
							fac1 = j;
						else fac2 = j;
				new var;
				if(fac1 <= 9 && fac1 >= 7)
				{
					var = fac1;
					fac1 = fac2;
					fac2 = var;
				}
				CanTurf[fac1] = 0;
				CanTurf[fac2] = 0;
				new ownerid;
				if(TurfsInfo[i][tKills1] > TurfsInfo[i][tKills2])
					ownerid = 1;
				else if(TurfsInfo[i][tKills1] < TurfsInfo[i][tKills2])ownerid = 2;

				if(TurfsInfo[i][tKills1] == TurfsInfo[i][tKills2] && TurfsInfo[i][tOwnerID] == fac1)
					ownerid = 1;
				else if(TurfsInfo[i][tKills1] == TurfsInfo[i][tKills2] && TurfsInfo[i][tOwnerID] == fac2)
					ownerid = 2;
				if(ownerid == 1)
					TurfsInfo[i][tOwnerID] = fac1;
				else TurfsInfo[i][tOwnerID] = fac2;
				new string1[256], string2[256];
				if(fac1 == 4) format(string1, sizeof(string1), "Grove Street");
				else if(fac1 == 5) format(string1, sizeof(string1), "Los Santos Vagos");
				else if(fac1 == 6) format(string1, sizeof(string1), "The Triads");
				else if(fac1 == 7) format(string1, sizeof(string1), "Ballas");
				else if(fac1 == 8) format(string1, sizeof(string1), "Varrios Los Aztecas");
				else if(fac1 == 9) format(string1, sizeof(string1), "The Mafia");

				if(fac2 == 4) format(string2, sizeof(string2), "Grove Street");
				else if(fac2 == 5) format(string2, sizeof(string2), "Los Santos Vagos");
				else if(fac2 == 6) format(string2, sizeof(string2), "The Triads");
				else if(fac2 == 7) format(string2, sizeof(string2), "Ballas");
				else if(fac2 == 8) format(string2, sizeof(string2), "Varrios Los Aztecas");
				else if(fac2 == 9) format(string2, sizeof(string2), "The Mafia");
				new Message[256];
				if(ownerid == 1)
				{
					format(Message, sizeof(Message), "{C44FA9}Winner: {C4C4C4}%s {23C40A}|{C4C4C4} %s {B000C4}Kills: {C4C4C4}%d {23C40A}| {C4C4C4}%s {B000C4}Kills: {C4C4C4}%d", string1, string1, TurfsInfo[i][tKills1], string2, TurfsInfo[i][tKills2]);
					for(new k = 0; k <= MAX_PLAYERS; k++)
					{
						if(IsPlayerConnected(k))
							if(PlayerInfo[k][pFaction] == fac1 || PlayerInfo[k][pFaction] == fac2)
							{
								PlayerTextDrawHide(k, TextTurf0[k]);
								PlayerTextDrawHide(k, TextTurf1[k]);
								SendClientMessage(k, COLOR_GREY, Message);
								Slap(k);
								SpawnPlayer(k);
								//AICI SCOT TXD;
							}
					}
				}
				if(ownerid == 2)
				{
					format(Message, sizeof(Message), "{C44FA9}Winner: {C4C4C4}%s {23C40A}|{C4C4C4} %s {B000C4}Kills: {C4C4C4}%d {23C40A}| {C4C4C4}%s {B000C4}Kills: {C4C4C4}%d", string2, string1, TurfsInfo[i][tKills1], string2, TurfsInfo[i][tKills2]);
					for(new k = 0; k <= MAX_PLAYERS; k++)
					{
						if(IsPlayerConnected(k))
							if(PlayerInfo[k][pFaction] == fac1 || PlayerInfo[k][pFaction] == fac2)
							{
								PlayerTextDrawHide(k, TextTurf0[k]);
								PlayerTextDrawHide(k, TextTurf1[k]);
								SendClientMessage(k, COLOR_GREY, Message);
								Slap(k);
								SpawnPlayer(k);
								//AICI SCOT TXD;
							}
					}
				}
				TDestroyVehicle(fac1, fac2);
				TurfsInfo[i][tStatus] = 0;
				for(new j = 0; j <= MAX_PLAYERS; j++)
				{
					if(TurfsOn[j] == 1)
					{
						GangZoneHideForPlayer(j, TurfsInfo[i][tZoneID]);
						if(TurfsInfo[i][tOwnerID] == 4) GangZoneShowForPlayer(j, TurfsInfo[i][tZoneID], COLOR_GROVE);
						else if(TurfsInfo[i][tOwnerID] == 5) GangZoneShowForPlayer(j, TurfsInfo[i][tZoneID], COLOR_LSV);
						else if(TurfsInfo[i][tOwnerID] == 6) GangZoneShowForPlayer(j, TurfsInfo[i][tZoneID], COLOR_TT);
						else if(TurfsInfo[i][tOwnerID] == 7) GangZoneShowForPlayer(j, TurfsInfo[i][tZoneID], COLOR_BALLAS);
						else if(TurfsInfo[i][tOwnerID] == 8) GangZoneShowForPlayer(j, TurfsInfo[i][tZoneID], COLOR_VLA);
						else if(TurfsInfo[i][tOwnerID] == 9) GangZoneShowForPlayer(j, TurfsInfo[i][tZoneID], COLOR_TM);
					}
				}
				new string[256];
				mysql_format(handle, string, sizeof(string), "UPDATE `turfinfo` SET `OwnerID`='%d' WHERE `ID`='%d'",TurfsInfo[i][tOwnerID], i);
		   		mysql_query(handle,string);	
			}
		}
	for(new j = 0; j <= MAX_PLAYERS; j++)
	{
		if(IsPlayerConnected(j) && IsGang(j) && CanTurf[PlayerInfo[j][pFaction]] == 2)
		{
			PlayerTextDrawHide(j, TextTurf0[j]);
			new string[256];
			format(string, sizeof(string), "Time Left: %d s", TurfsInfo[FactionTurf[PlayerInfo[j][pFaction]]][tTimer]);
			PlayerTextDrawSetString(j, TextTurf0[j], string);
			PlayerTextDrawShow(j, TextTurf0[j]);
		}
	}
	for(new i = 0; i <= MAX_PLAYERS; i++)
	{
		if(DrugsTimer[i] != 0) DrugsTimer[i]--;
		if(IsPlayerConnected(i))
		{

				if(PlayerInfo[i][pAdmin] >= 1338) { 
					new string[128];
					format(string, sizeof(string), "~r~~n~~n~%d~w~~n~TICK~g~~n~~n~%d~w~~n~ANIM~n~~n~~y~%d~w~~n~FPS~n~~n~~b~%d~w~~n~QUERIES", GetServerTickRate(), GetPlayerAnimationIndex(i), GetPlayerFPS(i), mysql_unprocessed_queries());
					PlayerTextDrawSetString(i, InfoTD, string);
					PlayerTextDrawShow(i, InfoTD);
				} 
				else PlayerTextDrawHide(i, InfoTD);
				if(Mute[i] >= 1)
				{
					Mute[i]--;
				}
				if(FMute[i] >= 1)
				{
				    FMute[i]--;
				}
				if(CMute[i] >= 1)
				{
				    CMute[i]--;
				}
				if(PlayerInfo[i][pJailTime]>1)
				{
				    PlayerInfo[i][pJailTime]--;
					new str1[500];
					format(str1, sizeof(str1),"Jail Time: %d", PlayerInfo[i][pJailTime]);
					PlayerTextDrawSetString(i, jailtime[i], str1);
					PlayerTextDrawShow(i, jailtime[i]);
				}
				if(PlayerInfo[i][pJailTime]==1)
				{
				    PlayerTextDrawHide(i,jailtime[i]);
				    PlayerInfo[i][pJailTime]--;
				    PlayerInfo[i][pVW]=0;
				    PlayerInfo[i][pInterior]=0;
				    SetPlayerVirtualWorld(i,0);
				    SetPlayerInterior(i,0);
				    SetPlayerPos(i,1825.3719,-1538.7783,13.5469);
				    PlayerTextDrawHide(i,  jailtime[i]);
				}
				if(PlayerInfo[i][pInDM] == 1)
				{
					PlayerTextDrawHide(i, dmTxd0[i]);
				    PlayerTextDrawHide(i, dmTxd1[i]);
				    PlayerTextDrawHide(i, dmTxd2[i]);
				    PlayerTextDrawHide(i, dmTxd3[i]);
					new second, string[256];
			        second = dmTimeLeft % 60;
			        if(second < 10) format(string, sizeof(string) , "%d:0%d", dmTimeLeft/60, second);
			        else format(string, sizeof(string) , "%d:%d", dmTimeLeft/60, second);
			        PlayerTextDrawSetString(i, dmTxd1[i], string);
			        if(dmMaxKills != 0)
			        {
			            format(string, sizeof(string) , "%s", GetName(dmMXID));
			            PlayerTextDrawSetString(i, dmTxd3[i], string);
			        }
			        else 
			        {
			        	format(string, sizeof(string) , "No-One");
			            PlayerTextDrawSetString(i, dmTxd3[i], string);
			        }
			        PlayerTextDrawShow(i, dmTxd0[i]);
			        PlayerTextDrawShow(i, dmTxd1[i]);
			        PlayerTextDrawShow(i, dmTxd2[i]);
			        PlayerTextDrawShow(i, dmTxd3[i]);
				}
				
		}
		if(IsPlayerConnected(i) && PlayerInfo[i][pCanQuitJob] != 0)
		{
			if(PlayerInfo[i][pJob] == 3 && FarmerTimer[i] != 0)
			{
				new Float:x, Float:y, Float:z;
				GetPlayerPos(i, x, y, z);
				UpdateFarmerTXD(i);
				if(x <= -150 && x >= -598 && y <= -1252 && y >= -1565)
				{
					FarmerComeTimer[i] = 0;
					if(GetVehicleSpeed(FarmerCarID[i]) > 25)
					{
						if(!IsPlayerPaused(i)) FarmerTimer[i]--;
						if(FarmerTimer[i] == 0)
						{
							DestroyVehicle(FarmerCarID[i]);
							FarmerCarID[i] = 0;
							new fainaCastigata;
							fainaCastigata = random(20);
							fainaCastigata += 40;
							new string[256];
							format(string, sizeof(string), "{9843c6}**Fermierul {bcb005}Ion {75bc04}Ceaun {9843c6}ti-a oferit {afafaf}%d kg {9843c6}de faina pentru munca depusa.", fainaCastigata);
							SCM(i, COLOR_GREY, string);
							SCM(i, COLOR_GREY, "Du-te la fabrica de paine pentru a o vinde.");
							PlayerInfo[i][pFaina] = fainaCastigata;
							PlayerInfo[i][pCanQuitJob] = 0;
							StopFarmerTXD(i);
						}
					}
				}
				else
				{
					if(FarmerComeTimer[i] == 0) 
					{
						FarmerComeTimer[i]  = 15;
						UpdateFarmerTXD(i);
					}
					else
					{
						FarmerComeTimer[i]--;
						if(FarmerComeTimer[i] == 0)
						{
							DestroyVehicle(FarmerCarID[i]);
							FarmerTimer[i] = 0;
							PlayerInfo[i][pCanQuitJob] = 0;
							StopFarmerTXD(i);
							SendClientMessage(i, -1, "{9843c6}**Fermierul {bcb005}Ion {75bc04}Ceaun {9843c6}este foarte nemultumit de tine.");
							FarmerCarID[i] = 0;
						}
					}
				}
			}
		}

	}
	CheckSpeed();
	new bool:unwanted[CAR_AMOUNT];
	for(new i = 0; i <= MAX_PLAYERS; i++)
		if(IsPlayerConnected(i))
	    	if(IsPlayerInAnyVehicle(i))
				 unwanted[GetPlayerVehicleID(i)] = true;
	new pos;
	for(new i = 0; i <= 2000; i++)
	{
		if(TruckerCarPlayerID[i] != -1)
		{
			new playerid = TruckerCarPlayerID[i];
			if(PlayerInfo[playerid][pTruckerStatus] == 2)
			{
				if(IsTrailerAttachedToVehicle(i) )
				{
					new trailerid = GetVehicleTrailer(i);
					if(trailerid != PlayerInfo[playerid][pTruckerTrailerID])
						DetachTrailerFromVehicle(i);
					if(trailerid == PlayerInfo[playerid][pTruckerTrailerID] && TruckerTrailerTimer[trailerid] != 0)
					{
						DisablePlayerCheckpoint(playerid);
						TruckerTrailerTimer[trailerid] = 0;
						new ppos = PlayerInfo[playerid][pTruckerPos];
						SetPlayerCheckpoint(playerid, TCargoInfo[ppos][trX], TCargoInfo[ppos][trY], TCargoInfo[ppos][trZ], 5);
						CP[playerid][ID] = 7;
						UpdateTruckerTXD(playerid);
					}
				}
				else
				{
					new trailerid = PlayerInfo[playerid][pTruckerTrailerID];
					if(TruckerTrailerTimer[trailerid] == 0) TruckerTrailerTimer[trailerid] = 61;
					TruckerTrailerTimer[trailerid]--;
					DisablePlayerCheckpoint(playerid);
					if(TruckerTrailerTimer[trailerid] != 0)
					{
						new Float:trailerX, Float:trailerY, Float: trailerZ;
						CP[playerid][ID] = 8;
						GetVehiclePos(trailerid, trailerX, trailerY, trailerZ);
						SetPlayerCheckpoint(playerid, trailerX, trailerY, trailerZ, 5);
						UpdateTruckerTXD(playerid);
					}
					else
					{
						PlayerInfo[playerid][pTruckerTrailerID] = 0;
						PlayerInfo[playerid][pTruckerStatus] = 1;
						TruckerTrailerPlayerID[trailerid] = -1;
						PlayerInfo[playerid][pTruckerPos] = 0;
						PlayerInfo[playerid][pTruckerCMoney] = 0;
						DestroyVehicle(trailerid);
						CP[playerid][ID] = 0;
						SCM(playerid, COLOR_GREY, "Ai pierdut cursa.");
						UpdateTruckerTXD(playerid);
					}
					
				}
			}
		}
		if(PersonalSCars[i] != 0)
		{
			pos = PersonalSCars[i];
			if(PersonalCars[pos][RainBowI] == 1)
			{
				new color;
				color = random(127);
				color += 128;
				ChangeVehicleColor(i, color, color);
			}
			if(unwanted[i] == true) PersonalCars[pos][Timer] = 900;
			else
			{
				PersonalCars[pos][Timer]--;
				if(PersonalCars[pos][Timer] == 0)
				{
					new vehid;
					vehid = i;
					DestroyVehicle(vehid);
					PersonalCars[pos][CarID] = 0;
					PersonalSCars[vehid] = 0;
					PersonalCars[pos][Spawned] = 0;
					PersonalCars[pos][Timer] = 0;
					PersonalCars[pos][RainBowI] = 0;
					if(PersonalCars[pos][VStatus] == 1) DestroyObject(PersonalCars[pos][ObjectID]);
					PersonalCars[pos][VStatus] = 0;

				}
			}
			
		}
		if(RentCarTimer[i] != 0)
		{
			if(unwanted[i] == true && RentCarPID[i] != -1) RentCarTimer[i] = 300;
			else 
			{
				RentCarTimer[i]--;
				if(RentCarTimer[i] == 0)
				{
					DestroyVehicle(i);
					new pid = RentCarPID[i];
					PRentCarID[pid] = 0;
					SCM(RentCarPID[i], COLOR_GREY, "Masina de la rent s-a despawnat.");
					RentCarPID[i] = -1;
				}
			}
		}
		
	}	


	return 1;
}
///------------------------Comenzi-----------------


public pdgate1()
{
    DestroyObject(pdup);
    pddown=CreateObject(968, 1544.70850, -1630.77942, 13.26140,   0.00000, 91.00000, 91.00000);
    pdgatecheck1=0;
    return 1;
}
public sfgate1()
{
    DestroyObject(sfgate1o);
    sfgate1c=CreateObject(968, -1572.18433, 658.69690, 6.90130,   0.00000, 90.00000, 90.00000);
    sfgate1status=0;
    return 1;
}
public sfgate2()
{
    DestroyObject(sfgate2o);
    sfgate2c=CreateObject(968, -1701.44397, 687.70813, 24.73360,   0.00000, -90.00000, 90.00000);
    sfgate2status=0;
    return 1;
}
public pdgate2()
{
    pdgarage=CreateObject(971, 1588.76697, -1638.40149, 15.07090,   0.00000, 0.00000, 180.00000);
    pdgatecheck2=0;
	return 1;
}
public fbi1gate()
{
	fbigate1=0;
	fbi1=CreateObject(971, 321.44199, -1488.15222, 26.58430,   0.00000, 0.00000, 142.00000);
	return 1;
}
public fbi2gate()
{
	fbigate2=0;
	fbi2=CreateObject(971, 283.22751, -1542.60132, 27.09560,   0.00000, 0.00000, -35.00000);
	return 1;
}
public nggateopen()
{
	nggateo=0;
    nggate=CreateObject(971, -1530.22327, 482.41272, 6.21660,   0.00000, 0.00000, 0.00000);
	return 1;
}
public nggateopen2()
{
	nggateo2=0;
	nggate2=CreateObject(10841, -1466.54443, 500.94949, 5.89130,   -15.00000, 0.00000, 89.00000);
	return 1;
}
public sfpdpoartaopen()
{
	sfpdpoartao=0;
    sfpdpoarta1=CreateObject(971, -1635.62866, 688.16260, 9.17640,   0.00000, 0.00000, 0.00000);
	sfpdpoarta2=CreateObject(971, -1626.81104, 688.13092, 9.18100,   0.00000, 0.00000, 180.00000);
	return 1;
}

public IsPlayerAtFuelStation(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid,20,1004.2475,-937.9796,42.1797)) return 1;
 	if(IsPlayerInRangeOfPoint(playerid,20,1943.6311,-1772.9531,13.3906)) return 1;
  	if(IsPlayerInRangeOfPoint(playerid,20,-1606.3761,-2713.7097,48.5335)) return 1;
   	if(IsPlayerInRangeOfPoint(playerid,20,-2026.5939,156.7059,29.0391)) return 1;
   	if(IsPlayerInRangeOfPoint(playerid,20,-1328.9844,2677.9714,50.0625)) return 1;
    if(IsPlayerInRangeOfPoint(playerid,20,608.8265,1699.7535,6.9922)) return 1;
    if(IsPlayerInRangeOfPoint(playerid,20,655.5261,-564.8308,16.3359)) return 1;
    if(IsPlayerInRangeOfPoint(playerid,20,608.8265,1699.7535,6.9922)) return 1;
    if(IsPlayerInRangeOfPoint(playerid,20,-1675.6821,412.9916,7.1797)) return 1;
    if(IsPlayerInRangeOfPoint(playerid,20,-2409.4727,975.9866,45.2969)) return 1;
    if(IsPlayerInRangeOfPoint(playerid,20,2114.4636,920.2435,10.8203)) return 1;
    return 0;
    
}

function CheckPlayerTurfZone(playerid)
{
	new Float: pX, Float:pY, Float:pZ;
	GetPlayerPos(playerid, pX, pY, pZ);
	for(new i = 1; i <= TurfsNumber; i++)
		if(TurfsInfo[i][tMaxX] >= pX && TurfsInfo[i][tMaxY] >= pY && TurfsInfo[i][tMinX] <= pX && TurfsInfo[i][tMinY] <= pY)
			return i;
	return 0;
}
function DefeadTurf(AttackerID, DefeadID)
{
	if(CanTurf[AttackerID] == 1 && CanTurf[DefeadID] == 1 && FactionTurf[AttackerID] == FactionTurf[DefeadID])
	{
		CanTurf[AttackerID] = 0;
		CanTurf[DefeadID] = 0;
		new string1[256];
		if(AttackerID == 4) format(string1, sizeof(string1), "Grove Street");
		else if(AttackerID == 5) format(string1, sizeof(string1), "Los Santos Vagos");
		else if(AttackerID == 6) format(string1, sizeof(string1), "The Triads");
		else if(AttackerID == 7) format(string1, sizeof(string1), "Ballas");
		else if(AttackerID == 8) format(string1, sizeof(string1), "Varrios Los Aztecas");
		else if(AttackerID == 9) format(string1, sizeof(string1), "The Mafia");
		new Message[256];
		format(Message, sizeof(Message), "{C44FA9}Winner: {C4C4C4}%s {C44FA9}for forfeit", string1);
		for(new k = 0; k <= MAX_PLAYERS; k++)
		{
			if(IsPlayerConnected(k))
				if(PlayerInfo[k][pFaction] == AttackerID || PlayerInfo[k][pFaction] == DefeadID)
					SendClientMessage(k, COLOR_GREY, Message);
			
		}
		new turfid = FactionTurf[AttackerID];
		TurfsInfo[turfid][tStatus] = 0;
		TurfsInfo[turfid][tOwnerID] = AttackerID;
		for(new i = 0; i <= MAX_PLAYERS; i++)
		{
			if(TurfsOn[i] == 1)
			{
				GangZoneHideForPlayer(i, TurfsInfo[i][tZoneID]);
				if(TurfsInfo[turfid][tOwnerID] == 4) GangZoneShowForPlayer(i, TurfsInfo[turfid][tZoneID], COLOR_GROVE);
				else if(TurfsInfo[turfid][tOwnerID] == 5) GangZoneShowForPlayer(i, TurfsInfo[turfid][tZoneID], COLOR_LSV);
				else if(TurfsInfo[turfid][tOwnerID] == 6) GangZoneShowForPlayer(i, TurfsInfo[turfid][tZoneID], COLOR_TT);
				else if(TurfsInfo[turfid][tOwnerID] == 7) GangZoneShowForPlayer(i, TurfsInfo[turfid][tZoneID], COLOR_BALLAS);
				else if(TurfsInfo[turfid][tOwnerID] == 8) GangZoneShowForPlayer(i, TurfsInfo[turfid][tZoneID], COLOR_VLA);
				else if(TurfsInfo[turfid][tOwnerID] == 9) GangZoneShowForPlayer(i, TurfsInfo[turfid][tZoneID], COLOR_TM);
			}
		}
		new string[256];
		mysql_format(handle, string, sizeof(string), "UPDATE `turfinfo` SET `OwnerID`='%d' WHERE `ID`='%d'",AttackerID, turfid);
   		mysql_query(handle,string);		
	}
	
	return 0;
}
//-------------------[BAN SISTEM]----------------
CMD:banip(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pAdmin] == 0) return SCM(playerid, COLOR_GREY, "Nu ai acces la aceasta comanda.");
	    new type[128], string[128], reason[256];
	    if(sscanf(params, "s[128]s[256]", type)) SendClientMessage(playerid, -1, "Usage: /banip <ip> <reason>");
	    else
	    {	
	        format(string, sizeof(string),"banip %s", type);
	        SendRconCommand(string);
	        SendRconCommand("reloadbans");
	        format(string, sizeof(string), "AdmCmd: %s a banat ip-ul %s. Reason: %s", GetName(playerid), type, reason);
	        for(new i = 0; i <= 1000; i++)
				if(IsPlayerConnected(i) && PlayerInfo[i][pAdmin] != 0)
					SCM(i, COLOR_RED, string);

	    }
	}
    return 1;
}
CMD:unbanip(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    new type[128],string[128], reason[256];
	    if(sscanf(params, "s[128]s[256]", type)) SendClientMessage(playerid, -1, "USAGE: /unbanip <ip> <reason>");
	    else
	    { 
	        if(PlayerInfo[playerid][pAdmin] >= 1)
	        {
	            format(string, sizeof(string),"unbanip %s", type);
	            SendRconCommand(string);
	            SendRconCommand("reloadbans");
	            format(string, sizeof(string), "AdmCmd: %s a banat ip-ul %s. Reason: %s", GetName(playerid), type, reason);
	            for(new i = 0; i <= 1000; i++)
					if(IsPlayerConnected(i) && PlayerInfo[i][pAdmin] != 0)
						SCM(i, COLOR_RED, string);
	        }
	        else
	        {
	            return SendClientMessage(playerid, -1 ,"You dont have access!");
	        }
	    }
	}
    return 1;
}
CMD:checkban(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pAdmin] == 0) return SCM(playerid, COLOR_GREY, "Nu ai acces la aceasta comanda.");
		new playername[256];
		if(sscanf(params, "s[256]", playername)) return SendClientMessage(playerid, COLOR_GREY,"Sintaxa: {FFFFFF}/checkban <playername>");

		new string[256];

		format(string, sizeof(string), "SELECT * FROM `users` WHERE BINARY `Name` = BINARY '%s'", playername);
		new Cache: db = mysql_query(handle, string);
	    new AccountRegistered;
		cache_get_row_count(AccountRegistered);
		if(AccountRegistered == 0)
		{
			SCM(playerid, COLOR_GREY, "Nume incorect sau incomplet.");
			cache_delete(db);
			return 1;
		}
		cache_delete(db);

		format(string, sizeof(string), "SELECT * FROM `bans` WHERE BINARY `PlayerName` = BINARY '%s'", playername);
		db = mysql_query(handle, string);
	    new result[256], AdminName[256], Reason[256], BanDate[256], ExpireBan, nrBans;
		cache_get_row_count(nrBans);
		for(new i = 0; i < nrBans ; i++)
		{
			cache_get_value_name(i, "AdminName", result);				format(AdminName, 256, result);
			cache_get_value_name(i, "Reason", result);				    format(Reason, 256, result);
			cache_get_value_name(i, "BanDate", result);					format(BanDate, 256, result);
			cache_get_value_name(i, "ExpireDate", result);				ExpireBan = strval(result);
			if(ExpireBan == 0 || ExpireBan > gettime())
			{
				if(ExpireBan != 0) format(string, sizeof(string), "Jucatorul %s is banned by %s | Ban Date: %s | Expire Date: %s | Reason: %s", playername, AdminName, BanDate, ConvertTime(ExpireBan), Reason);
				else format(string, sizeof(string), "Jucatorul %s is banned by %s Ban Date: %s | Expire Date: PERMANENT | Reason: %s", playername, AdminName, BanDate, Reason);
				SCM(playerid, COLOR_RED, string);
				cache_delete(db);
				return 1;
			}
		}
		if(nrBans == 0) SCM(playerid, COLOR_GREY, "Jucatorul nu este banat.");
	}
	return 1;
}

CMD:oban(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pAdmin] == 0) return SCM(playerid, COLOR_GREY, "Nu ai acces la aceasta comanda.");
		new nameban[256], days, reason[65], string[256], BPAdmin;
		if(sscanf(params, "s[256]is[64]", nameban, days, reason)) return SendClientMessage(playerid, COLOR_GREY,"Sintaxa: {FFFFFF}/oban <playername> <days(0 for permanent)> <reason>");
		if(days < 0) return SendClientMessage(playerid, COLOR_GREY,"Sintaxa: {FFFFFF}/oban <playerid/name> <days(0 for permanent)> <reason>");
		if(!strcmp("Fashion", nameban , false)) return SCM(playerid, COLOR_GREY, "Nu poti bana acest jucator.");
		for(new i = 0; i <= 1000; i++)
			if(IsPlayerConnected(i) && !strcmp(GetName(i), nameban , false)) 
				return SCM(playerid, COLOR_GREY, "Acel jucator este online, foloseste comanda /ban.");

		format(string, sizeof(string), "SELECT * FROM `users` WHERE BINARY `Name` = BINARY '%s'", nameban);
		new Cache: db = mysql_query(handle, string);
	    new AccountRegistered, SqlId;
		cache_get_row_count(AccountRegistered);
		if(AccountRegistered == 0)
		{
			SCM(playerid, COLOR_GREY, "Nume incorect sau incomplet.");
			cache_delete(db);
			return 1;
		}
		cache_get_value_name(0, "Admin", string); 					BPAdmin = strval(string);
		cache_get_value_name(0, "ID", string); 						SqlId = strval(string);
		cache_delete(db);
		if(BPAdmin >= PlayerInfo[playerid][pAdmin] && strcmp(GetName(playerid), "Fashion" , true)) return SCM(playerid, COLOR_GREY, "Nu poti bana acest jucator.");

		format(string, sizeof(string), "SELECT * FROM `bans` WHERE BINARY `PlayerName` = BINARY '%s'", nameban);
		db = mysql_query(handle, string);
	    new nrBans;
		cache_get_row_count(nrBans);
		if(nrBans != 0)
		{
			cache_delete(db);
			return SCM(playerid, COLOR_GREY, "Acel jucator este deja banat.");
		}
		cache_delete(db);

		new BanType, BanDate[18], ExpireDate, Query[256];
		if(days == 0) BanType = 0; ///permanent
		else BanType = 1;  ///temporar

		new date[3];
		getdate(date[0], date[1], date[2]);
		format(BanDate, sizeof(BanDate), "%02i/%02i/%i", date[2], date[1], date[0]);

		if(days == 0) ExpireDate = 0;
		else ExpireDate = ((days * 24 * 60 * 60) + gettime());

		format(Query, sizeof(Query), "INSERT INTO `bans`(`PlayerSQLiD`, `PlayerName`, `BanType`, `AdminName`, `Reason`, `BanDate`, `ExpireDate`) VALUES (%d,'%s',%d,'%s','%s','%s',%d)", SqlId, nameban, BanType, GetName(playerid), reason, BanDate, ExpireDate);
		mysql_query(handle, Query);	

		if(days == 0) format(string, sizeof(string), "AdmCmd: %s has been offline banned by admin %s[%d], reason: %s", nameban, GetName(playerid), playerid, reason);
		else format(string, sizeof(string), "AdmCmd: %s has been offline banned by admin %s[%d] for %i days, reason: %s", nameban, GetName(playerid), playerid, days, reason);
		SendClientMessageToAll(COLOR_RED, string);

	}
	return 1;
}
CMD:ban(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pAdmin] == 0) return SCM(playerid, COLOR_GREY, "Nu ai acces la aceasta comanda.");
		new banid, days, reason[65], string[256];
		if(sscanf(params, "uis[64]", banid, days, reason)) return SendClientMessage(playerid, COLOR_GREY,"Sintaxa: {FFFFFF}/ban <playerid/name> <days(0 for permanent)> <reason>");
		if(!IsPlayerConnected(banid)) return SCM(playerid, COLOR_GREY, "Jucatorul este offline, foloseste comanda /banoffline");
		if(days < 0) return SendClientMessage(playerid, COLOR_GREY,"Sintaxa: {FFFFFF}/ban <playerid/name> <days(0 for permanent)> <reason>");
		if(!strcmp(GetName(banid), "Fashion" , false)) 
		{
			SCM(playerid, COLOR_GREY, "Nu poti bana un owner.");
			format(string, sizeof(string), "AdmCmd: %s a incercat sa il baneze pe Fashion.", GetName(playerid));
			for(new i = 0; i <= 1000; i++)
				if(IsPlayerConnected(i) && PlayerInfo[i][pAdmin] != 0)
					SCM(i, COLOR_RED, string);
			return 1;
		}
		if(strcmp(GetName(playerid), "Fashion" , false) && PlayerInfo[banid][pAdmin] >= PlayerInfo[playerid][pAdmin])
		{
			format(string, sizeof(string), "AdmCmd: %s a incercat sa il baneze pe %s.", GetName(playerid), GetName(banid));
			for(new i = 0; i <= 1000; i++)
				if(IsPlayerConnected(i) && PlayerInfo[i][pAdmin] != 0)
					SCM(i, COLOR_RED, string);
			return 1;
		}
		BanPlayer(playerid, banid, days, reason);
	}
	return 1;
}
CMD:unban(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pAdmin] == 0) return SCM(playerid, COLOR_GREY, "Nu ai acces la aceasta comanda.");
		new playername[64], reason[65];
		if(sscanf(params, "s[64]s[64]", playername, reason)) return SendClientMessage(playerid, COLOR_GREY,"Sintaxa: {FFFFFF}/unban <playerid/name> <reason>");
		UnBanPlayer(playerid, playername, reason);
	}
	return 1;
	
}
function UnBanPlayer(playerid, playername[], reason[])
{
	for(new i = 0; i <= 1000; i++)
		if(IsPlayerConnected(i) && !strcmp(GetName(i), playername , false)) return SCM(playerid, COLOR_GREY, "Acel jucator nu este banat.");
	new string[256];
	format(string, sizeof(string), "SELECT * FROM `bans` WHERE BINARY `PlayerName` = BINARY'%s'",playername);
	new Cache: db = mysql_query(handle, string);
    new nrBans;
	cache_get_row_count(nrBans);
	if(nrBans == 0) 
	{
		cache_delete(db);
		return SCM(playerid, COLOR_GREY, "Acel jucator nu este banat.");
	}
	mysql_format(handle, string, sizeof(string), "DELETE FROM `bans` WHERE BINARY `PlayerName` = BINARY '%s'", playername);
	mysql_query(handle, string);
	format(string, sizeof(string), "AdmCmd: %s a primit unban de la %s. Reason: %s", playername, GetName(playerid), reason);
	for(new i = 0; i <= 1000; i++)
		if(IsPlayerConnected(i) && PlayerInfo[i][pAdmin] != 0)
			SCM(i, COLOR_RED, string);
	cache_delete(db);
	return 1;
}
function BanPlayer(playerid, banid, days, reason[])
{
	new BanType, BanDate[18], ExpireDate, Query[256];
	if(days == 0) BanType = 0; ///permanent
	else BanType = 1;  ///temporar

	new date[3];
	getdate(date[0], date[1], date[2]);
	format(BanDate, sizeof(BanDate), "%02i/%02i/%i", date[2], date[1], date[0]);

	if(days == 0) ExpireDate = 0;
	else ExpireDate = ((days * 24 * 60 * 60) + gettime());

	format(Query, sizeof(Query), "INSERT INTO `bans`(`PlayerSQLiD`, `PlayerName`, `BanType`, `AdminName`, `Reason`, `BanDate`, `ExpireDate`) VALUES (%d,'%s',%d,'%s','%s','%s',%d)",PlayerInfo[banid][pID], GetName(banid), BanType, GetName(playerid), reason, BanDate, ExpireDate);
	mysql_query(handle, Query);	

	new string[256];
	if(days == 0) format(string, sizeof(string), "AdmCmd: %s[%i] has been banned by admin %s[%d], reason: %s", GetName(banid), banid, GetName(playerid), playerid, reason);
	else format(string, sizeof(string), "AdmCmd: %s[%i] has been banned by admin %s[%d] for %i days, reason: %s", GetName(banid), banid, GetName(playerid), playerid, days, reason);
	SendClientMessageToAll(COLOR_RED, string);
	KickEx(banid);
	return 1;
}
//-----------------------------------------------
CMD:carradio(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_GREY, "Nu esti in masina.");
		if(GetPlayerVehicleSeat(playerid) != 0) return SCM(playerid, COLOR_GREY, "Nu esti soferul.");
		ShowPlayerDialog(playerid, DIALOG_CHOSERADIO, DIALOG_STYLE_LIST , "Change Radio", "Pro FM\nRadio Taraf\nRadio Manele Gangsta\nRadio HIT", "Select", "");
	}
	return 1;
}
CMD:stopradio(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_GREY, "Nu esti in masina.");
		if(GetPlayerVehicleSeat(playerid) != 0) return SCM(playerid, COLOR_GREY, "Nu esti soferul.");
		if(CarRadioID[playerid] == 0) return SCM(playerid, COLOR_GREY, "Nu asculti radio.");
		new vehicleid = GetPlayerVehicleID(playerid);
		CarRadioID[playerid] = 0;
		for(new i = 0; i <= MAX_PLAYERS; i++)
			if(IsPlayerConnected(i) && GetPlayerVehicleID(i) == vehicleid)
				StopAudioStreamForPlayer(i);

	}
	return 1;
}
CMD:sellbiz(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pBizID] == 0) return SCM(playerid, COLOR_GREY, "Nu ai un biz.");
		new bizid = PlayerInfo[playerid][pBizID];
		if(!IsPlayerInRangeOfPoint(playerid, 3, BizInfo[bizid][bX], BizInfo[bizid][bY], BizInfo[bizid][bZ]) || GetPlayerVirtualWorld(playerid != 0) || GetPlayerInterior(playerid) != 0) return SCM(playerid, COLOR_GREY, "Nu esti la biz.");
		GivePlayerMoney(playerid, 20000000);
		PlayerInfo[playerid][pMoney] += 20000000;
		PlayerInfo[playerid][pBizID] = 0;
		Update(playerid, pBizID);

		BizInfo[bizid][OwnerID] = -1;
		format(BizInfo[bizid][OwnerName], 256, "The State");
		new string[256];
		format(string, sizeof(string), "UPDATE `bizinfo` SET `OwnerID`=-1,`OwnerName`='%s' WHERE BINARY `ID`= BINARY %d", BizInfo[bizid][OwnerName], bizid);
		mysql_query(handle,string);	

		Delete3DTextLabel(BizInfo[bizid][TextID]);
		format(string, sizeof(string), "{09960d}%s\n{c1b02e}ID: {969694} %d\n{c1b02e}Owner: {969694}%s\n{c1b02e}Fee: {969694}%d $\n{c1b02e}Price: {969694}20.000.000 $\n{c1b02e}/buybiz", BizInfo[bizid][Name], bizid ,BizInfo[bizid][OwnerName], BizInfo[bizid][Fee]);
        BizInfo[bizid][TextID] = Create3DTextLabel(string, COLOR_WHITE,BizInfo[bizid][bX], BizInfo[bizid][bY], BizInfo[bizid][bZ],20,0,1);
	}
	return 1;
}
CMD:buygun(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(GetPlayerInterior(playerid) != 1) return SCM(playerid, COLOR_GREY, "Nu esti in GunShop.");
		if(GetPlayerVirtualWorld(playerid) < 715 ||  GetPlayerVirtualWorld(playerid) > 717) return SCM(playerid, COLOR_GREY, "Nu esti in GunShop.");
		if(!IsPlayerInRangeOfPoint(playerid, 10, 2169.46, 1618.8, 999.997)) return SCM(playerid, COLOR_GREY, "Nu esti in GunShop.");
		new weapon[256], ammo;
		if(sscanf(params, "s[256]i", weapon, ammo)) 
		{
			SendClientMessage(playerid, COLOR_GREY,"Sintaxa: {FFFFFF}/buygun <weapon> <ammo>");
			SendClientMessage(playerid, COLOR_GREY,"Deagle M4 MP5 ShotGun Rifle");
			return 1;
		}
		if(ammo < 1 || ammo > 999) return SCM(playerid, COLOR_GREY, "Ammo 0-999.");
		new id = 0;
		new coeficient, money;
		if(!strcmp(weapon, "deagle" , true)) 
		{ 
			id = 1; 
			coeficient = 100;
		}
		if(!strcmp(weapon, "m4" , true)) 
		{ 
			id = 2; 
			coeficient = 100;
		}
		if(!strcmp(weapon, "mp5" , true))
		{ 
			id = 3; 
			coeficient = 75;
		}
		if(!strcmp(weapon, "shotgun" , true))
		{ 
			id = 4; 
			coeficient = 200;
		}
		if(!strcmp(weapon, "rifle" , true))
		{ 
			id = 5; 
			coeficient = 200;
		}
		money = ammo * coeficient;
		if(PlayerInfo[playerid][pMoney] < money) return SCM(playerid, COLOR_GREY, "Nu ai destui bani");
		if(GetPlayerVirtualWorld(playerid) == 715) BizInfo[18][Money] += money;
		if(GetPlayerVirtualWorld(playerid) == 716) BizInfo[19][Money] += money;
		if(GetPlayerVirtualWorld(playerid) == 717) BizInfo[20][Money] += money;
		if(id == 1)
		{
			PlayerInfo[playerid][pMoney] -= money;
			GivePlayerMoney(playerid,-money);
			GivePlayerWeapon(playerid, 24, ammo);
			format(weapon, sizeof(weapon), "{541559}** Ai cumparat un Deagle cu %d gloante pentru %d $.", ammo, money);
			SCM(playerid, -1, weapon);
		}
		if(id == 2)
		{
			PlayerInfo[playerid][pMoney] -= money;
			GivePlayerMoney(playerid,-money);
			GivePlayerWeapon(playerid, 31, ammo);
			format(weapon, sizeof(weapon), "{541559}** Ai cumparat un M4 cu %d gloante pentru %d $.", ammo, money);
			SCM(playerid, -1, weapon);
		}
		if(id == 3)
		{
			PlayerInfo[playerid][pMoney] -= money;
			GivePlayerMoney(playerid,-money);
			GivePlayerWeapon(playerid, 29, ammo);
			format(weapon, sizeof(weapon), "{541559}** Ai cumparat un MP5 cu %d gloante pentru %d $.", ammo, money);
			SCM(playerid, -1, weapon);
		}
		if(id == 4)
		{
			PlayerInfo[playerid][pMoney] -= money;
			GivePlayerMoney(playerid,-money);
			GivePlayerWeapon(playerid, 25, ammo);
			format(weapon, sizeof(weapon), "{541559}** Ai cumparat un ShotGun cu %d gloante pentru %d $.", ammo, money);
			SCM(playerid, -1, weapon);
		}
		if(id == 5)
		{
			PlayerInfo[playerid][pMoney] -= money;
			GivePlayerMoney(playerid,-money);
			GivePlayerWeapon(playerid, 33, ammo);
			format(weapon, sizeof(weapon), "{541559}** Ai cumparat un Rifle cu %d gloante pentru %d $.", ammo, money);
			SCM(playerid, -1, weapon);
		}


	}
	return 1;
}
CMD:buybiz(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(GetPlayerVirtualWorld(playerid) != 0 || GetPlayerInterior(playerid) != 0) return SCM(playerid, COLOR_GREY, "Esti in VirtualWorld.");
		if(PlayerInfo[playerid][pBizID] != 0) return SCM(playerid, COLOR_GREY, "Ai deja un biz.");
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		new bizid = 0;
		for(new i = 1; i <= nrBiz; i++)
		{
			if(IsPlayerInRangeOfPoint(playerid, 3, BizInfo[i][bX], BizInfo[i][bY], BizInfo[i][bZ]))
			{
				bizid = i;
				break;
			}
		}
		if(bizid == 0) return SCM(playerid, COLOR_GREY, "Nu esti la un biz.");
		if(BizInfo[bizid][OwnerID] != -1) return SCM(playerid, COLOR_GREY, "Acest biz nu este la vanzare.");
		if(PlayerInfo[playerid][pMoney] < 20000000) return SCM(playerid, COLOR_GREY, "Nu ai destui bani.");
		GivePlayerMoney(playerid, -20000000);
		PlayerInfo[playerid][pMoney] -= 20000000;
		PlayerInfo[playerid][pBizID] = bizid;
		Update(playerid, pBizID);

		BizInfo[bizid][OwnerID] = PlayerInfo[playerid][pID];
		format(BizInfo[bizid][OwnerName], 256, GetName(playerid));
		new string[256];
		format(string, sizeof(string), "UPDATE `bizinfo` SET `OwnerID`=%d,`OwnerName`='%s' WHERE BINARY `ID`= BINARY %d", PlayerInfo[playerid][pID], BizInfo[bizid][OwnerName], bizid);
		mysql_query(handle,string);	

		Delete3DTextLabel(BizInfo[bizid][TextID]);
		format(string, sizeof(string), "{09960d}%s\n{c1b02e}ID: {969694} %d\n{c1b02e}Owner: {969694}%s\n{c1b02e}Fee: {969694}%d $", BizInfo[bizid][Name], bizid ,BizInfo[bizid][OwnerName], BizInfo[bizid][Fee]);
        BizInfo[bizid][TextID] = Create3DTextLabel(string, COLOR_WHITE,BizInfo[bizid][bX], BizInfo[bizid][bY], BizInfo[bizid][bZ],20,0,1);

	}
	return 1;
}
CMD:createbiz(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pAdmin] < 1339) return SCM(playerid, COLOR_GREY, "Nu ai acces la aceasta comanda.");
		new type;
		if(sscanf(params, "i", type )) return SCM(playerid, COLOR_GREY,"Sintaxa: {FFFFFF}/createbiz <type>");
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		new string[256];
		nrBiz++;
		if(type == 1)
			format(string, sizeof(string), "INSERT INTO `bizinfo`(`ID`, `Type`, `X`, `Y`, `Z`, `Interior`, `iX`, `iY`, `iZ`, `CanEnter`) VALUES (%d, %d, %f, %f, %f,17,-25.8845,-185.869,-1003.55, 1)", nrBiz, type, x, y, z);
		if(type == 2)
			format(string, sizeof(string), "INSERT INTO `bizinfo`(`ID`, `Type`, `X`, `Y`, `Z`, `CanEnter`, `Name`) VALUES (%d, %d, %f, %f, %f,0,'Rent Car')", nrBiz, type, x, y, z);
		if(type == 3)
			format(string, sizeof(string), "INSERT INTO `bizinfo`(`ID`, `Type`, `X`, `Y`, `Z`, `Interior`, `iX`, `iY`, `iZ`, `CanEnter`, `Name`) VALUES (%d, %d, %f, %f, %f,10,375.962463,-65.816848,1001.507812, 1, 'BurgerShot')", nrBiz, type, x, y, z);
		if(type == 4)
			format(string, sizeof(string), "INSERT INTO `bizinfo`(`ID`, `Type`, `X`, `Y`, `Z`, `Interior`, `iX`, `iY`, `iZ`, `CanEnter`, `Name`) VALUES (%d, %d, %f, %f, %f,0,2315.952880,-1.618174,26.742187, 1, 'Bank Comerciala PlayNioN')", nrBiz, type, x, y, z);
		if(type == 5)
			format(string, sizeof(string), "INSERT INTO `bizinfo`(`ID`, `Type`, `X`, `Y`, `Z`, `Interior`, `iX`, `iY`, `iZ`, `CanEnter`, `Name`) VALUES (%d, %d, %f, %f, %f,1,2169.461181,1618.798339,999.976562, 1, 'Gun Shop')", nrBiz, type, x, y, z);
		
		mysql_query(handle,string);	

	}
	return 1;
}
function adcnn()
{
	CanAdd = 0;
	return 1;
}
CMD:ad(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(CanAdd == 1) return SCM(playerid, COLOR_GREY, "Trebuie sa astepti 60sec de la ultimul anunt.");
		new string[256], ad[256];
		if(sscanf(params, "s[256]",string)) return SCM(playerid, COLOR_GREY,"Sintaxa: {FFFFFF}/ad <anunt>");
		if(strlen(string) > 40) return SCM(playerid, COLOR_GREY, "Anuntul nu trebuie sa depaseasca 40 de caractere.");
		new money = 125 * strlen(string);
		if(PlayerInfo[playerid][pMoney] < money) return SCM(playerid, COLOR_GREY, "Nu ai destui bani.");
		CanAdd = 1;
		PlayerInfo[playerid][pMoney] -= money;
		GivePlayerMoney(playerid, -money);
		BizInfo[21][Money] += money;
		format(ad, sizeof(ad), "{009625}Anunt: {f2f2f2}%s {009625}by {d89e0d}%s{ffffff} ({009625}ID:{d89e0d}%d{ffffff})", string, GetName(playerid), playerid);
		SendClientMessageToAll(-1, ad);
		SetTimer("adcnn", 60000, false);
	}
	return 1;
}
CMD:addgpslocation(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pAdmin] < 1339) return SCM(playerid, COLOR_GREY, "Nu ai acces la aceasta comanda.");
		new type, name[256];
		if(sscanf(params, "is[256]", type, name)) return SCM(playerid, COLOR_GREY,"Sintaxa: {FFFFFF}/addgpslocation <city> <name>");
		{
			new Float:xx, Float:yy, Float:zz;
			GetPlayerPos(playerid, xx, yy, zz);
			new string[256];
			nrGPS++;
			format(string, sizeof(string), "INSERT INTO `gpsinfo`(`ID`, `Type`, `X`, `Y`, `Z`, `Name`) VALUES (%d, %d, %f, %f, %f,'%s')", nrGPS, type, xx, yy, zz, name);
			mysql_query(handle,string);
			SCM(playerid, COLOR_GREY, "Ai adaugat o noua locatie in GPS.");

		}

	}
	return 1;
}
function ResetGetDrugs(playerid)
{
	PlayerInfo[playerid][pCanGetDrugs] = 0;
	return 1;
}
CMD:selldrugs(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pJob] != 2) return SCM(playerid, COLOR_GREY, "** You are not Drugs Dealer.");
		new id, amount;
		if(sscanf(params, "us[256]", id, amount)) return SCM(playerid, COLOR_GREY,"Sintaxa: {FFFFFF}/selldrugs <playerid/name> <amount>");
		if(id == playerid) return SCM(playerid, COLOR_GREY, "Nu iti poti vinde singur drugs.");
		if(amount < 1 || amount > 200000) return SCM(playerid, COLOR_GREY, "Alege o valoare valida(1-200.000g).");
		if(!IsPlayerConnected(id)) return SCM(playerid, COLOR_GREY, "** Jucatorul nu este conectat.");
		if(PlayerInfo[playerid][pDrugs] < amount) return SCM(playerid, COLOR_GREY, "Nu ai destule drugs.");
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		if(!IsPlayerInRangeOfPoint(id, 5, x, y, z)) return SCM(playerid, COLOR_GREY, "Jucatorul nu este langa tine.");
		if(GetPlayerVirtualWorld(playerid) != GetPlayerVirtualWorld(id)) return SCM(playerid, COLOR_GREY, "Jucatorul este in alt Virtual World.");
		if(PlayerInfo[id][pMoney] < amount * 100) return SCM(playerid, COLOR_GREY, "Jucatorul nu are destui bani.");
		SellDrugsInfo[playerid][id] = amount;
		new string[256];
		format(string, sizeof(string), "**Jucatorul %s ti-a oferit %d drugs pentru %d $. Foloseste comanda /acceptdrugs %d", GetName(playerid), amount, amount*100, id);
		SCM(id, COLOR_GREY, string);
		format(string, sizeof(string), "**Ai oferit jucatorului %s %d drugs pentru %d $.", GetName(id), amount, amount * 100);
		SCM(playerid, COLOR_GREY, string);
 	}
	return 1;
}
CMD:acceptdrugs(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		new id;
		if(sscanf(params, "i", id)) return SCM(playerid, COLOR_GREY,"Sintaxa: {FFFFFF}/acceptdrugs <playerid>");
		if(!IsPlayerConnected(id)) return SCM(playerid, COLOR_GREY, "Jucatorul nu este conectat.");
		if(SellDrugsInfo[id][playerid] == 0) return SCM(playerid, COLOR_GREY, "Nu ai o oferta de la acel jucator.");
		new amount;
		amount = SellDrugsInfo[id][playerid];
		SellDrugsInfo[id][playerid] = 0;
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		if(!IsPlayerInRangeOfPoint(id, 5, x, y, z)) return SCM(playerid, COLOR_GREY, "Jucatorul nu este langa tine.");
		if(PlayerInfo[id][pDrugs] < amount) return SCM(playerid, COLOR_GREY, "Jucatorul nu mai are destule droguri.");
		if(PlayerInfo[playerid][pMoney] < amount * 100) return SCM(playerid, COLOR_GREY, "Nu ai destui bani.");
		PlayerInfo[playerid][pDrugs] += amount;
		PlayerInfo[playerid][pMoney] -= amount * 100;
		GivePlayerMoney(playerid, -(amount * 100));
		PlayerInfo[id][pDrugs] -= amount;
		if(PlayerInfo[id][pDrugsSkill] < 750) PlayerInfo[id][pDrugsSkill]++;
		new string[256];
		format(string, sizeof(string), "*** Jucatorul %s a cumparat de la tine %d drugs pentru %d $", GetName(playerid), amount, amount * 100); 
		SCM(id, COLOR_GREY, string);
		format(string, sizeof(string), "*** Ai vandut jucatorului %s %d drugs pentru %d $", GetName(id), amount, amount * 100); 
		SCM(playerid, COLOR_GREY, string);
	}
	return 1;
}
CMD:getdrugs(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pJob] != 2) return SCM(playerid, COLOR_GREY, "** You are not Drugs Dealer.");
		if(!IsPlayerInRangeOfPoint(playerid, 3, 324.3867,1118.7701,1083.8828 )) return SCM(playerid, COLOR_GREY, "Nu esti la locul potrivit.");
		if(GetPlayerVirtualWorld(playerid) != 1) return SCM(playerid, COLOR_GREY, "Nu esti la locul potrivit.");
		if(PlayerInfo[playerid][pCanGetDrugs] == 1) return SCM(playerid, COLOR_GREY, "** You must wait 60 seconds.");
		new amount;
		if(sscanf(params, "i", amount)) return SendClientMessage(playerid, COLOR_GREY,"Sintaxa: {FFFFFF}/getdrugs <amount>");
		new SkillLevel = 1;
		new var = 0;
		while(var + SkillLevel * 50 <= PlayerInfo[playerid][pDrugsSkill])
		{
			var += SkillLevel * 50;
			SkillLevel++;
		}
		///aici pentru vip
		var = 14 * SkillLevel;
		if(amount < 0 || amount > var) return SCM(playerid, COLOR_GREY, "** Alege o valoare valida.");
		if(PlayerInfo[playerid][pDrugs] > 10) return SCM(playerid, COLOR_GREY, "** Ai atins numarul maxim de droguri pe care le poti avea la tine.");
		if(PlayerInfo[playerid][pMoney] < amount * 10) return SCM(playerid, COLOR_GREY, "** Nu ai destui bani.");
		PlayerInfo[playerid][pMoney] -= amount * 10;
		GivePlayerMoney(playerid, -(amount * 10));
		PlayerInfo[playerid][pDrugs] += amount;
		new string[256];
		format(string, sizeof(string), "** Ai cumparat %d drugs.", amount);
		SendClientMessage(playerid,COLOR_GREY, string);
		PlayerInfo[playerid][pCanGetDrugs] = 1;
		SetTimerEx("ResetGetDrugs",60000, false, "i", playerid);

	}
	return 1;
}
CMD:quitjob(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pCanQuitJob] == 1) return SCM(playerid, COLOR_GREY, "** Nu poti da /quitjob in acest moment.");
		if(PlayerInfo[playerid][pJob] == 0) return SCM(playerid, COLOR_GREY, "** Nu ai un job.");
		PlayerInfo[playerid][pJob] = 0;
		SCM(playerid, COLOR_GREY, "Ai demisionat."); 
	}
	return 1;
}
CMD:jobhelp(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pJob] == 0) return SCM(playerid, COLOR_GREY, "Nu ai un job.");
		if(PlayerInfo[playerid][pJob] == 1) ShowPlayerDialog(playerid, DIALOG_JOBHELP, DIALOG_STYLE_MSGBOX, "Arms Dealer Help:", "{c6c4c4}Foloseste comanda {a4f442}/getmats{c6c4c4} la locatia din LS(/gps)\nsi transporta pachetul la locatia din SF(/gps) si folosind comanda {a4f442}/delivermats {c6c4c4}vei fi recompensat cu mats.\nPentru a vinde arme foloseste comanda {a4f442}/sellgun", "Ok", "");
		if(PlayerInfo[playerid][pJob] == 2) ShowPlayerDialog(playerid, DIALOG_JOBHELP, DIALOG_STYLE_MSGBOX, "Drugs Dealer Help:", "{c6c4c4}Foloseste comanda {a4f442}/getdrugs{c6c4c4} la locatia din LS(/gps)\nPentru a vinde droguri foloseste comanda {a4f442}/selldrugs", "Ok", "");
		if(PlayerInfo[playerid][pJob] == 3) ShowPlayerDialog(playerid, DIALOG_JOBHELP, DIALOG_STYLE_MSGBOX, "Farmer Help:", "{c6c4c4}Foloseste comanda {a4f442}/startwork{c6c4c4} la ferma(/gps)\nPentru a vinde faina foloseste comanda {a4f442}/vindefaina la fabrica de faina(/gps)", "Ok", "");
		if(PlayerInfo[playerid][pJob] == 4) ShowPlayerDialog(playerid, DIALOG_JOBHELP, DIALOG_STYLE_MSGBOX, "Fisher Help:", "{c6c4c4}Foloseste comanda {a4f442}/fish{c6c4c4} la locatia din LS(/gps)\nPentru a vinde pestele du-te la cel mai apropiat 24/7", "Ok", "");
		if(PlayerInfo[playerid][pJob] == 5) ShowPlayerDialog(playerid, DIALOG_JOBHELP, DIALOG_STYLE_MSGBOX, "WoodCuuter Help:", "{c6c4c4}Foloseste comanda {a4f442}/startwork{c6c4c4}pentru a incepe munca\n{c6c4c4}Foloseste comanda {a4f442}/stopwork{c6c4c4} pentru a inceta munca", "Ok", "");
		if(PlayerInfo[playerid][pJob] == 6) ShowPlayerDialog(playerid, DIALOG_JOBHELP, DIALOG_STYLE_MSGBOX, "Miner Help:", "{c6c4c4}Foloseste comanda {a4f442}/startwork{c6c4c4}pentru a incepe munca\n{c6c4c4}Foloseste comanda {a4f442}/stopwork{c6c4c4} pentru a inceta munca", "Ok", "");
		if(PlayerInfo[playerid][pJob] == 7) ShowPlayerDialog(playerid, DIALOG_JOBHELP, DIALOG_STYLE_MSGBOX, "Trucker Help:", "{c6c4c4}Foloseste comanda {a4f442}/startwork{c6c4c4}pentru a incepe munca\n{c6c4c4}Foloseste comanda {a4f442}/stopwork{c6c4c4} pentru a inceta munca\n{c6c4c4}Foloseste comanda {a4f442}/tlocations{c6c4c4} pentru a afla locatiile fabricilor", "Ok", "");
		if(PlayerInfo[playerid][pJob] == 8) ShowPlayerDialog(playerid, DIALOG_JOBHELP, DIALOG_STYLE_MSGBOX, "Lawyer Help:", "{c6c4c4}Foloseste comanda {a4f442}/free{c6c4c4} la locatia din LS(/gps) pentru a elibera un detinut\n{c6c4c4}Foloseste comanda {a4f442}/jl{c6c4c4} pentru a vedea lista prizonierilor", "Ok", "");
	}
	return 1;
}
CMD:jobs(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(CP[playerid][ID] != 0) return SCM(playerid, COLOR_GREY, "**Ai un checkpoint activ.");
		ShowPlayerDialog(playerid, DIALOG_JOBSLOCATION, DIALOG_STYLE_LIST, "Job List:", "Arms Dealer\nDrugs Dealer\nFarmer\nFisher\nWoodCutter\nMiner\nTrucker\nLawyer", "Select", "Cancel");
	}
	return 1;
}
CMD:gps(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
		ShowPlayerDialog(playerid, DIALOG_GPS1, DIALOG_STYLE_LIST, "Choose City:" , "Los Santos\nLas Venturas\nSan Fiero", "Select", "Cancel");
	}
	return 1;
}
CMD:free(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pJob] != 8) return SCM(playerid, COLOR_GREY, "You are not a lawer.");
		new id;
		if(!IsPlayerInRangeOfPoint(playerid, 5, 224.3974,121.0106,999.0969)) return SCM(playerid, COLOR_GREY, "**Nu esti la birou.");
		if(sscanf(params, "u", id)) return SendClientMessage(playerid, COLOR_GREY,"Sintaxa: {FFFFFF}/free <playerid/name>");
		if(!IsPlayerConnected(id)) return SCM(playerid, COLOR_GREY, "Acel jucator nu este conectat.");
		if(PlayerInfo[id][pJailTime] == 0) return SCM(playerid, COLOR_GREY, "Acel jucator nu este in jail.");
		if(PlayerInfo[id][pJailTime] > PlayerInfo[playerid][pLawyerSkill] * 100 + 700) return SCM(playerid, COLOR_GREY, "Nu ai skill-ul necesar pentru a scoate acel jucator din jail.");
		new price = PlayerInfo[id][pJailTime] * 30;
		LawyerPrice[playerid][id] = price;
		new string[256];
		format(string, sizeof(string), "{0cbece}**Ai trimis oferta de eliberare din jail jucatorului {949696}%s {0cbece}pentru {949696}%d {0cbece}$.", GetName(id), price);
		SCM(playerid, COLOR_GREY, string);
		format(string, sizeof(string), "{0cbece}**Ai primit oferta de eliberare din jail de la avocatul {949696}%s {0cbece}pentru {949696}%d {0cbece}$.", GetName(playerid), price);
		SCM(id, COLOR_GREY, string);
		format(string, sizeof(string), "{0cbece}Foloseste comanda {949696}/acceptlawyer %d %d.", playerid, price);
		SCM(id, COLOR_GREY, string);
	}
	return 1;
}
CMD:jl(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pJob] != 8 && (PlayerInfo[playerid][pFaction] < 1 || PlayerInfo[playerid][pFaction] > 3)) return SCM(playerid, COLOR_GREY, "Nu ai acces la aceasta comanda.");
		new string[256];
		SCM(playerid, COLOR_GREY, "{999106}Jail List:");
		for(new i = 0; i <= 1001; i++)
			if(IsPlayerConnected(i))
				if(PlayerInfo[i][pJailTime] > 0)
				{
					format(string, sizeof(string), "{f7f29e}%s[ID:{d8d8d8}%d{f7f29e}]{d8d8d8}%d s.", GetName(i),i, PlayerInfo[i][pJailTime]);
					SCM(playerid, -1, string);
				}

	}
	return 1;
}
CMD:acceptlawyer(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{	
		if(PlayerInfo[playerid][pJailTime] == 0) return SCM(playerid, COLOR_GREY, "Nu esti in jail.");
		new id, price;
		if(sscanf(params, "ii", id, price)) return SendClientMessage(playerid, COLOR_GREY,"Sintaxa: {FFFFFF}/acceptlawyer <playerid> <price>");
		if(!IsPlayerConnected(id)) return SCM(playerid, COLOR_GREY, "Acel jucator nu este online.");
		if(PlayerInfo[id][pJob] != 8) return SCM(playerid, COLOR_GREY, "Acel jucator nu este avocat.");
		if(price > PlayerInfo[playerid][pMoney]) return SCM(playerid, COLOR_GREY, "**Nu ai destui bani.");
		if(LawyerPrice[id][playerid] != price) return SCM(playerid, COLOR_GREY, "**Suma de bani pe care trebuie sa o platesti s-a schimbat.");
		if(LawyerPrice[id][playerid] == 0) return SCM(playerid, COLOR_GREY, "Nu ai o oferta de la acel jucator.");
		GivePlayerMoney(playerid, -price);
		GivePlayerMoney(id, price);
		PlayerInfo[playerid][pMoney] -= price;
		PlayerInfo[id][pMoney] += price;
		if(PlayerInfo[id][pLawyerSkill] != 5)
		{
			PlayerInfo[id][pLawerFree] ++;
			if(PlayerInfo[id][pLawerFree] == 50 * PlayerInfo[id][pLawyerSkill])
			{
				PlayerInfo[id][pLawerFree] = 0;
				PlayerInfo[id][pLawyerSkill]++;
			}	

		}
		new string[256];
		format(string, sizeof(string), "{0cbece}**Jucatorul {949696}%s {0cbece}a acceptat oferta de eliberare din jail pentru {949696}%d {0cbece}$.", GetName(id), price);
		SCM(id, COLOR_GREY, string);
		format(string, sizeof(string), "{0cbece}**Ai acceptat oferta de eliberare din jail de la avocatul {949696}%s {0cbece}pentru {949696}%d {0cbece}$.", GetName(playerid), price);
		SCM(playerid, COLOR_GREY, string);
		for(new i = 0; i <= 1000; i++)
			LawyerPrice[i][playerid] = 0;
		PlayerInfo[playerid][pJailTime] = 0;
		SetPlayerVirtualWorld(playerid,0);
		SetPlayerInterior(playerid,0);
		SetPlayerPos(playerid,1825.3719,-1538.7783,13.5469);
		PlayerTextDrawHide(playerid,  jailtime[playerid]);
	}
	return 1;
}
CMD:getjob(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pJob] != 0) return SCM(playerid, -1, "{018c96}Ai deja un job, foloseste comanda /quitjob");
		if(IsPlayerInRangeOfPoint(playerid, 3, 1547.4502,-1669.6681,13.5669))
		{
			if(GetPlayerVirtualWorld(playerid) != 0) return SCM(playerid, COLOR_GREY, "Esti in VirtualWorld.");
			PlayerInfo[playerid][pJob] = 8; 
			SCM(playerid, -1, "{018c96}** You are now Lawyer.");
		}
		if(IsPlayerInRangeOfPoint(playerid, 3, 1365.0842,-1275.0449,13.5469))
		{
			if(GetPlayerVirtualWorld(playerid) != 0) return SCM(playerid, COLOR_GREY, "Esti in VirtualWorld.");
			PlayerInfo[playerid][pJob] = 1;
			PlayerInfo[playerid][pMatsP] = 0;
			SCM(playerid, -1, "{018c96}** You are now Arms Dealer.");
		}
		if(IsPlayerInRangeOfPoint(playerid, 3, 2166.6367,-1677.7665,15.0859))
		{
			if(GetPlayerVirtualWorld(playerid) != 0) return SCM(playerid, COLOR_GREY, "Esti in VirtualWorld.");
			PlayerInfo[playerid][pJob] = 2;
			SCM(playerid, -1, "{018c96}** You are now Drugs Dealer.");
		}
		if(IsPlayerInRangeOfPoint(playerid, 3, -382.8611,-1426.3734,26.2900))
		{
			if(GetPlayerVirtualWorld(playerid) != 0) return SCM(playerid, COLOR_GREY, "Esti in VirtualWorld.");
			PlayerInfo[playerid][pJob] = 3;
			SCM(playerid, -1, "{018c96}** You are now Farmer.");
		}
		if(IsPlayerInRangeOfPoint(playerid, 3, 376.4070,-2054.5667,8.0156))
		{
			if(GetPlayerVirtualWorld(playerid) != 0) return SCM(playerid, COLOR_GREY, "Esti in VirtualWorld.");
			PlayerInfo[playerid][pJob] = 4;
			SCM(playerid, -1, "{018c96}** You are now Fisher.");
		}
		if(IsPlayerInRangeOfPoint(playerid, 3, -1992.9341,-2387.8445,30.6250))
		{
			if(GetPlayerVirtualWorld(playerid) != 0) return SCM(playerid, COLOR_GREY, "Esti in VirtualWorld.");
			PlayerInfo[playerid][pJob] = 5;
			SCM(playerid, -1, "{018c96}** You are now WoodCutter.");
		}
		if(IsPlayerInRangeOfPoint(playerid, 3, -1864.4252,-1559.7217,21.7500))
		{
			if(GetPlayerVirtualWorld(playerid) != 0) return SCM(playerid, COLOR_GREY, "Esti in VirtualWorld.");
			PlayerInfo[playerid][pJob] = 6;
			SCM(playerid, -1, "{018c96}** You are now Miner.");
		}
		if(IsPlayerInRangeOfPoint(playerid, 3, 2813.8909,972.8784,10.7500))
		{
			if(GetPlayerVirtualWorld(playerid) != 0) return SCM(playerid, COLOR_GREY, "Esti in VirtualWorld.");
			PlayerInfo[playerid][pJob] = 7;
			SCM(playerid, -1, "{018c96}** You are now Trucker.");
		}
	}
	return 1;
}
function UpdateFarmerTXD(playerid)
{
	PlayerTextDrawHide(playerid, FarmerJobInfo[playerid]);
	PlayerTextDrawHide(playerid, FarmerLinie[playerid]);
	PlayerTextDrawHide(playerid, FarmerTime[playerid]);
	PlayerTextDrawHide(playerid, FarmerSpeed[playerid]);
	PlayerTextDrawHide(playerid, FarmerComeback[playerid]);

	PlayerTextDrawShow(playerid, FarmerJobInfo[playerid]);
	PlayerTextDrawShow(playerid, FarmerLinie[playerid]);
	new string[256];

	format(string, sizeof(string) ,"Munceste Inca %d secunde pentru a fi platit.", FarmerTimer[playerid]);
	PlayerTextDrawSetString(playerid, FarmerTime[playerid], string);
	PlayerTextDrawShow(playerid, FarmerTime[playerid]);

	if(FarmerComeTimer[playerid] > 0)
	{
		format(string, sizeof(string) ,"!! Intoarce-te la ferma, ai %d secunde.", FarmerComeTimer[playerid]);
		PlayerTextDrawSetString(playerid, FarmerComeback[playerid], string);
		PlayerTextDrawShow(playerid, FarmerComeback[playerid]);
	}
	if(GetVehicleSpeed(FarmerCarID[playerid]) < 25)
	{
		PlayerTextDrawSetString(playerid, FarmerSpeed[playerid], "!! Viteza ta trebuie sa fie mai mare de 25km/h.");
		PlayerTextDrawShow(playerid, FarmerSpeed[playerid]);
	}
	return 1;
}
function StopFarmerTXD(playerid)
{	
	PlayerTextDrawHide(playerid, FarmerJobInfo[playerid]);
	PlayerTextDrawHide(playerid, FarmerLinie[playerid]);
	PlayerTextDrawHide(playerid, FarmerTime[playerid]);
	PlayerTextDrawHide(playerid, FarmerSpeed[playerid]);
	PlayerTextDrawHide(playerid, FarmerComeback[playerid]);
	return 1;

}
function FishStop(playerid)
{
	PlayerInfo[playerid][pCanQuitJob] = 0;
	ApplyAnimation(playerid, "PED", "SHIFT", 4.1, 1, 1, 1, 1, 0, 1);
	ClearAnimations(playerid, 1);
	TogglePlayerControllable(playerid, 1);
	new var;
	var = random(10000);
	var += 10000;
	PlayerInfo[playerid][pFishKG] = var;
	new string[256];
	format(string, sizeof(string), "{04d615}**Felicitari!!! Ai prins un peste de {a5a5a5}%d{04d615}g. Du-te la un 24/7 si vinde-l.", var);
	SCM(playerid, COLOR_GREY, string);
	return 1;
}
CMD:fish(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pJob] != 4) return SCM(playerid, COLOR_GREY, "Nu esti fisher.");
		if(!IsPlayerInRangeOfPoint(playerid, 10, 383.7176,-2087.3936,7.8359)) return SCM(playerid, COLOR_GREY, "**Nu te afli in locul potrivit. Foloseste /GPS.");
		if(PlayerInfo[playerid][pFishKG] != 0) return SCM(playerid, COLOR_GREY, "**Ai dat deja fish, du-te si vinde pestele mai intai.");
		if(PlayerInfo[playerid][pCanQuitJob] != 0) return SCM(playerid, COLOR_GREY, "**Nu poti folosi aceasta comanda.");
		PlayerInfo[playerid][pCanQuitJob] = 1;
		TogglePlayerControllable(playerid, 0);
		ApplyAnimation(playerid, "PED", "IDLE_CHAT", 4.1, 1, 1, 1, 1, 0, 1);
		GameTextForPlayer(playerid, "Fishing...", 15000, 5);
		SetTimerEx("FishStop", 15000, 0, "u", playerid);
	}
	return 1;
}
CMD:vindefaina(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(!IsPlayerInRangeOfPoint(playerid, 3, -86.2853,-299.6250,2.7646)) return SCM(playerid, COLOR_GREY, "Nu esti la fabrica de faina.");
		if(GetPlayerVirtualWorld(playerid) != 0) return SCM(playerid, COLOR_GREY, "Esti in VirtualWorld");
		if(PlayerInfo[playerid][pFaina] == 0) return SCM(playerid, COLOR_GREY, "Nu ai faina.");
		new money, faina;
		money = (PlayerInfo[playerid][pFaina] * 1000) / 3;
		faina = PlayerInfo[playerid][pFaina];
		PlayerInfo[playerid][pFaina] = 0;
		GivePlayerMoney(playerid, money);
		PlayerInfo[playerid][pMoney] += money;
		new string[256];
		format(string, sizeof(string), "{0a663e}Ai vandut {969696}%d {0a663e}kg de faina pentru {969696}%d {0a663e}$.",faina, money );
		SCM(playerid, -1, string);
	}
	return 1;
}
function UpdateWoodCutterTXD(playerid)
{
	PlayerTextDrawHide(playerid, WoodJobInfo[playerid]);
	PlayerTextDrawHide(playerid, WoodJobTask[playerid]);
	PlayerTextDrawHide(playerid, WoodJobLinie[playerid]);
	PlayerTextDrawHide(playerid, WoodJobBusteni[playerid]);
	PlayerTextDrawHide(playerid, WoodJobMoney[playerid]);

	PlayerTextDrawShow(playerid, WoodJobInfo[playerid]);
	PlayerTextDrawShow(playerid, WoodJobLinie[playerid]);
	new string[256];

	if(CP[playerid][ID] == 5)
		format(string, sizeof(string), "!! Du-te si taie copacul.");
	else format(string, sizeof(string), "!! Transporta lemnele la fabrica.");
	PlayerTextDrawSetString(playerid, WoodJobTask[playerid], string);
	PlayerTextDrawShow(playerid, WoodJobTask[playerid]);

	format(string, sizeof(string), "Busteni: %d", PlayerInfo[playerid][pBusteni]);
	PlayerTextDrawSetString(playerid, WoodJobBusteni[playerid], string);
	PlayerTextDrawShow(playerid, WoodJobBusteni[playerid]);

	format(string, sizeof(string), "Money: %d.000 $", PlayerInfo[playerid][pBusteni]);
	PlayerTextDrawSetString(playerid, WoodJobMoney[playerid], string);
	PlayerTextDrawShow(playerid, WoodJobMoney[playerid]);
	return 1;
}
function StopWoodCutterTXD(playerid)
{
	PlayerTextDrawHide(playerid, WoodJobInfo[playerid]);
	PlayerTextDrawHide(playerid, WoodJobTask[playerid]);
	PlayerTextDrawHide(playerid, WoodJobLinie[playerid]);
	PlayerTextDrawHide(playerid, WoodJobBusteni[playerid]);
	PlayerTextDrawHide(playerid, WoodJobMoney[playerid]);
	return 1;
}
CMD:stopwork(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pJob] == 0) return SCM(playerid, COLOR_GREY, "**Nu lucrezi.");
		if(PlayerInfo[playerid][pCanQuitJob] == 0 ) return SCM(playerid, COLOR_GREY, "**Nu lucrezi.");
		if(PlayerInfo[playerid][pJob] == 7 && PlayerInfo[playerid][pCanQuitJob] == 1)
		{
			StopTruckerTXD(playerid);
			TruckerCarPlayerID[PlayerInfo[playerid][pTruckerCarID]] = -1;
			DestroyVehicle(PlayerInfo[playerid][pTruckerCarID]);
			PlayerInfo[playerid][pTruckerCarID] = 0;
			DisablePlayerCheckpoint(playerid);
			CP[playerid][ID] = 0;
			PlayerInfo[playerid][pTruckerMoney] = 0;
			PlayerInfo[playerid][pTruckerPos] = 0;
			if(PlayerInfo[playerid][pTruckerStatus] == 2)
			{
				TruckerTrailerTimer[PlayerInfo[playerid][pTruckerTrailerID]] = 0;
				TruckerTrailerPlayerID[PlayerInfo[playerid][pTruckerTrailerID]] = -1;
				DestroyVehicle(PlayerInfo[playerid][pTruckerTrailerID]);
				PlayerInfo[playerid][pTruckerTrailerID] = 0;
			}
			PlayerInfo[playerid][pTruckerStatus] = 0;
			PlayerInfo[playerid][pCanQuitJob] = 0;
			SCM(playerid, COLOR_GREY, "**Ai anulat job-ul.");
		}
		if(PlayerInfo[playerid][pJob] == 5) 
		{
			PlayerInfo[playerid][pCanQuitJob] = 0;
			RemovePlayerAttachedObject(playerid,2);
			RemovePlayerAttachedObject(playerid,3);
			StopWoodCutterTXD(playerid);
			new money;
			money = PlayerInfo[playerid][pBusteni] * 1000;
			GivePlayerMoney(playerid, money);
			PlayerInfo[playerid][pMoney] += money;
			new string[256];
			format(string, sizeof(string), "{00a1ff}** Ai primit {a8abad}%d {00a1ff}$ pentru munca depusa la fabrica.", money);
			SCM(playerid, -1, string);
			PlayerInfo[playerid][pBusteni] = 0;
			PlayerInfo[playerid][pBusteniT] = 0;
			DisablePlayerCheckpoint(playerid);
			CP[playerid][ID] = 0;
			ClearAnimations(playerid);
			TogglePlayerControllable(playerid, 1);
		}
		if(PlayerInfo[playerid][pJob] == 6) 
		{
			PlayerInfo[playerid][pCanQuitJob] = 0;
			RemovePlayerAttachedObject(playerid,2);
			StopMinerTXD(playerid);
			new money;
			money = PlayerInfo[playerid][pMinerAur] * 300 + PlayerInfo[playerid][pMinerArgint] * 150 + PlayerInfo[playerid][pMinerCupru]* 50 + PlayerInfo[playerid][pMinerFier] * 25;
			GivePlayerMoney(playerid, money);
			PlayerInfo[playerid][pMoney] += money;
			new string[256];
			format(string, sizeof(string), "{00a1ff}** Ai primit {a8abad}%d {00a1ff}$ pentru munca depusa.", money);
			SCM(playerid, -1, string);
			PlayerInfo[playerid][pMinerAur] = 0;
			PlayerInfo[playerid][pMinerArgint] = 0;
			PlayerInfo[playerid][pMinerCupru] = 0;
			PlayerInfo[playerid][pMinerFier] = 0;
			DisablePlayerCheckpoint(playerid);
			CP[playerid][ID] = 0;
			ClearAnimations(playerid);
			TogglePlayerControllable(playerid, 1);
		}
	}
	return 1;
}
function UpdateMinerTXD(playerid)
{
	PlayerTextDrawHide(playerid, MinerJobInfo[playerid]);
	PlayerTextDrawHide(playerid, MinerInfo1[playerid]);
	PlayerTextDrawHide(playerid, MinerLinie[playerid]);
	PlayerTextDrawHide(playerid, MinerInfo2[playerid]);
	PlayerTextDrawHide(playerid, MinerMoney[playerid]);

	PlayerTextDrawShow(playerid, MinerJobInfo[playerid]);
	PlayerTextDrawShow(playerid, MinerLinie[playerid]);

	new string[256];
	format(string, sizeof(string), "Aur: %dg Argint: %dg", PlayerInfo[playerid][pMinerAur], PlayerInfo[playerid][pMinerArgint]);
	PlayerTextDrawSetString(playerid, MinerInfo1[playerid], string);
	PlayerTextDrawShow(playerid, MinerInfo1[playerid]);

	format(string, sizeof(string), "Cupru: %dg Fier: %dg", PlayerInfo[playerid][pMinerCupru], PlayerInfo[playerid][pMinerFier]);
	PlayerTextDrawSetString(playerid, MinerInfo2[playerid], string);
	PlayerTextDrawShow(playerid, MinerInfo2[playerid]);

	format(string, sizeof(string), "Money: %d $", PlayerInfo[playerid][pMinerAur] * 300 + PlayerInfo[playerid][pMinerArgint] * 150 + PlayerInfo[playerid][pMinerCupru]* 50 + PlayerInfo[playerid][pMinerFier] * 25);
	PlayerTextDrawSetString(playerid, MinerMoney[playerid], string);
	PlayerTextDrawShow(playerid, MinerMoney[playerid]);
	return 1;
}
function StopMinerTXD(playerid)
{
	PlayerTextDrawHide(playerid, MinerJobInfo[playerid]);
	PlayerTextDrawHide(playerid, MinerInfo1[playerid]);
	PlayerTextDrawHide(playerid, MinerLinie[playerid]);
	PlayerTextDrawHide(playerid, MinerInfo2[playerid]);
	PlayerTextDrawHide(playerid, MinerMoney[playerid]);
	return 1;
}
function StopTruckerTXD(playerid)
{
	PlayerTextDrawHide(playerid, TruckerJobInfo[playerid]);
	PlayerTextDrawHide(playerid, TruckerLine1[playerid]);
	PlayerTextDrawHide(playerid, TruckerLinie[playerid]);
	PlayerTextDrawHide(playerid, TruckerType[playerid]);
	PlayerTextDrawHide(playerid, TruckerMoney[playerid]);
	return 1;
}
function UpdateTruckerTXD(playerid)
{
	PlayerTextDrawHide(playerid, TruckerJobInfo[playerid]);
	PlayerTextDrawHide(playerid, TruckerLine1[playerid]);
	PlayerTextDrawHide(playerid, TruckerLinie[playerid]);
	PlayerTextDrawHide(playerid, TruckerType[playerid]);
	PlayerTextDrawHide(playerid, TruckerMoney[playerid]);

	PlayerTextDrawShow(playerid, TruckerJobInfo[playerid]);
	PlayerTextDrawShow(playerid, TruckerLinie[playerid]);

	if(PlayerInfo[playerid][pTruckerStatus] == 1)
	{
		new string[256];
		format(string, sizeof(string), "!!! Foloseste comanda /tlocations pentru a lua trailer.");
		PlayerTextDrawSetString(playerid, TruckerLine1[playerid], string);
		PlayerTextDrawShow(playerid, TruckerLine1[playerid]);
	}
	if(PlayerInfo[playerid][pTruckerStatus] == 2)
	{
		new string[256];
		if(GetVehicleTrailer(PlayerInfo[playerid][pTruckerCarID]) != PlayerInfo[playerid][pTruckerTrailerID])
		{
			format(string, sizeof(string), "!!! Ai %d sec pentru a cupla trailerul.", TruckerTrailerTimer[PlayerInfo[playerid][pTruckerTrailerID]]);
			PlayerTextDrawSetString(playerid, TruckerLine1[playerid], string);
			PlayerTextDrawShow(playerid, TruckerLine1[playerid]);
		}
		format(string, sizeof(string), "Type: %s", TCargoInfo[PlayerInfo[playerid][pTruckerPos]][Type]);
		PlayerTextDrawSetString(playerid, TruckerType[playerid], string);
		PlayerTextDrawShow(playerid, TruckerType[playerid]);

		format(string, sizeof(string), "Money: %d$", PlayerInfo[playerid][pTruckerMoney]);
		PlayerTextDrawSetString(playerid, TruckerMoney[playerid], string);
		PlayerTextDrawShow(playerid, TruckerMoney[playerid]);
	}
	return 1;
}
CMD:loadcargo(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pJob] != 7) return SCM(playerid, COLOR_GREY, "Nu este trucker.");
		if(PlayerInfo[playerid][pCanQuitJob] == 0) return SCM(playerid, COLOR_GREY, "Nu muncesti.");
		if(CP[playerid][ID] != 0) return SCM(playerid, COLOR_GREY, "Ai un checkpoint activ.");
		if(PlayerInfo[playerid][pTruckerStatus] != 1) return SCM(playerid, COLOR_GREY, "Transporta trailer-ul la destinatie.");
		new loadcargoid = -1;
		if(IsPlayerInRangeOfPoint(playerid, 5, -235.4882,-256.6768,1.4297)) loadcargoid = 1;
		if(IsPlayerInRangeOfPoint(playerid, 5, -1039.1711,-590.1835,32.0078)) loadcargoid = 2;
		if(IsPlayerInRangeOfPoint(playerid, 5, -1929.8365,-1757.9303,24.1367)) loadcargoid = 3;
		if(IsPlayerInRangeOfPoint(playerid, 5, -1962.2478,-2477.5640,30.6250)) loadcargoid = 4;
		if(loadcargoid == -1) return SCM(playerid, COLOR_GREY, "**Nu esti in locul potrivit, foloseste /tlocations.");
		new string[512];
		for(new i = 1; i <= 99; i++)
			if(TCargoInfo[i][ID] == loadcargoid)
				format(string, sizeof(string),"%s%s\tDistanta: %0.1f\n", string, TCargoInfo[i][Type], GetPlayerDistanceFromPoint(playerid, TCargoInfo[i][trX], TCargoInfo[i][trY], TCargoInfo[i][trZ]) );
		ShowPlayerDialog(playerid, DIALOG_LOADCARGO, DIALOG_STYLE_TABLIST, "Chose route", string, "Select", "Cancel");
	}
	return 1;
}
CMD:tlocations(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pJob] != 7) return SCM(playerid, COLOR_GREY, "Nu este trucker.");
		if(PlayerInfo[playerid][pCanQuitJob] == 0) return SCM(playerid, COLOR_GREY, "Nu muncesti.");
		if(CP[playerid][ID] != 0) return SCM(playerid, COLOR_GREY, "Ai un checkpoint activ.");
		if(PlayerInfo[playerid][pTruckerStatus] != 1) return SCM(playerid, COLOR_GREY, "Transporta trailer-ul la destinatie.");
		new string[256];
		new Float: d1, Float: d2, Float: d3, Float: d4;
		d1 = GetPlayerDistanceFromPoint(playerid, -235.4882,-256.6768,1.4297);
		d2 = GetPlayerDistanceFromPoint(playerid, -1039.1711,-590.1835,32.0078);
		d3 = GetPlayerDistanceFromPoint(playerid, -1929.8365,-1757.9303,24.1367);
		d4 = GetPlayerDistanceFromPoint(playerid, -1962.2478,-2477.5640,30.6250);
		format(string, sizeof(string), "Nume\tDistanta\nFabrica de paine\t%.1f\nRafinarie\t%.1f\nMina\t%.1f\nFabrica de cherestea\t%.1f", d1, d2, d3, d4);
		ShowPlayerDialog(playerid, DIALOG_TLOCATIONS, DIALOG_STYLE_TABLIST_HEADERS, "Trucker Locations", string, "Select", "Cancel");
	}
	return 1;
}
CMD:startwork(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pJob] == 0) return SCM(playerid, COLOR_GREY, "Nu ai un job.");
		if(PlayerInfo[playerid][pCanQuitJob] != 0) return SCM(playerid, COLOR_GREY, "Nu poti folosi aceasta comanda acum.");
		if(PlayerInfo[playerid][pWanted] != 0) return SCM(playerid, COLOR_GREY, "Esti urmarit de politie.");
		if(IsPlayerInRangeOfPoint(playerid, 3, 2804.2161,972.3039,10.7500))
		{
			if(GetPlayerVirtualWorld(playerid) != 0) return SCM(playerid, COLOR_GREY, "Esti in virtual world.");
			if(PlayerInfo[playerid][pJob] != 7) return SCM(playerid, COLOR_GREY, "Nu esti Trucker.");
			if(CP[playerid][ID] != 0) return SCM(playerid, COLOR_GREY, "Ai un cp activ. Incearca din nou cand nu ai un cp activ.");
			PlayerInfo[playerid][pCanQuitJob] = 1;
			new var = random(6), vehid;
			if(var == 0) vehid = CreateVehicle(515, 2849.4153,898.5353,11.7711,359.4889 , 1, 2, 0);
			else if(var == 1) vehid = CreateVehicle(515, 2843.7141,897.4188,11.7749,0.8224 , 1, 2, 0);
			else if(var == 2) vehid = CreateVehicle(515, 2837.7615,897.4318,11.7826,0.4071 , 1, 2, 0);
			else if(var == 3) vehid = CreateVehicle(515, 2831.9736,898.2260,11.7718,359.3994 , 1, 2, 0);
			else if(var == 4) vehid = CreateVehicle(515, 2860.6074,898.3023,11.7839,0.3592 , 1, 2, 0);
			else if(var == 5) vehid = CreateVehicle(515, 2868.7742,897.1641,11.7720,1.2171 , 1, 2, 0);
			PutPlayerInVehicle(playerid, vehid, 0);
			SetVehicleParamsEx(vehid, 1, 0, 0, 1,0, 0, 0);
			PlayerInfo[playerid][pTruckerCarID] = vehid;
			PlayerInfo[playerid][pTruckerMoney] = 0;
			PlayerInfo[playerid][pTruckerCMoney] = 0;
			PlayerInfo[playerid][pTruckerTrailerID] = 0;
			PlayerInfo[playerid][pTruckerStatus] = 1;
			TruckerCarPlayerID[vehid] = playerid;
			UpdateTruckerTXD(playerid);

		}
		if(IsPlayerInRangeOfPoint(playerid, 3, -1855.0463,-1560.4830,21.7500))
		{
			if(GetPlayerVirtualWorld(playerid) != 0) return SCM(playerid, COLOR_GREY, "Esti in virtual world.");
			if(PlayerInfo[playerid][pJob] != 6) return SCM(playerid, COLOR_GREY, "Nu esti Miner.");
			if(CP[playerid][ID] != 0) return SCM(playerid, COLOR_GREY, "Ai un cp activ. Incearca din nou cand nu ai un cp activ.");
			CP[playerid][ID] = 5;
			PlayerInfo[playerid][pCanQuitJob] = 1;
			PlayerInfo[playerid][pMinerAur] = 0;
			PlayerInfo[playerid][pMinerArgint] = 0;
			PlayerInfo[playerid][pMinerCupru] = 0;
			PlayerInfo[playerid][pMinerFier] = 0;
			UpdateMinerTXD(playerid);
			SCM(playerid, -1, "{c9bd34}**Foloseste comanda {a0a09f}/stopwork{c9bd34} pentru a inceta munca.");
			new var; var = random(9);
			if(var == 0)
			{
				SetPlayerCheckpoint(playerid, -1810.3282,-1646.8640,22.8473, 1);
			}
			else if(var == 1)
			{
				SetPlayerCheckpoint(playerid, -1797.4072,-1656.6472,28.9579, 1);
			}
			else if(var == 2)
			{
				SetPlayerCheckpoint(playerid, -1785.8064,-1653.8997,26.0740, 1);
			}
			else if(var == 3)
			{
				SetPlayerCheckpoint(playerid, -1771.7822,-1647.9310,25.8311, 1);
			}
			else if(var == 4)
			{
				SetPlayerCheckpoint(playerid, -1782.3867,-1645.1805,32.7344, 1);
			}
			else if(var == 5)
			{
				SetPlayerCheckpoint(playerid, -1852.1948,-1654.5300,23.4745, 1);
			}
			else if(var == 6)
			{
				SetPlayerCheckpoint(playerid, -1855.0757,-1646.1533,24.8496, 1);
			}
			else if(var == 7)
			{
				SetPlayerCheckpoint(playerid, -1864.4315,-1649.5781,24.6766, 1);
			}
			else if(var == 8)
			{
				SetPlayerCheckpoint(playerid, -1864.4104,-1659.4810,22.4337, 1);
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 3, -2000.6581,-2368.5271,30.6250))
		{
			if(GetPlayerVirtualWorld(playerid) != 0) return SCM(playerid, COLOR_GREY, "Esti in virtual world.");
			if(PlayerInfo[playerid][pJob] != 5) return SCM(playerid, COLOR_GREY, "Nu esti WoodCutter.");
			if(CP[playerid][ID] != 0) return SCM(playerid, COLOR_GREY, "Ai un cp activ. Incearca din nou cand nu ai un cp activ.");
			CP[playerid][ID] = 5;
			PlayerInfo[playerid][pCanQuitJob] = 1;
			PlayerInfo[playerid][pBusteni] = 0;
			UpdateWoodCutterTXD(playerid);
			SCM(playerid, -1, "{c9bd34}**Foloseste comanda {a0a09f}/stopwork{c9bd34} pentru a inceta munca.");
			new var; var = random(9);
			if(var == 0)
			{
				SetPlayerCheckpoint(playerid, -1931.3807,-2361.4666,30.8452, 1);
			}
			else if(var == 1)
			{
				SetPlayerCheckpoint(playerid, -1932.0576,-2346.1526,33.1779, 1);
			}
			else if(var == 2)
			{
				SetPlayerCheckpoint(playerid, -1918.9552,-2352.7754,30.9004, 1);
			}
			else if(var == 3)
			{
				SetPlayerCheckpoint(playerid, -1914.3473,-2368.6514,29.8125, 1);
			}
			else if(var == 4)
			{
				SetPlayerCheckpoint(playerid, -1903.3979,-2371.4641,30.9230, 1);
			}
			else if(var == 5)
			{
				SetPlayerCheckpoint(playerid, -1903.7625,-2361.4548,31.1642, 1);
			}
			else if(var == 6)
			{
				SetPlayerCheckpoint(playerid, -1919.5613,-2406.1536,30.1000, 1);
			}
			else if(var == 7)
			{
				SetPlayerCheckpoint(playerid, -1937.3892,-2415.2402,30.6250, 1);
			}
			else if(var == 8)
			{
				SetPlayerCheckpoint(playerid, -1950.2982,-2407.8999,30.6250, 1);
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 3, -372.3134,-1427.8519,25.7266))
		{
			if(PlayerInfo[playerid][pJob] != 3) return SCM(playerid, COLOR_GREY, "Nu esti farmer.");
			if(PlayerInfo[playerid][pFaina] != 0) return SCM(playerid, COLOR_GREY, "Du-te sa vinzi faina la fabrica de paine.");
			if(GetPlayerVirtualWorld(playerid) != 0) return SCM(playerid, COLOR_GREY, "Esti in virtual world.");
			FarmerTimer[playerid] = 120;
			FarmerComeTimer[playerid] = 0;
			PlayerInfo[playerid][pCanQuitJob] = 1;
			UpdateFarmerTXD(playerid);
			new var;
			var = random(5);
			if(var == 0)
			{
				FarmerCarID[playerid] = CreateVehicle(531, -438.9510,-1412.5612,20.8642,9.9394, 0, 0, -1);
				PutPlayerInVehicle(playerid, FarmerCarID[playerid], 0);
			}
			else if(var == 1)
			{
				FarmerCarID[playerid] = CreateVehicle(531, -427.6136,-1408.6779,21.9899,14.4096, 1, 1, -1);
				PutPlayerInVehicle(playerid, FarmerCarID[playerid], 0);
			}
			else if(var == 2)
			{
				FarmerCarID[playerid] = CreateVehicle(531, -419.0540,-1407.2760,22.9787,15.6099, 2, 2, -1);
				PutPlayerInVehicle(playerid, FarmerCarID[playerid], 0);
			}
			else if(var == 3)
			{
				FarmerCarID[playerid] = CreateVehicle(531, -409.3405,-1405.8524,23.6950,8.3241, 3, 3, -1);
				PutPlayerInVehicle(playerid, FarmerCarID[playerid], 0);
			}
			else if(var == 4)
			{
				FarmerCarID[playerid] = CreateVehicle(531, -394.2117,-1403.7688,23.9203,10.0922, 4, 4, -1);
				PutPlayerInVehicle(playerid, FarmerCarID[playerid], 0);
			}
			SetVehicleParamsEx(FarmerCarID[playerid], 1, 0, 0, 1,0, 0, 0);
		}
	}
	return 1;
}
CMD:getmats(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pJob] != 1) return SCM(playerid, COLOR_GREY, "** You are not Arms Dealer.");
		if(!IsPlayerInRangeOfPoint(playerid, 3, 593.1838,-1248.7792,18.1781)) return SCM(playerid, COLOR_GREY, "Nu esti la locatia potrivita. Foloseste /GPS.");
		if(GetPlayerVirtualWorld(playerid) != 0 ) return SCM(playerid, COLOR_GREY, "Esti in Virtual World.");
		if(PlayerInfo[playerid][pMatsP] == 1) return SCM(playerid, COLOR_GREY, "Nu poti lua mai multe pachete.");
		if(PlayerInfo[playerid][pMoney] < 5000) return SCM(playerid, COLOR_GREY, "Nu ai destui bani.");
		PlayerInfo[playerid][pMatsP] = 1;
		PlayerInfo[playerid][pMoney] -= 5000;
		GivePlayerMoney(playerid, -5000);
		SendClientMessage(playerid, -1, "{018c96}** Ai luat 1 pachet pentru 5000$. Livreaza-l pentru a putea lua altul.");
	}
	return 1;
}
CMD:sellgun(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pJob] != 1) return SCM(playerid, COLOR_GREY, "** You are not Arms Dealer.");
		new giverid, weapon[256];
		if(sscanf(params, "us[256]", giverid, weapon)) 
		{
			SendClientMessage(playerid, COLOR_GREY,"Sintaxa: {FFFFFF}/sellgun <playerid/name> <weapon>");
			SendClientMessage(playerid, COLOR_GREY,"Deagle(200 mats) M4(600 mats) MP5(400mats) ShotGun(600 mats) Rifle(600 mats)");
			return 1;
		}
		if(!IsPlayerConnected(giverid)) return SCM(playerid, COLOR_GREY, "** Acel jucator nu este online.");
		new Float:px, Float:py, Float:pz;
		GetPlayerPos(playerid, px, py, pz);
		if(!IsPlayerInRangeOfPoint(giverid, 5, px, py, pz)) return SCM(playerid, COLOR_GREY, "** Acel player nu este langa tine.");
		if(GetPlayerVirtualWorld(playerid) != GetPlayerVirtualWorld(giverid)) return SCM(playerid, COLOR_GREY, "** Acel player se afla in alt Virtual World");
		new id = 0;
		if(!strcmp(weapon, "deagle" , true)) id = 1;
		if(!strcmp(weapon, "m4" , true)) id = 2;
		if(!strcmp(weapon, "mp5" , true)) id = 3;
		if(!strcmp(weapon, "shotgun" , true)) id = 4;
		if(!strcmp(weapon, "rifle" , true)) id = 5;
		if(id == 1)
		{
			if(PlayerInfo[playerid][pMats] < 200) return SCM(playerid, COLOR_GREY, "** Nu ai destule mats.");
			PlayerInfo[playerid][pMats] -= 200;
			GivePlayerWeapon(giverid, 24, 200);
			format(weapon, sizeof(weapon), "{541559}** Ai primit de la  %s un Deagle", GetName(playerid));
			SCM(giverid, -1, weapon);
			format(weapon, sizeof(weapon), "{541559}** Ai oferit un Deagle lui %s", GetName(giverid));
			SCM(playerid, -1, weapon);
		}
		if(id == 2)
		{
			if(PlayerInfo[playerid][pMats] < 600) return SCM(playerid, COLOR_GREY, "** Nu ai destule mats.");
			PlayerInfo[playerid][pMats] -= 600;
			GivePlayerWeapon(giverid, 31, 200);
			format(weapon, sizeof(weapon), "{541559}** Ai primit de la  %s un M4", GetName(playerid));
			SCM(giverid, -1, weapon);
			format(weapon, sizeof(weapon), "{541559}** Ai oferit un M4 lui %s", GetName(giverid));
			SCM(playerid, -1, weapon);
		}
		if(id == 3)
		{
			if(PlayerInfo[playerid][pMats] < 400) return SCM(playerid, COLOR_GREY, "** Nu ai destule mats.");
			PlayerInfo[playerid][pMats] -= 400;
			GivePlayerWeapon(giverid, 29, 200);
			format(weapon, sizeof(weapon), "{541559}** Ai primit de la  %s un MP5", GetName(playerid));
			SCM(giverid, -1, weapon);
			format(weapon, sizeof(weapon), "{541559}** Ai oferit un MP5 lui %s", GetName(giverid));
			SCM(playerid, -1, weapon);
		}
		if(id == 4)
		{
			if(PlayerInfo[playerid][pMats] < 600) return SCM(playerid, COLOR_GREY, "** Nu ai destule mats.");
			PlayerInfo[playerid][pMats] -= 600;
			GivePlayerWeapon(giverid, 25, 200);
			format(weapon, sizeof(weapon), "{541559}** Ai primit de la  %s un ShotGun", GetName(playerid));
			SCM(giverid, -1, weapon);
			format(weapon, sizeof(weapon), "{541559}** Ai oferit un ShotGun lui %s", GetName(giverid));
			SCM(playerid, -1, weapon);
		}
		if(id == 5)
		{
			if(PlayerInfo[playerid][pMats] < 600) return SCM(playerid, COLOR_GREY, "** Nu ai destule mats.");
			PlayerInfo[playerid][pMats] -= 600;
			GivePlayerWeapon(giverid, 33, 200);
			format(weapon, sizeof(weapon), "{541559}** Ai primit de la  %s un Rifle", GetName(playerid));
			SCM(giverid, -1, weapon);
			format(weapon, sizeof(weapon), "{541559}** Ai oferit un Rifle lui %s", GetName(giverid));
			SCM(playerid, -1, weapon);
		}

	}
	return 1;
}
CMD:delivermats(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pJob] != 1) return SCM(playerid, COLOR_GREY, "** You are not Arms Dealer.");
		if(!IsPlayerInRangeOfPoint(playerid, 3, -2119.4187,-178.3190,35.3203)) return SCM(playerid, COLOR_GREY, "Nu esti la locatia potrivita. Foloseste /GPS.");
		if(GetPlayerVirtualWorld(playerid) != 0 ) return SCM(playerid, COLOR_GREY, "Esti in Virtual World.");
		if(PlayerInfo[playerid][pMatsP] == 0) return SCM(playerid, COLOR_GREY, "Ai 0 pachete.");\
		PlayerInfo[playerid][pMatsP] = 0;
		///aici pun pentru vip
		PlayerInfo[playerid][pMats] += 500;
		SendClientMessage(playerid, -1, "{018c96}** Ai primit 500 mats pentru pachet.");
	}
	return 1;
}
function ResetService(playerid)
{
	CanUseService[playerid] = 0;
	return 1;
}
function ResetTaxiComanda(playerid)
{
	RemoveTPCtimer[playerid]  = 0;
	for(new i = 1; i <= nrTPC; i++)
		if(TaxiPComandsID[i] == playerid)
		{
			TaxiPComandsID[i] = -1;
			return 1;
		}
	return 1;
}
CMD:gethit(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pFaction] != 11) return SCM(playerid, COLOR_GREY, "Nu esti hitman.");
		if(PlayerInfo[playerid][pHasContract] != -1) return SCM(playerid, COLOR_GREY, "Ai deja un contract.");
		if(CP[playerid][ID] != 0) return SCM(playerid, COLOR_GREY, "**Ai un checkpoint activ. Foloseste comanda /killcp pentru a anula CheckPointul.");
		while(nrContracts != 0 && ContractsPlayersID[nrContracts] == -1)
		{
			nrContracts--;
		}
		if(nrContracts == 0) return SCM(playerid, COLOR_GREY, "**Nu mai sunt contracte de efectuat.");
		PlayerInfo[playerid][pHasContract] = ContractsPlayersID[nrContracts];
		PlayerInfo[playerid][pContractMoney] = ContractsMoney[nrContracts];
		nrContracts--;
		new string[256];
		format(string, sizeof(string), "{adadad}[HITMAN] {e0e0e0}Agentul %s a acceptat un contract.", GetName(playerid));
		for(new i = 0; i <= 1000; i++)
			if(IsPlayerConnected(i) && PlayerInfo[i][pFaction] == 11)
				SCM(i, -1, string);
		format(string, sizeof(string), "{adadad}Nume: {e0e0e0}%s  {adadad}ID: {e0e0e0}%d {adadad}Price: {e0e0e0}%d", GetName(PlayerInfo[playerid][pHasContract]), PlayerInfo[playerid][pHasContract], PlayerInfo[playerid][pContractMoney]);
		SCM(playerid, -1, string);
		SCM(playerid, -1, "{adadad}Ti-a fost setat un CheckPoint catre locatia tinte. Good Luck!!");
		new Float: varX, Float: varY, Float: varZ;
		GetPlayerPos(PlayerInfo[playerid][pHasContract], varX, varY, varZ);
		SetPlayerCheckpoint(playerid, varX, varY, varZ, 3);
		CP[playerid][ID] = 6;
		CP[playerid][Player] = PlayerInfo[playerid][pHasContract];

	}
	return 1;
}
CMD:order(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pFaction] != 11) return SCM(playerid, COLOR_GREY, "Nu ai acces la aceasta comanda.");
		if(!IsPlayerInRangeOfPoint(playerid, 5, 1080.6824,-345.0348,73.9868)) return SCM(playerid, COLOR_GREY, "Nu esti la locul potrivit.");
		if(PlayerInfo[playerid][pMoney] < 15000) return SCM(playerid, COLOR_GREY, "Nu ai destui bani (15.000$).");
		GivePlayerMoney(playerid, -15000);
		PlayerInfo[playerid][pMoney] -= 15000;         
		if(PlayerInfo[playerid][pRFaction] == 1)
		{
			GivePlayerWeapon(playerid, 24, 250);
			GivePlayerWeapon(playerid, 4, 1);
			GivePlayerWeapon(playerid, 34, 50);
		}
		if(PlayerInfo[playerid][pRFaction] == 2)
		{
			GivePlayerWeapon(playerid, 24, 250);
			GivePlayerWeapon(playerid, 4, 1);
			GivePlayerWeapon(playerid, 34, 50);
			GivePlayerWeapon(playerid, 29, 250);
		}
		if(PlayerInfo[playerid][pRFaction] >= 3)
		{
			GivePlayerWeapon(playerid, 24, 250);
			GivePlayerWeapon(playerid, 4, 1);
			GivePlayerWeapon(playerid, 34, 50);
			GivePlayerWeapon(playerid, 29, 250);
			GivePlayerWeapon(playerid, 31, 250);
		}
	}
	return 1;
}
CMD:contract(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pFaction] == 11) return SCM(playerid, COLOR_GREY, "**Un agent al corporatiei nu poate plasa contracte.");
		new deadid, price;
		if(sscanf(params, "ui", deadid, price)) return SendClientMessage(playerid, COLOR_GREY,"Sintaxa: {FFFFFF}/contract <playerid/name> <money>");
		if(price < 10000 || price > 100000) return SCM(playerid, COLOR_GREY, "Pretul unui contract trebuie sa fie cuprins intre 10.000 - 100.000$.");
		if(PlayerInfo[playerid][pMoney] < price) return SCM(playerid, COLOR_GREY, "Nu ai destui bani.");
		if(!IsPlayerConnected(deadid)) return SCM(playerid, COLOR_GREY, "Acel jucator nu este conectat.");
		if(PlayerInfo[deadid][pFaction] == 1) return SCM(playerid, COLOR_GREY, "Nu poti pune contract pe un membrul al agentiei.");
		if(PlayerInfo[playerid][pFaction] <= 3 && PlayerInfo[playerid][pFaction] >= 1 && price != 100000) return SCM(playerid, COLOR_GREY, "Pretul minim pentru un politist este de 100.000$.");
		for(new i = 1; i <= nrContracts; i++)
			if(ContractsPlayersID[i] == deadid) return SCM(playerid, COLOR_GREY, "Acel jucator are deja un contract.");
		for(new i = 0; i <= 1000; i++)
			if(IsPlayerConnected(i) && PlayerInfo[i][pFaction] == 11 && PlayerInfo[i][pHasContract] == deadid) return SCM(playerid, COLOR_GREY, "Acel jucator are deja un contract.");
		nrContracts++;
		ContractsPlayersID[nrContracts] = deadid;
		ContractsMoney[nrContracts] = price;
		GivePlayerMoney(playerid, -price);
		PlayerInfo[playerid][pMoney] -= price;
		new string[256];
		format(string, sizeof(string), "{adadad}[HITMAN] {e0e0e0}Un contract in valoare de %d $ a fost semnat pentru %s [ID:%d].", price, GetName(deadid), deadid);
		for(new i = 0; i <= 1000; i++)
			if(IsPlayerConnected(i) && PlayerInfo[i][pFaction] == 11)
				SCM(i, -1, string);
	}
	return 1;
}
CMD:cancelhit(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pFaction] != 11) return SCM(playerid, COLOR_GREY, "Nu esti hitman.");
		if(PlayerInfo[playerid][pHasContract] == -1) return SCM(playerid, COLOR_GREY, "Nu ai un contract.");
		new reason[32];
		if(sscanf(params, "s[32]", reason)) return SendClientMessage(playerid, COLOR_GREY,"Sintaxa: {FFFFFF}/cancelhit <reason>");
		PlayerInfo[playerid][pHasContract] = -1;
		PlayerInfo[playerid][pCancelContracts]++;
		CP[playerid][ID] = 0;
		DisablePlayerCheckpoint(playerid);
		new string[256];
		format(string, sizeof(string), "{adadad}[HITMAN] {e0e0e0}Agentul %s a anulat un contract. Reason: %s", GetName(playerid), reason);
		for(new i = 0; i <= 1000; i++)
			if(IsPlayerConnected(i) && PlayerInfo[i][pFaction] == 11)
				SCM(i, -1, string);	

	}
	return 1; 
}
CMD:service(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		new type[16];
		if(sscanf(params, "s[16]", type))
		{
			SendClientMessage(playerid, COLOR_GREY,"Sintaxa: {FFFFFF}/service <type>");
			return SCM(playerid, COLOR_GREY, "taxi medic license");
		}
		new id = 0;
		if(!strcmp(type, "taxi" , true)) id = 1;
		if(!strcmp(type, "medic" , true)) id = 2;
		if(!strcmp(type, "license" , true)) id = 3;
		if(id == 0)
		{
			SendClientMessage(playerid, COLOR_GREY,"Sintaxa: {FFFFFF}/service <type>");
			return SCM(playerid, COLOR_GREY, "taxi medic license");
		}
		if(id == 1)
		{
			for(new i = 1; i <= nrTPC; i++)
				if(TaxiPComandsID[i] == playerid) return SCM(playerid, COLOR_GREY, "**Ai comandat deja un taxi, asteapta pana se va elibare unul.");
			nrTPC++;
			TaxiPComandsID[nrTPC] = playerid;
			new string[256];
			format(string, sizeof(string), "{f4eb42}[Taxi] {68dbff}%s a comandat un taxi. Foloseste comanda /accepttaxi pentru a accepta comanda.", GetName(playerid));
			for(new i = 0; i <= MAX_PLAYERS; i++)
				if(IsPlayerConnected(i) && PlayerInfo[i][pFaction] == 13)
					SCM(i, -1, string);
			RemoveTPCtimer[playerid] = SetTimerEx("ResetTaxiComanda", 60000, false, "u", playerid);
		}
		CanUseService[playerid] = 1;
		SetTimerEx("ResetService", 30000, false, "u", playerid);
	}
	return 1;
}
CMD:canceltaxi(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		new motiv[32];
		if(sscanf(params, "s[32]", motiv)) return SendClientMessage(playerid, COLOR_GREY,"Sintaxa: {FFFFFF}/canceltaxi <reason>");
		for(new i = 0; i <= MAX_PLAYERS; i++)
			if(IsPlayerConnected(playerid))
				if(PlayerInfo[i][pFaction] == 13 && TaxiPlayerC[i] == playerid)
				{
					TaxiPlayerC[i] = -1;
		    		KillTimer(RemoveTPtimer[i]);
					ResetTaxiTimer(i);
					new string[256];
					format(string, sizeof(string), "{f4eb42}[Taxi] {68dbff}Clientul %s a anulat comanda. Reason: %s", GetName(playerid), motiv);
					for(new j = 0; j <= MAX_PLAYERS; j++)
						if(IsPlayerConnected(j) && PlayerInfo[j][pFaction] == 13)
							SCM(j, -1, string);
					SCM(playerid, COLOR_GREY, "!!Ai anulat comanda cu succes.");
					DisablePlayerCheckpoint(i);
					CP[i][ID] = 0;
					return 1;
				}
	}
	return 1;
}
CMD:accepttaxi(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pFaction] != 13) return SCM(playerid, COLOR_GREY, "**Nu ai acces la aceasta comanda, #JOSUBER :))");
		if(TaxiFare[playerid] == 0) return SCM(playerid, COLOR_GREY, "**Nu esti On-Duty.");
		if(TaxiPlayerC[playerid] != -1) return SCM(playerid, COLOR_GREY, "**Nu mai poti folosi aceasta comanda, asteapta 60s sau anuleaza comanda.");
		if(CP[playerid][ID] != 0) return SCM(playerid, COLOR_GREY, "**Ai un checkpoint activ. Foloseste comanda /killcp pentru a anula CheckPointul.");
		while(nrTPC != 0 && TaxiPComandsID[nrTPC] == -1)
		{
			nrTPC--;
		}
		if(nrTPC == 0) return SCM(playerid, COLOR_GREY, "Ne cerem scuze, nu exista comenzi de taxi.");
		new clientid = TaxiPComandsID[nrTPC];
		TaxiPComandsID[nrTPC] = -1;
		nrTPC--;
		TaxiPlayerC[playerid] = clientid;
		new string[256];
		format(string, sizeof(string), "**Ai acceptat comanda jucatorului %s. Ti-am setat un CheckPoint la locatia clientului. Foloseste comanda /killcp pentru a anula CheckPointul.", GetName(clientid));
		SCM(playerid, COLOR_LIGHTBLUE, string);
		format(string, sizeof(string), "**Taximetristul %s ti-a acceptat comanda. Folosesta comanda /canceltaxi pentru a anula comanda.", GetName(playerid));
		SCM(clientid, COLOR_LIGHTBLUE, string);
		new Float:clx, Float:cly, Float:clz;
		GetPlayerPos(clientid, clx, cly, clz);
		SetPlayerCheckpoint(playerid, clx, cly, clz, 4);
		CP[playerid][ID] = 4;
		RemoveTPtimer[playerid] = SetTimerEx("ResetTaxiTimer", 60000, false, "u", playerid);

	}
	return 1;
}
function ResetTaxiTimer(playerid)
{
	RemoveTPtimer[playerid] = 0;
	TaxiPlayerC[playerid] = -1;
	return 1;
}
CMD:depune(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(IsPlayerInRangeOfPoint(playerid, 3, 2026.9764,1007.7463,10.8203) || IsPlayerInRangeOfPoint(playerid, 5, 2158.0566,-1454.6040,25.5391) || IsPlayerInRangeOfPoint(playerid, 5, 2493.7822,-1666.7747,13.3438) || IsPlayerInRangeOfPoint(playerid, 5, 2769.2451,-1945.1285,13.3734) || IsPlayerInRangeOfPoint(playerid, 5, 680.9553,-1276.6500,13.5836) ||  IsPlayerInRangeOfPoint(playerid, 5, -2192.0007,641.5342,49.4375))
		{
			if(!IsGang(playerid)) return SCM(playerid, COLOR_GREY, "Nu esti in mafie/gang");
			new type[16], amount;
			if(sscanf(params, "s[16]i", type, amount)) return SendClientMessage(playerid, COLOR_GREY,"Sintaxa: {FFFFFF}/depune <drugs/mats> <value>");
			new id = 0;
			if(!strcmp(type, "drugs" , true)) id = 1;
			if(!strcmp(type, "mats" , true)) id = 2;
			if(id == 0) return SendClientMessage(playerid, COLOR_GREY,"Sintaxa: {FFFFFF}/depune <drugs/mats> <value>");
			new string[256];
			if(id == 1)
			{
				if(amount > PlayerInfo[playerid][pDrugs] || amount  < 0) return SCM(playerid, COLOR_GREY, "Alege o suma valida.");
				PlayerInfo[playerid][pDrugs] -= amount;
				PlayerInfo[playerid][pSeifDrugs] += amount;
				format(string, sizeof(string), "{001d4c}* Ai depus {808182}%d {001d4c}droguri.", amount);
				SCM(playerid, -1, string);
			}
			if(id == 2)
			{
				if(amount > PlayerInfo[playerid][pMats] || amount  < 0) return SCM(playerid, COLOR_GREY, "Alege o suma valida.");
				PlayerInfo[playerid][pMats] -= amount;
				PlayerInfo[playerid][pSeifMats] += amount;
				format(string, sizeof(string), "{001d4c}* Ai depus {808182}%d {001d4c}materiale.", amount);
				SCM(playerid, -1, string);
			}
			
		}
	}
	return 1;
}
CMD:retrage(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(IsPlayerInRangeOfPoint(playerid, 3, 2026.9764,1007.7463,10.8203) || IsPlayerInRangeOfPoint(playerid, 5, 2158.0566,-1454.6040,25.5391) || IsPlayerInRangeOfPoint(playerid, 5, 2493.7822,-1666.7747,13.3438) || IsPlayerInRangeOfPoint(playerid, 5, 2769.2451,-1945.1285,13.3734) || IsPlayerInRangeOfPoint(playerid, 5, 680.9553,-1276.6500,13.5836) || IsPlayerInRangeOfPoint(playerid, 5, -2192.0007,641.5342,49.4375))
		{
			if(!IsGang(playerid)) return SCM(playerid, COLOR_GREY, "Nu esti in mafie/gang");
			new type[16], amount;
			if(sscanf(params, "s[16]i", type, amount)) return SendClientMessage(playerid, COLOR_GREY,"Sintaxa: {FFFFFF}/retrage <drugs/mats> <value>");
			new id = 0;
			if(!strcmp(type, "drugs" , true)) id = 1;
			if(!strcmp(type, "mats" , true)) id = 2;
			if(id == 0) return SendClientMessage(playerid, COLOR_GREY,"Sintaxa: {FFFFFF}/retrage <drugs/mats> <value>");
			new string[256];
			if(id == 1)
			{
				if(amount > PlayerInfo[playerid][pSeifDrugs] || amount  < 0) return SCM(playerid, COLOR_GREY, "Alege o suma valida.");
				PlayerInfo[playerid][pDrugs] += amount;
				PlayerInfo[playerid][pSeifDrugs] -= amount;
				format(string, sizeof(string), "{001d4c}* Ai retras {808182}%d {001d4c}droguri.", amount);
				SCM(playerid, -1, string);
			}
			if(id == 2)
			{
				if(amount > PlayerInfo[playerid][pSeifMats] || amount  < 0) return SCM(playerid, COLOR_GREY, "Alege o suma valida.");
				PlayerInfo[playerid][pMats] += amount;
				PlayerInfo[playerid][pSeifMats] -= amount;
				format(string, sizeof(string), "{001d4c}* Ai retras {808182}%d {001d4c}materiale.", amount);
				SCM(playerid, -1, string);
			}
			
		}
	}
	return 1;
}
CMD:attack(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pRFaction] < 4 || !IsGang(playerid)) return SCM(playerid, COLOR_GREY, "Nu ai acces la aceasta comanda!");
		new ZoneID;
		ZoneID = CheckPlayerTurfZone(playerid);
		///De verificat aliantele
		if(ZoneID == 0) return SCM(playerid, COLOR_GREY, "Nu te afli intr-o zona de war");
		if(CanTurf[ PlayerInfo[playerid][pFaction] ] != 0 || CanTurf[TurfsInfo[ZoneID][tOwnerID]] != 0)	return SCM(playerid, COLOR_GREY, "Nu poti ataca acel teritoriu.");
		new AttackerID, DefeadID;
		AttackerID = PlayerInfo[playerid][pFaction]; 
		DefeadID = TurfsInfo[ZoneID][tOwnerID];
		new a1, a2;
		if(AttackerID <= 6 && AttackerID >= 4) a1 = 1;
		else a1 = 2;
		if(DefeadID <= 6 && DefeadID >= 4) a2 = 1;
		else a2 = 2;
		if(a1 == a2) return SCM(playerid, COLOR_GREY, "Nu poti ataca un teritoriu detinut de alianta.");
		if(AttackerID == DefeadID) return SCM(playerid, COLOR_GREY, "Deja detii acest teritoriu.");
		CanTurf[AttackerID] = 1;
		CanTurf[DefeadID] = 1;
		FactionTurf[AttackerID] = ZoneID;
		FactionTurf[DefeadID] = ZoneID;
		new string[256];
		//new var;
		format(string, sizeof(string), "Teritoriul va este atacat de catre %s, folositi comanda /defend in urmatoarele 2min, daca nu teritoriul va fi pierdut.",PlayerInfo[playerid][pFacName]);
		for(new i = 0; i <= MAX_PLAYERS; i++)
			if(IsPlayerConnected(i) && PlayerInfo[i][pFaction] == DefeadID)
			{
				SendClientMessage(i, COLOR_LIGHTSKYBLUE, string);
				//var = i;
			}
		TurfTimer[AttackerID] = TurfTimer[DefeadID] = SetTimerEx("DefeadTurf", 120000, false, "ii", AttackerID, DefeadID);

	}
	return 1;
}
function TCreateCars(Faction1, Faction2, turfVW)
{
	new Float:x, Float:y, Float:z, Float:r;
	new City, AllianceF1, AllianceF2;
	if(Faction1 >= 4 && Faction1 <= 6) AllianceF1 = 1;
	    	else AllianceF1 = 2;
	if(Faction2 >= 4 && Faction2 <= 6) AllianceF2 = 1;
	    	else AllianceF2 = 2;
	City = TurfsInfo[FactionTurf[Faction1]][tCity];
	new var;
	if(AllianceF1 != 1)
	{
		AllianceF1 = 1;
		var = AllianceF2;
		AllianceF2 = 2;
		var = Faction1;
		Faction1 = Faction2;
		Faction2 = var;
	}
	//fac1
	x = TurfCarPos1[City][1][tX]; y = TurfCarPos1[City][1][tY]; z = TurfCarPos1[City][1][tZ]; r = TurfCarPos1[City][1][tR];
	TurfCarID[Faction1][1] = CreateVehicle(560, x, y, z, r, TurfCarColor[Faction1], TurfCarColor[Faction1], -1);
	
	x = TurfCarPos1[City][2][tX]; y = TurfCarPos1[City][2][tY]; z = TurfCarPos1[City][2][tZ]; r = TurfCarPos1[City][2][tR];
	TurfCarID[Faction1][2] = CreateVehicle(560, x, y, z, r, TurfCarColor[Faction1], TurfCarColor[Faction1], -1);

	x = TurfCarPos1[City][3][tX]; y = TurfCarPos1[City][3][tY]; z = TurfCarPos1[City][3][tZ]; r = TurfCarPos1[City][3][tR];
	TurfCarID[Faction1][3] = CreateVehicle(560, x, y, z, r, TurfCarColor[Faction1], TurfCarColor[Faction1], -1);

	x = TurfCarPos1[City][4][tX]; y = TurfCarPos1[City][4][tY]; z = TurfCarPos1[City][4][tZ]; r = TurfCarPos1[City][4][tR];
	TurfCarID[Faction1][4] = CreateVehicle(560, x, y, z, r, TurfCarColor[Faction1], TurfCarColor[Faction1], -1);

	x = TurfCarPos1[City][5][tX]; y = TurfCarPos1[City][5][tY]; z = TurfCarPos1[City][5][tZ]; r = TurfCarPos1[City][5][tR];
	TurfCarID[Faction1][5] = CreateVehicle(560, x, y, z, r, TurfCarColor[Faction1], TurfCarColor[Faction1], -1);

	x = TurfCarPos1[City][6][tX]; y = TurfCarPos1[City][6][tY]; z = TurfCarPos1[City][6][tZ]; r = TurfCarPos1[City][6][tR];
	TurfCarID[Faction1][6] = CreateVehicle(560, x, y, z, r, TurfCarColor[Faction1], TurfCarColor[Faction1], -1);
	///fac2*/

	x = TurfCarPos2[City][1][tX]; y = TurfCarPos2[City][1][tY]; z = TurfCarPos2[City][1][tZ]; r = TurfCarPos2[City][1][tR];
	TurfCarID[Faction2][1] = CreateVehicle(560, x, y, z, r, TurfCarColor[Faction2], TurfCarColor[Faction2], -1);

	x = TurfCarPos2[City][2][tX]; y = TurfCarPos2[City][2][tY]; z = TurfCarPos2[City][2][tZ]; r = TurfCarPos2[City][2][tR];
	TurfCarID[Faction2][2] = CreateVehicle(560, x, y, z, r, TurfCarColor[Faction2], TurfCarColor[Faction2], -1);

	x = TurfCarPos2[City][3][tX]; y = TurfCarPos2[City][3][tY]; z = TurfCarPos2[City][3][tZ]; r = TurfCarPos2[City][3][tR];
	TurfCarID[Faction2][3] = CreateVehicle(560, x, y, z, r, TurfCarColor[Faction2], TurfCarColor[Faction2], -1);

	x = TurfCarPos2[City][4][tX]; y = TurfCarPos2[City][4][tY]; z = TurfCarPos2[City][4][tZ]; r = TurfCarPos2[City][4][tR];
	TurfCarID[Faction2][4] = CreateVehicle(560, x, y, z, r, TurfCarColor[Faction2], TurfCarColor[Faction2], -1);

	x = TurfCarPos2[City][5][tX]; y = TurfCarPos2[City][5][tY]; z = TurfCarPos2[City][5][tZ]; r = TurfCarPos2[City][5][tR];
	TurfCarID[Faction2][5] = CreateVehicle(560, x, y, z, r, TurfCarColor[Faction2], TurfCarColor[Faction2], -1);

	x = TurfCarPos2[City][6][tX]; y = TurfCarPos2[City][6][tY]; z = TurfCarPos2[City][6][tZ]; r = TurfCarPos2[City][6][tR];
	TurfCarID[Faction2][6] = CreateVehicle(560, x, y, z, r, TurfCarColor[Faction2], TurfCarColor[Faction2], -1);
	///VW
	SetVehicleVirtualWorld(TurfCarID[Faction1][1], turfVW);
	SetVehicleVirtualWorld(TurfCarID[Faction1][2], turfVW);
	SetVehicleVirtualWorld(TurfCarID[Faction1][3], turfVW);
	SetVehicleVirtualWorld(TurfCarID[Faction1][4], turfVW);
	SetVehicleVirtualWorld(TurfCarID[Faction1][5], turfVW);
	SetVehicleVirtualWorld(TurfCarID[Faction1][6], turfVW);

	SetVehicleVirtualWorld(TurfCarID[Faction2][1], turfVW);
	SetVehicleVirtualWorld(TurfCarID[Faction2][2], turfVW);
	SetVehicleVirtualWorld(TurfCarID[Faction2][3], turfVW);
	SetVehicleVirtualWorld(TurfCarID[Faction2][4], turfVW);
	SetVehicleVirtualWorld(TurfCarID[Faction2][5], turfVW);
	SetVehicleVirtualWorld(TurfCarID[Faction2][6], turfVW);
	return 1;
}
function TDestroyVehicle(Faction1, Faction2)
{
	DestroyVehicle(TurfCarID[Faction1][1]);
	DestroyVehicle(TurfCarID[Faction1][2]);
	DestroyVehicle(TurfCarID[Faction1][3]);
	DestroyVehicle(TurfCarID[Faction1][4]);
	DestroyVehicle(TurfCarID[Faction1][5]);
	DestroyVehicle(TurfCarID[Faction1][6]);

	DestroyVehicle(TurfCarID[Faction2][1]);
	DestroyVehicle(TurfCarID[Faction2][2]);
	DestroyVehicle(TurfCarID[Faction2][3]);
	DestroyVehicle(TurfCarID[Faction2][4]);
	DestroyVehicle(TurfCarID[Faction2][5]);
	DestroyVehicle(TurfCarID[Faction2][6]);
	return 1;
}
CMD:getcar(playerid,params[])
{
	if(IsPlayerConnected(playerid))
	{
		new carid, virtual; new Float:xxx , Float:yyy, FLoat:zzz;
		
		GetPlayerPos(playerid, Float:xxx, Float:yyy, Float:zzz);
		
		virtual = GetPlayerVirtualWorld(playerid);
		if(sscanf(params, "i", carid)) return SendClientMessage(playerid, COLOR_GREY,"Sintaxa: {FFFFFF}/getcar <carid>");
		SetVehiclePos(carid, Float:xxx, Float:yyy, Float:zzz);
		SetVehicleVirtualWorld(carid, virtual);
	}
	return 1;
}
CMD:defend(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
	    if(!IsGang(playerid) ) return SCM(playerid, COLOR_GREY, "Nu ai acces la aceasta comanda!");
	    if(CanTurf[PlayerInfo[playerid][pFaction]] != 1) return SCM(playerid, COLOR_GREY, "Teritoriile tale nu sunt amenintate");
		KillTimer(TurfTimer[PlayerInfo[playerid][pFaction]]);
		new fac1, fac2;
		fac2 = fac1 = PlayerInfo[playerid][pFaction];
		for(new i = 0; i <= 9; i++)
		    if(FactionTurf[i] == FactionTurf[fac1] && i != fac1)
		        fac2 = i;
		CanTurf[fac1] = 2; CanTurf[fac2] = 2;
		TurfsInfo[FactionTurf[fac1]][tStatus] = 1;
		TurfsInfo[FactionTurf[fac1]][tKills1] = 0; TurfsInfo[FactionTurf[fac1]][tKills2] = 0;
		new vw;
		vw = 2000 + fac1; 
		TurfsInfo[FactionTurf[fac1]][tVW] = vw;
		TurfsInfo[FactionTurf[fac1]][tTimer] = 1200;
		for(new i = 0; i <= MAX_PLAYERS; i++)
			if(IsPlayerConnected(i))
				if((PlayerInfo[i][pFaction] == fac1 || PlayerInfo[i][pFaction] == fac2) && CanJoinEvents(i) == 1 )
				    {
				    	if(TurfsOn[i] == 1)
				    	{
				    		if(fac2 == 4) GangZoneFlashForPlayer(i, TurfsInfo[FactionTurf[fac1]][tZoneID], COLOR_GROVE);
							else if(fac2 == 5) GangZoneFlashForPlayer(i, TurfsInfo[FactionTurf[fac1]][tZoneID], COLOR_LSV);
							else if(fac2 == 6) GangZoneFlashForPlayer(i, TurfsInfo[FactionTurf[fac1]][tZoneID], COLOR_TT);
							else if(fac2 == 7) GangZoneFlashForPlayer(i, TurfsInfo[FactionTurf[fac1]][tZoneID], COLOR_BALLAS);
							else if(fac2 == 8) GangZoneFlashForPlayer(i, TurfsInfo[FactionTurf[fac1]][tZoneID], COLOR_VLA);
							else if(fac2 == 9) GangZoneFlashForPlayer(i, TurfsInfo[FactionTurf[fac1]][tZoneID], COLOR_TM);
					    }
				    	SCM(i, COLOR_TURQUOISE, "Turf-ul a inceput");
				    	///aici pun pentru txd afisare
				    	Slap(i);
						SpawnPlayer(i);
				    }
		TCreateCars(fac1, fac2, vw);
		TurfsInfo[FactionTurf[fac1]][tFac1] = fac1;
		TurfsInfo[FactionTurf[fac1]][tFac2] = fac2;

	}
	return 1;
}
CMD:eject(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_GREY, "Nu esti intr-o masina.");
		if(GetPlayerVehicleSeat(playerid) != 0) return SCM(playerid, COLOR_GREY, "Trebuie sa fii soferul masinii.");
		new ejectid;
		if(sscanf(params, "u", ejectid)) return SendClientMessage(playerid, COLOR_GREY,"Sintaxa: {FFFFFF}/eject <playerid/name>");
		if(!IsPlayerConnected(ejectid)) return SCM(playerid, COLOR_GREY, "Jucatorul nu este conectat.");
		if(GetPlayerVehicleID(ejectid) != GetPlayerVehicleID(playerid)) return SCM(playerid, COLOR_GREY, "Acel jucator nu este in masina cu tine.");
		Slap(ejectid);
		SCM(ejectid, COLOR_GREY, "Ai fost dat afara din masina.");
	}
	return 1;
}
new Float:mX, Float: mY, Float: mmX, Float:mmY;//max min
CMD:tpos1(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		new Float:z;
		GetPlayerPos(playerid, mX, mY, z);
		SendClientMessage(playerid, COLOR_INACTIVEBORDER, "Done pos1");
	}
	return 1;
}
CMD:tpos2(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		new ownerid, city;
		if(sscanf(params, "ii", ownerid, city)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/tpos2 <ownerid> <city>");
		new Float:var, Float:z;
		GetPlayerPos(playerid, mmX, mmY, z);
		if(mX < mmX)
		{
			var = mX;
			mX = mmX;
			mmX = var;
		}
		if(mY < mmY)
		{
			var = mY;
			mY = mmY;
			mmY = var;
		}
		new string[256];
		TurfsNumber++;
		format(string, sizeof(string), "INSERT INTO `turfinfo`(`ID`, `OwnerID`, `City`, `MaxX`, `MaxY`, `MinX`, `MinY`) VALUES (%d, %d, %d, %f, %f, %f, %f)", TurfsNumber, ownerid, city, mX, mY, mmX, mmY);
		mysql_query(handle,string);
		SendClientMessage(playerid, COLOR_INACTIVEBORDER, "Done pos2");
	}
	return 1;
}
CMD:turfs(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		new i;
		if(TurfsOn[playerid] == 0)
		{
			for(i = 1; i <= TurfsNumber; i++)
			{
				if(TurfsInfo[i][tOwnerID] == 4) 
				{
					GangZoneShowForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_GROVE);
					if(TurfsInfo[i][tStatus] == 1)
					{
						if(TurfsInfo[i][tFac2] == 4) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_GROVE);
						else if(TurfsInfo[i][tFac2] == 5) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_LSV);
						else if(TurfsInfo[i][tFac2] == 6) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_TT);
						else if(TurfsInfo[i][tFac2] == 7) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_BALLAS);
						else if(TurfsInfo[i][tFac2] == 8) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_VLA);
						else if(TurfsInfo[i][tFac2] == 9) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_TM);
					}
				}
				else if(TurfsInfo[i][tOwnerID] == 5) 
				{
					GangZoneShowForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_LSV);
					if(TurfsInfo[i][tStatus] == 1)
					{
						if(TurfsInfo[i][tFac2] == 4) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_GROVE);
						else if(TurfsInfo[i][tFac2] == 5) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_LSV);
						else if(TurfsInfo[i][tFac2] == 6) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_TT);
						else if(TurfsInfo[i][tFac2] == 7) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_BALLAS);
						else if(TurfsInfo[i][tFac2] == 8) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_VLA);
						else if(TurfsInfo[i][tFac2] == 9) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_TM);
					}
				}
				else if(TurfsInfo[i][tOwnerID] == 6) 
				{
					GangZoneShowForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_TT);
					if(TurfsInfo[i][tStatus] == 1)
					{
						if(TurfsInfo[i][tFac2] == 4) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_GROVE);
						else if(TurfsInfo[i][tFac2] == 5) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_LSV);
						else if(TurfsInfo[i][tFac2] == 6) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_TT);
						else if(TurfsInfo[i][tFac2] == 7) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_BALLAS);
						else if(TurfsInfo[i][tFac2] == 8) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_VLA);
						else if(TurfsInfo[i][tFac2] == 9) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_TM);
					}
				}
				else if(TurfsInfo[i][tOwnerID] == 7) 
				{
					GangZoneShowForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_BALLAS);
					if(TurfsInfo[i][tStatus] == 1)
					{
						if(TurfsInfo[i][tFac2] == 4) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_GROVE);
						else if(TurfsInfo[i][tFac2] == 5) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_LSV);
						else if(TurfsInfo[i][tFac2] == 6) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_TT);
						else if(TurfsInfo[i][tFac2] == 7) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_BALLAS);
						else if(TurfsInfo[i][tFac2] == 8) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_VLA);
						else if(TurfsInfo[i][tFac2] == 9) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_TM);
					}
				}
				else if(TurfsInfo[i][tOwnerID] == 8) 
				{
					GangZoneShowForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_VLA);
					if(TurfsInfo[i][tStatus] == 1)
					{
						if(TurfsInfo[i][tFac2] == 4) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_GROVE);
						else if(TurfsInfo[i][tFac2] == 5) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_LSV);
						else if(TurfsInfo[i][tFac2] == 6) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_TT);
						else if(TurfsInfo[i][tFac2] == 7) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_BALLAS);
						else if(TurfsInfo[i][tFac2] == 8) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_VLA);
						else if(TurfsInfo[i][tFac2] == 9) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_TM);
					}
				}
				else if(TurfsInfo[i][tOwnerID] == 9)
				{
					GangZoneShowForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_TM);
					if(TurfsInfo[i][tStatus] == 1)
					{
						if(TurfsInfo[i][tFac2] == 4) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_GROVE);
						else if(TurfsInfo[i][tFac2] == 5) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_LSV);
						else if(TurfsInfo[i][tFac2] == 6) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_TT);
						else if(TurfsInfo[i][tFac2] == 7) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_BALLAS);
						else if(TurfsInfo[i][tFac2] == 8) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_VLA);
						else if(TurfsInfo[i][tFac2] == 9) GangZoneFlashForPlayer(playerid, TurfsInfo[i][tZoneID], COLOR_TM);
					}
				}
				
			}
			TurfsOn[playerid] = 1;
		}
		else 
		{
			TurfsOn[playerid] = 0;
			for(i = 1; i <= TurfsNumber; i++)
				GangZoneHideForPlayer(playerid, TurfsInfo[i][tZoneID]);
		}
	}
	return 1;
}
//-------------[DEALERSHIP]-----------------
function EmptyPersonalCarsPos()
{
	for(new i = 1; i <= 10000; i++)
		if(EmptyPersonalCars[i] == 0)
			return i;
	return 0;
}
function AddPersonalVehicle(playerid, model)
{
	new string[512];
	PCarMaxID++;
	new pos;
	pos = EmptyPersonalCarsPos();
	PVLock[pos][playerid] = 1;
	format(string, sizeof(string), "%d", pos);
	SendClientMessage(playerid, COLOR_GREY, string);
	EmptyPersonalCars[pos] = 1;
	PersonalCars[pos][OwnerID] = playerid;
	PersonalCars[pos][OwnerSQLID] = PlayerInfo[playerid][pID];
	PersonalCars[pos][ID] = PCarMaxID;
	PersonalCars[pos][Model] = model;
	new p;
	p = random(7);
	if(p == 0)
	{
		PersonalCars[pos][cX] = 2148.4468;
		PersonalCars[pos][cY] = -1133.9388;
		PersonalCars[pos][cZ] = 25.2429;
		PersonalCars[pos][cR] = 269.4610;
	}
	if(p == 1)
	{
		PersonalCars[pos][cX] = 2147.7200;
		PersonalCars[pos][cY] = -1148.0171;
		PersonalCars[pos][cZ] = 24.0868;
		PersonalCars[pos][cR] = 270.5531;
	}
	if(p == 2)
	{
		PersonalCars[pos][cX] = 2148.3953;
		PersonalCars[pos][cY] = -1170.7538;
		PersonalCars[pos][cZ] = 23.4608;
		PersonalCars[pos][cR] = 269.4610;
	}
	if(p == 3)
	{
		PersonalCars[pos][cX] = 2147.0317;
		PersonalCars[pos][cY] = -1185.0538;
		PersonalCars[pos][cZ] = 23.4667;
		PersonalCars[pos][cR] = 271.4962;
	}
	if(p == 4)
	{
		PersonalCars[pos][cX] = 2161.1345;
		PersonalCars[pos][cY] = -1148.2642;
		PersonalCars[pos][cZ] = 24.0598;
		PersonalCars[pos][cR] = 90.1110;
	}
	if(p == 5)
	{
		PersonalCars[pos][cX] = 2161.3110;
		PersonalCars[pos][cY] = -1163.0541;
		PersonalCars[pos][cZ] = 23.4925;
		PersonalCars[pos][cR] = 90.9162;
	}
	if(p == 6)
	{
		PersonalCars[pos][cX] = 2161.1428;
		PersonalCars[pos][cY] = -1183.0354;
		PersonalCars[pos][cZ] = 23.4634;
		PersonalCars[pos][cR] = 93.0243;
	}
	PersonalCars[pos][vX] = 0;
	PersonalCars[pos][vY] = 0;
	PersonalCars[pos][vZ] = 0;
	PersonalCars[pos][rX] = 0;
	PersonalCars[pos][rY] = 0;
	PersonalCars[pos][rZ] = 0;
	PersonalCars[pos][ObjectID] = 0;
	PersonalCars[pos][Vip] = 0; 
	format(PersonalCars[pos][Plate], 256, "New Car");
	format(PersonalCars[pos][VText], 256, "VIP NAME");
	format(PersonalCars[pos][VColor], 256, "ffffff");
	PersonalCars[pos][VStatus] = 0; 
	PersonalCars[pos][Color1] = 1;
	PersonalCars[pos][Color2] = 1;
	PersonalCars[pos][PaintJob] = -1;
	PersonalCars[pos][Mode1] = 0;
	PersonalCars[pos][Mode2] = 0;
	PersonalCars[pos][Mode3] = 0;
	PersonalCars[pos][Mode4] = 0;
	PersonalCars[pos][Mode5] = 0;
	PersonalCars[pos][Mode6] = 0;
	PersonalCars[pos][Mode7] = 0;
	PersonalCars[pos][Mode8] = 0;
	PersonalCars[pos][Mode9] = 0;
	PersonalCars[pos][Mode10] = 0;
	PersonalCars[pos][Mode11] = 0;
	PersonalCars[pos][Mode12] = 0;
	PersonalCars[pos][Mode13] = 0;
	PersonalCars[pos][Mode14] = 0;
	PersonalCars[pos][RainBow] = 0;
	PersonalCars[pos][RainBowI] = 0;
	for(new i = 0; i <= 9; i++)
		if(PlayerInfo[playerid][pCarPos][i] == 0)
    	{
    		PlayerInfo[playerid][pCarPos][i] = pos;
    		break;
    	}
    format(string, sizeof(string), "INSERT INTO `personalcars`(`ID`, `OwnerID`, `Model`, `X`, `Y`, `Z`, `R`,`Color1`, `Color2`, `PaintJob`, `Plate`) VALUES (%d,%d,%d,%f,%f,%f,%f,1,1,-1,'%s')", PCarMaxID, PlayerInfo[playerid][pID], model, PersonalCars[pos][cX], PersonalCars[pos][cY], PersonalCars[pos][cZ], PersonalCars[pos][cR], PersonalCars[pos][Plate]);
	mysql_query(handle,string);
	return 1;
}
CMD:check(playerid, params[])
{
	new string[256];
	new cars = 0;
	for(new i = 0; i <= 9; i++)
		if(PlayerInfo[playerid][pCarPos][i] > 0)
			cars++;
	format(string, sizeof(string), "Masini: %d, Id1 %d id2: %d",cars, PlayerInfo[playerid][pCarPos][0], PlayerInfo[playerid][pCarPos][1] );
	SendClientMessage(playerid, COLOR_GREY, string);
	return 1;
}
/*public OnPlayerPause(playerid)
{
	if(dsCarID[playerid] != 0)
	{
		TogglePlayerControllable(playerid, 1);
		SetCameraBehindPlayer(playerid);
		TextDrawHideForPlayer(playerid, DealerBox1[playerid]);
		TextDrawHideForPlayer(playerid, DealerBox2[playerid]);
		TextDrawHideForPlayer(playerid, DealerBox3[playerid]);
		TextDrawHideForPlayer(playerid, DealerBox4[playerid]);
		TextDrawHideForPlayer(playerid, DealerBox5[playerid]);
		TextDrawHideForPlayer(playerid, DealerModel[playerid]);
		TextDrawHideForPlayer(playerid, DealerName[playerid]);
		TextDrawHideForPlayer(playerid, DealerPrice[playerid]);
		TextDrawHideForPlayer(playerid, DealerPrice1[playerid]);
		TextDrawHideForPlayer(playerid, DealerSpeed[playerid]);
		TextDrawHideForPlayer(playerid, DealerStock[playerid]);
		TextDrawHideForPlayer(playerid, DealerCumpara[playerid]);
		TextDrawHideForPlayer(playerid, DealerAnuleaza[playerid]);
		TextDrawHideForPlayer(playerid, DealerInapoi[playerid]);
		TextDrawHideForPlayer(playerid, DealerInainte[playerid]);
		DestroyVehicle(dsCarID[playerid]);
		dsCarID[playerid] = 0;
		dsID[playerid] = 0;
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, 2131.7778,-1150.3885,24.1623);
		CancelSelectTextDraw(playerid);
	}
	return 1;
}*/
public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(clickedid == Text:INVALID_TEXT_DRAW)
	{
    	if(dsCarID[playerid] != 0)
		{
			TogglePlayerControllable(playerid, 1);
			SetCameraBehindPlayer(playerid);
			TextDrawHideForPlayer(playerid, DealerBox1[playerid]);
			TextDrawHideForPlayer(playerid, DealerBox2[playerid]);
			TextDrawHideForPlayer(playerid, DealerBox3[playerid]);
			TextDrawHideForPlayer(playerid, DealerBox4[playerid]);
			TextDrawHideForPlayer(playerid, DealerBox5[playerid]);
			TextDrawHideForPlayer(playerid, DealerModel[playerid]);
			TextDrawHideForPlayer(playerid, DealerName[playerid]);
			TextDrawHideForPlayer(playerid, DealerPrice[playerid]);
			TextDrawHideForPlayer(playerid, DealerPrice1[playerid]);
			TextDrawHideForPlayer(playerid, DealerSpeed[playerid]);
			TextDrawHideForPlayer(playerid, DealerStock[playerid]);
			TextDrawHideForPlayer(playerid, DealerCumpara[playerid]);
			TextDrawHideForPlayer(playerid, DealerAnuleaza[playerid]);
			TextDrawHideForPlayer(playerid, DealerInapoi[playerid]);
			TextDrawHideForPlayer(playerid, DealerInainte[playerid]);
			DestroyVehicle(dsCarID[playerid]);
			dsCarID[playerid] = 0;
			dsID[playerid] = 0;
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerPos(playerid, 2131.7778,-1150.3885,24.1623);
			CancelSelectTextDraw(playerid);
		}
  	}
	if(clickedid == DealerCumpara[playerid]) 
	{
		new selectedcar;
		selectedcar = dsID[playerid];
		///DE UPDATAT STOCK-UL
		if(PlayerInfo[playerid][pMoney] < DealerCars[selectedcar][Price]) return SCM(playerid, COLOR_GREY, "Nu ai destul bani ca sa cumperi acea masina.");
		if(DealerCars[selectedcar][Stock] == 0) return SCM(playerid, COLOR_GREY, "Acea masina nu mai este in stock.");
		new cars = 0;
		for(new i = 0; i <= 9; i++)
			if(PlayerInfo[playerid][pCarPos][i] > 0)
				cars++;
		if(cars >= PlayerInfo[playerid][pMaxCars]) return SCM(playerid, COLOR_GREY, "Ai atins numarul maxim de masini.");
		PlayerInfo[playerid][pMoney] -= DealerCars[selectedcar][Price];
		GivePlayerMoney(playerid, -DealerCars[selectedcar][Price]);
		Update(playerid, pMoney);
		DealerCars[selectedcar][Stock]--;
		new string[256];
		format(string, sizeof(string), "UPDATE `dscars` SET `Stock`=%d WHERE BINARY `ID`= BINARY %d", DealerCars[selectedcar][Stock], selectedcar);
		mysql_query(handle,string);
		AddPersonalVehicle(playerid, DealerCars[selectedcar][Model]);

		dsID[playerid] = 0;
		TogglePlayerControllable(playerid, 1);
		SetCameraBehindPlayer(playerid);
		TextDrawHideForPlayer(playerid, DealerBox1[playerid]);
		TextDrawHideForPlayer(playerid, DealerBox2[playerid]);
		TextDrawHideForPlayer(playerid, DealerBox3[playerid]);
		TextDrawHideForPlayer(playerid, DealerBox4[playerid]);
		TextDrawHideForPlayer(playerid, DealerBox5[playerid]);
		TextDrawHideForPlayer(playerid, DealerModel[playerid]);
		TextDrawHideForPlayer(playerid, DealerName[playerid]); 
		TextDrawHideForPlayer(playerid, DealerPrice[playerid]);
		TextDrawHideForPlayer(playerid, DealerPrice1[playerid]);
		TextDrawHideForPlayer(playerid, DealerSpeed[playerid]);
		TextDrawHideForPlayer(playerid, DealerStock[playerid]);
		TextDrawHideForPlayer(playerid, DealerCumpara[playerid]);
		TextDrawHideForPlayer(playerid, DealerAnuleaza[playerid]);
		TextDrawHideForPlayer(playerid, DealerInapoi[playerid]);
		TextDrawHideForPlayer(playerid, DealerInainte[playerid]);
		DestroyVehicle(dsCarID[playerid]);
		dsCarID[playerid] = 0;
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, 2131.7778,-1150.3885,24.1623);
		CancelSelectTextDraw(playerid);
	}
	if(clickedid == DealerAnuleaza[playerid]) 
	{
		TogglePlayerControllable(playerid, 1);
		SetCameraBehindPlayer(playerid);
		TextDrawHideForPlayer(playerid, DealerBox1[playerid]);
		TextDrawHideForPlayer(playerid, DealerBox2[playerid]);
		TextDrawHideForPlayer(playerid, DealerBox3[playerid]);
		TextDrawHideForPlayer(playerid, DealerBox4[playerid]);
		TextDrawHideForPlayer(playerid, DealerBox5[playerid]);
		TextDrawHideForPlayer(playerid, DealerModel[playerid]);
		TextDrawHideForPlayer(playerid, DealerName[playerid]);
		TextDrawHideForPlayer(playerid, DealerPrice[playerid]);
		TextDrawHideForPlayer(playerid, DealerPrice1[playerid]);
		TextDrawHideForPlayer(playerid, DealerSpeed[playerid]);
		TextDrawHideForPlayer(playerid, DealerStock[playerid]);
		TextDrawHideForPlayer(playerid, DealerCumpara[playerid]);
		TextDrawHideForPlayer(playerid, DealerAnuleaza[playerid]);
		TextDrawHideForPlayer(playerid, DealerInapoi[playerid]);
		TextDrawHideForPlayer(playerid, DealerInainte[playerid]);
		DestroyVehicle(dsCarID[playerid]);
		dsCarID[playerid] = 0;
		dsID[playerid] = 0;
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, 2131.7778,-1150.3885,24.1623);
		CancelSelectTextDraw(playerid);
	}
	if(clickedid == DealerInapoi[playerid])
	{
		dsID[playerid]--;
		if(dsID[playerid] == 0) dsID[playerid] = dsCars;
		UpdateDSTXD(playerid);
	} 
	if(clickedid == DealerInainte[playerid]) 
	{
		dsID[playerid]++;
		if(dsID[playerid] == dsCars + 1) dsID[playerid] = 1;
		UpdateDSTXD(playerid);
	}
	return 0;
}
function UpdateDSTXD(playerid)
{
	DestroyVehicle(dsCarID[playerid]);
	new modelid = DealerCars[dsID[playerid]][Model], id = dsID[playerid];
	dsCarID[playerid] = CreateVehicle(modelid, -1662.6661,1210.7771,6.9301,274.7026, 1, 1, -1);
	SetVehicleVirtualWorld(dsCarID[playerid], 12000 + playerid);

	new string[256];

	format(string, sizeof(string), VehicleNames[modelid-400]);
	TextDrawSetString(DealerName[playerid], string);
	TextDrawShowForPlayer(playerid, DealerName[playerid]);

	format(string, sizeof(string), "%d $", DealerCars[id][Price]);
	TextDrawSetString(DealerPrice1[playerid], string);
	TextDrawShowForPlayer(playerid, DealerPrice1[playerid]);

	format(string, sizeof(string), "Speed: %dkm/h", DealerCars[id][Speed]);
	TextDrawSetString(DealerSpeed[playerid], string);
	TextDrawShowForPlayer(playerid, DealerSpeed[playerid]);

	format(string, sizeof(string), "Stock: %d left", DealerCars[id][Stock]);
	TextDrawSetString(DealerStock[playerid], string);
	TextDrawShowForPlayer(playerid, DealerStock[playerid]);

	TextDrawSetPreviewModel(DealerModel[playerid], modelid);
	TextDrawShowForPlayer(playerid, DealerModel[playerid]);
}
function SpawnPersonalCar(playerid)
{
	new pos = MyCarID[playerid], vehid;
	if(PersonalCars[pos][Spawned] == 1) return SCM(playerid, COLOR_GREY, "Masina este deja spawnata.");
	vehid = CreateVehicle(PersonalCars[pos][Model], PersonalCars[pos][cX], PersonalCars[pos][cY], PersonalCars[pos][cZ], PersonalCars[pos][cR], PersonalCars[pos][Color1], PersonalCars[pos][Color2], -1);
	PaintJobP[vehid] = -1;
	PColor1[vehid] = PersonalCars[pos][Color1];
	PColor2[vehid] = PersonalCars[pos][Color2];
	PersonalCars[pos][CarID] = vehid;
	PersonalSCars[vehid] = pos;
	PersonalCars[pos][Spawned] = 1;
	PersonalCars[pos][Timer] = 900;
	AddVehicleComponent(vehid, PersonalCars[pos][Mode1]);
	AddVehicleComponent(vehid, PersonalCars[pos][Mode2]);
	AddVehicleComponent(vehid, PersonalCars[pos][Mode3]);
	AddVehicleComponent(vehid, PersonalCars[pos][Mode4]);
	AddVehicleComponent(vehid, PersonalCars[pos][Mode5]);
	AddVehicleComponent(vehid, PersonalCars[pos][Mode6]);
	AddVehicleComponent(vehid, PersonalCars[pos][Mode7]);
	AddVehicleComponent(vehid, PersonalCars[pos][Mode8]);
	AddVehicleComponent(vehid, PersonalCars[pos][Mode9]);
	AddVehicleComponent(vehid, PersonalCars[pos][Mode10]);
	AddVehicleComponent(vehid, PersonalCars[pos][Mode11]);
	AddVehicleComponent(vehid, PersonalCars[pos][Mode12]);
	AddVehicleComponent(vehid, PersonalCars[pos][Mode13]);
	AddVehicleComponent(vehid, PersonalCars[pos][Mode14]);
	ChangeVehiclePaintjob(vehid, PersonalCars[pos][PaintJob]);
	SetVehicleNumberPlate(vehid, PersonalCars[pos][Plate]);
	PersonalCars[pos][RainBowI] = 0;
	return 1;
}
function DespawnPersonalCar(playerid)
{
	new pos = MyCarID[playerid], vehid;
	if(PersonalCars[pos][Spawned] == 0) return SCM(playerid, COLOR_GREY, "Masina este deja despawnata.");
	vehid = PersonalCars[pos][CarID];
	PersonalCars[pos][CarID] = 0;
	PersonalSCars[vehid] = 0;
	PersonalCars[pos][Spawned] = 0;
	PersonalCars[pos][Timer] = 0;
	PersonalCars[pos][RainBowI] = 0;
	if(PersonalCars[pos][VStatus] == 1) DestroyObject(PersonalCars[pos][ObjectID]);
	PersonalCars[pos][VStatus] = 0;
	DestroyVehicle(vehid);
	return 1;
}
function UpdatePersonalCar(playerid)
{
	new pos = MyCarID[playerid], vehid;
	vehid = PersonalCars[pos][CarID];
	PersonalCars[pos][Mode1] = GetVehicleComponentInSlot(vehid, 0);
	PersonalCars[pos][Mode2] = GetVehicleComponentInSlot(vehid, 1);
	PersonalCars[pos][Mode3] = GetVehicleComponentInSlot(vehid, 2);
	PersonalCars[pos][Mode4] = GetVehicleComponentInSlot(vehid, 3);
	PersonalCars[pos][Mode5] = GetVehicleComponentInSlot(vehid, 4);
	PersonalCars[pos][Mode6] = GetVehicleComponentInSlot(vehid, 5);
	PersonalCars[pos][Mode7] = GetVehicleComponentInSlot(vehid, 6);
	PersonalCars[pos][Mode8] = GetVehicleComponentInSlot(vehid, 7);
	PersonalCars[pos][Mode9] = GetVehicleComponentInSlot(vehid, 8);
	PersonalCars[pos][Mode10] = GetVehicleComponentInSlot(vehid, 9);
	PersonalCars[pos][Mode11] = GetVehicleComponentInSlot(vehid, 10);
	PersonalCars[pos][Mode12] = GetVehicleComponentInSlot(vehid, 11);
	PersonalCars[pos][Mode13] = GetVehicleComponentInSlot(vehid, 12);
	PersonalCars[pos][Mode14] = GetVehicleComponentInSlot(vehid, 13);
	PersonalCars[pos][PaintJob] = PaintJobP[vehid];
	PersonalCars[pos][Color1] = PColor1[vehid];
	PersonalCars[pos][Color2] = PColor2[vehid];
	new mod1, mod2, mod3, mod4, mod5, mod6, mod7, mod8, mod9, mod10, mod11, mod12, mod13, mod14;
	mod1 = PersonalCars[pos][Mode1];
	mod2 = PersonalCars[pos][Mode2];
	mod3 = PersonalCars[pos][Mode3];
	mod4 = PersonalCars[pos][Mode4];
	mod5 = PersonalCars[pos][Mode5];
	mod6 = PersonalCars[pos][Mode6];
	mod7 = PersonalCars[pos][Mode7];
	mod8 = PersonalCars[pos][Mode8];
	mod9 = PersonalCars[pos][Mode9];
	mod10 = PersonalCars[pos][Mode10];
	mod11 = PersonalCars[pos][Mode11];
	mod12 = PersonalCars[pos][Mode12];
	mod13 = PersonalCars[pos][Mode13];
	mod14 = PersonalCars[pos][Mode14];
	new string[256];
	format(string, sizeof(string), "UPDATE `personalcars` SET `Mode1`=%d,`Mode2`=%d,`Mode3`=%d,`Mode4`=%d,`Mode5`=%d,`Mode6`=%d,`Mode7`=%d,`Mode8`=%d,`Mode9`=%d,`Mode10`=%d,`Mode11`=%d,`Mode12`=%d,`Mode13`=%d,`Mode14`=%d,`Color1`=%d,`Color2`=%d,`PaintJob`=%d WHERE BINARY ID= BINARY %d",mod1, mod2, mod3, mod4, mod5, mod6, mod7, mod8, mod9, mod10, mod11, mod12, mod13, mod14,PersonalCars[pos][Color1],PersonalCars[pos][Color2],PersonalCars[pos][PaintJob],PersonalCars[pos][ID]);
	mysql_query(handle,string);
}
CMD:givekey(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		new giverid;
		if(sscanf(params, "u", giverid)) return SendClientMessage(playerid, COLOR_GREY,"Sintaxa: {FFFFFF}/givekey <playerid/name>");
		if(!IsPlayerConnected(giverid)) return SCM(playerid, COLOR_GREY, "Acel jucator nu este online.");
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		if(!IsPlayerInRangeOfPoint(giverid, 10, x, y, z)) return SCM(playerid, COLOR_GREY, "Acel jucator nu este langa tine.");
		new vw = GetPlayerVirtualWorld(playerid);
		if(vw != GetPlayerVirtualWorld(giverid)) return SCM(playerid, COLOR_GREY, "Acel jucator nu este langa tine.");
		GivePSkey[playerid] = giverid;
		new string[256], pos, cars;
		for(new i = 0; i <= 9; i++)
			if(PlayerInfo[playerid][pCarPos][i] > 0)
			{
				cars++;
				pos = PlayerInfo[playerid][pCarPos][i];
				if(PersonalCars[pos][Spawned] == 1) 
				{
					format(string, sizeof(string), "%s%s\t{33AA33}Spawned\n", string, VehicleNames[PersonalCars[pos][Model]-400]);
				}
				else 
				{
					format(string, sizeof(string), "%s%s\t{FF0000}Despawned\n", string, VehicleNames[PersonalCars[pos][Model]-400]);
				}
			}
		if(cars == 0) return SCM(playerid, COLOR_GREY, "Nu ai masini.");
		ShowPlayerDialog(playerid, DIALOG_GIVEPKEY, DIALOG_STYLE_TABLIST, "My Cars", string, "Select", "Cancel");
	}
	return 1;
}
/*CMD:vipname(playerid, params[])
{
	if(IsPlayerConnected(playerid))
		if(IsPlayerInAnyVehicle(playerid))
		{
            new currentveh;
			currentveh = GetPlayerVehicleID(playerid);
			new Float:vehx, Float:vehy, Float:vehz;
			GetVehiclePos(currentveh, vehx, vehy, vehz);
			new objectid = CreateObject(19327, vehx,vehy,vehz, vehx,vehy,vehz);
			SetObjectMaterialText(objectid, "namemele", 0, 50, "Arial", 25, 1, 0xE60000FF, 0, 1);
			//AttachObjectToVehicle(objectid, currentveh, 0.0, -1.9, 0.3, 270.0, 0.0, 0.0);
		}﻿﻿               
	return 1;
}﻿
CMD:vipname(playerid, params[])
{
	if(IsPlayerConnected(playerid))
		if(IsPlayerInAnyVehicle(playerid))
		{
			new vehid;
			vehid = GetPlayerVehicleID(playerid);
			new Float:vx, Float:vy, Float:vz;
			GetVehiclePos(vehid, vx, vy, vz);
			new policecar2 = CreateObject(19327, vx, vy, vz, 0, 0, 0);
			SetObjectMaterialText(policecar2, "POLICE", 0, 50, "Arial", 25, 1, -16776216, 0, 1);
			///AttachObjectToVehicle(policecar2, vehid, 0.0, -1.9, 0.3, 270.0, 0.0, 0.0); // stanga dreapta || fata spate || sus jos || roteste (gen 90 grade) ||
			///EditObject(playerid, policecar2);
		}
	return 1;
}*/
CMD:sellcarto(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pEditVName] == 1) return SCM(playerid, COLOR_GREY, "Nu poti folosi aceasta comanda pana nu termini de editat VIP NAME.");
		if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_GREY, "Nu esti in masina.");
		if(GetPlayerVehicleSeat(playerid) != 0) return SCM(playerid, COLOR_GREY, "Trebuie sa conduci masina.");
		new vehicleid = GetPlayerVehicleID(playerid);
		new pos = PersonalSCars[vehicleid];
		if(PersonalCars[pos][OwnerSQLID] != PlayerInfo[playerid][pID]) return SCM(playerid, COLOR_GREY, "Masina nu iti apartine.");
		new model = GetVehicleModel(vehicleid);
		new giverid, price;
		if(sscanf(params, "ui", giverid, price)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/sellcarto <playerid/name> <price>");
		if(giverid == playerid) return SCM(playerid, COLOR_GREY, "Nu iti poti vinde masina tie.");
		if(price < 0) return SCM(playerid, COLOR_GREY, "Pretul masinii trebuie sa fie pozitiv.");
		if(!IsPlayerConnected(giverid)) return SCM(playerid, COLOR_GREY, "Jucatorul nu este conectat.");
		if(GetPlayerVehicleID(playerid) != GetPlayerVehicleID(giverid)) return SCM(playerid, COLOR_GREY, "Jucatorul nu este in masina cu tine.");
		SellingCarPos[playerid][giverid] = pos;
		SellingCarPrice[playerid][giverid] = price;
		new string[256], string1[256];
		format(string, sizeof(string), "{00e06c}!!Ai oferit jucatorului %s masina %s Color: %d/%d", GetName(giverid), VehicleNames[model-400], PersonalCars[pos][Color1], PersonalCars[pos][Color2]);
		format(string1, sizeof(string1), "{00e06c}!!Jucatorul %s ti-a oferit masina %s Color: %d/%d", GetName(playerid), VehicleNames[model-400], PersonalCars[pos][Color1], PersonalCars[pos][Color2]);
		if(PersonalCars[pos][RainBow] == 1) 
		{
			format(string, sizeof(string), "%s RainBow: Yes", string);
			format(string1, sizeof(string1), "%s RainBow: Yes", string1);
		}
		else 
		{
			format(string, sizeof(string), "%s RainBow: No", string);
			format(string1, sizeof(string1), "%s RainBow: No", string1);
		}
		if(PersonalCars[pos][Vip] == 1) 
		{
			format(string, sizeof(string), "%s VIP: Yes Price: %d $", string, price);
			format(string1, sizeof(string1), "%s VIP: Yes Price: %d $", string1, price);
		}
		else 
		{
			format(string, sizeof(string), "%s VIP: No Price: %d $", string, price);
			format(string1, sizeof(string1), "%s VIP: No Price: %d $", string1, price);
		}
		SCM(playerid, -1, string);
		SCM(playerid, -1, "{00e06c}!!Foloseste comanda /cancelsell pentru a anula vanzarea.");
		SCM(giverid, -1, string1);
		format(string1, sizeof(string1), "{00e06c}!!Foloseste comanda /acceptcar %d %d %d", playerid, model, price);
		SCM(giverid, -1, string1);
		SCM(giverid, -1, " ");
	}
	return 1;
}
CMD:cancelsell(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		for(new i = 0; i <= 1000; i++)
		{
			SellingCarPos[playerid][i] = 0;
			SellingCarPrice[playerid][i] = 0;
		}	
		SCM(playerid, -1, "{00e06c}!!Ai anulat toate ofertele recente.");
	}
	return 1;
}
CMD:acceptcar(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		new giverid, model, price;
		if(sscanf(params, "iii", giverid, model, price)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/acceptcar <playerid> <model> <price>");
		if(!IsPlayerConnected(giverid)) return SCM(playerid, COLOR_GREY, "Jucatorul nu este conectat.");

		if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_GREY, "Nu esti in masina.");
		if(GetPlayerVehicleSeat(playerid) == 0) return SCM(playerid, COLOR_GREY, "Trebuie sa fii pasager.");
		new vehicleid = GetPlayerVehicleID(playerid);
		if(!IsPlayerInAnyVehicle(giverid) || GetPlayerVehicleID(giverid) != vehicleid) return SCM(playerid, COLOR_GREY, "Jucatorul nu este in masina.");
		new pos = PersonalSCars[vehicleid];
		if(pos == 0) return SCM(playerid, COLOR_GREY, "Masina personala inexistenta.");
		if(SellingCarPos[giverid][playerid] == 0) return SCM(playerid, COLOR_GREY, "Oferta inexistenta.");
		if(SellingCarPos[giverid][playerid] != pos) return SCM(playerid, COLOR_GREY, "Nu esti in masina protrivita.");
		if(SellingCarPrice[giverid][playerid] != price) return SCM(playerid, COLOR_GREY, "Pretul masinii s-a schimbat.");
		if(PersonalCars[pos][Model] != model) return SCM(playerid, COLOR_GREY, "Oferta schimbata.");
		if(PlayerInfo[playerid][pMoney] < price) return SCM(playerid, COLOR_GREY, "Nu ai destui bani.");
		new cars = 1;
		for(new i = 0; i <= 9; i++)
			if(PlayerInfo[playerid][pCarPos][i] > 0)
				cars++;
		if(cars >= PlayerInfo[playerid][pMaxCars]) return SCM(playerid, COLOR_GREY, "Ai atins numarul maxim de masini.");
		for(new i = 0; i < 1001; i++)
			PVLock[pos][i] = 0;
		PVLock[pos][playerid] = 1;
		PersonalCars[pos][OwnerID] = playerid;
		PersonalCars[pos][OwnerSQLID] = PlayerInfo[playerid][pID];
		for(new i = 0; i <= 9; i++)
			if(PlayerInfo[playerid][pCarPos][i] == 0)
			{
				PlayerInfo[playerid][pCarPos][i] = pos;
				break;
			}
		Slap(giverid);
		PutPlayerInVehicle(playerid, vehicleid, 0);
		new string[256];
		format(string, sizeof(string), "UPDATE `personalcars` SET `OwnerID`=%d WHERE BINARY 'ID'= BINARY %d", PlayerInfo[playerid][pID], PersonalCars[pos][ID]);
		mysql_query(handle,string);
		GivePlayerMoney(playerid, -price);
		GivePlayerMoney(giverid, price);
		SCM(playerid, COLOR_GREY, "{0afa16}Masina cumparata cu succes.");
		SCM(giverid, COLOR_GREY, "{fa0a0a}Masina vanduta cu succes.");
	}
	return 1;
}
CMD:sellcartods(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(!IsPlayerInRangeOfPoint(playerid, 5, 2121.0017,-1131.1345,25.3776)) return SCM(playerid, COLOR_GREY, "Nu esti la dealership.");
		if(PlayerInfo[playerid][pEditVName] == 1) return SCM(playerid, COLOR_GREY, "Nu poti folosi aceasta comanda pana nu termini de editat VIP NAME.");
		if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_GREY, "Nu esti in masina.");
		if(GetPlayerVehicleSeat(playerid) != 0) return SCM(playerid, COLOR_GREY, "Trebuie sa conduci masina.");
		new vehicleid = GetPlayerVehicleID(playerid);
		new pos = PersonalSCars[vehicleid];
		if(PersonalCars[pos][OwnerSQLID] != PlayerInfo[playerid][pID]) return SCM(playerid, COLOR_GREY, "Masina nu iti apartine.");
		new model = GetVehicleModel(vehicleid);
		new dsid, price;
		for(new i = 0; i <= dsCars; i++)
			if(DealerCars[i][Model] == model)
			{
				dsid = i;
				price = DealerCars[i][Price];
				break;
			}
		DealerCars[dsid][Stock]++;

		new sqlid = PersonalCars[pos][ID];
		for(new i = 0; i < 1001; i++)
			PVLock[pos][i] = 0;
		for(new i = 0; i <= 9; i++)
			if(PlayerInfo[playerid][pCarPos][i] == pos)
				PlayerInfo[playerid][pCarPos][i] = 0;
		EmptyPersonalCars[pos] = 0;

		PersonalCars[pos][CarID] = 0;
		PersonalSCars[vehicleid] = 0;
		PersonalCars[pos][Spawned] = 0;
		PersonalCars[pos][Timer] = 0;
		PersonalCars[pos][RainBowI] = 0;
		if(PersonalCars[pos][VStatus] == 1) DestroyObject(PersonalCars[pos][ObjectID]);
		PersonalCars[pos][VStatus] = 0;
		DestroyVehicle(vehicleid);

		new string[256];
		format(string, sizeof(string), "DELETE FROM `personalcars` WHERE BINARY `ID`= BINARY %d", sqlid);
		mysql_query(handle,string);
		price = price * 25 / 100;
		format(string, sizeof(string), "**Ai vandut %s pentru %d $$", VehicleNames[model-400], price);
		SCM(playerid, COLOR_RED, string);
		format(string, sizeof(string), "{c10303}[AdmInfo] {f98484}Jucatorul %s a vandut %s pentru %d $$.", GetName(playerid), VehicleNames[model-400], price);
		for(new i = 0; i <= 1000; i++)
			if(IsPlayerConnected(i) && PlayerInfo[i][pAdmin] > 0)
				SCM(i, -1, string);
		GivePlayerMoney(playerid, price);
		PlayerInfo[playerid][pMoney] += price;
	}
	return 1;
}
CMD:factions(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		new fOm[15];
		for(new i = 0; i <= 1001; i++)
			if(IsPlayerConnected(i)) 
				fOm[PlayerInfo[i][pFaction]]++;
		new string[1280];
		format(string, sizeof(string), "{033dfc}Police Department\t{ffffff}Level: %d\tMembers: %d/%d {25d60d}(%d online)\n", FactionMembers[1][fMinLevel], FactionMembers[1][fTotalMembers], FactionMembers[1][fMaxMembers], fOm[1]);
		format(string, sizeof(string), "%s{240dd6}F.B.I\t{ffffff}Level: %d\tMembers: %d/%d {25d60d}(%d online)\n", string, FactionMembers[2][fMinLevel], FactionMembers[2][fTotalMembers], FactionMembers[2][fMaxMembers], fOm[2]);
		format(string, sizeof(string), "%s{140396}National Guard\t{ffffff}Level: %d\tMembers: %d/%d {25d60d}(%d online)\n", string, FactionMembers[3][fMinLevel], FactionMembers[3][fTotalMembers], FactionMembers[3][fMaxMembers], fOm[3]);
		format(string, sizeof(string), "%s{039632}Grove Street\t{ffffff}Level: %d\tMembers: %d/%d {25d60d}(%d online)\n", string, FactionMembers[4][fMinLevel], FactionMembers[4][fTotalMembers], FactionMembers[4][fMaxMembers], fOm[4]);
		format(string, sizeof(string), "%s{a5ab07}Los Santos Vagos\t{ffffff}Level: %d\tMembers: %d/%d {25d60d}(%d online)\n", string, FactionMembers[5][fMinLevel], FactionMembers[5][fTotalMembers], FactionMembers[5][fMaxMembers], fOm[5]);
		format(string, sizeof(string), "%s{662505}The Triads\t{ffffff}Level: %d\tMembers: %d/%d {25d60d}(%d online)\n", string, FactionMembers[6][fMinLevel], FactionMembers[6][fTotalMembers], FactionMembers[6][fMaxMembers], fOm[6]);
		format(string, sizeof(string), "%s{a10594}Ballas\t{ffffff}Level: %d\tMembers: %d/%d {25d60d}(%d online)\n", string, FactionMembers[7][fMinLevel], FactionMembers[7][fTotalMembers], FactionMembers[7][fMaxMembers], fOm[7]);
		format(string, sizeof(string), "%s{07dbeb}Varrios Los Aztecas\t{ffffff}Level: %d\tMembers: %d/%d {25d60d}(%d online)\n", string, FactionMembers[8][fMinLevel], FactionMembers[8][fTotalMembers], FactionMembers[8][fMaxMembers], fOm[8]);
		format(string, sizeof(string), "%s{d10812}The Mafia\t{ffffff}Level: %d\tMembers: %d/%d {25d60d}(%d online)\n", string, FactionMembers[9][fMinLevel], FactionMembers[9][fTotalMembers], FactionMembers[9][fMaxMembers], fOm[9]);
		format(string, sizeof(string), "%s{f77c8a}Medics\t{ffffff}Level: %d\tMembers: %d/%d {25d60d}(%d online)\n", string, FactionMembers[10][fMinLevel], FactionMembers[10][fTotalMembers], FactionMembers[10][fMaxMembers], fOm[10]);
		format(string, sizeof(string), "%s{aba9a9}Hitman\t{ffffff}Level: %d\tMembers: %d/%d {25d60d}(%d online)\n", string, FactionMembers[11][fMinLevel], FactionMembers[11][fTotalMembers], FactionMembers[11][fMaxMembers], fOm[11]);
		format(string, sizeof(string), "%s{ffa8a8}License Faction\t{ffffff}Level: %d\tMembers: %d/%d {25d60d}(%d online)\n", string, FactionMembers[12][fMinLevel], FactionMembers[12][fTotalMembers], FactionMembers[12][fMaxMembers], fOm[12]);
		format(string, sizeof(string), "%s{edc421}Taxi Company\t{ffffff}Level: %d\tMembers: %d/%d {25d60d}(%d online)\n", string, FactionMembers[13][fMinLevel], FactionMembers[13][fTotalMembers], FactionMembers[13][fMaxMembers], fOm[13]);
		format(string, sizeof(string), "%s{cca8ff}News Reporter\t{ffffff}Level: %d\tMembers: %d/%d {25d60d}(%d online)\n", string, FactionMembers[14][fMinLevel], FactionMembers[14][fTotalMembers], FactionMembers[14][fMaxMembers], fOm[14]);
		format(string, sizeof(string), "%s{ffffff}Infernus Club\tLevel: 4\n", string);
		format(string, sizeof(string), "%sNFS Club\tLevel: 4\n", string);
		format(string, sizeof(string), "%sBikers Club\tLevel: 4\n", string);
		ShowPlayerDialog(playerid, DIALOG_MYCARS, DIALOG_STYLE_TABLIST, "Factions", string, "OK", "");

	}
	return 1;
}
CMD:v(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pEditVName] == 1) return SCM(playerid, COLOR_GREY, "Nu poti accesa lista cu masinile personale pana nu termini de editat VIP NAME.");
		new string[256], pos, cars;
		for(new i = 0; i <= 9; i++)
			if(PlayerInfo[playerid][pCarPos][i] > 0)
			{
				cars++;
				pos = PlayerInfo[playerid][pCarPos][i];
				if(PersonalCars[pos][Spawned] == 1) 
				{
					new m, s;
					m = PersonalCars[pos][Timer] / 60;
					s = PersonalCars[pos][Timer] % 60;
					format(string, sizeof(string), "%s%s\t{33AA33}Spawned\t%d:%d\n", string, VehicleNames[PersonalCars[pos][Model]-400], m, s);
				}
				else 
				{
					format(string, sizeof(string), "%s%s\t{FF0000}Despawned\tN/A\n", string, VehicleNames[PersonalCars[pos][Model]-400]);
				}
			}
		if(cars == 0) return SCM(playerid, COLOR_GREY, "Nu ai masini.");
		ShowPlayerDialog(playerid, DIALOG_MYCARS, DIALOG_STYLE_TABLIST, "My Cars", string, "Select", "Cancel");
	}
	return 1;
}
CMD:buycar(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(IsPlayerInRangeOfPoint(playerid, 5, 2131.7778,-1150.3885,24.1623))
		{
			SetPlayerPos(playerid, -1658.2781,1222.6648,7.2500);
			TogglePlayerControllable(playerid, 0);
			SelectTextDraw(playerid, 0xffffffFF);
			TextDrawShowForPlayer(playerid, DealerBox1[playerid]);
			TextDrawShowForPlayer(playerid, DealerBox2[playerid]);
			TextDrawShowForPlayer(playerid, DealerBox3[playerid]);
			TextDrawShowForPlayer(playerid, DealerBox4[playerid]);
			TextDrawShowForPlayer(playerid, DealerBox5[playerid]);
			TextDrawShowForPlayer(playerid, DealerPrice[playerid]);
			TextDrawShowForPlayer(playerid, DealerCumpara[playerid]);
			TextDrawShowForPlayer(playerid, DealerAnuleaza[playerid]);
			TextDrawShowForPlayer(playerid, DealerInapoi[playerid]);
			TextDrawShowForPlayer(playerid, DealerInainte[playerid]);
			SetPlayerCameraPos(playerid, -1657.1593,1219.0881,8.4974);
			SetPlayerCameraLookAt(playerid, -1662.9868,1210.6738,8.7351);
			SetPlayerVirtualWorld(playerid, 12000 + playerid);
			dsID[playerid] = 1;
			new modelid = DealerCars[dsID[playerid]][Model], id = dsID[playerid];
			dsCarID[playerid] = CreateVehicle(modelid, -1662.6661,1210.7771,6.9301,274.7026, 1, 1, -1);
			SetVehicleVirtualWorld(dsCarID[playerid], 12000 + playerid);

			new string[256];

			format(string, sizeof(string), VehicleNames[modelid-400]);
			TextDrawSetString(DealerName[playerid], string);
			TextDrawShowForPlayer(playerid, DealerName[playerid]);

			format(string, sizeof(string), "%d $", DealerCars[id][Price]);
			TextDrawSetString(DealerPrice1[playerid], string);
			TextDrawShowForPlayer(playerid, DealerPrice1[playerid]);

			format(string, sizeof(string), "Speed: %dkm/h", DealerCars[id][Speed]);
			TextDrawSetString(DealerSpeed[playerid], string);
			TextDrawShowForPlayer(playerid, DealerSpeed[playerid]);

			format(string, sizeof(string), "Stock: %d left", DealerCars[id][Stock]);
			TextDrawSetString(DealerStock[playerid], string);
			TextDrawShowForPlayer(playerid, DealerStock[playerid]);

			TextDrawSetPreviewModel(DealerModel[playerid], modelid);
			TextDrawShowForPlayer(playerid, DealerModel[playerid]);
		}
	}
	return 1;
}
//-------------[HOUSE SYSTEM]---------------
CMD:fixcar(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pTypeHome] != 1) return SCM(playerid, COLOR_GREY, "Nu ai o casa");
		new bool:unwanted[CAR_AMOUNT];
		foreach(new player : Player)
	        if(IsPlayerInAnyVehicle(player))
				 	unwanted[GetPlayerVehicleID(player)]=true;
		if(unwanted[svHouse[PlayerInfo[playerid][pHouseID]][hVehID]] == false)
		{
			SetVehicleToRespawn(svHouse[PlayerInfo[playerid][pHouseID]][hVehID]);
			SCM(playerid, COLOR_WHITE, "House car respawned.");
		}	
		else SCM(playerid, COLOR_WHITE, "Vehiculul este folosit.");
	}
	return 1;
}
CMD:rentroom(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
		if(PlayerInfo[playerid][pVW] != 0) return 1;
		if(PlayerInfo[playerid][pWanted] != 0) return SCM(playerid,COLOR_GREY,"Ai wanted.");
		if(PlayerInfo[playerid][pHouseID] != 0) return SCM(playerid,COLOR_GREY,"Ai deja o casa / un rent.");
		new houseid=0;
		new Float:x;
		new Float:y;
		new Float:z;
		new i;
		GetPlayerPos(playerid,x,y,z);
		new ok=1;
		for(i=1;i<=HouseNumber && ok==1;i++)
		{
			if(IsPlayerInRangeOfPoint(playerid,2,svHouse[i][hX1],svHouse[i][hY1],svHouse[i][hZ1]) )
			{
				houseid=i;
				ok=0;
			}
		}
		if(houseid==0) return 1;
		if(svHouse[houseid][hOwned] == 0) return SCM(playerid,COLOR_GREY,"Casa nu are un proprietar . O poti cumpara folosind comanda /buyhouse.");
		if(PlayerInfo[playerid][pMoney] - svHouse[houseid][hRentPrice] < 0) return SCM(playerid,COLOR_GREY,"Nu ai destui bani.");
		PlayerInfo[playerid][pTypeHome] = 2;
		PlayerInfo[playerid][pSpawnType] = 1;
		PlayerInfo[playerid][pHouseID] = houseid;
		PlayerInfo[playerid][pMoney] -= svHouse[houseid][hRentPrice];
		GivePlayerMoney(playerid, -svHouse[houseid][hRentPrice]);
		Update(playerid,pTypeHome);
		Update(playerid,pHouseID);
		Update(playerid,pSpawnType);
		SCM(playerid,COLOR_GREY,"Ai inchiriat casa.");
	}
	return 1;
}
function ResetChangeSpawn(playerid)
{
	PlayerInfo[playerid][pChangeSpawnTimer] = 0;
	return 1;
}
CMD:changespawn(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pChangeSpawnTimer] == 1) return SCM(playerid,COLOR_GREY,"Poti schimba spawn-ul odata la 5 minute.");
		if(PlayerInfo[playerid][pHouseID] == 0) return SCM(playerid,COLOR_GREY,"Nu ai casa/rent.");
		PlayerInfo[playerid][pChangeSpawnTimer] = 1;
		if(PlayerInfo[playerid][pSpawnType] == 1) 
		{
			PlayerInfo[playerid][pSpawnType] = 0;
			SCM(playerid, COLOR_BLUE, "Spawn-ul tau a fost setat la factiune/spawn civil.");
		}
		else 
		{
			PlayerInfo[playerid][pSpawnType] = 1;
			SCM(playerid, COLOR_BLUE, "Spawn-ul tau a fost setat la casa/rent.");
		}
		SetTimerEx("ResetChangeSpawn",300000, false, "i", playerid);
		Update(playerid,pSpawnType);
	}
	return 1;
}
CMD:unrentroom(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pHouseID] == 0) return SCM(playerid,COLOR_GREY,"Nu ai rent.");
		if(PlayerInfo[playerid][pTypeHome] == 1) return SCM(playerid,COLOR_GREY,"Nu ai rent.");
		PlayerInfo[playerid][pTypeHome] = 0;
		PlayerInfo[playerid][pHouseID] = 0;
		PlayerInfo[playerid][pSpawnType] = 0;
		Update(playerid,pTypeHome);
		Update(playerid,pHouseID);
		Update(playerid,pSpawnType);
		SCM(playerid,COLOR_GREY,"You're now homeless..");
	}
	return 1;
}
function GetPlayerID(name[])
{
	new string[256];
	new n ;
	n=strlen(name);
	foreach(new i : Player)
	{
		format(string,sizeof(string),"%s",GetName(i));
		if(strcmp(string,name, false, n ) == 0 )
			return i;
	}
	return -1;
}
function ResetHouseInfo(x)
{
	new string[256];
	DestroyPickup(svHouse[x][hPickup]);
   	Delete3DTextLabel(svHouse[x][hTextID]);
	if(svHouse[x][hOwned] == 0)
        {
        	svHouse[x][hPickup] = CreatePickup(1273, 1,svHouse[x][hX1], svHouse[x][hY1],svHouse[x][hZ1] , 0);
        	format(string,sizeof(string),"{009933}House ID: {ffffff}%d\n{009933}Owner:{ffffff} The State\n{009933}Interior: {ffffff}%s\n{009933}Price:{ffffff}%d\n{009933}Level:{ffffff}%d\n/buyhouse",svHouse[x][ID],svHouse[x][hName],svHouse[x][hPrice],svHouse[x][hLevel]);
        	svHouse[x][hTextID] =Create3DTextLabel(string,COLOR_WHITE,svHouse[x][hX1],svHouse[x][hY1],svHouse[x][hZ1],20,0,1);
        }
        else
     	{
     		svHouse[x][hPickup] = CreatePickup(1272, 1,svHouse[x][hX1], svHouse[x][hY1],svHouse[x][hZ1] , 0);
     		format(string,sizeof(string),"{009933}House ID: {ffffff}%d\n{009933}Owner:{ffffff} %s\n{009933}Interior: {ffffff}%s\n{009933}Rent Price:{ffffff}%d\n{ffffff}/rentroom",svHouse[x][ID],svHouse[x][hOwnerName],svHouse[x][hName],svHouse[x][hRentPrice]);
        	svHouse[x][hTextID] = Create3DTextLabel(string,COLOR_WHITE,svHouse[x][hX1],svHouse[x][hY1],svHouse[x][hZ1],20,0,1);
     	}	
	return 1;
}
CMD:asellhouse(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pAdmin] < 1337) return SCM(playerid,COLOR_GREY,"Nu ai acces la aceasta comanda.");
		new houseid;
		if(sscanf(params, "i", houseid)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/asellhouse <id>");
		if(houseid < 1 || houseid > HouseNumber) return SCM(playerid,COLOR_GREY,"Casa respectiva nu exista.");
		if(svHouse[houseid][hOwned] == 0) return SCM(playerid,COLOR_GREY,"Casa nu are proprietar.");
		new id = GetPlayerID(svHouse[houseid][hOwnerName]);
		new string[256];
		format(string,sizeof(string),"ID: %d",id);
		SCM(playerid,COLOR_RED,string);
		if(id != -1 )
		{
			PlayerInfo[id][pHouseID] = 0;
			PlayerInfo[id][pTypeHome] = 0;
			PlayerInfo[id][pSpawnType] = 0;
			format(string,sizeof(string),"[WARNING] Adminul %s ti-a vandut casa.",GetName(playerid));
			SCM(id,COLOR_LIGHTRED,string);
		}

		mysql_format(handle, string, sizeof(string), "UPDATE `users` SET `HouseID`='0' WHERE BINARY `Name`= BINARY '%s'",svHouse[houseid][hOwnerName]);
   		mysql_query(handle,string);
   		mysql_format(handle, string, sizeof(string), "UPDATE `users` SET `TypeHome`='0' WHERE BINARY `Name`= BINARY '%s'",svHouse[houseid][hOwnerName]);
   		mysql_query(handle,string);
   		mysql_format(handle, string, sizeof(string), "UPDATE `users` SET `SpawnType`='0' WHERE BINARY `Name`= BINARY '%s'",svHouse[houseid][hOwnerName]);
   		mysql_query(handle,string);

		svHouse[houseid][hX2]= svHouse[houseid][hX3];
		svHouse[houseid][hX2]= svHouse[houseid][hY3];
		svHouse[houseid][hX2]= svHouse[houseid][hZ3];
		svHouse[houseid][hOwned] = 0;
		svHouse[houseid][hInteriorID1]= svHouse[houseid][hInteriorID2];
		format(svHouse[houseid][hOwnerName],256,"The State");

		ResetHouseInfo(houseid);

		mysql_format(handle, string, sizeof(string), "UPDATE `house` SET `OwnerName`='The State' WHERE `ID`='%d'",houseid);
   		mysql_query(handle,string);
   		mysql_format(handle, string, sizeof(string), "UPDATE `house` SET `Owned`='0' WHERE `ID`='%d'",houseid);
   		mysql_query(handle,string);
   		mysql_format(handle, string, sizeof(string), "UPDATE `house` SET `X2`='%f' WHERE `ID`='%d'",svHouse[houseid][hX3],houseid);
   		mysql_query(handle,string);
   		mysql_format(handle, string, sizeof(string), "UPDATE `house` SET `Y2`='%f' WHERE `ID`='%d'",svHouse[houseid][hY3],houseid);
   		mysql_query(handle,string);
   		mysql_format(handle, string, sizeof(string), "UPDATE `house` SET `Z2`='%f' WHERE `ID`='%d'",svHouse[houseid][hZ3],houseid);
   		mysql_query(handle,string);
   		mysql_format(handle, string, sizeof(string), "UPDATE `house` SET `InteriorID1`='%d' WHERE `ID`='%d'",svHouse[houseid][hInteriorID2],houseid);
   		mysql_query(handle,string);
   		format(string,sizeof(string),"[WARNING] Adminul %s a vandut casa cu id-ul %d",GetName(playerid),houseid);
   		foreach(new i : Player)
   		{
   			if(PlayerInfo[i][pAdmin] > 0) 
   				SCM(i,COLOR_LIGHTRED,string);
   		}

	}
	return 1;
}
CMD:sellhouse(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pTypeHome] != 1) return SCM(playerid,COLOR_GREY,"Nu ai casa.");
		new houseid; 
		houseid = PlayerInfo[playerid][pHouseID];
		PlayerInfo[playerid][pMoney] += svHouse[houseid][hPrice];
		GivePlayerMoney(playerid, svHouse[houseid][hPrice]);
		PlayerInfo[playerid][pHouseID] = 0;
		PlayerInfo[playerid][pTypeHome] = 0;
		PlayerInfo[playerid][pSpawnType] = 0;
		Update(playerid,pSpawnType);
		Update(playerid,pTypeHome);
		Update(playerid,pHouseID);
		svHouse[houseid][hX2]= svHouse[houseid][hX3];
		svHouse[houseid][hX2]= svHouse[houseid][hY3];
		svHouse[houseid][hX2]= svHouse[houseid][hZ3];
		svHouse[houseid][hOwned] = 0;
		svHouse[houseid][hInteriorID1]= svHouse[houseid][hInteriorID2];
		format(svHouse[houseid][hOwnerName],256,"The State");

		new string[256];
		ResetHouseInfo(houseid);

		mysql_format(handle, string, sizeof(string), "UPDATE `house` SET `OwnerName`='The State' WHERE `ID`='%d'",houseid);
   		mysql_query(handle,string);
   		mysql_format(handle, string, sizeof(string), "UPDATE `house` SET `Owned`='0' WHERE `ID`='%d'",houseid);
   		mysql_query(handle,string);
   		mysql_format(handle, string, sizeof(string), "UPDATE `house` SET `X2`='%f' WHERE `ID`='%d'",svHouse[houseid][hX3],houseid);
   		mysql_query(handle,string);
   		mysql_format(handle, string, sizeof(string), "UPDATE `house` SET `Y2`='%f' WHERE `ID`='%d'",svHouse[houseid][hY3],houseid);
   		mysql_query(handle,string);
   		mysql_format(handle, string, sizeof(string), "UPDATE `house` SET `Z2`='%f' WHERE `ID`='%d'",svHouse[houseid][hZ3],houseid);
   		mysql_query(handle,string);
   		mysql_format(handle, string, sizeof(string), "UPDATE `house` SET `InteriorID1`='%d' WHERE `ID`='%d'",svHouse[houseid][hInteriorID2],houseid);
   		mysql_query(handle,string);
   		SCM(playerid,COLOR_LIGHTRED,"You're now homeless.");
	}
	return 1;
}
CMD:housewithdraw(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
		if(PlayerInfo[playerid][pTypeHome] != 1) return SCM(playerid, COLOR_GREY, "Nu detii o casa.");
		new type[256];
		new amount; new houseid = PlayerInfo[playerid][pHouseID]; 
		new money[] = "money"; // 1
		new mats[] = "mats"; // 2
		new drugs[] = "drugs"; // 3
		if(sscanf(params, "s[256]i", type, amount)) return SendClientMessage(playerid, COLOR_GREY,"Sintaxa: {FFFFFF}/housewithdraw <type> <amount>\n Type: money , mats , drugs");
		new string[256]; new number = 0;
		if(!strcmp(type, money, true)) number = 1;
		if(!strcmp(type, mats, true)) number = 2;
		if(!strcmp(type, drugs, true)) number = 3;
		if(number == 0) return SendClientMessage(playerid, COLOR_GREY,"Sintaxa: {FFFFFF}/housewithdraw <type> <amount>\n Type: money , mats , drugs");
		
		if(number == 1)
		{
			if(svHouse[houseid][hMoney] - amount < 0) return SCM(playerid, COLOR_GREY, "Ai ales o suma prea mare.");
			format(string, sizeof(string), "Ai retras %d $", amount);
			SCM(playerid, COLOR_BLUE, string);
			PlayerInfo[playerid][pMoney] += amount;
			svHouse[houseid][hMoney] -= amount;
			GivePlayerMoney(playerid, amount);
			Update(playerid,pMoney);
			mysql_format(handle, string, sizeof(string), "UPDATE `house` SET `Money`='%d' WHERE `ID`='%d'",svHouse[houseid][hMoney],houseid);
   			mysql_query(handle,string);
		}
		else if(number == 2)
		{

		}
		else if(number == 3)
		{

		}

	}
	return 1;
}
CMD:buyhouse(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
		if(PlayerInfo[playerid][pVW] != 0) return 1;
		if(PlayerInfo[playerid][pWanted] != 0) return SCM(playerid,COLOR_GREY,"Ai wanted.");
		if(PlayerInfo[playerid][pHouseID] != 0) return SCM(playerid,COLOR_GREY,"Ai deja o casa / un rent.");
		new houseid=0;
		new Float:x;
		new Float:y;
		new Float:z;
		GetPlayerPos(playerid,x,y,z);
		new ok=1;
		for(new i=1;i<=HouseNumber && ok==1;i++)
		{
			if(IsPlayerInRangeOfPoint(playerid,2,svHouse[i][hX1],svHouse[i][hY1],svHouse[i][hZ1]) )
			{
				houseid=i;
				ok=0;
			}
		}
		if(houseid == 0) return 1;
		if(svHouse[houseid][hOwned] == 1) return SCM(playerid,COLOR_GREY,"Casa este deja cumparata de un jucator.");
		if(PlayerInfo[playerid][pMoney] - svHouse[houseid][hPrice] < 0) return SCM(playerid,COLOR_GREY,"Nu ai destui bani.");
		if(PlayerInfo[playerid][pLvl] < svHouse[houseid][hLevel] ) return SCM(playerid,COLOR_GREY,"Nu ai lvl necesar.");
		PlayerInfo[playerid][pTypeHome] = 1;
		PlayerInfo[playerid][pSpawnType] = 1;
		PlayerInfo[playerid][pHouseID] = houseid;
		PlayerInfo[playerid][pMoney] -= svHouse[houseid][hPrice];
		GivePlayerMoney(playerid, - svHouse[houseid][hPrice]);
		Update(playerid,pTypeHome);
		Update(playerid,pMoney);
		Update(playerid,pHouseID);
		Update(playerid,pSpawnType);

		format(svHouse[houseid][hOwnerName],256,GetName(playerid));
		svHouse[houseid][hOwned] = 1;

		new string[256];
		mysql_format(handle, string, sizeof(string), "UPDATE `house` SET `OwnerName`='%s' WHERE `ID`='%d'",GetName(playerid),houseid);
   		mysql_query(handle,string);
   		mysql_format(handle, string, sizeof(string), "UPDATE `house` SET `Owned`='%d' WHERE `ID`='%d'",1,houseid);
   		mysql_query(handle,string);

   		ResetHouseInfo(houseid);
	}
	return 1;
}
CMD:createhouse(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pAdmin] < 1337) return SCM(playerid,COLOR_GREY,"Nu ai acces la aceasta comanda.");
		new type , price , lvl;
		if(sscanf(params, "iii", type,price,lvl)) return SendClientMessage(playerid, COLOR_GREY,"Sintaxa: {FFFFFF}/createhouse <type> <price> <level>");
		if(type>9 || type < 1) return SCM(playerid,COLOR_GREY,"Alege un interior intre 1 si 9.");
		new Float:x;
		new Float:y;
		new Float:z;
		GetPlayerPos(playerid,x,y,z);
		HouseNumber++;
		new string[2024];
		new string1[2024];
		format(string,sizeof(string),"INSERT INTO `house`(`ID`, `X3`, `Y3`, `Z3`, `X1`, `X2`, `Y1`, `Y2`, `Z1`, `Z2`, `InteriorID1`, `InteriorID2`, `OwnerName`, `Owned`, `Price`, `RentPrice`, `Level`, `VW` , `Money`, `HName`) VALUES ");
		format(string1,sizeof(string1),"(%d,%f,%f,%f,%f,%f,%f,%f,%f,%f,%d,%d,'%s',%d,%d,%d,%d,%d,%d,'%s')",HouseNumber,HouseCreateInfo[type][hX],HouseCreateInfo[type][hY],HouseCreateInfo[type][hZ],x,HouseCreateInfo[type][hX],y,HouseCreateInfo[type][hY],z,HouseCreateInfo[type][hZ],HouseCreateInfo[type][hInterior],HouseCreateInfo[type][hInterior],"The State",0,price,100,lvl,100+HouseNumber,0,HouseCreateInfo[type][hName]);
		strcat(string,string1);
		mysql_query(handle,string);
		format(string,sizeof(string),"Ai creat casa cu numarul %d, type %d, X: %f, Y: %f, Z: %f.",HouseNumber,type,x,y,z);
		SCM(playerid,COLOR_WHITE,string);
	}
	return 1;
}
//--------------------------------------------
function NewBieDown()
{
    for(new i = 0; i <= 1000; i++)
        if(IsPlayerConnected(i))
        {
            if(NewBieMute[i] != 0)
            {
                NewBieMute[i] --;
                if(NewBieMute[i] == 0) SCM(i, COLOR_GREY, "Acum poti vorbi pe /n.");
            }      
            if(NewBieCoolDown[i] != 0) NewBieCoolDown[i]--;
        }
}
 
CMD:n(playerid, params[])
{
    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pAdmin] == 0 && PlayerInfo[playerid][pHelper] == 0 && PlayerInfo[playerid][pLvl] > 5) return SCM(playerid, COLOR_GREY, "Nu mai ai acces la aceasta comanda.");
        new string[256];
        if(NewBieMute[playerid] != 0)
        {
            format(string, sizeof(string), "Au mai ramas %d min %d sec din mute.", NewBieMute[playerid] / 60, NewBieMute[playerid] % 60);
            return SCM(playerid, COLOR_GREY, string);
        }
        if(NewBieCoolDown[playerid] != 0)
        {
            format(string, sizeof(string), "Poti folosi aceasta comanda peste %d sec", NewBieCoolDown[playerid] % 60);
            return SCM(playerid, COLOR_GREY, string);
        }
        new message[256];
        if(sscanf(params, "s[256]", message)) return SendClientMessage(playerid, COLOR_GREY,"Sintaxa: {FFFFFF}/n <text>");
        if(strlen(message) == 0) return SCM(playerid, COLOR_GREY, "Mesajul trebuia sa contina cel putin un caracter.");
        if(PlayerInfo[playerid][pAdmin] == 0 && PlayerInfo[playerid][pHelper] == 0)
        {
            NewBieCoolDown[playerid] = 60;
            format(string, sizeof(string), "{ffbc03}[NewBie Level %d] %s(ID:%d): {b3b3b3}%s",PlayerInfo[playerid][pLvl], GetName(playerid), playerid, message);
        }
        if(PlayerInfo[playerid][pAdmin] > 0) format(string, sizeof(string), "{f21a0f}[Admin Level %d] %s(ID:%d): {b3b3b3}%s", PlayerInfo[playerid][pAdmin], GetName(playerid), playerid, message);
        if(PlayerInfo[playerid][pHelper] > 0 && PlayerInfo[playerid][pAdmin] == 0) format(string, sizeof(string), "[Helper Level %d]%s: %s", PlayerInfo[playerid][pHelper], GetName(playerid), message);
       
        for(new i = 0; i <= 1000; i++)
            if(IsPlayerConnected(i))
                if(PlayerInfo[i][pLvl] <= 5 || PlayerInfo[i][pAdmin] != 0 || PlayerInfo[i][pHelper] != 0)
                    SCM(i, COLOR_GREY, string);
    }
    return 1;
}
CMD:nmute(playerid, params[])
{
    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pAdmin] == 0 || PlayerInfo[playerid][pHelper] == 0) return SCM(playerid, COLOR_GREY, "Nu ai acces la aceasta comanda.");
        new nbid, minutes, reason[256];
        if(sscanf(params, "uis[256]", nbid, minutes, reason)) return SendClientMessage(playerid, COLOR_GREY,"Sintaxa: {FFFFFF}/nmute <playerid/name> <minutes> <reason>");
        if(!IsPlayerConnected(nbid)) return SCM(nbid, COLOR_GREY, "Jucatorul nu este conectat.");
        if(PlayerInfo[nbid][pLvl] > 5) return SCM(playerid, COLOR_GREY, "Jucatorul nu mai are acces la /n.");
        if(minutes < 0) return SCM(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/nmute <playerid/name> <minutes> <reason>");
        if(strlen(reason) == 0) return SCM(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/nmute <playerid/name> <minutes> <reason>");
        if(PlayerInfo[nbid][pAdmin] != 0 || PlayerInfo[nbid][pHelper] != 0) return SCM(playerid, COLOR_GREY, "Acel jucator este admin/helper.");
        new string[256];
        NewBieMute[nbid] = minutes * 60;
        format(string, sizeof(string), "AdmCmd: %s a primit nmute pentru %d minute de la %s. Reason : %s", GetName(nbid), minutes, GetName(playerid), reason);
        for(new i = 0; i <= 1000; i++)
            if(IsPlayerConnected(i))
                if(PlayerInfo[i][pLvl] <= 5 || PlayerInfo[i][pAdmin] != 0 || PlayerInfo[i][pHelper] != 0)
                    SCM(i, COLOR_RED, string);
 
    }
    return 1;
}
CMD:nunmute(playerid, params[])
{
    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pAdmin] == 0 || PlayerInfo[playerid][pHelper] == 0) return SCM(playerid, COLOR_GREY, "Nu ai acces la aceasta comanda.");
        new nbid, reason[256];
        if(sscanf(params, "us[256]", nbid, reason)) return SendClientMessage(playerid, COLOR_GREY,"Sintaxa: {FFFFFF}/nunmute <playerid/name> <reason>");
        if(!IsPlayerConnected(nbid)) return SCM(nbid, COLOR_GREY, "Jucatorul nu este conectat.");
        if(PlayerInfo[nbid][pLvl] > 5) return SCM(playerid, COLOR_GREY, "Jucatorul nu mai are acces la /n.");
        if(strlen(reason) == 0) return SCM(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/nunmute <playerid/name> <reason>");
        new string[256];
        NewBieMute[nbid] = 0;
        format(string, sizeof(string), "AdmCmd: %s a primit unmute pe newbie chat de la %s. Reason : %s", GetName(nbid), GetName(playerid), reason);
        for(new i = 0; i <= 1000; i++)
            if(IsPlayerConnected(i))
                if(PlayerInfo[i][pLvl] <= 5 || PlayerInfo[i][pAdmin] != 0 || PlayerInfo[i][pHelper] != 0)
                    SCM(i, COLOR_RED, string);
 
    }
    return 1;
}
forward CanGetWanted(playerid);
public CanGetWanted(playerid)
{
	if(WarStatus == 1 && IsGang(playerid) == 1) return 0;
	if(PlayerInfo[playerid][pInDM] == 1 && dmStatus == 1) return 0;
	return 1;
}
forward CanJoinEvents(playerid);
public CanJoinEvents(playerid)
{
	if(WarStatus == 1 && IsGang(playerid) == 1) return 0;
	if(PlayerInfo[playerid][pInDM] == 1 && dmStatus == 1) return 0;
	if(PlayerInfo[playerid][pWanted] > 1) return 0;
	return 1;
}
CMD:loaddm(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pAdmin] < 1) return SCM(playerid, COLOR_GREY, "Nu ai acces la aceasta comanda.");
		if(dmStatus == 1) return SCM(playerid, COLOR_GREY, "Este deja un event in desfasurare.");
		dmStatus = 1;
		dmMaxKills = 0;
		dmMXID = -1;
		dmID = 1;
		dmTimeLeft = 1200;
		dmEventGangZone = GangZoneCreate(1251, -1166, 1693, -924);
		SendClientMessageToAll(COLOR_INDIANRED, "DeathMatch EVENT ON /joindm");
	}
	return 1;
}
CMD:stopdm(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pAdmin] < 1) return SCM(playerid, COLOR_GREY, "Nu ai acces la aceasta comanda.");
		if(dmStatus == 0) return SCM(playerid, COLOR_GREY, "Nu este un event in desfasurare.");
		for (new i = 0; i < MAX_PLAYERS; i++)
			if(PlayerInfo[i][pInDM] == 1)
                ExitDmEvent(i);
        new string[256];
        format(string, sizeof(string), "DM WINNER : %s | Kills %d", GetName(dmMXID), dmMaxKills);
        SendClientMessageToAll(COLOR_DARKGOLDENROD, string);
        dmStatus = 0;
		dmMaxKills = 0;
		dmMXID = -1;
		dmID = 0;
		dmTimeLeft = 0;
	}
	return 1;
}
CMD:joindm(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pInDM] == 1) return SCM(playerid, COLOR_GREY, "Esti deja in event.");
		if(dmStatus == 0) return SCM(playerid, COLOR_GREY, "Eventul este inactiv.");
		PlayerInfo[playerid][pInDM] = 1;
		PlayerInfo[playerid][pDmKills] = 0;
		Slap(playerid);
		SpawnPlayer(playerid);
		GangZoneShowForPlayer(playerid, dmEventGangZone, COLOR_RED);
		/*new string;
		new second;
		second = dmTimeLeft % 60;
		if(second < 10) format(string, sizeof(string) , "%d:0%d", dmTimeLeft/60, second);
		else format(string, sizeof(string) , "%d:%d", dmTimeLeft/60, second);
		PlayerTextDrawSetString(playerid, dmTxd1[playerid], string);
		if(dmMaxKills != 0)
		{
			format(string, sizeof(string) , "%s", GetName(dmMXID));
			PlayerTextDrawSetString(playerid, dmTxd3[playerid], string);
		}
		PlayerTextDrawShow(playerid, dmTxd0[playerid]);
		PlayerTextDrawShow(playerid, dmTxd1[playerid]);
		PlayerTextDrawShow(playerid, dmTxd2[playerid]);
		PlayerTextDrawShow(playerid, dmTxd3[playerid]);*/
	}
	return 1;
}
CMD:leavedm(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pInDM] == 0) return SCM(playerid, COLOR_GREY, "Nu esti in event.");
		ExitDmEvent(playerid);
		dmMaxKills = 0;
		for(new i = 0 ; i < MAX_PLAYERS; i++)
			if(PlayerInfo[i][pDmKills] > dmMaxKills && i != playerid)
			{
				dmMaxKills = PlayerInfo[i][pDmKills];
				dmMXID = i;
			}
	}
	return 1;
}
//----------------[WAR SYSTEM]----------------
CMD:startwar(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pRFaction] != 7 || (PlayerInfo[playerid][pFaction] < 4 || PlayerInfo[playerid][pFaction] > 9)) return SCM(playerid, COLOR_GREY, "Nu ai acces la aceasta comanda.");
		if(WarStatus != 0) return SendClientMessage(playerid, COLOR_GREY, "War-ul este activ");
		new string[256];
		for(new i = 1; i <= WarNumbers; i++)
		{
			strcat(string, WarInfo[i][Name]);
			strcat(string, "\n");
		}
		ShowPlayerDialog(playerid, DIALOG_SELECTWAR, DIALOG_STYLE_LIST, "War List", string, "Select", "");
	}
	return 1;
}
//--------------------------------------------
//-------------[MISSION SYSTEM]---------------
CMD:missions(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
		SCM(playerid,COLOR_WHITE,"{009900}Mission Bonus");
		SCM(playerid,COLOR_WHITE,"10 Missions - 50.000$");
		SCM(playerid,COLOR_WHITE,"50 Missions - 100.000$ + 1RP");
		SCM(playerid,COLOR_WHITE,"100 Missions - 200.000$ + 5RP");
		SCM(playerid,COLOR_WHITE,"200 Missions - 400.000$ + 1LVL");
		SCM(playerid,COLOR_WHITE,"500 Missions - 1.000.000$ + 2LVL");
		SCM(playerid,COLOR_WHITE,"1000 Missions - 5.000.000$ + 5LVL");
		new string[256];
		if(PlayerInfo[playerid][pMissionF] < 10) format(string,sizeof(string),"Missions [%d/10].",PlayerInfo[playerid][pMissionF]);
		else if(PlayerInfo[playerid][pMissionF] < 50) format(string,sizeof(string),"Missions [%d/50].",PlayerInfo[playerid][pMissionF]);
		else if(PlayerInfo[playerid][pMissionF] < 100) format(string,sizeof(string),"Missions [%d/100].",PlayerInfo[playerid][pMissionF]);
		else if(PlayerInfo[playerid][pMissionF] < 200) format(string,sizeof(string),"Missions [%d/200].",PlayerInfo[playerid][pMissionF]);
		else if(PlayerInfo[playerid][pMissionF] < 500) format(string,sizeof(string),"Missions [%d/500].",PlayerInfo[playerid][pMissionF]);
		else if(PlayerInfo[playerid][pMissionF] < 1000) format(string,sizeof(string),"Missions [%d/1000].",PlayerInfo[playerid][pMissionF]);
		else format(string,sizeof(string),"Missions [%d].",PlayerInfo[playerid][pMissionF]);
		SCM(playerid,COLOR_WHITE,string);
	}
	return 1;
}
CMD:startmissions(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
		if(PlayerInfo[playerid][pAdmin] < 4) return SCM(playerid,COLOR_GREY,"Nu ai acces la aceasta comanda.");
		if(CurrentMission != 0) return SCM(playerid,COLOR_GREY,"Sistemul de misiuni este deja activ");
		CurrentMission = 1;
		new string[256];
		format(string,sizeof(string),"Adminul %s a activat sistemul de misiuni .",GetName(playerid));
		SendClientMessageToAll(COLOR_RED1, string);
		format(string,sizeof(string),"{009900} ACTUAL MISSION : {ffffff} %s",Missions[CurrentMission][Title]);
		SendClientMessageToAll(COLOR_WHITE, string);
		format(string,sizeof(string),"{009900} Description: {ffffff} %s {009900} | Difficulty: {ffffff}%s {009900}| Reward: {ffffff}%d",Missions[CurrentMission][Description],Missions[CurrentMission][Difficulty],Missions[CurrentMission][Reward]);
		SendClientMessageToAll(COLOR_WHITE, string);
	}
	return 1;
}

CMD:stopmissions(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
		if(PlayerInfo[playerid][pAdmin] < 4) return SCM(playerid,COLOR_GREY,"Nu ai acces la aceasta comanda.");
		if(CurrentMission == 0) return SCM(playerid,COLOR_GREY,"Sistemul de misiuni este deja oprit");
		CurrentMission = 0;
		new string[256];
		format(string,sizeof(string),"Adminul %s a oprit sistemul de misiuni .",GetName(playerid));
		SendClientMessageToAll(COLOR_RED1, string);
		foreach(new i: Player)
		{
			if(PlayerInfo[i][pMissionid] != 0)
			{
				CheckColor(i);
				PlayerInfo[i][pMissionid] =0;
				PlayerInfo[i][pMissionCP] =0;
				CP[i][ID]=0;
				DisablePlayerCheckpoint(i);
				SCM(i,COLOR_BLUE,"Misiunea a fost anulata deoarece un admin a oprit sistemul de misiuni.");
			}	
		}
	}
	return 1;
}
CMD:mission(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
		if(IsPlayerInRangeOfPoint(playerid, 5, 1380.3617,-1088.7767,27.3844) )
		{
			new string[256];
			if(GetPlayerVirtualWorld(playerid) != 0) return SCM(playerid, COLOR_GREY, "**Esti in virtual world.");
			if(CurrentMission == 0) return SCM(playerid,COLOR_GREY,"Sistemul de misiuni este oprit.");
			if(PlayerInfo[playerid][pWanted] > 0) return SCM(playerid,COLOR_GREY,"Nu poti incepe o misiune daca ai wanted.");
			if(PlayerInfo[playerid][pMissionid] != 0 ) return SCM(playerid,COLOR_GREY,"Ai deja o misiune de indeplinit.");
			if(CP[playerid][ID] != 0) return SCM(playerid,COLOR_GREY,"Ai deja un CheckPoint pe harta. Pentru a anula checkpointul foloseste comanda /killcp");
			if(PlayerInfo[playerid][pLastMission] == CurrentMission ) return SCM(playerid,COLOR_YELLOW,"Ai terminat deja misiunea , asteapta urmatoare misiune.");
			SetPlayerCheckpoint(playerid, Missions[CurrentMission][CP1X], Missions[CurrentMission][CP1Y], Missions[CurrentMission][CP1Z], 5);
			PlayerInfo[playerid][pMissionid] = CurrentMission;
			PlayerInfo[playerid][pMissionCP] = 1;
			format(string,sizeof(string),"{009900} YOUR MISSION : {ffffff} %s",Missions[CurrentMission][Title]);
			SCM(playerid,COLOR_WHITE, string);
			format(string,sizeof(string),"{009900} Description: {ffffff} %s {009900} | Difficulty: {ffffff}%s {009900}| Reward: {ffffff}%d",Missions[CurrentMission][Description],Missions[CurrentMission][Difficulty],Missions[CurrentMission][Reward]);
			SCM(playerid,COLOR_WHITE, string);
			SetPlayerColor(playerid,0xAFAFAFAA);
		}
		else SCM(playerid,COLOR_GREY,"Nu esti la disketa.");
	}
	return 1;
}
CMD:cancelmission(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
		if(PlayerInfo[playerid][pMissionid] == 0) return SCM(playerid,COLOR_GREY,"Nu esti intr-o misiune.");
		CheckColor(playerid);
		PlayerInfo[playerid][pMissionid] =0;
		PlayerInfo[playerid][pMissionCP] =0;
		CP[playerid][ID]=0;
		DisablePlayerCheckpoint(playerid);
		SCM(playerid,COLOR_BLUE,"Ai anulat misiunea.");
	}
	return 1;
}
CMD:createmission(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
	    if(PlayerInfo[playerid][pAdmin] < 4 ) return SCM(playerid,COLOR_GREY,"Nu ai acces la aceasta comanda.");
	    new title[64];
	    new description[64];
	    new difficulty[64];
	    new reward;
	    if(sscanf(params, "s[64]is[64]s[64]", title,reward,difficulty,description)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/createmission <titlu> <premiu> <dificultate> <descriere> ");
		if(reward < 10000 || reward > 100000 ) return SCM(playerid,COLOR_GREY,"Premiul poate fi intre 10k si 100k.");
		format(CreateMissions[playerid][Title],64,title);
		format(CreateMissions[playerid][Description],64,description);
		format(CreateMissions[playerid][Difficulty],64,difficulty);
		CreateMissions[playerid][Reward] = reward;
		SCM(playerid,COLOR_RED,"Du-te unde vrei sa fie primul CP si foloseste comanda /mcp1 ");
	}
	return 1;
}

CMD:mcp1(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
	    if(PlayerInfo[playerid][pAdmin] < 4 ) return SCM(playerid,COLOR_GREY,"Nu ai acces la aceasta comanda.");
	    new Float:x;
	    new Float:y;
		new Float:z;
	    new text[64];
	    if(sscanf(params, "s[64]", text)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/mcp1 <text>");
		format(CreateMissions[playerid][Text1],64,text);
		GetPlayerPos(playerid,x,y,z);
		CreateMissions[playerid][CP1X] = x;
  		CreateMissions[playerid][CP1Y] = y;
  		CreateMissions[playerid][CP1Z] = z;
		SCM(playerid,COLOR_RED,"Du-te unde vrei sa fie primul CP si foloseste comanda /mcp2 ");
	}
	return 1;
}
CMD:mcp2(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
	    if(PlayerInfo[playerid][pAdmin] < 4 ) return SCM(playerid,COLOR_GREY,"Nu ai acces la aceasta comanda.");
	    new Float:x;
	    new Float:y;
		new Float:z;
	    new text[64];
	    if(sscanf(params, "s[64]", text)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/mcp2 <text>");
		format(CreateMissions[playerid][Text2],64,text);
		GetPlayerPos(playerid,x,y,z);
		CreateMissions[playerid][CP2X] = x;
  		CreateMissions[playerid][CP2Y] = y;
  		CreateMissions[playerid][CP2Z] = z;
		SCM(playerid,COLOR_RED,"Du-te unde vrei sa fie primul CP si foloseste comanda /mcp3 ");
	}
	return 1;
}
CMD:mcp3(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
	    if(PlayerInfo[playerid][pAdmin] < 4 ) return SCM(playerid,COLOR_GREY,"Nu ai acces la aceasta comanda.");
	    new Float:x;
	    new Float:y;
		new Float:z;
	    new text[256];
	    if(sscanf(params, "s[64]", text)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/mcp3 <text>");
		format(CreateMissions[playerid][Text3],64,text);
		GetPlayerPos(playerid,x,y,z);
		CreateMissions[playerid][CP3X] = x;
  		CreateMissions[playerid][CP3Y] = y;
  		CreateMissions[playerid][CP3Z] = z;
		SCM(playerid,COLOR_RED,"Du-te unde vrei sa fie primul CP si foloseste comanda /mcp4 ");
	}
	return 1;
}
CMD:mcp4(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
	    if(PlayerInfo[playerid][pAdmin] < 4 ) return SCM(playerid,COLOR_GREY,"Nu ai acces la aceasta comanda.");
	    new Float:x;
	    new Float:y;
		new Float:z;
	    new text[256];
	    if(sscanf(params, "s[64]", text)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/mcp4 <text>");
		format(CreateMissions[playerid][Text4],64,text);
		GetPlayerPos(playerid,x,y,z);
		CreateMissions[playerid][CP4X] = x;
  		CreateMissions[playerid][CP4Y] = y;
  		CreateMissions[playerid][CP4Z] = z;
		SCM(playerid,COLOR_RED,"Du-te unde vrei sa fie primul CP si foloseste comanda /mcp5");
	}
	return 1;
}
CMD:mcp5(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
	    if(PlayerInfo[playerid][pAdmin] < 4 ) return SCM(playerid,COLOR_GREY,"Nu ai acces la aceasta comanda.");
	    new Float:x;
	    new Float:y;
		new Float:z;
	    new text[256];
	    if(sscanf(params, "s[64]", text)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/mcp5 <text>");
		format(CreateMissions[playerid][Text5],64,text);
		GetPlayerPos(playerid,x,y,z);
		CreateMissions[playerid][CP5X] = x;
  		CreateMissions[playerid][CP5Y] = y;
  		CreateMissions[playerid][CP5Z] = z;
		SCM(playerid,COLOR_RED,"Du-te unde vrei sa fie primul CP si foloseste comanda /mcp6 ");
	}
	return 1;
}
CMD:mcp6(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
	    if(PlayerInfo[playerid][pAdmin] < 4 ) return SCM(playerid,COLOR_GREY,"Nu ai acces la aceasta comanda.");
	    new Float:x;
	    new Float:y;
		new Float:z;
	    new text[256];
	    if(sscanf(params, "s[64]", text)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/mcp6 <text>");
		format(CreateMissions[playerid][Text6],64,text);
		GetPlayerPos(playerid,x,y,z);
		CreateMissions[playerid][CP6X] = x;
  		CreateMissions[playerid][CP6Y] = y;
  		CreateMissions[playerid][CP6Z] = z;
  		NrMissions++;
  		new string[2048];
  		new string1[2048];
		format(string,sizeof(string),"INSERT INTO `missions`(`ID`, `Title`, `Description`, `Difficulty`, `Reward`, `Text1`, `Text2`, `Text3`, `Text4`, `Text5`, `Text6`, `CP1X`, `CP1Y`, `CP1Z`, `CP2X`, `CP2Y`, `CP2Z`, `CP3X`, `CP3Y`, `CP3Z`, `CP4X`, `CP4Y`, `CP4Z`, `CP5X`, `CP5Y`, `CP5Z`, `CP6X`, `CP6Y`, `CP6Z`) VALUES ");
		format(string1,sizeof(string1),"(%d,'%s','%s','%s',%d,'%s','%s','%s','%s','%s','%s',",NrMissions,CreateMissions[playerid][Title],CreateMissions[playerid][Description],CreateMissions[playerid][Difficulty],CreateMissions[playerid][Reward],CreateMissions[playerid][Text1],CreateMissions[playerid][Text2],CreateMissions[playerid][Text3],CreateMissions[playerid][Text4],CreateMissions[playerid][Text5],CreateMissions[playerid][Text6]);
		strcat(string,string1);
		format(string1,sizeof(string1),"%f,%f,%f,%f,%f,%f,%f,%f,%f,",CreateMissions[playerid][CP1X],CreateMissions[playerid][CP1Y],CreateMissions[playerid][CP1Z],CreateMissions[playerid][CP2X],CreateMissions[playerid][CP2Y],CreateMissions[playerid][CP2Z],CreateMissions[playerid][CP3X],CreateMissions[playerid][CP3Y],CreateMissions[playerid][CP3Z]);
		strcat(string,string1);
		format(string1,sizeof(string1),"%f,%f,%f,%f,%f,%f,%f,%f,%f)",CreateMissions[playerid][CP4X],CreateMissions[playerid][CP4Y],CreateMissions[playerid][CP4Z],CreateMissions[playerid][CP5X],CreateMissions[playerid][CP5Y],CreateMissions[playerid][CP5Z],CreateMissions[playerid][CP6X],CreateMissions[playerid][CP6Y],CreateMissions[playerid][CP6Z]);
        strcat(string,string1);
        mysql_query(handle,string);
        printf(string);
		printf("[Mission Log] Adminul %s a creat misiunea cu id-ul %d",GetName(playerid),NrMissions);
		SCM(playerid,COLOR_RED,"Misiune Salvata.");
	}
	return 1;
}
//---------------[END MISSION SYSTEM]--------------------
CMD:clearfstats(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
	    if(PlayerInfo[playerid][pFaction] == 0 || PlayerInfo[playerid][pRFaction] != 7) return SCM(playerid,COLOR_GREY,"Nu esti lider.");
	    if(PlayerInfo[playerid][pFaction] >= 4 && PlayerInfo[playerid][pFaction] <= 9) return SCM(playerid,COLOR_GREY,"Gang-urile/Mafiile nu au norma.");
	    new id, motiv[256];
	    new string[256];
	    if(sscanf(params, "us[256]", id,motiv)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/clearfstats <playerid/name> <reason>");
	    if(IsPlayerConnected(id) )
	    {
	        if(PlayerInfo[playerid][pFaction] != PlayerInfo[id][pFaction]) return SCM(playerid,COLOR_GREY,"Jucatorul nu este membru al factiunii tale.");
	        
	        if(PlayerInfo[playerid][pFaction] == 1 || PlayerInfo[playerid][pFaction] == 2 || PlayerInfo[playerid][pFaction] == 3)//pd,ng,fbi
	        {
	            if(PlayerInfo[id][pKills] == 0 && PlayerInfo[id][pArrests] == 0 && PlayerInfo[id][pTickets] == 0 && PlayerInfo[id][pAssists] == 0)
					return SCM(playerid,COLOR_BLUE,"Membrul respectiv are deja norma resetata.");
					
				PlayerInfo[id][pKills] = 0 ;
			    PlayerInfo[id][pArrests] = 0;
				PlayerInfo[id][pTickets] = 0;
				PlayerInfo[id][pAssists] = 0;
				
				format(string,sizeof(string),"Liderul %s a resetat norma membrului %s , motiv: %s.",GetName(playerid),GetName(id),motiv );
				foreach(new i : Player)
				{
				    if(IsPlayerConnected(i))
				        if(PlayerInfo[i][pFaction] == PlayerInfo[playerid][pFaction]) SCM(i,COLOR_BLUE,string);
				}
			}
	        if(PlayerInfo[playerid][pFaction] == 10)//medic
	        {
				if(PlayerInfo[id][pPillsSold] == 0 && PlayerInfo[id][pHealP] == 0) return SCM(playerid,COLOR_BLUE,"Membrul respectiv are deja norma resetata.");
				
				PlayerInfo[id][pPillsSold] = 0;
				PlayerInfo[id][pHealP] = 0;
				
				format(string,sizeof(string),"Liderul %s a resetat norma membrului %s , motiv: %s.",GetName(playerid),GetName(id),motiv );
				foreach(new i : Player)
				{
				    if(IsPlayerConnected(i))
				        if(PlayerInfo[i][pFaction] == PlayerInfo[playerid][pFaction]) SCM(i,COLOR_BLUE,string);
				}
			}
			if(PlayerInfo[playerid][pFaction] == 12)//lf
	        {
				if(PlayerInfo[id][pLicenseSold] == 0) return SCM(playerid,COLOR_BLUE,"Membrul respectiv are deja norma resetata.");

				PlayerInfo[id][pLicenseSold] = 0;

				format(string,sizeof(string),"Liderul %s a resetat norma membrului %s , motiv: %s.",GetName(playerid),GetName(id),motiv );
				foreach(new i : Player)
				{
				    if(IsPlayerConnected(i))
				        if(PlayerInfo[i][pFaction] == PlayerInfo[playerid][pFaction]) SCM(i,COLOR_BLUE,string);
				}
			}
			if(PlayerInfo[playerid][pFaction] == 13)//taxi
			{
				if(PlayerInfo[id][pTaxiRaport] == 0) return SCM(playerid,COLOR_BLUE,"Membrul respectiv are deja norma resetata.");
				
				PlayerInfo[id][pTaxiRaport] = 0;
				Update(id, pTaxiRaport);
				format(string,sizeof(string),"Liderul %s a resetat norma membrului %s , motiv: %s.",GetName(playerid),GetName(id),motiv);
				foreach(new i : Player)
				{
				    if(IsPlayerConnected(i))
				        if(PlayerInfo[i][pFaction] == PlayerInfo[playerid][pFaction]) SCM(i,COLOR_BLUE,string);
				}
			}
			if(PlayerInfo[playerid][pFaction] == 14)//nr
			{
				if(PlayerInfo[id][pTaxiRaport] == 0) return SCM(playerid,COLOR_BLUE,"Membrul respectiv are deja norma resetata.");
				
				PlayerInfo[id][pNrRaport] = 0;
				Update(id, pNrRaport);
				format(string,sizeof(string),"Liderul %s a resetat norma membrului %s , motiv: %s.",GetName(playerid),GetName(id),motiv);
				foreach(new i : Player)
				{
				    if(IsPlayerConnected(i))
				        if(PlayerInfo[i][pFaction] == PlayerInfo[playerid][pFaction]) SCM(i,COLOR_BLUE,string);
				}
			}
			if(PlayerInfo[playerid][pFaction] == 11)//hitman
			{
				if(PlayerInfo[id][pDoneContracts] == 0 && PlayerInfo[id][pCancelContracts] == 0 && PlayerInfo[id][pFailContracts] == 0) return SCM(playerid,COLOR_BLUE,"Membrul respectiv are deja norma resetata.");
				
				PlayerInfo[id][pDoneContracts] = 0;
				PlayerInfo[id][pCancelContracts] = 0;
				PlayerInfo[id][pFailContracts] = 0;
				Update(id, pDoneContracts);
				Update(id, pCancelContracts);
				Update(id, pFailContracts);
				format(string,sizeof(string),"Liderul %s a resetat norma membrului %s , motiv: %s.",GetName(playerid),GetName(id),motiv);
				foreach(new i : Player)
				{
				    if(IsPlayerConnected(i))
				        if(PlayerInfo[i][pFaction] == PlayerInfo[playerid][pFaction]) SCM(i,COLOR_BLUE,string);
				}
			}

		}
	    else SCM(playerid,COLOR_GREY,"Jucatorul nu este conectat.");
	    
	}
	return 1;
}
CMD:acceptlicenses(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
		if(PlayerInfo[playerid][pLicMoney] == 0) return SCM(playerid,COLOR_GREY,"Nu ai nici o oferta de licente.");
		new money;
		new id;
		new number;
		
		id = PlayerInfo[playerid][pLicID];
		money = PlayerInfo[playerid][pLicMoney];
		number = PlayerInfo[playerid][pLicNumber];
		
		PlayerInfo[playerid][pLicMoney] = 0;
		PlayerInfo[playerid][pLicID] = 0;
		PlayerInfo[playerid][pLicNumber] = 0;
		
		new Float:x;
		new Float:y;
		new Float:z;
		if(PlayerInfo[id][pFaction] != 12) return SCM(playerid,COLOR_GREY,"Instructorul care ti-a oferit licentele a fost dat afara.");
		GetPlayerPos(playerid,x,y,z);
		if(!IsPlayerInRangeOfPoint(id,10,x,y,z)) return SCM(playerid,COLOR_GREY,"Instructorul nu mai este langa tine.");
		if(PlayerInfo[playerid][pMoney] - PlayerInfo[playerid][pLicMoney] < 0 ) return SCM(playerid,COLOR_GREY,"Nu ai destui bani");
		new string[256];
  		if(number == 0)
		{
		    if(PlayerInfo[playerid][pWeaponLic] > 1200 )
		    {
		        SCM(playerid,COLOR_BLUE,"Ai deja licente.");
		        SCM(id,COLOR_BLUE,"Jucatorul are  deja licente.");
		        return 1;
		    }
		    /// aici pun norma la lf
		    PlayerInfo[playerid][pWeaponLic] = 7200;
		    PlayerInfo[playerid][pMoney] -= money;
		    PlayerInfo[id][pLicenseSold] ++;
		    PlayerInfo[id][pMoney] += money;
			format(string,sizeof(string),"Ai cumparat licenta de arme de la instructorul %s contra sumei de %d.",GetName(id),money);
			SCM(playerid,COLOR_BLUE,string);
			format(string,sizeof(string),"Jucatorul %s cumparat licenta de arme contra sumei de %d.",GetName(playerid),money);
			SCM(id,COLOR_BLUE,string);

		}
		else if(number == 1)
		{
		    if(PlayerInfo[playerid][pFlyLic] > 1200 )
		    {
		        SCM(playerid,COLOR_BLUE,"Ai deja licente.");
		        SCM(id,COLOR_BLUE,"Jucatorul are  deja licente.");
		        return 1;
		    }
			/// aici pun norma la lf
		    PlayerInfo[playerid][pFlyLic] = 7200;
		    PlayerInfo[playerid][pMoney] -= money;
		    PlayerInfo[id][pLicenseSold] ++;
		    PlayerInfo[id][pMoney] += money;
			format(string,sizeof(string),"Ai cumparat licenta de zbor de la instructorul %s contra sumei de %d.",GetName(id),money);
			SCM(playerid,COLOR_BLUE,string);
			format(string,sizeof(string),"Jucatorul %s cumparat licenta de zbor contra sumei de %d.",GetName(playerid),money);
			SCM(id,COLOR_BLUE,string);
		}
        else if(number == 2)
		{
		    if(PlayerInfo[playerid][pBoatLic] > 1200 )
		    {
		        SCM(playerid,COLOR_BLUE,"Ai deja licente.");
		        SCM(id,COLOR_BLUE,"Jucatorul are  deja licente.");
		        return 1;
		    }
		    /// aici pun norma la lf
		    PlayerInfo[playerid][pBoatLic] = 7200;
		    PlayerInfo[playerid][pMoney] -= money;
		    PlayerInfo[id][pLicenseSold] ++;
		    PlayerInfo[id][pMoney] += money;
			format(string,sizeof(string),"Ai cumparat licenta de navigatie de la instructorul %s contra sumei de %d.",GetName(id),money);
			SCM(playerid,COLOR_BLUE,string);
			format(string,sizeof(string),"Jucatorul %s cumparat licenta de navigatie contra sumei de %d.",GetName(playerid),money);
			SCM(id,COLOR_BLUE,string);
		}
		else if(number == 3)
		{
		    if(PlayerInfo[playerid][pWeaponLic] > 1200 )
		    {
		        SCM(playerid,COLOR_BLUE,"Ai deja licente.");
		        SCM(id,COLOR_BLUE,"Jucatorul are  deja licente.");
		        return 1;
		    }
			if(PlayerInfo[playerid][pFlyLic] > 1200 )
		    {
		        SCM(playerid,COLOR_BLUE,"Ai deja licente.");
		        SCM(id,COLOR_BLUE,"Jucatorul are  deja licente.");
		        return 1;
		    }
		    if(PlayerInfo[playerid][pBoatLic] > 1200 )
		    {
		        SCM(playerid,COLOR_BLUE,"Ai deja licente.");
		        SCM(id,COLOR_BLUE,"Jucatorul are  deja licente.");
		        return 1;
		    }
		    /// aici pun norma la lf///
		    PlayerInfo[id][pLicenseSold] +=3;
		    PlayerInfo[playerid][pWeaponLic] = 7200;
		    PlayerInfo[playerid][pFlyLic] = 7200;
		    PlayerInfo[playerid][pBoatLic] = 7200;
		    PlayerInfo[playerid][pMoney] -= money;
		    PlayerInfo[id][pMoney] += money;
			format(string,sizeof(string),"Ai cumparat toate licentele de la instructorul %s contra sumei de %d.",GetName(id),money);
			SCM(playerid,COLOR_BLUE,string);
			format(string,sizeof(string),"Jucatorul %s cumparat toate licentele contra sumei de %d.",GetName(playerid),money);
			SCM(id,COLOR_BLUE,string);
		}
	}
	return 1;
}
CMD:denylicenses(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
	    if(PlayerInfo[playerid][pLicMoney] == 0) return SCM(playerid,COLOR_GREY,"Nu ai nici o oferta de licente.");
	    new string[256];
	    format(string,sizeof(string),"Jucatorul %s a anulat oferta de licente.",GetName(playerid));
	    SCM(PlayerInfo[playerid][pLicID], COLOR_BLUE,string);
	    format(string,sizeof(string),"Ai anulat oferta de licente.");
	    SCM(playerid,COLOR_GREY,string);
		PlayerInfo[playerid][pLicMoney] = 0;
		PlayerInfo[playerid][pLicID] = 0;
		PlayerInfo[playerid][pLicNumber] = 0;
	}
	return 1;
}
CMD:givelicense(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
	    if(PlayerInfo[playerid][pFaction] != 12) return SCM(playerid,COLOR_GREY,"Nu esti instructor.");
		new id;
	    if(sscanf(params, "u", id)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/givelicense <playerid/name>");
	    {
	        if(IsPlayerConnected(id) )
			{
			    new Float:x,Float:y,Float:z;
			    GetPlayerPos(playerid,x,y,z);
			    if(!IsPlayerInRangeOfPoint(id,10,x,y,z) ) return SCM(playerid,COLOR_GREY,"Jucatorul nu este langa tine.");
				LicenseID[playerid][ID]=id;
                ShowPlayerDialog(playerid, DIALOG_LICSELL, DIALOG_STYLE_LIST, "Chose License", "Weapon License\nFlying License\nSailing License\nAll Licenses", "Choose", "Close");
			}
			else SCM(playerid,COLOR_GREY,"Jucatorul respectiv nu este conectat.");
	    }
	}
	return 1;
}
CMD:licenses(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
	    new string[256];
	    new var;
	    new var1;
	    if(PlayerInfo[playerid][pCarLic] > 0)
	    {
			var=((PlayerInfo[playerid][pCarLic]%60));
    		var1=PlayerInfo[playerid][pCarLic]/60;
	    	format(string,sizeof(string),"Driving license : Suspended [%d h %d m left]\n",var1,var);
		}
		else
		    format(string,sizeof(string),"Driving license : Passed\n");
		    
        if(PlayerInfo[playerid][pWeaponLic] > 0)
	    {
			var=((PlayerInfo[playerid][pWeaponLic]%60));
    		var1=PlayerInfo[playerid][pWeaponLic]/60;
	    	format(string,sizeof(string),"%sWeapon license : Passed [%d h %d m left]\n",string,var1,var);
		}
		else
		    format(string,sizeof(string),"%sWeapon license : Expired\n",string);
		    
        if(PlayerInfo[playerid][pBoatLic] > 0)
	    {
			var=((PlayerInfo[playerid][pBoatLic]%60));
    		var1=PlayerInfo[playerid][pBoatLic]/60;
	    	format(string,sizeof(string),"%sSailing license : Passed [%d h %d m left]\n",string,var1,var);
		}
		else
		    format(string,sizeof(string),"%sSailing license : Expired\n",string);
		    
        if(PlayerInfo[playerid][pFlyLic] > 0)
	    {
			var=((PlayerInfo[playerid][pFlyLic]%60));
    		var1=PlayerInfo[playerid][pFlyLic]/60;
	    	format(string,sizeof(string),"%sFlying license : Passed [%d h %d m left]\n",string,var1,var);
		}
		else
		    format(string,sizeof(string),"%sFlying license : Expired\n",string);
		    
	    ShowPlayerDialog(playerid, DIALOG_LICENSES, DIALOG_STYLE_MSGBOX, "Licenses", string, "Ok", "");
	}
	return 1;
}
CMD:killcp(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(CP[playerid][ID] == 6) return SCM(playerid, COLOR_GREY, "Nu poti anula acel CheckPoint.");
		if(PlayerInfo[playerid][pCanQuitJob] != 0) return SCM(playerid, COLOR_GREY, "Nu poti anula acel CheckPoint.");
	    DisablePlayerCheckpoint(playerid);
		CP[playerid][ID]=0;
		SendClientMessage(playerid,COLOR_LGREEN,"Ai anulat CheckPoint.");
	}
	return 1;
}
CMD:givebp(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
		if(PlayerInfo[playerid][pClub] == 0) return SCM(playerid,COLOR_GREY,"Nu esti membru al unuii club.");
	    if(PlayerInfo[playerid][pRClub] != 7) return SCM(playerid,COLOR_GREY,"Nu ai acces la aceasta comanda");
	    new string[256], reason[256], id, bountyp;
	    if(sscanf(params, "us[256]", id, bountyp, reason)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/givebp <playerid/name> <bounty points> <motiv>");
	    if(IsPlayerConnected(id) )
	    {
	    	if(PlayerInfo[playerid][pClub] != PlayerInfo[id][pClub]) return SCM(playerid,COLOR_GREY,"Jucatorul respectiv nu este in club cu tine.");
	    	if(bountyp < 0 ) return SCM(playerid, COLOR_GREY, "Numarul de BP trebuie sa fie pozitiv.");
	    	PlayerInfo[id][pBP] += bountyp;
	    	Update(id, pBP);
	    	format(string, sizeof(string), "Membrul %s a primit de la liderul %s %d BP, Motiv: %s.", GetName(id), GetName(playerid), bountyp, reason);
	    	foreach(new i : Player)
			{
			    if(IsPlayerConnected(i) )
			    {
			        if(PlayerInfo[i][pClub] == PlayerInfo[playerid][pClub])
			            SendClientMessage(i,COLOR_LGREEN,string);
			    }
			}
	    } else {
	    	SCM(playerid, COLOR_GREY, "Jucatorul respectiv nu este conectat.");
	    }
	}
	return 1;
}
CMD:givecrank(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pClub] == 0) return SCM(playerid, COLOR_GREY, "Nu esti membru al unui club.");
		if(PlayerInfo[playerid][pRClub] != 0) return SCM(playerid, COLOR_GREY, "Nu esti liderul clubului.");
		new id, rank;
		if(sscanf(params, "ui", id, rank)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/givecrank <playerid/name> <rank>");
		if(rank < 1 || rank > 6) return SCM(playerid, COLOR_GREY, "Rankul trebuie sa fie intre 1 si 6.");
		if(IsPlayerConnected(id) )
		{
			if(PlayerInfo[id][pClub] != PlayerInfo[playerid][pClub]) return SCM(playerid, COLOR_GREY, "Jucatorul nu este in club cu tine.");
			if(PlayerInfo[id][pRClub] == 7) return SCM(playerid, COLOR_GREY, "Nu poti schimba rank-ul unui lider.");
			PlayerInfo[id][pRClub] = rank;
			Update(id, pRClub);
			new string[256];
			format(string, sizeof(string), "Membrul %s a primit rank %d de la liderul %s.", GetName(id), rank, GetName(playerid));
	    	foreach(new i : Player)
			{
			    if(IsPlayerConnected(i) )
			    {
			        if(PlayerInfo[i][pClub] == PlayerInfo[playerid][pClub])
			            SendClientMessage(i,COLOR_LGREEN,string);
			    }
			}

		}
		else SCM(playerid, COLOR_GREY, "Jucatorul nu este conectat.");

	}
	return 1;
}
CMD:agl(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		new id, license[256];
		if(PlayerInfo[playerid][pAdmin] < 4) return SCM(playerid, COLOR_GREY, "Nu ai acces la aceasta comanda.");
		if(sscanf(params, "us[256]", id, license)) 
		{
			SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/agl <playerid/name> <license>");
			SCM(playerid, COLOR_GREY, "License: All, Driving, Sailing, Weapon, Flying");
			return 1;
		}
		if(!IsPlayerConnected(id)) return SCM(playerid, COLOR_GREY, "Jucatorul nu este conectat.");
		new All[] = "All"; new Driving[] = "Driving"; new Sailing[] = "Sailing"; new Weapon[] = "Weapon"; new Flying[] = "Flying"; /// 1 2 3 4 5
	    new number = 0;
		if(!strcmp(license, All, true)) number = 1;
		if(!strcmp(license, Driving, true)) number = 2;
		if(!strcmp(license, Sailing, true)) number = 3;
		if(!strcmp(license, Weapon, true)) number = 4;
		if(!strcmp(license, Flying, true)) number = 5;
		if(number == 0) return SCM(playerid, COLOR_GREY, "License: All, Driving, Sailing, Weapon, Flying");
		if(number == 1)
		{
			PlayerInfo[id][pCarLic] = 0;
			PlayerInfo[id][pWeaponLic] = 12000;
			PlayerInfo[id][pFlyLic] = 12000;
			PlayerInfo[id][pBoatLic] = 12000;
		}
		else if(number == 2) PlayerInfo[id][pCarLic] = 0;
		else if(number == 3) PlayerInfo[id][pBoatLic] = 12000;
		else if(number == 4) PlayerInfo[id][pWeaponLic] = 12000;
		else PlayerInfo[id][pFlyLic] = 12000;
		new string[256], string1[256];
		if(number == 1)
		{
			format(string, sizeof(string), "Adminul %s ti-a oferit toate licentele.", GetName(playerid));
			format(string1, sizeof(string1), "Adminul %s a oferit toate licentele jucatorului %s", GetName(playerid), GetName(id));

		} 
		else if (number == 2) 
		{
			format(string, sizeof(string), "Adminul %s ti-a oferit licenta de condus.", GetName(playerid));
			format(string1, sizeof(string1), "Adminul %s a oferit licenta de condus jucatorului %s", GetName(playerid), GetName(id));
		} 
		else if (number == 3) 
		{
			format(string, sizeof(string), "Adminul %s ti-a oferit licenta de navigatie.", GetName(playerid));
			format(string1, sizeof(string1), "Adminul %s a oferit licenta de navigatie jucatorului %s", GetName(playerid), GetName(id));
		} 
		else if (number == 4) 
		{
			format(string, sizeof(string), "Adminul %s ti-a oferit licenta de port-arma.", GetName(playerid));
			format(string1, sizeof(string1), "Adminul %s a oferit licenta de port-arma jucatorului %s", GetName(playerid), GetName(id));
		} 
		else if (number == 5) 
		{
			format(string, sizeof(string), "Adminul %s ti-a oferit licenta de zburat.", GetName(playerid));
			format(string1, sizeof(string1), "Adminul %s a oferit licenta de zburat jucatorului %s", GetName(playerid), GetName(id));
		}
		SCM(id, COLOR_LGREEN, string);
		foreach(new i : Player)
			{
			    if(IsPlayerConnected(i) )
			    {
			        if(PlayerInfo[i][pAdmin] >= 1 )
			            SendClientMessage(i,COLOR_LGREEN,string1);
			    }
			}
	}
	return 1;
}
CMD:mark(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pAdmin] < 1) return SCM(playerid, COLOR_GREY, "Nu ai acces la aceasta comanda.");
		new Float:x;
		new Float:y;
		new Float:z;
		GetPlayerPos(playerid, x, y, z);
		PlayerInfo[playerid][pMarkX] = x;
		PlayerInfo[playerid][pMarkY] = y;
		PlayerInfo[playerid][pMarkZ] = z;
		PlayerInfo[playerid][pMarkInterior] = GetPlayerInterior(playerid);
		PlayerInfo[playerid][pMarkVW] = GetPlayerVirtualWorld(playerid);
		SCM(playerid, COLOR_SNOW, "Ai setat mark.");
	}
	return 1;
}
CMD:gotomark(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pAdmin] < 1) return SCM(playerid, COLOR_GREY, "Nu ai acces la aceasta comanda.");
		if(PlayerInfo[playerid][pMarkX] == 999999 && PlayerInfo[playerid][pMarkY] == 999999 && PlayerInfo[playerid][pMarkZ] == 999999) return SCM(playerid, COLOR_SNOW, "Nu ai setat mark.");
		SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][pMarkVW]);
		SetPlayerInterior(playerid, PlayerInfo[playerid][pMarkInterior]);
		PlayerInfo[playerid][pVW] = PlayerInfo[playerid][pMarkVW];
		PlayerInfo[playerid][pInterior] = PlayerInfo[playerid][pMarkInterior];
		SetPlayerPos(playerid, PlayerInfo[playerid][pMarkX], PlayerInfo[playerid][pMarkY], PlayerInfo[playerid][pMarkZ]);
		SCM(playerid, COLOR_SNOW, "Ai fost teleportat la mark.");
	}
	return 1;
}

CMD:takebp(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
		if(PlayerInfo[playerid][pClub] == 0) return SCM(playerid,COLOR_GREY,"Nu esti membru al unui club.");
	    if(PlayerInfo[playerid][pRClub] != 7) return SCM(playerid,COLOR_GREY,"Nu ai acces la aceasta comanda");
	    new string[256], reason[256], id, bountyp;
	    if(sscanf(params, "uis[256]", id, bountyp, reason)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/givebp <playerid/name> <bounty points> <motiv>");
	    if(IsPlayerConnected(id) )
	    {
	    	if(PlayerInfo[playerid][pClub] != PlayerInfo[id][pClub]) return SCM(playerid,COLOR_GREY,"Jucatorul respectiv nu este in club cu tine.");
	    	if(bountyp < 0 ) return SCM(playerid, COLOR_GREY, "Numarul de BP trebuie sa fie pozitiv.");
	    	if(PlayerInfo[id][pBP] - bountyp < 0) return SCM(playerid, COLOR_GREY, "Jucatorul nu are destule BP.");
	    	PlayerInfo[id][pBP] -= bountyp;
	    	Update(id,pBP);
	    	format(string, sizeof(string), "Liderul %s i-a luat membrului %s %d BP, Motiv: %s.", GetName(playerid), GetName(id), bountyp, reason);
	    	foreach(new i : Player)
			{
			    if(IsPlayerConnected(i) )
			    {
			        if(PlayerInfo[i][pClub] == PlayerInfo[playerid][pClub])
			            SendClientMessage(i,COLOR_LGREEN,string);
			    }
			}
	    }
	    else
	    {
	    	SCM(playerid, COLOR_GREY, "Jucatorul respectiv nu este conectat.");
	    }
	}
	return 1;
}
CMD:cuninvite(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
	    if(PlayerInfo[playerid][pClub] == 0) return SCM(playerid,COLOR_GREY,"Nu esti membru al unui club.");
	    if(PlayerInfo[playerid][pRClub] != 7) return SCM(playerid,COLOR_GREY,"Nu ai acces la aceasta comanda");
	    new string[256],string1[256],id;
	    if(sscanf(params, "us[256]", id,string1)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/cuninvite <playerid/name> <motiv>");
	    if(IsPlayerConnected(id) )
	    {
	        if(id == playerid) return SCM(playerid,COLOR_LGREEN,"Nu iti poti da kick singur");
	        if(PlayerInfo[playerid][pClub] != PlayerInfo[id][pClub]) return SCM(playerid,COLOR_GREY,"Jucatorul respectiv nu este in club cu tine.");
	        format(string,sizeof(string),"Membrul %s a primit kick de la %s, motiv: %s.",GetName(id),GetName(playerid),string1);
			foreach(new i : Player)
			{
			    if(IsPlayerConnected(i) )
			    {
			        if(PlayerInfo[i][pClub] == PlayerInfo[playerid][pClub])
			            SendClientMessage(i,COLOR_LGREEN,string);
			    }
			}
			PlayerInfo[id][pClub]=0;
			CMute[id]=0;
			mysql_format(handle, string, sizeof(string), "UPDATE `users` SET `CMute`='%d' WHERE BINARY `Name`= BINARY '%s'",CMute[id],GetName(id));
   			mysql_query(handle,string);
			PlayerInfo[id][pRClub]=0;
			Update(id,pClub);
	    }
	    else SCM(playerid,COLOR_GREY,"Jucatorul respectiv nu este conectat.");

	}
	return 1;
}
CMD:funinvite(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
	    if(PlayerInfo[playerid][pFaction] == 0) return SCM(playerid,COLOR_GREY,"Nu esti membru al unei factiuni.");
	    if(PlayerInfo[playerid][pRFaction] != 7) return SCM(playerid,COLOR_GREY,"Nu ai acces la aceasta comanda");
	    new string[256],string1[256],id;
	    if(sscanf(params, "us[256]", id,string1)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/funinvite <playerid/name> <motiv>");
	    if(IsPlayerConnected(id) )
	    {
	        if(id == playerid) return SCM(playerid,COLOR_LGREEN,"Nu iti poti da kick singur");
	        if(PlayerInfo[playerid][pFaction] != PlayerInfo[id][pFaction]) return SCM(playerid,COLOR_GREY,"Jucatorul respectiv nu este in factiune cu tine.");
	        format(string,sizeof(string),"Membrul %s a primit kick de la %s, motiv: %s.",GetName(id),GetName(playerid),string1);
	        FactionMembers[PlayerInfo[playerid][pFaction]][fTotalMembers]--;
			foreach(new i : Player)
			{
			    if(IsPlayerConnected(i) )
			    {
			        if(PlayerInfo[i][pFaction] == PlayerInfo[playerid][pFaction])
			            SendClientMessage(i,COLOR_LGREEN,string);
			    }
			}
			if(PlayerInfo[id][pFaction] >= 1 && PlayerInfo[id][pFaction] <= 3)
			{
                PlayerInfo[id][pAssists]=0;
                PlayerInfo[id][pTickets]=0;
                PlayerInfo[id][pArrests]=0;
				PlayerInfo[id][pKills]=0;
				Update(id,pAssists);
				Update(id,pTickets);
				Update(id,pArrests);
				Update(id,pKills);
			}
			PlayerInfo[id][pFaction]=0;
			FMute[id]=0;
			mysql_format(handle, string, sizeof(string), "UPDATE `users` SET `FMute`='%d' WHERE BINARY `Name`= BINARY '%s'",FMute[id],GetName(id));
   			mysql_query(handle,string);
			PlayerInfo[id][pRFaction]=0;
			Update(id,pFaction);
			Update(id,pRFaction);
			if(PlayerInfo[id][pGender]==1)
			{
				PlayerInfo[id][pSkin]=Skins[0][1];
			}
			else
			{
				PlayerInfo[id][pSkin]=Skins[0][8];
			}
			Update(id,pSkin);
			
	    }
	    else SCM(playerid,COLOR_GREY,"Jucatorul respectiv nu este conectat.");

	}
	return 1;
}
CMD:cunmute(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
	    if(PlayerInfo[playerid][pClub] == 0) return SCM(playerid,COLOR_GREY,"Nu esti membru al unui club.");
	    if(PlayerInfo[playerid][pRClub] < 6) return SCM(playerid,COLOR_GREY,"Nu ai acces la aceasta comanda");
	    new string[256],id;
	    if(sscanf(params, "u", id)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/cunmute <playerid/name> ");
	    if(IsPlayerConnected(id) )
	    {
	        if(PlayerInfo[playerid][pClub] != PlayerInfo[id][pClub]) return SCM(playerid,COLOR_GREY,"Jucatorul respectiv nu este in club cu tine.");
	        if(CMute[id] == 0) return SCM(playerid,COLOR_GREY,"Jucatorul respective nu are club mute.");
	        CMute[id]=0;
	        format(string,sizeof(string),"Membrul %s a primit unmute de la %s .",GetName(id),GetName(playerid));
			foreach(new i : Player)
			{
			    if(IsPlayerConnected(i) )
			    {
			        if(PlayerInfo[i][pClub] == PlayerInfo[playerid][pClub])
			            SCM(i,COLOR_LGREEN,string);
			    }
			}
	    }
	    else SCM(playerid,COLOR_GREY,"Jucatorul respectiv nu este conectat.");
	    
	}
	return 1;
}
CMD:funmute(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
	    if(PlayerInfo[playerid][pFaction] == 0) return SCM(playerid,COLOR_GREY,"Nu esti membru al unei factiuni.");
	    if(PlayerInfo[playerid][pRFaction] < 6) return SCM(playerid,COLOR_GREY,"Nu ai acces la aceasta comanda");
	    new string[256],id;
	    if(sscanf(params, "u", id)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/funmute <playerid/name> ");
	    if(IsPlayerConnected(id) )
	    {
	        if(PlayerInfo[playerid][pFaction] != PlayerInfo[id][pFaction]) return SCM(playerid,COLOR_GREY,"Jucatorul respectiv nu este in factiune cu tine.");
	        if(FMute[id] == 0) return SCM(playerid,COLOR_GREY,"Jucatorul respective nu are faction mute.");
	        FMute[id]=0;
	        format(string,sizeof(string),"Membrul %s a primit unmute de la %s .",GetName(id),GetName(playerid));
			foreach(new i : Player)
			{
			    if(IsPlayerConnected(i) )
			    {
			        if(PlayerInfo[i][pFaction] == PlayerInfo[playerid][pFaction])
			            SCM(i,COLOR_LGREEN,string);
			    }
			}
	    }
	    else SCM(playerid,COLOR_GREY,"Jucatorul respectiv nu este conectat.");
	    
	}
	return 1;
}
CMD:fmute(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
	    if(PlayerInfo[playerid][pFaction] >= 1)
	    {
	        if(PlayerInfo[playerid][pRFaction] >= 6 )
	        {
	            new id, string[256],seconds;
	            if(sscanf(params, "uis[256]", id,seconds , string)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/fmute <playerid/name> <time in minutes> <reason>");
	            {
	                if(IsPlayerConnected(id) )
	                {
	                    if(PlayerInfo[id][pFaction] == PlayerInfo[playerid][pFaction])
	                    {
	                        if(PlayerInfo[id][pRFaction] < PlayerInfo[playerid][pRFaction])
	                        {
								new string1[256];
								FMute[id]+=(seconds*60);
								format(string1,sizeof(string1),"Membrul %s a primit mute de la %s pentru : %d minute.",GetName(id),GetName(playerid),seconds);
								foreach(new i : Player)
								{
								    if(IsPlayerConnected(i) )
								    {
								        if(PlayerInfo[i][pFaction] == PlayerInfo[playerid][pFaction])
								            SCM(i,COLOR_LGREEN,string1);
								    }
								}
								
	                        }
							else
							{
							    SCM(playerid,COLOR_WHITE,"Nu poti da mute unui membru cu rank mai mare sau egal cu al tau.");
							}
	                        
	                    }
	                    else
	                    {
	                        SCM(playerid,COLOR_BLUE,"Jucatorul respectiv nu este in factiune cu tine.");
	                    }
	                }
	                else
	                {
	                    SCM(playerid,COLOR_GREY,"Jucatorul respectiv nu este conectat.");
	                }
	            }
	        }
	        else
	        {
	            SCM(playerid,COLOR_GREY,"Nu ai acces la aceasta comanda.");
	        }
	    }
	    else
	    {
	        SCM(playerid,COLOR_BLUE,"Nu esti intr-o factiune.");
		}
	}
	return 1;
}
CMD:fmembers(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
		new faction = PlayerInfo[playerid][pFaction];
		if(faction == 0) return SCM(playerid,COLOR_LGREEN,"Nu faci parte dintr-o factiune.");
		if(faction >= 1 && faction <= 3)
		{
		    new string[256];
		    format(string,sizeof(string),"[%s Members]",PlayerInfo[playerid][pFacName]);
		    SCM(playerid,COLOR_BLUE,string);
		    for(new i= 0 ; i <= MAX_PLAYERS; i++)
		    {
		        if(IsPlayerConnected(i) && PlayerInfo[i][pFaction] == faction )
		        {
		        	format(string,sizeof(string),"Nume[%s] | Rank:[%s] | Tickets:[%d] | Assists:[%d] | Kills:[%d] | Arrests:[%d] | FW:[%d/3] | Mute:[%d Sec]",GetName(i),PlayerInfo[i][pFacRank],PlayerInfo[i][pTickets],PlayerInfo[i][pAssists],PlayerInfo[i][pKills],PlayerInfo[i][pArrests],PlayerInfo[i][pFW],FMute[i]);
					if(PlayerInfo[i][pRFaction] >=6 )
					    SCM(playerid,COLOR_RED,string);
					else
					    SCM(playerid,COLOR_BLUE,string);
				}
			}
		}
		if(faction == 10)
		{
		    new string[256];
		    format(string,sizeof(string),"[%s Members]",PlayerInfo[playerid][pFacName]);
		    SCM(playerid,COLOR_BLUE,string);
		    foreach(new i : Player)
		    {

		        if(IsPlayerConnected(i) && PlayerInfo[i][pFaction] == faction )
		        {
		        	format(string,sizeof(string),"Nume[%s] | Rank:[%s] | SoldPills[%d] | Healed People: [%d] | FW:[%d/3] | Mute:[%d Sec]",GetName(i),PlayerInfo[i][pFacRank],PlayerInfo[i][pPillsSold],PlayerInfo[i][pHealP],PlayerInfo[i][pFW],FMute[i]);
					if(PlayerInfo[i][pRFaction] >=6 )
					    SCM(playerid,COLOR_RED,string);
					else
					    SCM(playerid,COLOR_BLUE,string);
				}
			}
		}
		if(faction == 11)
		{
		    new string[256];
		    format(string,sizeof(string),"[%s Members]",PlayerInfo[playerid][pFacName]);
		    SCM(playerid,COLOR_BLUE,string);
		    foreach(new i : Player)
		    {

		        if(IsPlayerConnected(i) && PlayerInfo[i][pFaction] == faction )
		        {
		        	format(string,sizeof(string),"Nume[%s] | Rank:[%s] | Done Contracts[%d] | Failed Contracts: [%d] | Canceled Contracts: [%d] | FW:[%d/3] | Mute:[%d Sec]",GetName(i),PlayerInfo[i][pFacRank],PlayerInfo[i][pDoneContracts],PlayerInfo[i][pFailContracts],PlayerInfo[i][pCancelContracts],PlayerInfo[i][pFW],FMute[i]);
					if(PlayerInfo[i][pRFaction] >=6 )
					    SCM(playerid,COLOR_RED,string);
					else
					    SCM(playerid,COLOR_BLUE,string);
				}
			}
		}
		if(faction == 12)
		{
		    new string[256];
		    format(string,sizeof(string),"[%s Members]",PlayerInfo[playerid][pFacName]);
		    SCM(playerid,COLOR_BLUE,string);
		    foreach(new i : Player)
		    {

		        if(IsPlayerConnected(i) && PlayerInfo[i][pFaction] == faction )
		        {
		        	format(string,sizeof(string),"Nume[%s] | Rank:[%s] | LicenseSold[%d] | FW:[%d/3] | Mute:[%d Sec]",GetName(i),PlayerInfo[i][pFacRank],PlayerInfo[i][pLicenseSold],PlayerInfo[i][pFW],FMute[i]);
					if(PlayerInfo[i][pRFaction] >=6 )
					    SCM(playerid,COLOR_RED,string);
					else
					    SCM(playerid,COLOR_BLUE,string);
				}
			}
		}
		if(faction == 13)
		{
			new string[256];
			format(string,sizeof(string),"[%s Members]",PlayerInfo[playerid][pFacName]);
			SCM(playerid,COLOR_YELLOW,string);
			for(new i = 0; i <= MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i) && PlayerInfo[i][pFaction] == faction)
				{
					format(string,sizeof(string),"Nume[%s] | Rank:[%s] | Rides[%d] | FW:[%d/3] | Mute:[%d Sec]",GetName(i),PlayerInfo[i][pFacRank],PlayerInfo[i][pTaxiRaport],PlayerInfo[i][pFW],FMute[i]);
					if(PlayerInfo[i][pRFaction] >=6 )
					    SCM(playerid,COLOR_RED,string);
					else
					    SCM(playerid,COLOR_BLUE,string);
				}
			}
		}
		if(faction == 14)
		{
			new string[256];
			format(string,sizeof(string),"[%s Members]",PlayerInfo[playerid][pFacName]);
			SCM(playerid,COLOR_YELLOW,string);
			for(new i = 0; i <= MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i) && PlayerInfo[i][pFaction] == faction)
				{
					format(string,sizeof(string),"Nume[%s] | Rank:[%s] | NP Sold[%d] | FW:[%d/3] | Mute:[%d Sec]",GetName(i),PlayerInfo[i][pFacRank],PlayerInfo[i][pNrRaport],PlayerInfo[i][pFW],FMute[i]);
					if(PlayerInfo[i][pRFaction] >=6 )
					    SCM(playerid,COLOR_RED,string);
					else
					    SCM(playerid,COLOR_BLUE,string);
				}
			}
		}

	}
	return 1;
}
CMD:unfw(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
	    if(PlayerInfo[playerid][pFaction] == 0) return SCM(playerid,COLOR_GREY,"Nu esti membru al unei factiuni.");
	    if(PlayerInfo[playerid][pRFaction] != 7) return SCM(playerid,COLOR_GREY,"Nu esti liderul factiunii tale.");
	    new string[256],id;
	    if(sscanf(params, "us[256]", id, string)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/unfw <playerid/name> <reason>");
		if(IsPlayerConnected(id) )
		{
		    if(PlayerInfo[id][pFaction] == PlayerInfo[playerid][pFaction])
		    {
		        if(PlayerInfo[id][pFW] == 0) return SCM(playerid,COLOR_GREY,"Membrul respectiv nu are FW .");
		        PlayerInfo[id][pFW]--;
		        new string1[256];
		        format(string1,sizeof(string1),"Liderul %s a scos un FW membrului %s , motiv: %s .",GetName(playerid),GetName(id),string);
		        foreach(new i : Player)
				{
				    if(IsPlayerConnected(i) )
				    {
				        if(PlayerInfo[i][pFaction]==PlayerInfo[playerid][pFaction])
				        {
				            SCM(i,COLOR_LGREEN,string1);
				        }

				    }
				}
				Update(id,pFW);
		    }
		    else
		    {
		        SCM(playerid,COLOR_GREY,"Jucatorul respectiv nu este in factiune  cu tine");
		    }
		}
		else
  		{
  		    SCM(playerid,COLOR_GREY,"Jucatorul respectiv nu este conectat.");
		}
	}
	return 1;
	
}
CMD:fw(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
	    if(PlayerInfo[playerid][pFaction] == 0) return SCM(playerid,COLOR_BLUE,"Nu esti membru al unei factiuni.");
        if(PlayerInfo[playerid][pRFaction] != 7) return SCM(playerid,COLOR_BLUE,"Nu esti lider al factiunii tale");
	    new string[256],id;
	    if(sscanf(params, "us[256]", id, string)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/fw <playerid/name> <reason>");
	    if(IsPlayerConnected(id))
	    {
	        if(PlayerInfo[id][pFaction] == PlayerInfo[playerid][pFaction])
	        {
	            if(PlayerInfo[id][pRFaction] == 7 ) return SCM(playerid,COLOR_BLUE,"Nu poti da FW unui lider.");
				PlayerInfo[id][pFW]++;
				new string1[256],ok=0;
				if(PlayerInfo[id][pFW] >=3)
				{
					PlayerInfo[id][pFW]=0;
				    format(string1,sizeof(string1),"Membrul %s a primit kick din factiune : motiv 3/3 faction warn.",GetName(id));
				    ok=1;
					PlayerInfo[id][pFaction]=0;
					PlayerInfo[id][pRFaction]=0;
					Slap(id);
					SpawnPlayer(id);
					if(PlayerInfo[id][pGender]==1)
						{
							PlayerInfo[id][pSkin]=Skins[0][7];
						}
						else
						{
							PlayerInfo[id][pSkin]=Skins[0][8];
						}
					new str[256];
                    SetPlayerSkin(id,PlayerInfo[id][pSkin]);
					mysql_format(handle, str, sizeof(str), "UPDATE `users` SET `Skin`='%d'  WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[id][pSkin], GetName(id));
					mysql_query(handle,str);
					mysql_format(handle, str, sizeof(str), "UPDATE `users` SET `RFaction`='%d' WHERE BINARY `Name`= BINARY '%s'",PlayerInfo[id][pRFaction],GetName(id));
				    mysql_query(handle,str);
				    mysql_format(handle, str, sizeof(str), "UPDATE `users` SET `Faction`='%d' WHERE BINARY `Name`= BINARY '%s'",PlayerInfo[id][pFaction],GetName(id));
				    mysql_query(handle,str);
				    mysql_format(handle, gQuery, sizeof(gQuery), "SELECT * FROM factions WHERE ID = '%d'", PlayerInfo[id][pFaction]);
					mysql_tquery(handle, gQuery, "NumeFactiune", "i", id);
				}
				new string2[256];
				format(string2,sizeof(string2),"Membrul %s , a primit faction warn de la %s , motiv: %s .",GetName(id),GetName(playerid),string);
				Update(id,pFW);
				foreach(new i : Player)
				{
				    if(IsPlayerConnected(i) )
				    {
				        if(PlayerInfo[i][pFaction]==PlayerInfo[playerid][pFaction])
				        {
				            SCM(i,COLOR_LGREEN,string2);
				            if(ok==1) SCM(i,COLOR_LGREEN,string1);
				        }
				    
				    }
				}

	        }
	        else
	        {
	            SCM(playerid,COLOR_BLUE,"Jucatorul nu este membru al factiunii tale.");
			}
	    }
		else
		{
		    SCM(playerid,COLOR_BLUE,"Jucatorul nu este conectat.");
		}
	}
	return 1;
}
CMD:fill(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(IsPlayerAtFuelStation(playerid))
	    {
	        new carid=GetPlayerVehicleID(playerid);
			if(IsABike(carid) || IsAPlane(carid) || IsABoat(carid)) return SCM(playerid,COLOR_GREY,"Nu poti pune benzina acestui vehicul.");
			new price;
			new actualfuel = floatround(fuel[carid], floatround_round);
			price=(100-actualfuel)*10;
			if(actualfuel==100) return SCM(playerid,COLOR_BLUE,"Ai rezervorul plin.");
			if(PlayerInfo[playerid][pMoney]>=price)
			{
			    FillCar[playerid]=1;
				SCM(playerid,COLOR_BLUE,"Asteapta pana se umple rezevorul....");
				TogglePlayerControllable(playerid,0);
			}
			else
			{
			    SCM(playerid,COLOR_BLUE,"Nu ai destui bani.");
			}
	    }
	}
	return 1;
}
CMD:m(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pFaction]>=1&&PlayerInfo[playerid][pFaction]<=3)
	    {
	        if(PlayerInfo[playerid][pDuty]==0)  return SendClientMessage(playerid,COLOR_WHITE,"Nu esti la datorie.");
	        new id;
            if(sscanf(params, "u", id)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/m <playerid/name> ");
			if(IsPlayerConnected(id))
			{
			    if(id==playerid) return SendClientMessage(playerid,COLOR_GREY,"Nu te poti soma singur.");
			    new
			        Float:x,
			        Float:y,
			        Float:z;
				GetPlayerPos(playerid,x,y,z);
				
				if(IsPlayerInRangeOfPoint(id,30,x,y,z))
				{
				    new vehicle;
					vehicle = GetPlayerVehicleID(playerid);
					if(ServerVehicles[vehicle][vFaction]<1||ServerVehicles[vehicle][vFaction]>3) return SendClientMessage(playerid,COLOR_GREY,"Nu esti intr-o masina de politie");
					new string[256];
					format(string,sizeof(string),"%s %s : %s trage pe dreapta.",PlayerInfo[playerid][pFacRank],GetName(playerid),GetName(id));
					foreach(new i : Player)
					{
					    if(IsPlayerInRangeOfPoint(i,30,x,y,z))  SendClientMessage(i,COLOR_YELLOW,string);
					}
				}
				else
				{
				    SendClientMessage(playerid,COLOR_WHITE,"Jucatorul nu este langa tine");
				}
			}
			else
			{
			    SendClientMessage(playerid,COLOR_WHITE,"Jucatorul nu este conectat.");
			}
	    }
	}
	return 1;
}
CMD:clear(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pFaction]<=3&&PlayerInfo[playerid][pFaction]>=1)
	    {
	        new id;
	        if(sscanf(params, "u", id)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/clear <playerid/name>");
	        if(IsPlayerConnected(id))
	        {
	            new string[256];
	            UpdatePlayerWantedLevel( id, PlayerInfo[id][pWanted], 0 );
	            PlayerInfo[id][pWanted]=0;
	            PlayerInfo[id][pWantedMinute]=0;
	            SetPlayerWantedLevel(id, 0);
	            PlayerTextDrawHide(id,  wantedscade[id]);
	            mysql_format(handle, string, sizeof(string), "UPDATE `users` SET `Wanted`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[id][pWanted], GetName(id));
				mysql_query(handle,string);
				format(string,sizeof(string),"%s %s a sters wanted-ul jucatorului %s.",PlayerInfo[playerid][pFacRank],GetName(playerid),GetName(id));
				foreach(new i : Player)
					if(PlayerInfo[playerid][pFaction]<=3&&PlayerInfo[playerid][pFaction]>=1)
						SCM(i,COLOR_BLUE,string);
	            
			}
			else SCM(playerid,COLOR_BLUE,"Jucatorul nu este conectat.");
	    }
	    else SCM(playerid,COLOR_GREY,"Nu esti in departament.");
	}
	return 1;
}
CMD:aclear(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pAdmin]>=1)
	    {
	        new id;
	        if(sscanf(params, "u", id)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/aclear <playerid/name>");
	        if(IsPlayerConnected(id))
	        {
	            new string[256];
	            UpdatePlayerWantedLevel( id, PlayerInfo[id][pWanted], 0 );
	            PlayerInfo[id][pWanted]=0;
	            PlayerInfo[id][pWantedMinute]=0;
	            SetPlayerWantedLevel(id, 0);
	            PlayerTextDrawHide(id,  wantedscade[id]);
	            mysql_format(handle, string, sizeof(string), "UPDATE `users` SET `Wanted`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[id][pWanted], GetName(id));
				mysql_query(handle,string);
				format(string,sizeof(string),"Adminul %s a sters wanted-ul jucatorului %s.",GetName(playerid),GetName(id));
				foreach(new i : Player)
					if((PlayerInfo[playerid][pFaction]<=3&&PlayerInfo[playerid][pFaction]>=1)||PlayerInfo[playerid][pAdmin]>=1)
						SCM(i,COLOR_BLUE,string);

			}
			else SCM(playerid,COLOR_BLUE,"Jucatorul nu este conectat.");
	    }
	    else SCM(playerid,COLOR_GREY,"Nu esti admin.");
	}
	return 1;
}
CMD:jail(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pAdmin]>=1)
	    {
	        new id , seconds, string[256];
	        if(sscanf(params, "uis[256]", id,seconds,string)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/jail <playerid/name> <secunde> <motiv>");
	        {
	            if(IsPlayerConnected(id))
	            {
	            	if(seconds < 1) return SCM(playerid, COLOR_GREY, "Nu poti da jail unui jucator mai putin de 1 secunda.");
	                PlayerInfo[id][pJailTime]=seconds;
	                SetPlayerPos(id, 223.1602,114.7808,999.0156);
					SetPlayerVirtualWorld(id,15);
					SetPlayerInterior(id,10);
					PlayerInfo[playerid][pVW]=15;
					PlayerInfo[playerid][pInterior]=10;
					new announce[256];
					format(announce,sizeof(announce),"Jucatorul %s a primit jail pentru %d sec de la adminul %s , motiv: %s",GetName(id), seconds, GetName(playerid), string);
					SendClientMessageToAll(COLOR_RED,announce);
	            }
	            else SCM(playerid,COLOR_BLUE,"Jucatorul nu este conectat.");
	        }
	    }
	    else    SCM(playerid,COLOR_GREY,"Nu esti admin.");
	}
	return 1;
}
CMD:unjail(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pAdmin]>=1)
	    {
	        new id , string[256];
	        if(sscanf(params, "uis[256]", id,string)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/unjail <playerid/name> <motiv>");
	        {
	            if(IsPlayerConnected(id))
	            {
	                if(PlayerInfo[id][pJailTime]==0) return SCM(playerid,COLOR_GREY,"Jucatorul respectiv nu este in jail.");
	                PlayerInfo[id][pJailTime]=0;
					new announce[256];
					format(announce,sizeof(announce),"Jucatorul %s a primit unjail  de la adminul %d , motiv: %s",GetName(id),string);
					SendClientMessageToAll(COLOR_RED,announce);
	            }
	            else SCM(playerid,COLOR_BLUE,"Jucatorul nu este conectat.");
	        }
	    }
	    else    SCM(playerid,COLOR_GREY,"Nu esti admin.");
	}
	return 1;
}
CMD:ticket(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pFaction]==1)
	    {
	        if(PlayerInfo[playerid][pDuty]==0)  return SendClientMessage(playerid,COLOR_WHITE,"Nu esti la datorie.");
	        new id,motiv[256],suma;
            if(sscanf(params, "uis[256]", id,suma,motiv)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/ticket <playerid/name> <money> <reason>");
			if(IsPlayerConnected(id))
			{
			    if(suma<1||suma>9000000) return SendClientMessage(playerid,COLOR_GREY,"Amenda trebuie sa fie intre 1$ si 10kk $.");
			    if(id==playerid) return SendClientMessage(playerid,COLOR_GREY,"Nu te poti amenda singur");
			    new
			        Float:x,
			        Float:y,
			        Float:z;
				GetPlayerPos(playerid,x,y,z);
				if(IsPlayerInRangeOfPoint(id,10,x,y,z))
				{
					if(PlayerInfo[id][pTicketMoney]>0) return SendClientMessage(playerid,COLOR_GREY,"Acel jucator a primit deja o amenda, acum trebuie sa o plateasca");
					PlayerInfo[id][pTicketid]=playerid;
					PlayerInfo[id][pTicketMoney]=suma;
					new string[256];
					format(string,sizeof(string),"%s %s te-a amendat cu %d $ pentru %s ",PlayerInfo[playerid][pFacRank],GetName(playerid),suma,motiv);
					SendClientMessage(id,COLOR_BLUE,string);
					format(string,sizeof(string),"L-ai amendat pe %s cu suma de %d $ pentru %s",GetName(id),suma,motiv);
					SendClientMessage(playerid,COLOR_BLUE,string);
					SendClientMessage(id,COLOR_BLUE,"/payticket or /denyticket");
				}
				else
				{
				    SendClientMessage(playerid,COLOR_WHITE,"Jucatorul nu este langa tine");
				}
			}
			else
			{
			    SendClientMessage(playerid,COLOR_GREY,"Jucatorul nu este conectat");
			}
	    
		}
		else
		{
		    SendClientMessage(playerid,COLOR_GREY,"Nu faci parte din Police Department.");
		}
		
	}
	return 1;
}
CMD:payticket(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pTicketMoney]>0)
	    {
	        new string[256],id;
	        id=PlayerInfo[playerid][pTicketid];
	        PlayerInfo[id][pTickets]++;
			format(string,sizeof(string),"Jucatorul %s a platit amenda in valoare de %d.",GetName(playerid),PlayerInfo[playerid][pTicketMoney]);
			SendClientMessage(id,COLOR_BLUE,string);
			format(string,sizeof(string),"Ai platit amenda in valoare de %d.",PlayerInfo[playerid][pTicketMoney]);
			SendClientMessage(playerid,COLOR_BLUE,string);
			PlayerInfo[id][pMoney]=PlayerInfo[id][pMoney]+PlayerInfo[playerid][pTicketMoney];
			PlayerInfo[playerid][pMoney]=PlayerInfo[playerid][pMoney]-PlayerInfo[playerid][pTicketMoney];
			GivePlayerMoney(playerid,-PlayerInfo[playerid][pTicketMoney]);
			GivePlayerMoney(id,PlayerInfo[id][pTicketMoney]);
			PlayerInfo[playerid][pTicketMoney]=0;
			PlayerInfo[playerid][pTicketid]=0;
			mysql_format(handle, string, sizeof(string), "UPDATE `users` SET `Money`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pMoney], GetName(playerid));
			mysql_query(handle,string);
			mysql_format(handle, string, sizeof(string), "UPDATE `users` SET `Money`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[id][pMoney], GetName(id));
			mysql_query(handle,string);
	    }
	    else
	    {
	        SendClientMessage(playerid,COLOR_GREY,"Nu ai nici o amenda.");
	    }
	}
	return 1;
}
CMD:denyticket(playerid,params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pTicketMoney]>0)
	    {
	        new string[256],id;
	        id=PlayerInfo[playerid][pTicketid];
			format(string,sizeof(string),"Jucatorul %s a refuzat sa plateasca amenda.",GetName(playerid));
			SendClientMessage(id,COLOR_BLUE,string);
			format(string,sizeof(string),"Ai refuzat sa platesti amenda.",PlayerInfo[playerid][pTicketMoney]);
			SendClientMessage(playerid,COLOR_BLUE,string);
			PlayerInfo[playerid][pTicketMoney]=0;
			PlayerInfo[playerid][pTicketid]=0;
	    }
	    else
	    {
	        SendClientMessage(playerid,COLOR_GREY,"Nu ai nici o amenda.");
	    }
	}
	return 1;
}
CMD:duty(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pFaction]>=1&&PlayerInfo[playerid][pFaction]<=3)
	    {
	        if(IsPlayerInRangeOfPoint(playerid,5,256.5275,74.2209,1003.6406)||IsPlayerInRangeOfPoint(playerid,5,289.9962,173.3008,1007.1794)||IsPlayerInRangeOfPoint(playerid,5,-1348.4601,492.6391,11.1953))
	        {
				if(PlayerInfo[playerid][pDuty]==1) 
				{
				    PlayerInfo[playerid][pDuty]=0;
	            	SetPlayerArmour(playerid,0);
	            	SetPlayerHealth(playerid,100);
	            	SendClientMessage(playerid,COLOR_WHITE,"You're now off duty.");
				}
				else
				{
	    			PlayerInfo[playerid][pDuty]=1;
	       			SetPlayerArmour(playerid,100);
	          		SetPlayerHealth(playerid,100);
	            	SendClientMessage(playerid,COLOR_WHITE,"You're now on duty.");
            	}
	        }
	 	}
	 	else
	 	{
			SendClientMessage(playerid,COLOR_WHITE,"Nu esti in departament");
	 	}
	}
	return 1;
}
CMD:arrest(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pFaction]>=1&&PlayerInfo[playerid][pFaction]<=3)
	    {
	        if(PlayerInfo[playerid][pDuty]==0) return SendClientMessage(playerid,COLOR_WHITE,"Nu esti la datorie.");
	        if(IsPlayerInAnyVehicle(playerid)==0) return SendClientMessage(playerid,COLOR_WHITE,"Nu esti in masina");
	        new id, carid1,carid2;
            if(sscanf(params, "u", id)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/arrest <playerid/name>");
			if(IsPlayerConnected(id))
			{
                if(IsPlayerInRangeOfPoint(playerid,5,1529.9692,-1665.5592,6.2188))
                {
		            carid1=GetPlayerVehicleID(playerid);
					carid2=GetPlayerVehicleID(id);
					if(carid1==carid2)
					{
						new string[256];
						TogglePlayerControllable(id,1);
						format(string, sizeof(string),"Ofiterul %s a arestat jucatorul %s.",GetName(playerid),GetName(id));
						PlayerInfo[playerid][pArrests]++;
						SendClientMessageToAll(COLOR_WHITE,string);
						PlayerInfo[id][pJailTime]=400*PlayerInfo[id][pWanted];
						UpdatePlayerWantedLevel( id, PlayerInfo[id][pWanted], 0 );
		  				PlayerInfo[id][pWanted]=0;
		  				PlayerInfo[id][pWantedMinute]=0;
		  				SetPlayerPos(id, 223.1602,114.7808,999.0156);
						SetPlayerVirtualWorld(id,15);
						SetPlayerInterior(id,10);
						PlayerInfo[id][pVW]=15;
						PlayerInfo[id][pInterior]=10;
		  				new str1[256];
						format(str1, sizeof(str1),"Jail Time: %d", PlayerInfo[id][pJailTime]);
						PlayerTextDrawSetString(id, jailtime[id], str1);
						PlayerTextDrawShow(id, jailtime[id]);
						PlayerTextDrawHide(id,  wantedscade[id]);
				        SetPlayerWantedLevel(id, 0);
				        SetPlayerHealth(id,100);
				        mysql_format(handle, string, sizeof(string), "UPDATE `users` SET `JailTime`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[id][pJailTime], GetName(id));
					    mysql_query(handle,string);


					}
					else
					{
					    SendClientMessage(playerid,COLOR_WHITE,"Suspectul nu este in masina");
					}
				}
			}
			else
			{
			    SendClientMessage(playerid,COLOR_WHITE,"Suspectul nu este conectat.");
			}
	    }
	    else
	    {
	        SendClientMessage(playerid,COLOR_WHITE,"Nu esti in departament");
	    }
	}
	return 1;
}

CMD:givegun(playerid, params[])
{
	if(IsPlayerConnected(playerid))
 	{
	   	if (PlayerInfo[playerid][pAdmin] >= 2)
		{
			new id,gun,ammo,string[100],sendername[30],giveplayer[30];
			if(sscanf(params, "uii",id,gun,ammo))
   			{
   				SCM(playerid,COLOR_GREY, "Sintaxa: {FFFFFF}/givegun <playerid/name> <Weapon ID> <Gloante>");
			    SCM(playerid,COLOR_WHITE,"1-Brass Knuckles; 2-Golf Club; 3-Nightstick; 4-Knife; 5-Baseball Bat; 6-Shovel; 7-Pool Cue; 8-Katana;");
		    	SCM(playerid,COLOR_WHITE,"9-Chainsaw; 10-Double-ended Dildo; 11-Dildo; 12-Vibrator; 13-Silver Vibrator; 14-Flowers; 15-Cane;");
		    	SCM(playerid,COLOR_WHITE,"16-Grenade; 17-Tear Gas; 18-Molotov Cocktail; 22-9mm; 23-Silenced 9mm; 24-Desert Eagle; 25-Shotgun;");
		    	SCM(playerid,COLOR_WHITE,"26-Sawnoff Shotgun; 27-Combat Shotgun; 28-Micro SMG/Uzi; 29-MP5; 30-AK-47; 31-M4; 32-Tec-9; 33-Country Rifle;");
		    	SCM(playerid,COLOR_WHITE,"34-Sniper Rifle; 35-RPG; 36-HS Rocket; 37-Flamethrower; 38-Minigun; 39-Satchel Charge; 40-Detonator;");
		    	SCM(playerid,COLOR_WHITE,"41-Spraycan; 42-Fire Extinguisher; 43-Camera; 44-Night Vis Goggles; 46-Parachute;");
			    return 1;
	    	}
	  	    if(gun < 1||gun > 46||gun==19||gun==20||gun==21||gun==45) return SCM(playerid,COLOR_WHITE,"Invalid weapond ID.");
		    if(ammo <1||ammo > 1000) return SCM(playerid,COLOR_WHITE,"Invalid ammo (1-1000).");
			if(IsPlayerConnected(id))
			{
			    if(id != INVALID_PLAYER_ID)
			    {
					GivePlayerWeapon(id, gun, ammo);
					GetPlayerName(id, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					new gunname[32];
					GetWeaponName(gun, gunname, 32);
					format(string, sizeof(string), "AdmCmd: %s i-a dat lui %s arma %s (%d ammo).",sendername,giveplayer,gunname, ammo);
					foreach(new i : Player)
					{
					    if(IsPlayerConnected(i) )
					    {
					        if(PlayerInfo[i][pAdmin] >= 1)
					        	SCM(i,COLOR_RED,string);
					    }
					}
					if(GetPlayerState(id) == PLAYER_STATE_PASSENGER)
					{
				        new gun2,tmp;
				        GetPlayerWeaponData(id,5,gun2,tmp);
				        #pragma unused tmp
				        if(gun2)SetPlayerArmedWeapon(id,gun2);
				        else SetPlayerArmedWeapon(id,0);
					}
				}
			}
		    else return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat.");
		}
		else return SendClientMessage(playerid,COLOR_LGREEN, "Nu ai acces la aceasta comanda!");
	}
	return 1;
}
CMD:cuff(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pFaction]>=1&&PlayerInfo[playerid][pFaction]<=3)
	    {
	        if(PlayerInfo[playerid][pDuty]==0) return SendClientMessage(playerid,COLOR_WHITE,"Nu esti la datorie.");
	        if(IsPlayerInAnyVehicle(playerid)==0) return SendClientMessage(playerid,COLOR_WHITE,"Nu esti in masina");
	        new id, carid1,carid2;
            if(sscanf(params, "u", id)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/cuff <playerid/name>");
			if(IsPlayerConnected(id))
			{
			    if(playerid==id) return SendClientMessage(playerid,COLOR_WHITE,"Nu iti poti pune catusele singur.");
				carid1=GetPlayerVehicleID(playerid);
				carid2=GetPlayerVehicleID(id);
				if(carid1==carid2)
				{
				    if(PlayerInfo[id][pCuff]==1) return SendClientMessage(playerid,COLOR_WHITE,"Suspectul are deja catusele puse");
					new string[256];
					TogglePlayerControllable(id,0);
					format(string, sizeof(string),"Ofiterul %s ti-a pus catusele.",GetName(playerid));
					SendClientMessage(id,COLOR_WHITE,string);
					format(string, sizeof(string),"Ai pus catusele jucatorului %s",GetName(id));
					SendClientMessage(playerid,COLOR_WHITE,string);
					PlayerInfo[id][pCuff]=1;
				}
				else
				{
				    SendClientMessage(playerid,COLOR_WHITE,"Suspectul nu este in masina");
				}
			}
			else
			{
			    SendClientMessage(playerid,COLOR_WHITE,"Jucatorul nu este conectat");
			}
	    }
	    else
		{
		    SendClientMessage(playerid,COLOR_WHITE,"Nu esti in departament");
		}
	}
	return 1;
}
CMD:fixveh(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_LGREEN, "Nu ai acces la aceasta comanda!");
		{
    		if(IsPlayerInAnyVehicle(playerid))
		    {
			    RepairVehicle(GetPlayerVehicleID(playerid));
			    fuel[GetPlayerVehicleID(playerid)] = 100;
			    SendClientMessage(playerid, COLOR_YELLOW, "Comanda executata cu succes.");
		    }
		}
	}
	return 1;
} 
CMD:flip(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 1) return 1;
	if(!IsPlayerInAnyVehicle(playerid)) return 1;
	if(PlayerInfo[playerid][pWanted] != 0) return  SCM(playerid, -1, "Nu poti folosi aceasta comanda atata timp cat ai wanted!");
    new Float:angle;
    GetVehicleZAngle(GetPlayerVehicleID(playerid), angle);
    SetVehicleZAngle(GetPlayerVehicleID(playerid), angle);
    SendClientMessage(playerid, COLOR_YELLOW, "Comanda executata cu succes.");
	return 1;
}
CMD:nos(playerid, params[])
{
    	if(PlayerInfo[playerid][pWanted] > 0) return SCM(playerid,COLOR_GREY, "Ai wanted.");
	    if(IsPlayerConnected(playerid))
	    {
	        if(PlayerInfo[playerid][pAdmin] >= 2)
			{
				if(IsPlayerInAnyVehicle(playerid))
				{
					AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);
					SendClientMessage(playerid, COLOR_YELLOW, "Comanda executata cu succes.");
				}
			}
		}
		return 1;
}
CMD:uncuff(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pFaction]>=1&&PlayerInfo[playerid][pFaction]<=3)
	    {
	        if(PlayerInfo[playerid][pDuty]==0) return SendClientMessage(playerid,COLOR_WHITE,"Nu esti la datorie.");
	        if(IsPlayerInAnyVehicle(playerid)==0) return SendClientMessage(playerid,COLOR_WHITE,"Nu esti in masina");
	        new id, carid1,carid2;
            if(sscanf(params, "u", id)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/uncuff <playerid/name>");
			if(IsPlayerConnected(id))
			{
			    if(playerid==id) return SendClientMessage(playerid,COLOR_WHITE,"Nu iti poti pune catusele singur.");
				carid1=GetPlayerVehicleID(playerid);
				carid2=GetPlayerVehicleID(id);
				if(carid1==carid2)
				{
				    if(PlayerInfo[id][pCuff]==0) return SendClientMessage(playerid,COLOR_WHITE,"Suspectul nu are catusele puse");
					new string[256];
					TogglePlayerControllable(id,1);
					format(string, sizeof(string),"Ofiterul %s ti-a scos catusele.",GetName(playerid));
					SendClientMessage(id,COLOR_WHITE,string);
					format(string, sizeof(string),"Ai scos catusele jucatorului %s",GetName(id));
					SendClientMessage(playerid,COLOR_WHITE,string);
					PlayerInfo[id][pCuff]=0;
				}
				else
				{
				    SendClientMessage(playerid,COLOR_WHITE,"Suspectul nu este in masina");
				}
			}
			else
			{
			    SendClientMessage(playerid,COLOR_WHITE,"Jucatorul nu este conectat");
			}
	    }
	    else
		{
		    SendClientMessage(playerid,COLOR_WHITE,"Nu esti in departament");
		}
	}
	return 1;
}
CMD:gate(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pFaction]>=1&&PlayerInfo[playerid][pFaction]<=3)
	    {
	        if (IsPlayerInRangeOfPoint(playerid, 10.0, 1544.68945, -1630.74756, 13.16160))
	        {
	            if(pdgatecheck1==0)
	            {
					pdgatecheck1=1;
			        DestroyObject(pddown);
					pdup=CreateObject(968, 1544.68945, -1630.74756, 13.16160,   0.00000, 0.00000, -90.00000);
					SetTimer("pdgate1", 3000, false);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_GREY,"Bariera este deja deschisa");
				}
			}
			else if(IsPlayerInRangeOfPoint(playerid,10.0,1588.76697, -1638.40149, 15.07090))
			{
			    if(pdgatecheck2==0)
			    {
					pdgatecheck2=1;
					DestroyObject(pdgarage);
					SetTimer("pdgate2", 3000, false);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_GREY,"Poarta este deja deschisa");
				}
			}
			else if(IsPlayerInRangeOfPoint(playerid,10.0,321.44199, -1488.15222, 26.58430))
			{
			    if(fbigate1==0)
			    {
					fbigate1=1;
					DestroyObject(fbi1);
					SetTimer("fbi1gate", 3000, false);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_GREY,"Poarta este deja deschisa");
				}
			}
			else if(IsPlayerInRangeOfPoint(playerid,10.0,283.22751, -1542.60132, 27.09560))
			{
			    if(fbigate2==0)
			    {
					fbigate2=1;
					DestroyObject(fbi2);
					SetTimer("fbi2gate", 3000, false);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_GREY,"Poarta este deja deschisa");
				}
			}
			else if(IsPlayerInRangeOfPoint(playerid,10.0,-1530.22327, 482.41272, 6.21660))
			{
			    if(nggateo==0)
			    {
					nggateo=1;
					DestroyObject(nggate);
					SetTimer("nggateopen", 3000, false);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_GREY,"Poarta este deja deschisa");
				}
			}
			else if(IsPlayerInRangeOfPoint(playerid,20.0,-1466.54443, 500.94949, 5.89130))
			{
			    if(nggateo2==0)
			    {
					nggateo2=1;
					DestroyObject(nggate2);
					SetTimer("nggateopen2", 3000, false);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_GREY,"Poarta este deja deschisa");
				}
			}
			else if(IsPlayerInRangeOfPoint(playerid,30.0,-1635.62866, 688.16260, 9.17640))
			{
			    if(sfpdpoartao==0)
			    {
					sfpdpoartao=1;
					DestroyObject(sfpdpoarta1);
					DestroyObject(sfpdpoarta2);
					SetTimer("sfpdpoartaopen", 3000, false);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_GREY,"Poarta este deja deschisa");
				}
			}
            else if (IsPlayerInRangeOfPoint(playerid, 10.0, 1544.68945, -1630.74756, 13.16160))
	        {
	            if(pdgatecheck1==0)
	            {
					pdgatecheck1=1;
			        DestroyObject(pddown);
					pdup=CreateObject(968, 1544.68945, -1630.74756, 13.16160,   0.00000, 0.00000, -90.00000);
					SetTimer("pdgate1", 3000, false);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_GREY,"Bariera este deja deschisa");
				}
			}
			else if (IsPlayerInRangeOfPoint(playerid, 10.0, -1572.20435, 658.77692, 6.78130))
	        {
	            if(sfgate1status==0)
	            {
					sfgate1status=1;
			        DestroyObject(sfgate1c);
					sfgate1o=CreateObject(968, -1572.20435, 658.77692, 6.78130,   0.00000, 0.00000, 90.00000);
					SetTimer("sfgate1", 3000, false);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_GREY,"Bariera este deja deschisa");
				}
			}
			else if (IsPlayerInRangeOfPoint(playerid, 10.0, -1701.44263, 687.59241, 24.65360))
	        {
	            if(sfgate2status==0)
	            {
					sfgate2status=1;
			        DestroyObject(sfgate2c);
					sfgate2o=CreateObject(968, -1701.44263, 687.59241, 24.65360,   0.00000, 0.00000, 90.00000);
					SetTimer("sfgate2", 3000, false);
				}
				else
				{
				    SendClientMessage(playerid,COLOR_GREY,"Bariera este deja deschisa");
				}
			}
			
	    }
	    else
		{
		    SendClientMessage(playerid,COLOR_GREY,"Nu esti in politie.");
		}

	}
	return 1;
}
new HQfaction, HQvw1, HQinterior1,HQvw2, HQinterior2, HQjob, HType;
new Float: HQx;
new Float: HQy;
new Float: HQz;
CMD:pos1(playerid,params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pAdmin]>=6)
	    {
		    if(sscanf(params, "iiiiii",HQfaction , HQjob, HQvw1, HQinterior1,HQvw2, HQinterior2, HType)) return SendClientMessage(playerid,COLOR_GREY, "Sintaxa: {FFFFFF}/pos1 <faction> <job> <vw1> <interior1> <vw2> <interior2> <HType>");
	 		GetPlayerPos(playerid,HQx,HQy,HQz);
		   	SendClientMessage(playerid,COLOR_WHITE,"ai salvat pos1");
		}
		else SendClientMessage(playerid,COLOR_WHITE,"Nu ai admin");
	}
    return 1;
}
CMD:pos2(playerid,params[])
{
    if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pAdmin]>=6)
	    {
		    new Float: HQx1;
			new Float: HQy1;
			new Float: HQz1;
		    GetPlayerPos(playerid,HQx1,HQy1,HQz1);
		    SendClientMessage(playerid,COLOR_WHITE,"ai salvat pos2");
		    nrhq++;
		    new string[256];
		    format(string, sizeof(string),"INSERT INTO `svinterior`(`ID`, `Job`, `Faction`, `Interior1`, `VW1`, `VW2`, `Interior2`, `X1`, `Y1`, `Z1`, `X2`, `Y2`, `Z2`, `Type`) VALUES (%d,%d,%d,%d,%d,%d,%d,%f,%f,%f,%f,%f,%f,%d)",nrhq,HQjob,HQfaction,HQinterior1,HQvw1,HQvw2,HQinterior2,HQx,HQy,HQz,HQx1,HQy1,HQz1,HType);
		    mysql_query(handle,string);
        }
		else SendClientMessage(playerid,COLOR_WHITE,"Nu ai admin");
	}

    return 1;
}
CMD:enter(playerid,params[])
{
	if(IsPlayerConnected(playerid))
	{
        if(PlayerInfo[playerid][pWanted]!=0) return SendClientMessage(playerid,COLOR_WHITE,"Ai wanted");
	    for(new i=1;i<=nrhq;i++)
		{
	        if(IsPlayerInRangeOfPoint(playerid,2,SvHq[i][X1],SvHq[i][Y1],SvHq[i][Z1]))
	        {
				
                    SetPlayerPos(playerid, SvHq[i][X2], SvHq[i][Y2], SvHq[i][Z2]);
					SetPlayerVirtualWorld(playerid, SvHq[i][VW2]);
					SetPlayerInterior(playerid,SvHq[i][Interior2]);
					PlayerInfo[playerid][pVW]=SvHq[i][VW2];
					PlayerInfo[playerid][pInterior]=SvHq[i][Interior2];
			
			}
	    }
	}
	return 1;
}
CMD:exit(playerid,params[])
{
	if(IsPlayerConnected(playerid))
	{
	    for(new i=1;i<=nrhq;i++)
		{
	        if(IsPlayerInRangeOfPoint(playerid,2,SvHq[i][X2],SvHq[i][Y2],SvHq[i][Z2])&& GetPlayerVirtualWorld(playerid)==SvHq[i][VW2])
	        {
                    SetPlayerPos(playerid, SvHq[i][X1], SvHq[i][Y1], SvHq[i][Z1]);
					SetPlayerVirtualWorld(playerid, SvHq[i][VW1]);
					SetPlayerInterior(playerid,SvHq[i][Interior1]);
					PlayerInfo[playerid][pVW]=SvHq[i][VW1];
					PlayerInfo[playerid][pInterior]=SvHq[i][Interior1];
			}
	    }
	}
	return 1;
}
CMD:enterlf(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(IsPlayerInRangeOfPoint(playerid,5,-2046.1213,-96.8852,34.8954))
		{
		    if(PlayerInfo[playerid][pFaction]==12)
		    {
		        new Float:x, Float:y, Float:z;
				GetPlayerPos(playerid, x, y, z);
				new tmpcar = GetPlayerVehicleID(playerid);
				if (GetPlayerState(playerid) == 2)
				{
					SetVehiclePos(tmpcar, -2047.3822,-109.2990,34.9515);
				}
				else
				{
					SetPlayerPos(playerid,-2047.3822,-109.2990,34.9515);
				}
		    }
		    else
		    {
		        SendClientMessage(playerid,COLOR_WHITE,"Nu faci parte din License Faction");
		    }
		}
	}
	return 1;
}
CMD:exitlf(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(IsPlayerInRangeOfPoint(playerid,5,-2047.3822,-109.2990,34.9515))
		{
		    if(PlayerInfo[playerid][pFaction]==12)
		    {
		        new Float:x, Float:y, Float:z;
				GetPlayerPos(playerid, x, y, z);
				new tmpcar = GetPlayerVehicleID(playerid);
				if (GetPlayerState(playerid) == 2)
				{
					SetVehiclePos(tmpcar, -2046.1213,-96.8852,34.8954);
				}
				else
				{
					SetPlayerPos(playerid,-2046.1213,-96.8852,34.8954);
				}
		    }
		    else
		    {
		        SendClientMessage(playerid,COLOR_WHITE,"Nu faci parte din License Faction");
		    }
		}
	}
	return 1;
}
function IsPlayerAtHospital(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid,5,2036.2089,-1404.2548,17.2640) ) return 1;
	if(IsPlayerInRangeOfPoint(playerid,5,1182.3969,-1323.4067,13.5794) ) return 1;
	if(IsPlayerInRangeOfPoint(playerid,5,-2640.5422,637.7804,14.4531) ) return 1;
	return 0;
}
function PillsCoolDown(playerid)
{
	PillsCD[playerid]=0;
	return 1;
}
CMD:healme(playerid,params[])
{
	if(IsPlayerConnected(playerid) )
	{
	    if(IsPlayerAtHospital(playerid) )
	    {
            new Float:ph;
			GetPlayerHealth(playerid, ph);
			if(ph >= 95 ) return SCM(playerid, COLOR_GREY,"Ai viata full.");
			SetPlayerHealth(playerid,100.0);
	    }
	}
	return 1;
}
CMD:heal(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
	    if(PlayerInfo[playerid][pFaction] == 10 )
	 	{
	 	    new id;
            if(sscanf(params, "u", id)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/heal <playerid/name>");
			if(IsPlayerConnected(id) )
			{
			    if(id==playerid) return SendClientMessage(playerid,COLOR_GREY,"Nu te poti vindeca singur.");
			    new
			        Float:x,
			        Float:y,
			        Float:z;
				GetPlayerPos(playerid,x,y,z);
				if(IsPlayerInRangeOfPoint(id,10,x,y,z))
				{
					new Float:ph;
					GetPlayerHealth(id, ph);
					if(ph >= 95 ) return SCM(playerid, COLOR_GREY,"Jucatorul are viata full.");
					SetPlayerHealth(id,100);
					new string[256];
					format(string,sizeof(string),"Medicul %s te-a vindecat.",GetName(playerid));
					SCM(id,COLOR_RED1,string);
					format(string,sizeof(string),"Ai vindecat jucatorul %s.",GetName(id));
					SCM(playerid,COLOR_RED1,string);
					PlayerInfo[playerid][pHealP]++;
				}
			}
	    }
	}
	return 1;
}
CMD:getpills(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
	    if(IsPlayerAtHospital(playerid) )
	    {
			if(PlayerInfo[playerid][pFaction] != 10 ) return SCM(playerid,COLOR_GREY,"Nu esti medic.");
			if(PlayerInfo[playerid][pPills] > 20 ) return SCM(playerid,COLOR_GREY,"Mai poti lua pills doar cand ai mai putine de 20.");
			new var;
			var=100 + 50 * PlayerInfo[playerid][pRFaction];
			new string[256];
			format(string,sizeof(string),"Ai luat %d pills",var);
			SCM(playerid,COLOR_WHITE,string);
			PlayerInfo[playerid][pPills]+=var;
			Update(playerid,pPills);
    	}
	}
	return 1;
}
CMD:usedrugs(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		new string[256];
		if(DrugsTimer[playerid] != 0)
		{
			format(string, sizeof(string), "Trebuie sa mai astepti %d secunde.", DrugsTimer[playerid]);
			SCM(playerid, COLOR_GREY, string);
			return 1;
		}
		new Float:hp, gdrugs;
		GetPlayerHealth(playerid, hp);
		if(hp >= 99.0) return SCM(playerid, COLOR_GREY, "Ai viata full");
		if(PlayerInfo[playerid][pDrugs] == 0) return SCM(playerid, COLOR_GREY, "Nu mai ai drugs.");
		DrugsTimer[playerid] = 10;
		if(PlayerInfo[playerid][pDrugs] >= 4) gdrugs = 4;
		else gdrugs = PlayerInfo[playerid][pDrugs];
		PlayerInfo[playerid][pDrugs] -= gdrugs;
		hp = hp + gdrugs * 10;
		if(hp > 100.0) hp = 100;
		SetPlayerHealth(playerid, hp);
		format(string, sizeof(string), " %d Drugs Grams used !", gdrugs);
		SCM(playerid, COLOR_GREY, string);
		format(string, sizeof(string), "{9a70ba}%s used %d Drugs Grams", GetName(playerid), gdrugs);
		new Float:varX, Float:varY, Float:varZ;
		GetPlayerPos(playerid, varX, varY, varZ);
		new inter, vw;
		inter = GetPlayerInterior(playerid);
		vw = GetPlayerVirtualWorld(playerid);
		for(new i = 0; i <= MAX_PLAYERS; i++)
			if(IsPlayerInRangeOfPoint(i, 25, varX, varY, varZ) && GetPlayerInterior(i) == inter && GetPlayerVirtualWorld(i) == vw)
				SCM(i, -1, string);
	}
	return 1;
}
CMD:usepills(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
	    if(PillsCD[playerid] == 1 ) return SCM(playerid,COLOR_GREY,"Ai folosit deja pills . Asteapta 60 secunde.");
	    if(PlayerInfo[playerid][pPills] == 0 ) return SCM(playerid,COLOR_GREY,"Nu mai ai pills.");
	    new Float:ph;
		GetPlayerHealth(playerid, ph);
		if(ph >= 95 ) return SCM(playerid, COLOR_GREY,"Ai viata full.");
		PlayerInfo[playerid][pPills]--;
		Update(playerid,pPills);
		SetPlayerHealth(playerid,100.0);
		PillsCD[playerid] =1;
	    SetTimerEx("PillsCoolDown" , 60000 , false , "i" , playerid);
		SCM(playerid,COLOR_LGREEN,"Ai folosit un pill.");
	}
	return 1;
}
function ResetPills(playerid)
{
	if(PlayerInfo[playerid][pPillsnumber] != 0 )
	{
	    PlayerInfo[playerid][pPillsnumber] = 0;
	    SCM(playerid,COLOR_GREY,"Ai primit o oferta de pills de la un medic dar aceasta a expirat.");
	}
	return 1;
}
CMD:acceptpills(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pPillsnumber]>0)
	    {
	        new string[256],id;
	        id=PlayerInfo[playerid][pPillsid];
	        if(PlayerInfo[id][pPills] - PlayerInfo[playerid][pPillsnumber] < 0 ) return SCM(playerid,COLOR_GREY,"Medicul nu mai are destule pills.");
	        PlayerInfo[id][pPillsSold]++;
			format(string,sizeof(string),"Jucatorul %s a acceptat oferta.",GetName(playerid));
			SendClientMessage(id,COLOR_BLUE,string);
			format(string,sizeof(string),"Ai acceptat oferta si ai primit %d pills pentru %d $.",PlayerInfo[playerid][pPillsnumber] , 100 * PlayerInfo[playerid][pPillsnumber]);
			SendClientMessage(playerid,COLOR_BLUE,string);
			PlayerInfo[id][pMoney]=PlayerInfo[id][pMoney] + 100 * PlayerInfo[playerid][pPillsnumber];
			PlayerInfo[playerid][pMoney]=PlayerInfo[playerid][pMoney]-  100 * PlayerInfo[playerid][pPillsnumber];
			GivePlayerMoney(playerid,- 100 * PlayerInfo[playerid][pPillsnumber]);
			GivePlayerMoney(id, 100 * PlayerInfo[playerid][pPillsnumber]);
			PlayerInfo[playerid][pPills] = PlayerInfo[playerid][pPills] + PlayerInfo[playerid][pPillsnumber];
            PlayerInfo[id][pPills] = PlayerInfo[id][pPills] - PlayerInfo[playerid][pPillsnumber];
			PlayerInfo[playerid][pPillsnumber] = 0 ;
			PlayerInfo[playerid][pPillsid] = 0 ;
			mysql_format(handle, string, sizeof(string), "UPDATE `users` SET `Money`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pMoney], GetName(playerid));
			mysql_query(handle,string);
			mysql_format(handle, string, sizeof(string), "UPDATE `users` SET `Money`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[id][pMoney], GetName(id));
			mysql_query(handle,string);
	    }
	    else
	    {
	        SendClientMessage(playerid,COLOR_GREY,"Nu ai nici o oferta.");
	    }
	}
	return 1;
}
CMD:denypills(playerid,params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pPillsnumber]>0)
	    {
	        new string[256],id;
	        id=PlayerInfo[playerid][pTicketid];
			format(string,sizeof(string),"Jucatorul %s a refuzat pills.",GetName(playerid));
			SendClientMessage(id,COLOR_BLUE,string);
			format(string,sizeof(string),"Ai refuzat pills.",PlayerInfo[playerid][pTicketMoney]);
			SendClientMessage(playerid,COLOR_BLUE,string);
			PlayerInfo[playerid][pPillsnumber]=0;
			PlayerInfo[playerid][pPillsid]=0;
	    }
	    else
	    {
	        SendClientMessage(playerid,COLOR_GREY,"Nu ai nici o oferta.");
	    }
	}
	return 1;
}
CMD:sellpills(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pFaction]== 10)
	    {
	        new id,pills;
            if(sscanf(params, "ui", id,pills)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/sellpills <playerid/name> <pills>");
			if(IsPlayerConnected(id))
			{
			    if(id==playerid) return SendClientMessage(playerid,COLOR_GREY,"Nu iti poti vinde pills singur.");
			    new
			        Float:x,
			        Float:y,
			        Float:z;
				GetPlayerPos(playerid,x,y,z);
				if(IsPlayerInRangeOfPoint(id,10,x,y,z))
				{
   					new money;
					money= 100 * pills;
				    if(PlayerInfo[id][pPillsnumber] !=0 ) return SCM(playerid,COLOR_GREY,"Jucatorul respecitv are deja o oferta .");
				    if(PlayerInfo[playerid][pPills] - pills < 0 ) return SCM(playerid,COLOR_GREY,"Nu ai destule pills");
	        		if(PlayerInfo[id][pPills] > 5 ) return SCM(playerid,COLOR_GREY,"Nu poti vinde pills unui jucator care are deja mai mult de 5 pills.");
	        		if(PlayerInfo[id][pMoney] - money < 0 ) return SCM(playerid,COLOR_GREY,"Jucatorul respectiv nu are destui bani .");
				    SetTimerEx("ResetPills",60000,false,"i",id);
					PlayerInfo[id][pPillsid]=playerid;
					PlayerInfo[id][pPillsnumber]=pills;
					new string[256];
					format(string,sizeof(string),"%s %s	ti-a oferit %d pills pentru %d $ ",PlayerInfo[playerid][pFacRank],GetName(playerid),pills,money);
					SendClientMessage(id,COLOR_BLUE,string);
					format(string,sizeof(string),"Ai oferit jucatorului %s %d pills pentru %d $.",GetName(id) ,pills,money);
					SendClientMessage(playerid,COLOR_BLUE,string);
					SendClientMessage(id,COLOR_BLUE,"/acceptpills or /denypills");
				}
				else
				{
				    SendClientMessage(playerid,COLOR_WHITE,"Jucatorul nu este langa tine");
				}
			}
			else
			{
			    SendClientMessage(playerid,COLOR_GREY,"Jucatorul nu este conectat");
			}

		}
		else
		{
		    SendClientMessage(playerid,COLOR_GREY,"Nu esti medic.");
		}

	}
	return 1;
}
CMD:goto(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pWanted] > 0) return SendClientMessage(playerid,COLOR_GREY, "Ai wanted.");
		if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pHelper] >= 1)
		{
			new id;
			if(sscanf(params, "u", id)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/goto <playerid/name>");
			{
				if(id != INVALID_PLAYER_ID)
		        {

					new Float:x, Float:y, Float:z;
					GetPlayerPos(id, x, y, z);
					new tmpcar = GetPlayerVehicleID(playerid);
					if (GetPlayerState(playerid) == 2)
					{
						SetVehiclePos(tmpcar, x, y+4, z);
					}
					else
					{
						SetPlayerPos(playerid,x,y+2, z);
					}
					SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(id));
					SetPlayerInterior(playerid, GetPlayerInterior(id));
					PlayerInfo[playerid][pVW]=GetPlayerVirtualWorld(id);
					PlayerInfo[playerid][pInterior]=GetPlayerInterior(id);
					new string[256];
					format(string ,sizeof(string),"AdmCmd: %s s-a teleportat la %s.",GetName(playerid),GetName(id));
					foreach(new i : Player)
					{
					    if(PlayerInfo[i][pAdmin]>=1 || PlayerInfo[i][pHelper]>=1)
							SendClientMessage(i,COLOR_RED,string);
					}
					format(string ,sizeof(string),"AdmCmd: %s s-a teleportat la tine.",GetName(playerid));
					SendClientMessage(id,COLOR_WHITE,string);

				}
				else return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat.");
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_LGREEN, "Nu ai acces la aceasta comanda!");
		}
	}
	return 1;
}
CMD:restartgame(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pAdmin] >= 6)
		{
			new sendername[30],string[100];
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "AdmCmd: Admin %s a dat restart la server.", sendername);
			SendClientMessageToAll(COLOR_WHITE,string);
			GameModeExit();
		}
		else
		{
			SendClientMessage(playerid, COLOR_LGREEN, "Nu ai acces la aceasta comanda!");
		}
	}
	return 1;
}
CMD:mute(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pAdmin]>=1)
		{
		    new id,timp,motiv[190],string[256];
			if(sscanf(params, "uis[180]",id,timp,motiv)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/mute <playerid/name> <timp(minute)> <motiv>");
			if(IsPlayerConnected(id))
			{
				Mute[id]=timp*60;
                format(string, 250, "AdmCmd: %s a primit mute de la %s timp de %d minute pentru : %s",GetName(id),GetName(playerid),timp/60,motiv);
				SendClientMessageToAll(COLOR_RED,string);
				format(string, 250, "Ai primit mute de la %s pentru %d minute. De acum nu mai poti vorbi.",GetName(playerid),timp/60);
				SendClientMessage(id,COLOR_GREY,string);

			}
			else
			{
			SendClientMessage(playerid,COLOR_GREY,"Jucatorul nu este conectat.");
			}
		}
		else
		{
		SendClientMessage(playerid,COLOR_GREY,"Nu ai acces la aceasta comanda.");
		}

	}
    return 1;
}
CMD:mutelist(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    SendClientMessage(playerid,COLOR_GREY,"Mute List:");
	    foreach(new i : Player)
	    {
	        if(Mute[i]>0)
	        {
				new string[256];
				format(string,255,"Jucatorul %s are mute pentru inca %d minute si %d secunde.",GetName(i),Mute[i]/60,Mute[i]%60);
				SendClientMessage(playerid,COLOR_GREY,string);
	        }
	    }

	}
	return 1;
}
CMD:stats(playerid, params[])
{
	if(IsPlayerConnected(playerid))
 	{
 	    new string[300],sex[30];
 	    GetPlayerName(playerid, string , sizeof(string));
 	    if(PlayerInfo[playerid][pGender]==1)
 	        format(sex, 30, "Barbat");
 	    else
 	        format(sex, 30,"Femeie");

 	    SendClientMessage(playerid,COLOR_GREY,"----------------------------------------GFZONE--------------------------------------");
 	    SendClientMessage(playerid,COLOR_GREY,string);
 	    ///
		format(string, 300, "MaxCars[%d] Houseid:[%d] Level:[%d] Sex:[%s] Cash:[$%d] Admin:[%d] Helper:[%d] Pills:[%d]",PlayerInfo[playerid][pMaxCars],PlayerInfo[playerid][pHouseID],PlayerInfo[playerid][pLvl],sex,PlayerInfo[playerid][pMoney],PlayerInfo[playerid][pAdmin],PlayerInfo[playerid][pHelper],PlayerInfo[playerid][pPills]);
		SendClientMessage(playerid,COLOR_GREY,string);
		format(string, 300, "materials[%d] | seifMats[%d], drugs %d, seifdrugs %d", PlayerInfo[playerid][pMats], PlayerInfo[playerid][pSeifMats], PlayerInfo[playerid][pDrugs], PlayerInfo[playerid][pSeifDrugs]);
		SCM(playerid, COLOR_GREY, string);
		SendClientMessage(playerid,COLOR_GREY,"----------------------------------------GFZONE--------------------------------------");
	 }
	return 1;
}
/*CMD:jl(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		new string[256];
		format(string , sizeof(string), "JailTime: %d",PlayerInfo[playerid][pJailTime]);
		SendClientMessage(playerid,COLOR_GREY,string);
	}
	return 1;
}*/
CMD:respawn(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pAdmin]>=1)
	    {
		    new id,sendername[30],giveplayer[30];
			if(sscanf(params, "u",id)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/respawn <playerid/name>");
			if(IsPlayerConnected(id))
			{
			    GetPlayerName(id, giveplayer, sizeof(giveplayer));
				GetPlayerName(playerid, sendername, sizeof(sendername));
				Slap(id);
				SpawnPlayer(id);
				SetPlayerVirtualWorld(id,0);
				SetPlayerInterior(id,0);
				new str[256];
				format(str, 256, "You have been respawned by %s.", sendername);
				SendClientMessage(id,COLOR_GREY,str);
				format(str, 256, "You have been respawn player %s.", giveplayer);
				SendClientMessage(playerid,COLOR_GREY,str);
				foreach(new i : Player)
				{
					if(IsPlayerConnected(i))
					{
						if(PlayerInfo[i][pAdmin] != 0)
						{

							format(str, 256, "{ff0000}Adminul/Helperul %s a folosit comanda /respawn pe jucatorul %s", sendername, giveplayer);
							SendClientMessage(i,COLOR_GREY,str);
						}
					}
				}
			}
			else
			{
			    SendClientMessage(playerid,COLOR_GREY,"Acest jucator nu este conectat.");
   			}
		}
		else
		{
		    SendClientMessage(playerid,COLOR_GREY,"Nu ai acces la aceasta comanda");
		}
	}
	return 1;
}
CMD:sethp(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pAdmin]>=1)
	    {
		    new id,hp,sendername[30],giveplayer[30];
			if(sscanf(params, "ui",id,hp)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/sethp <playerid/name> <hp>");
			if(IsPlayerConnected(id))
			{
			    GetPlayerName(id, giveplayer, sizeof(giveplayer));
				GetPlayerName(playerid, sendername, sizeof(sendername));
				SetPlayerHealth(id,hp);
				new str[256];
				format(str, 256, "Adminul %s ti-a setat hp-ul la %d.", sendername, hp);
				SendClientMessage(id,COLOR_GREY,str);
				format(str, 256, "Ai setat hp-ul jucatorului %s la %d.", giveplayer, hp);
				SendClientMessage(playerid,COLOR_GREY,str);
				foreach(new i : Player)
				{
					if(IsPlayerConnected(i))
					{
						if(PlayerInfo[i][pAdmin] != 0)
						{

							format(str, 256, "{ff0000}Adminul %s a setat hp-ul jucatorului %s la %d.", sendername, giveplayer, hp);
							SendClientMessage(i,COLOR_GREY,str);
						}
					}
				}
			}
			else
			{
			    SendClientMessage(playerid,COLOR_GREY,"Acest jucator nu este conectat.");
   			}
		}
		else
		{
		    SendClientMessage(playerid,COLOR_GREY,"Nu ai acces la aceasta comanda");
		}
	}
	return 1;
}
CMD:fly(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pAdmin]>=4)
		{
		    SetPlayerHealth(playerid,99999);
		    StartFly(playerid);
		    SendClientMessage(playerid,COLOR_GREY,"Fly Mode activat.");
		}
		else
		{
		    SendClientMessage(playerid,COLOR_GREY,"Nu ai acces la aceasta comanda.");
		}
	}
	return 1;
}
CMD:stopfly(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pAdmin]>=4)
		{
		    StopFly(playerid);
		    SetPlayerHealth(playerid,100);
		    SendClientMessage(playerid,COLOR_GREY,"Fly Mode oprit.");
		}
		else
		{
		    SendClientMessage(playerid,COLOR_GREY,"Nu ai acces la aceasta comanda.");
		}
	}
	return 1;
}
CMD:pay(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
			new id,money,sendername[30],giveplayer[30],string[200];
			if(sscanf(params, "ui",id,money)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/pay <playerid/name> <money>");
			if(IsPlayerConnected(id))
			{
			    if(PlayerInfo[playerid][pMoney]-money>=0)
			    {
				    if(money>=1 && money <=10000000)
				    {

					    if(id != INVALID_PLAYER_ID)
					    {
							GetPlayerName(id, giveplayer, sizeof(giveplayer));
							GetPlayerName(playerid, sendername, sizeof(sendername));
							PlayerInfo[id][pMoney] +=money;
							GivePlayerMoney(id,money);
							PlayerInfo[playerid][pMoney]-=money;
							GivePlayerMoney(playerid,-money);

							foreach(new i : Player)
							{
								if(IsPlayerConnected(i))
								{
									if(PlayerInfo[i][pAdmin] != 0)
									{
										new str[256];
										format(str, 256, "{ff0000} Playerul %s a trimis jucatorului %s %d bani .", sendername, giveplayer, money);
										SendClientMessage(i,COLOR_GREY,str);
									}
								}
							}
							format(string, sizeof(string), "Ai primit de la %s %d bani.", sendername, money);
							SendClientMessage(id, COLOR_WHITE, string);
							format(string, sizeof(string), "I-ai dat jucatorului %s %d bani. .", giveplayer,money);
							SendClientMessage(playerid, COLOR_WHITE, string);
							new strr[256];
							mysql_format(handle, strr, sizeof(strr), "UPDATE `users` SET `Money`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[id][pMoney], giveplayer);
							mysql_query(handle,strr);
							mysql_format(handle, strr, sizeof(strr), "UPDATE `users` SET `Money`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pMoney], sendername);
							mysql_query(handle,strr);
						}
					}
					else
					{
						SendClientMessage(playerid,COLOR_GREY,"Banii pe care ii dai trebuie sa fie intre 1$ si 10kk$");
					}
				}
				else
				{
				    SendClientMessage(playerid,COLOR_GREY,"Nu ai suficienti bani.");
				}
			}
    		else
	    	{
		    	SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat.");
		    }
	}
	return 1;
}
CMD:kick(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{	new id, reason[128], string[256], sendername[25], giveplayer[25];
		if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pHelper] >= 2)
		{
		    if(sscanf(params, "us[128]", id, reason)) return SendClientMessage(playerid,COLOR_GREY, "Sintaxa: {FFFFFF}/kick <playerid/name> <Motiv>");
		    {
		        if(id != INVALID_PLAYER_ID)
		        {
					GetPlayerName(id, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), "AdmCmd: %s a primti kick de la %s, motiv: %s", giveplayer, sendername, reason);
					SendClientMessageToAll(COLOR_RED, string);
					KickEx(id);
				}
				else return SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat.");
			}
		}
		else return SendClientMessage(playerid, COLOR_GREY, "Nu ai acces la aceasta comanda!");
	}
	return 1;
}
CMD:unmute(playerid,params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pAdmin]>=1)
	    {
	        new id;
	        if(sscanf(params, "u",id)) return SendClientMessage(playerid,COLOR_GREY,"Sintaxa: {FFFFFF}/unmute <playerid/name>");
	        if(IsPlayerConnected(id))
	        {
	            Mute[id]=0;
				new string[256];
				format(string,sizeof(string),"%s a primit unmute de la %s.",GetName(id),GetName(playerid));
				foreach(new i : Player)
				{
				    if(PlayerInfo[i][pAdmin]>=0)
						SendClientMessage(i,COLOR_GREY,string);
				}
				format(string,sizeof(string),"Ai primit unmute de la %s.",GetName(playerid));
				SendClientMessage(id,COLOR_GREY,string);
	        }
	        else
	        {
	            SendClientMessage(playerid,COLOR_GREY,"Acest jucator nu este conectat.");
			}
	    }
	    else
	    {
			SendClientMessage(playerid,COLOR_GREY,"Nu ai acces la aceasta comanda.");
	    }
	}
	return 1;
}
CMD:spawncar(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pAdmin] >= 2)
		{
			new model,sendername[25],string[256];
			if(sscanf(params, "i", model)) return SendClientMessage(playerid,COLOR_GREY, "Sintaxa: {FFFFFF}/spawncar <Model>");
			if(model < 400 || model > 611) return SendClientMessage(playerid,COLOR_GREY, "Invalid car ID.");
	    	new Float:X,Float:Y,Float:Z;
			GetPlayerPos(playerid, X,Y,Z);
	     	CreateVehicle(model, X,Y,Z, 0.0, -1, -1, 100);
	       	GetPlayerName(playerid, sendername, sizeof(sendername));
	    	format(string, sizeof(string), "AdmCmd: Admin %s a spawnat o masina , model: %d.",sendername,model);
	    	foreach(new i : Player)
	        {
		    	if(IsPlayerConnected(i))
				{
					if(PlayerInfo[i][pAdmin] != 0)
						SendClientMessage(i,COLOR_GREY,string);
				}
			}
		}
		else return SendClientMessage(playerid, COLOR_LGREEN, "Nu ai acces la aceasta comanda!");
	}
	return 1;
}

CMD:undercover(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pFaction]>=1&&PlayerInfo[playerid][pFaction]<=2)
	    {
	    
	        if(IsPlayerInRangeOfPoint(playerid,5,254.1615,77.7713,1003.6406)||IsPlayerInRangeOfPoint(playerid,5,285.3049,173.5263,1007.1719))
	        {
	            if(PlayerInfo[playerid][pRFaction]<3) return SendClientMessage(playerid,COLOR_GREY,"Nu ai rank-ul necesar pentru a fi undercover");
	        	if(PlayerInfo[playerid][pDuty]==0) return SendClientMessage(playerid,COLOR_GREY,"Nu esti la datorie.");
	        	if(PlayerInfo[playerid][pUndercover] == 1 )
	        	{
	        		PlayerInfo[playerid][pUndercover] = 0;
	        	    SetPlayerArmour(playerid,100);
			    	SetPlayerHealth(playerid,100);
			    	CheckColor(playerid);
                    SetPlayerSkin(playerid,Skins[PlayerInfo[playerid][pFaction]][PlayerInfo[playerid][pRFaction]]);
	        	}
				else if(PlayerInfo[playerid][pUndercover] == 0)
	        	{
                    PlayerInfo[playerid][pUndercover] = 1;
	            	ShowPreviewModelDialog(playerid, DIALOG_UNDERCOVER, "Undercover Selection Dialog", UNDERCOVER_MODELS, UNDERCOVER_NAMES, "Select", "Cancel");
	            }
	        }
	    }
	}
	return 1;
}
CMD:cinvite(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pRClub]==7)
	    {
	        new id;
			if(sscanf(params, "ui",id)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/cinvite <playerid/name>");
			if(IsPlayerConnected(id))
			{
			    if(PlayerInfo[id][pClub]==0)
			    {
			        if(PlayerInfo[id][pWanted]!=0) return SendClientMessage(playerid,COLOR_GREY,"Acel jucator are wanted.");
					PlayerInfo[id][pClub]=PlayerInfo[playerid][pClub];
					PlayerInfo[id][pRClub]=1;
					new str[256];
					format(str,sizeof(str),"Jucatorul %s a intrat in club . Welcome! ",GetName(id));
					foreach(new i : Player)
					{
					    if(IsPlayerConnected(i) )
					    {
					        if(PlayerInfo[i][pClub] == PlayerInfo[playerid][pClub])
					        {
					            SCM(i,COLOR_LGREEN,str);
					        }
						}
					}
					mysql_format(handle, str, sizeof(str), "UPDATE `users` SET `Club`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[id][pClub], GetName(id));
					mysql_query(handle,str);
					mysql_format(handle, str, sizeof(str), "UPDATE `users` SET `RClub`='1' WHERE BINARY `Name`= BINARY '%s'", GetName(id));
				    mysql_query(handle,str);
				    mysql_format(handle, gQuery, sizeof(gQuery), "SELECT * FROM club WHERE ID = '%d'", PlayerInfo[id][pClub]);
					mysql_tquery(handle, gQuery, "NumeClub", "i", id);
					SpawnPlayer(id);

				}
				else
				{
				    SendClientMessage(playerid,COLOR_GREY,"Acel jucator este deja intr-un club.");
				}
			
			}
			else
			{
			    SendClientMessage(playerid,COLOR_GREY,"Jucatorul nu este conectat.");
			}
			
	    }
	    else
	    {
	        SendClientMessage(playerid,COLOR_GREY,"Nu esti lider.");
	    }
	}
	return 1;
}
CMD:finvite(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pRFaction]==7)
	    {
	        new id;
			if(sscanf(params, "ui",id)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/finvite <playerid/name>");
			if(IsPlayerConnected(id))
			{
			    if(PlayerInfo[id][pFaction]==0)
			    {
			        if(PlayerInfo[id][pWanted]!=0) return SendClientMessage(playerid,COLOR_GREY,"Acel jucator are wanted.");
			        if(FactionMembers[PlayerInfo[playerid][pFaction]][fTotalMembers] + 1 > FactionMembers[PlayerInfo[playerid][pFaction]][fMaxMembers]) return SCM(playerid, COLOR_GREY, "Nu mai poti invita jucatori in factiune.");
				    if(PlayerInfo[id][pGender]==1)
					{
						PlayerInfo[id][pSkin]=Skins[PlayerInfo[playerid][pFaction]][1];
					}
					else
					{
						PlayerInfo[id][pSkin]=Skins[PlayerInfo[playerid][pFaction]][8];
					}
					FactionMembers[PlayerInfo[playerid][pFaction]][fTotalMembers]++;
					PlayerInfo[id][pFaction]=PlayerInfo[playerid][pFaction];
					PlayerInfo[id][pRFaction]=1;
					new str[256];
					format(str,sizeof(str),"Jucatorul %s a intrat in factiune . Welcome! ",GetName(id));
					foreach(new i : Player)
					{
					    if(IsPlayerConnected(i) )
					    {
					        if(PlayerInfo[i][pFaction] == PlayerInfo[playerid][pFaction])
					        {
					            SCM(i,COLOR_LGREEN,str);
					        }
						}
					}
					if(PlayerInfo[id][pFaction] == 13)
					{
						PlayerInfo[id][pTaxiRaport] = 0;
						Update(id, pTaxiRaport);
					}
					mysql_format(handle, str, sizeof(str), "UPDATE `users` SET `Faction`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[id][pFaction], GetName(id));
					mysql_query(handle,str);
					mysql_format(handle, str, sizeof(str), "UPDATE `users` SET `Skin`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[id][pSkin], GetName(id));
					mysql_query(handle,str);
					mysql_format(handle, str, sizeof(str), "UPDATE `users` SET `RFaction`='1' WHERE BINARY `Name`= BINARY '%s'", GetName(id));
				    mysql_query(handle,str);
				    mysql_format(handle, gQuery, sizeof(gQuery), "SELECT * FROM factions WHERE ID = '%d'", PlayerInfo[id][pFaction]);
					mysql_tquery(handle, gQuery, "NumeFactiune", "i", id);
					SpawnPlayer(id);

				}
				else
				{
				    SendClientMessage(playerid,COLOR_GREY,"Acel jucator este deja intr-o factiune.");
				}
			
			}
			else
			{
			    SendClientMessage(playerid,COLOR_GREY,"Jucatorul nu este conectat.");
			}
			
	    }
	    else
	    {
	        SendClientMessage(playerid,COLOR_GREY,"Nu esti lider.");
	    }
	}
	return 1;
}
CMD:giverank(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pRFaction]==7)
	    {
	        new id,rank;
			if(sscanf(params, "ui",id,rank)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/giverank <playerid/name> <rank>");
			if(IsPlayerConnected(id))
			{
				if(PlayerInfo[id][pFaction]==PlayerInfo[playerid][pFaction])
	   			{
	   				if(PlayerInfo[id][pRFaction] == 7) return SCM(playerid, COLOR_GREY, "Nu poti folosi aceasta comanda pe un lider.");
	   			    if(rank>0&&rank<7)
	   			    {
	   			        if(PlayerInfo[id][pRFaction]!= rank)
	   			        {
			            	if(PlayerInfo[id][pGender]==1)
							{
								PlayerInfo[id][pSkin]=Skins[PlayerInfo[playerid][pFaction]][rank];
							}
							else
							{
								PlayerInfo[id][pSkin]=Skins[PlayerInfo[playerid][pFaction]][8];
							}
							new string[256];
							if(rank < PlayerInfo[id][pRFaction])
								format(string,sizeof(string),"Liderul %s a dat rank down membrului %s.",GetName(playerid),GetName(id));
							else
							    format(string,sizeof(string),"Liderul %s ti-a dat rank up membrului %s.",GetName(playerid),GetName(id));
							foreach(new i : Player)
							{
							    if(PlayerInfo[i][pFaction] == PlayerInfo[playerid][pFaction])
							        SCM(i,COLOR_GREY,string);
							}
							PlayerInfo[id][pRFaction]=rank;
							new str[256];
							SetPlayerSkin(id,PlayerInfo[id][pSkin]);
							mysql_format(handle, str, sizeof(str), "UPDATE `users` SET `Skin`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[id][pSkin], GetName(id));
							mysql_query(handle,str);
							mysql_format(handle, str, sizeof(str), "UPDATE `users` SET `RFaction`='%d' WHERE BINARY `Name`= BINARY '%s'",PlayerInfo[id][pRFaction],GetName(id));
						    mysql_query(handle,str);
						    mysql_format(handle, gQuery, sizeof(gQuery), "SELECT * FROM factions WHERE ID = '%d'", PlayerInfo[id][pFaction]);
							mysql_tquery(handle, gQuery, "NumeFactiune", "i", id);

	   			        }
	   			        else
	   			        {
	   			            SendClientMessage(playerid,COLOR_GREY,"Acel memebru are deja acel rank");
	   			        }
	   			    }
	   			    else
	   			    {
	   			        SendClientMessage(playerid,COLOR_GREY,"Alege un rank existent.");
	   			    }
	   			}
	   			else
	   			{
	   			    SendClientMessage(playerid,COLOR_GREY,"Acel player nu este din factiunea ta.");
	   			}
            }
            else
            {
                SendClientMessage(playerid,COLOR_GREY,"Acel jucator nu este conectat");
			}
	    
	    }
	    else
	    {
	        SendClientMessage(playerid,COLOR_GREY,"Nu esti lider.");
	    }
	}
	return 1;
}
CMD:fpk(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pAdmin] >= 4)
	    {
	        new id,motiv[256],string[256];
			if(sscanf(params, "us[255]",id,motiv)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/fpk <playerid/name> <motiv>");
			if(IsPlayerConnected(id))
			{
			    if(PlayerInfo[id][pFaction]!=0)
			    {
			    		FactionMembers[PlayerInfo[id][pFaction]][fTotalMembers]--;
						PlayerInfo[id][pFaction] = 0;
						PlayerInfo[id][pRFaction] = 0;
						if(PlayerInfo[id][pGender]==1)
						{
							PlayerInfo[id][pSkin]=Skins[0][1];
						}
						else
						{
							PlayerInfo[id][pSkin]=Skins[0][8];
						}
						printf("AdmCmd: %s has been kicked from faction by %s , reason: %s", GetName(id), GetName(playerid),motiv);
						format(string, sizeof(string), "AdmCmd: %s has been kicked from faction by %s , reason: %s", GetName(id), GetName(playerid),motiv);
						SendClientMessageToAll(COLOR_WHITE, string);
						new str[256];
						mysql_format(handle, str, sizeof(str), "UPDATE `users` SET `Faction`='0' WHERE BINARY `Name`= BINARY '%s'", GetName(id));
						mysql_query(handle,str);
						mysql_format(handle, str, sizeof(str), "UPDATE `users` SET `Skin`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[id][pSkin], GetName(id));
						mysql_query(handle,str);
						mysql_format(handle, str, sizeof(str), "UPDATE `users` SET `RFaction`='0' WHERE BINARY `Name`= BINARY '%s'", GetName(id));
						mysql_query(handle,str);
						mysql_format(handle, gQuery, sizeof(gQuery), "SELECT * FROM factions WHERE ID = '%d'", PlayerInfo[id][pFaction]);
    					mysql_tquery(handle, gQuery, "NumeFactiune", "i", id);
    					Slap(id);
    					SpawnPlayer(id);
			    }
			    else
			    {
			        SendClientMessage(playerid,COLOR_GREY,"Acel player nu face parte dintr-o factiune.");
			    }
			}
			else
			{
			    SendClientMessage(playerid,COLOR_GREY,"Acel player nu este conectat.");
			}
	    }
	    else
	    {
	        SendClientMessage(playerid,COLOR_GREY,"Nu ai acces la aceasta comanda.");
	    }
	}
	return 1;
}
CMD:makefleader(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pAdmin] >= 1337)
		{
			new id,factiune,sendername[30],giveplayer[30],string[200];
			if(sscanf(params, "ui",id,factiune)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/makefleader <playerid/name> <Faction>");
			if(IsPlayerConnected(id))
			{
			    if(factiune>0&&factiune<=14)
			    {

				    if(id != INVALID_PLAYER_ID)
				    {
						GetPlayerName(id, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						PlayerInfo[id][pFaction] = factiune;
						PlayerInfo[id][pRFaction] = 7;
						PlayerInfo[id][pFW] = 0;

						if(PlayerInfo[playerid][pGender]==1)
						{
							PlayerInfo[id][pSkin]=Skins[factiune][7];
						}
						else
						{
							PlayerInfo[id][pSkin]=Skins[factiune][8];
						}
						printf("AdmCmd: %s has promoted %s to leader to faction number %d", sendername, giveplayer, factiune);
						format(string, sizeof(string), "Ai fost promovat la functia lider la factiunea numarul %d de catre %s,", factiune, sendername);
						SendClientMessage(id, COLOR_WHITE, string);
						format(string, sizeof(string), "L-ai promovat pe %s la functia de lider la factiunea %d .", giveplayer,factiune);
						SendClientMessage(playerid, COLOR_WHITE, string);
					 	new wakaname[25];
						GetPlayerName(id,wakaname,25);
						new str[256];
						mysql_format(handle, str, sizeof(str), "UPDATE `users` SET `Faction`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[id][pFaction], wakaname);
						mysql_query(handle,str);
						mysql_format(handle, str, sizeof(str), "UPDATE `users` SET `Skin`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[id][pSkin], wakaname);
						mysql_query(handle,str);
						mysql_format(handle, str, sizeof(str), "UPDATE `users` SET `RFaction`='7' WHERE BINARY `Name`= BINARY '%s'", wakaname);
						mysql_query(handle,str);
						mysql_format(handle, gQuery, sizeof(gQuery), "SELECT * FROM factions WHERE ID = '%d'", PlayerInfo[id][pFaction]);
    					mysql_tquery(handle, gQuery, "NumeFactiune", "i", id);
    					Slap(id);
    					SpawnPlayer(id);
					}
				}
				else
				{
					SendClientMessage(playerid,COLOR_GREY,"Alege o factiune existenta.");
				}

			}
    		else
	    	{
		    	SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat.");
		    }
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREY, "Nu ai acces la aceasta comanda!");
		}
	}
	return 1;
}
CMD:makecleader(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			new id,factiune,sendername[30],giveplayer[30],string[200];
			if(sscanf(params, "ui",id,factiune)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/makefleader <playerid/name> <Club>");
			if(IsPlayerConnected(id))
			{
			    if(factiune>0&&factiune<=3)
			    {
				    if(id != INVALID_PLAYER_ID)
				    {
						GetPlayerName(id, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						PlayerInfo[id][pClub] = factiune;
						PlayerInfo[id][pRClub] = 7;
						printf("AdmCmd: %s has promoted %s to leader to club number %d", sendername, giveplayer, factiune);
						format(string, sizeof(string), "Ai fost promovat la fucntia lider la clubul numarul %d de catre %s,", factiune, sendername);
						SendClientMessage(id, COLOR_WHITE, string);
						format(string, sizeof(string), "L-ai promovat pe %s la functia de lider la clubul %d .", giveplayer,factiune);
						SendClientMessage(playerid, COLOR_WHITE, string);
					 	new wakaname[25];
						GetPlayerName(id,wakaname,25);
						new str[256];
						mysql_format(handle, str, sizeof(str), "UPDATE `users` SET `Club`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[id][pClub], wakaname);
						mysql_query(handle,str);
						mysql_format(handle, str, sizeof(str), "UPDATE `users` SET `RClub`='7' WHERE BINARY `Name`= BINARY '%s'", wakaname);
						mysql_query(handle,str);
						mysql_format(handle, gQuery, sizeof(gQuery), "SELECT * FROM club WHERE ID = '%d'", PlayerInfo[id][pFaction]);
    					mysql_tquery(handle, gQuery, "NumeClub", "i", id);
					}
				}
				else{SendClientMessage(playerid,COLOR_GREY,"Alege un club existent");}
			}
    		else
	    	{
		    	SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat.");
		    }
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREY, "Nu ai acces la aceasta comanda!");
		}
	}
	return 1;
}
CMD:makeadmin(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			new id,adminlevel,sendername[30],giveplayer[30],string[200];
			if(sscanf(params, "ui",id,adminlevel)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/makeadmin <playerid/name> <Admin Level>");
			if(IsPlayerConnected(id))
			{
			    if(id != INVALID_PLAYER_ID)
			    {
					GetPlayerName(id, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					PlayerInfo[id][pAdmin] = adminlevel;
					printf("AdmCmd: %s has promoted %s to a level %d admin.", sendername, giveplayer, adminlevel);
					format(string, sizeof(string), "Ai fost promovat la admin %d de %s,", adminlevel, sendername);
					SendClientMessage(id, COLOR_WHITE, string);
					format(string, sizeof(string), "L-ai promovat pe %s la nivel %d admin.", giveplayer,adminlevel);
					SendClientMessage(playerid, COLOR_WHITE, string);
				 	new wakaname[25];
					GetPlayerName(id,wakaname,25);
					new str[256];
					mysql_format(handle, str, sizeof(str), "UPDATE `users` SET `Admin`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[id][pAdmin], wakaname);
					mysql_query(handle,str);
				}
			}
    		else
	    	{
		    	SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat.");
		    }
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREY, "Nu ai acces la aceasta comanda!");
		}
	}
	return 1;
}
CMD:buylevel(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pXp]>=4*PlayerInfo[playerid][pLvl])
	    {
	        if(PlayerInfo[playerid][pMoney]>=PlayerInfo[playerid][pLvl]*100000)
	        {
	            PlayerInfo[playerid][pXp]-=4*PlayerInfo[playerid][pLvl];
				PlayerInfo[playerid][pMoney]-=100000*PlayerInfo[playerid][pLvl];
				GivePlayerMoney(playerid,-100000*PlayerInfo[playerid][pLvl]);
				PlayerInfo[playerid][pLvl]++;
				SendClientMessage(playerid,COLOR_GREY,"Ai trecut la urmatorul lvl.");
				new wakaname[25];
				GetPlayerName(playerid,wakaname,25);
				new str[256];
				mysql_format(handle, str, sizeof(str), "UPDATE `users` SET `Lvl`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pLvl], wakaname);
				mysql_query(handle,str);
				mysql_format(handle, str, sizeof(str), "UPDATE `users` SET `Money`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pMoney], wakaname);
				mysql_query(handle,str);
				mysql_format(handle, str, sizeof(str), "UPDATE `users` SET `Xp`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pXp], wakaname);
				mysql_query(handle,str);
				SetPlayerScore(playerid, PlayerInfo[playerid][pLvl]);

	        }
	        else
			{
			    SendClientMessage(playerid,COLOR_GREY,"Nu ai suficienti bani pentru a trece la urmatorul lvl.");
			}

	    }
	    else
	    {
	        SendClientMessage(playerid,COLOR_GREY,"Nu ai suficient XP pentru a trece la urmatorul lvl.");
	    }

	}
	return 1;
}
CMD:givemoney(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			new id,moneynr;
			if(sscanf(params, "ui",id,moneynr)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/givemoney <playerid/name> <money>");
			if(IsPlayerConnected(id))
			{
			    if(id != INVALID_PLAYER_ID)
			    {
					PlayerInfo[id][pMoney] += moneynr;
					GivePlayerMoney(id,moneynr);
				 	new wakaname[25];
				 	new sendername[25];
					GetPlayerName(id,wakaname,25);
					GetPlayerName(playerid, sendername, 25);
					new string[256];
					format(string, sizeof(string), "Ai primit de la adminul %s %d bani.", sendername,moneynr);
					SendClientMessage(id,COLOR_GREY,string);
					format(string, sizeof(string), "Ai ai oferit jucatorului %s %d bani.", wakaname,moneynr);
					new str[256];
					mysql_format(handle, str, sizeof(str), "UPDATE `users` SET `Money`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[id][pMoney], wakaname);
					mysql_query(handle,str);
				}
			}
    		else
	    	{
		    	SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat.");
		    }
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREY, "Nu ai acces la aceasta comanda!");
		}
	}
	return 1;
}
CMD:gotoxyz(playerid, params[])
{
    if(PlayerInfo[playerid][pWanted] > 0) return SendClientMessage(playerid,COLOR_GREY, "Ai wanted.");
	if(PlayerInfo[playerid][pAdmin] >= 5)
	{
		new string[128],interior,vw;
		new Float:x, Float:y, Float:z;
		if(sscanf(params, "fffii", x,y,z,interior,vw)) return SendClientMessage(playerid,COLOR_GREY, "Sintaxa: {FFFFFF}/gotoxyz <x> <y> <z> <interior> <virtual world>");
		{
			SetPlayerPos(playerid, x, y, z);
			format(string,sizeof(string),"Te-ai teleportat la x = %f, y = %f, z = %f, interior %d.",x,y,z,interior);
			SendClientMessage(playerid,COLOR_WHITE, string);
			SetPlayerVirtualWorld(playerid, vw);
			SetPlayerInterior(playerid,interior);
		}
	}
	else return SendClientMessage(playerid, COLOR_LGREEN, "Nu ai acces la aceasta comanda!");
	return 1;
}
CMD:makehelper(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			new id,adminlevel,sendername[30],giveplayer[30],string[200];
			if(sscanf(params, "ui",id,adminlevel)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/makehelper <playerid/name> <Helper Level>");
			if(IsPlayerConnected(id))
			{
			    if(id != INVALID_PLAYER_ID)
			    {
					GetPlayerName(id, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					PlayerInfo[id][pHelper] = adminlevel;
					printf("AdmCmd: %s has promoted %s to a level %d helper.", sendername, giveplayer, adminlevel);
					format(string, sizeof(string), "Ai fost promovat la helper %d de %s,", adminlevel, sendername);
					SendClientMessage(id, COLOR_WHITE, string);
					format(string, sizeof(string), "L-ai promovat pe %s la nivel %d helper.", giveplayer,adminlevel);
					SendClientMessage(playerid, COLOR_WHITE, string);
				 	new wakaname[25];
					GetPlayerName(id,wakaname,25);
					new str[256];
					mysql_format(handle, str, sizeof(str), "UPDATE `users` SET `Helper`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[id][pHelper], wakaname);
					mysql_query(handle,str);
				}
			}
    		else
	    	{
		    	SendClientMessage(playerid, COLOR_GREY, "Acel player nu este conectat.");
		    }
		}
		else
		{
			SendClientMessage(playerid, COLOR_GREY, "Nu ai acces la aceasta comanda!");
		}
	}
	return 1;
}
CMD:ac(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pAdmin]>=1)
	    {
	    	new text[180]; new strr[180];
	    	if(sscanf(params, "s[180]",text)) return SendClientMessage(playerid,COLOR_GREY,"Sintaxa: {FFFFFF}/ac <text>");
			GetPlayerName(playerid, strr, sizeof(strr));
	  	    foreach(new i : Player)
			{
				if(IsPlayerConnected(i))
				{
					if(PlayerInfo[i][pAdmin] != 0)
					{
						new str[256];
						format(str, 256, "{ff0000} Admin %s {ffffff} : %s .", strr, text);
						SendClientMessage(i,COLOR_GREY,str);
					}
				}
			}
  		}
	    else SendClientMessage(playerid,COLOR_GREY,"Nu esti admin.");
	}
	return 1;
}
CMD:r(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pFaction]>=1&&PlayerInfo[playerid][pFaction]<=3||PlayerInfo[playerid][pFaction]==10)
	    {
	        if(FMute[playerid] != 0 ) return SCM(playerid,COLOR_LGREEN,"Ai mute.");
			new text[180]; new strr[180];
	    	if(sscanf(params, "s[180]",text)) return SendClientMessage(playerid,COLOR_GREY,"Sintaxa: {FFFFFF}/r <text>");
			GetPlayerName(playerid, strr, sizeof(strr));
			new str[256];
			if(PlayerInfo[playerid][pRFaction] <= 5) format(str, 256, "{1528A1}** %s %s: %s, over **",PlayerInfo[playerid][pFacRank],strr, text);
			else format(str, 256, "{1528A1}** %s %s: %s, over **",PlayerInfo[playerid][pFacRank],strr, text);
	  	    foreach(new i : Player)
			{
				if(IsPlayerConnected(i))
				{
					if(PlayerInfo[i][pFaction]==PlayerInfo[playerid][pFaction] )
					{
						SendClientMessage(i,COLOR_GREY,str);
					}
				}
			}
		}
		else
		{
		SendClientMessage(playerid,COLOR_GREY,"Nu esti in departament.");
		}
	}
	return 1;
}
CMD:d(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pFaction]>=1&&PlayerInfo[playerid][pFaction]<=3)
	    {
	        if(FMute[playerid] != 0 ) return SCM(playerid,COLOR_LGREEN,"Ai mute.");
			new text[180]; new strr[180];
	    	if(sscanf(params, "s[180]",text)) return SendClientMessage(playerid,COLOR_GREY,"Sintaxa: {FFFFFF}/d <text>");
			GetPlayerName(playerid, strr, sizeof(strr));
			new str[256];
			format(str, 256, "{ff0000} %s %s {ffffff} : %s .",PlayerInfo[playerid][pFacName],strr, text);
	  	    foreach(new i : Player)
			{
				if(IsPlayerConnected(i))
				{
					if(PlayerInfo[i][pFaction]>=1&&PlayerInfo[i][pFaction]<=3)
					{
						SendClientMessage(i,COLOR_GREY,str);
					}
				}
			}
		}
		else
		{
		SendClientMessage(playerid,COLOR_GREY,"Nu esti in departament.");
		}
	}
	return 1;
}
CMD:joinstevent(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pClub] != 3) return SCM(playerid, COLOR_GREY, "Nu faci parte din bikers club.");
		if(BikersActive == 0) return SCM(playerid, COLOR_GREY, "Nu este nici un stunt event in desfasurare.");
		if(CP[playerid][ID] != 0) return SCM(playerid, COLOR_GREY, "Ai deja un CP, pentru a anula foloseste /killcp.");
		SCM(playerid, COLOR_GREY, BikersNume1);
		new string[256];
		GetPlayerName(playerid, string, sizeof(string));
		if(BikersN1 != 0)
			if(strcmp( string, BikersNume1, false) == 0) return SCM(playerid, COLOR_GREY, "Ai participat deja la acest event.");

		if(BikersN2 != 0)
			if(strcmp( string, BikersNume2, false) == 0) return SCM(playerid, COLOR_GREY, "Ai participat deja la acest event.");

		if(BikersN3 != 0)
			if(strcmp( string, BikersNume3, false) == 0) return SCM(playerid, COLOR_GREY, "Ai participat deja la acest event.");

		SetPlayerCheckpoint(playerid, BikersX, BikersY, BikersZ, 5);
		CP[playerid][ID] = 3;
		SCM(playerid, COLOR_SALMON, "Ti-a fost setat un CP cu locatia eventului, pentru a anula foloseste /killcp.");
	}
	return 1;
}
CMD:createbkstunt(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pClub] != 3) return SCM(playerid, COLOR_GREY, "Nu faci parte din bikers club.");
		if(PlayerInfo[playerid][pRClub] < 5) return SCM(playerid, COLOR_GREY, "Nu ai acces la aceasta comanda.");
		if(GetPlayerVirtualWorld(playerid) != 0 || GetPlayerInterior(playerid) != 0) return SCM(playerid, COLOR_GREY, "Nu poti face stunt event in Virtual World.");
		if(BikersActive == 1) return SCM(playerid, COLOR_GREY, "Este deja un event in desfasurare , pentru a anula eventul tasteaza /stopbkstunt.");
		new prize1, prize2, prize3;
		if(sscanf(params, "iii",prize1, prize2, prize3)) return SendClientMessage(playerid,COLOR_GREY,"Sintaxa: {FFFFFF}/createbkstunt <prize 1> <prize 2> <prize 3>");
		if(prize1 < 0 || prize2 < 0 || prize3 < 0 || prize1 > 10000 || prize2 > 10000 || prize3 > 10000) return SCM(playerid, COLOR_GREY, "Premiile care constau in BP trebuie sa fie mai mari decat 0 si mai mici decat 10 000.");
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		BikersX = x;
		BikersY = y;
		BikersZ = z;
		BikersN1 = 0;
		BikersN2 = 0;
		BikersN3 = 0;
		BikersPrize1 = prize1;
		BikersPrize2 = prize2;
		BikersPrize3 = prize3;
		BikersActive = 1;
		new string[256];
		format(string, sizeof(string), "Pentru a anula eventul tasteaza , /stopbkstunt.");
		SCM(playerid, COLOR_SIENNA, string);
		format(string, sizeof(string), "%s a activat stunt event, primii 3 vor primi premii, /joinstevent pentru a participa.", GetName(playerid));
		foreach(new i : Player)
		{
			if(IsPlayerConnected(i))
			{
				if(PlayerInfo[i][pClub] == 3)
				{
					SendClientMessage(i,COLOR_GREY,string);
				}
			}
		}

	}
	return 1;
}
CMD:stopbkstunt(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pClub] != 3) return SCM(playerid, COLOR_GREY, "Nu faci parte din bikers club.");
		if(PlayerInfo[playerid][pRClub] < 5) return SCM(playerid, COLOR_GREY, "Nu ai acces la aceasta comanda.");
		if(BikersActive == 0) return SCM(playerid, COLOR_GREY, "Nu este nici un stunt event in desfasurare.");
		BikersActive = 0;
		new string[256];
		format(string, sizeof(string), "%s a anulat stunt event.", GetName(playerid));
		foreach(new i : Player)
		{
			if(IsPlayerConnected(i))
			{
				if(PlayerInfo[i][pClub] == 3)
				{
					SendClientMessage(i,COLOR_GREY,string);
				}
			}
		}
	}
	return 1;
}
CMD:nfs(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
		if(PlayerInfo[playerid][pClub] != 2) return SCM(playerid,COLOR_GREY,"Nu faci parte din NFS club.");
		new text[180]; 
	    new strr[180];
	    if(sscanf(params, "s[180]",text)) return SendClientMessage(playerid,COLOR_GREY,"Sintaxa: {FFFFFF}/nfs <text>");
	    GetPlayerName(playerid, strr, sizeof(strr));
		new str[256];
		format(str, 256, "{ff0000} %s %s {ffffff} : %s .",PlayerInfo[playerid][pClubRank],strr, text);
		foreach(new i : Player)
		{
			if(IsPlayerConnected(i))
			{
				if(PlayerInfo[i][pClub]==PlayerInfo[playerid][pClub])
				{
					SendClientMessage(i,COLOR_GREY,str);
				}
			}
		}
	}
	return 1;
}
CMD:inf(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
		if(PlayerInfo[playerid][pClub] != 1) return SCM(playerid,COLOR_GREY,"Nu faci parte din infernus club.");
		new text[180]; 
	    new strr[180];
	    if(sscanf(params, "s[180]",text)) return SendClientMessage(playerid,COLOR_GREY,"Sintaxa: {FFFFFF}/inf <text>");
	    GetPlayerName(playerid, strr, sizeof(strr));
		new str[256];
		format(str, 256, "{ff0000} %s %s {ffffff} : %s .",PlayerInfo[playerid][pClubRank],strr, text);
		foreach(new i : Player)
		{
			if(IsPlayerConnected(i))
			{
				if(PlayerInfo[i][pClub]==PlayerInfo[playerid][pClub])
				{
					SendClientMessage(i,COLOR_GREY,str);
				}
			}
		}
	}
	return 1;
}
CMD:cmute(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
	    if(PlayerInfo[playerid][pClub] >= 1)
	    {
	        if(PlayerInfo[playerid][pRClub] >= 6 )
	        {
	            new id, string[256],seconds;
	            if(sscanf(params, "uis[256]", id,seconds , string)) return SendClientMessage(playerid, COLOR_GREY, "Sintaxa: {FFFFFF}/cmute <playerid/name> <time in minutes> <reason>");
	            {
	                if(IsPlayerConnected(id) )
	                {
	                    if(PlayerInfo[id][pClub] == PlayerInfo[playerid][pClub])
	                    {
	                        if(PlayerInfo[id][pRClub] < PlayerInfo[playerid][pRClub])
	                        {
								new string1[256];
								CMute[id]+=(seconds*60);
								format(string1,sizeof(string1),"Membrul %s a primit mute de la %s pentru : %d minute.",GetName(id),GetName(playerid),seconds);
								foreach(new i : Player)
								{
								    if(IsPlayerConnected(i) )
								    {
								        if(PlayerInfo[i][pClub] == PlayerInfo[playerid][pClub])
								            SCM(i,COLOR_LGREEN,string1);
								    }
								}
								
	                        }
							else
							{
							    SCM(playerid,COLOR_WHITE,"Nu poti da mute unui membru cu rank mai mare sau egal cu al tau.");
							}
	                        
	                    }
	                    else
	                    {
	                        SCM(playerid,COLOR_BLUE,"Jucatorul respectiv nu este in club cu tine.");
	                    }
	                }
	                else
	                {
	                    SCM(playerid,COLOR_GREY,"Jucatorul respectiv nu este conectat.");
	                }
	            }
	        }
	        else
	        {
	            SCM(playerid,COLOR_GREY,"Nu ai acces la aceasta comanda.");
	        }
	    }
	    else
	    {
	        SCM(playerid,COLOR_BLUE,"Nu esti intr-un club.");
		}
	}
	return 1;
}
CMD:nfsm(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
		if(PlayerInfo[playerid][pClub] != 2) return SCM(playerid, COLOR_GREY, "Nu faci parte din NFS club." );
		new string[256];
		SCM(playerid, COLOR_LIGHTRED, "[NFS CLUB MEMBERS]");
		foreach(new i : Player)
		{
			if(IsPlayerConnected(i))
			{
				if(PlayerInfo[i][pClub] == 2)
				{
					format(string, sizeof(string), "Nume[%s] | Rank[%s] | BP[%d] | Mute[%ds] | Jail [%ds] | Wanted [%d]", GetName(i), PlayerInfo[i][pClubRank], PlayerInfo[i][pBP], CMute[i], PlayerInfo[i][pJailTime], PlayerInfo[i][pWanted]);
					if(PlayerInfo[i][pRClub] >= 6) SCM(playerid, COLOR_RED, string);
					else SCM(playerid, COLOR_BLUE, string);
				}
			}
		}
	}
	return 1;
}
CMD:infm(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
		if(PlayerInfo[playerid][pClub] != 1) return SCM(playerid, COLOR_GREY, "Nu faci parte din infernus club." );
		new string[256];
		SCM(playerid, COLOR_LIGHTRED, "[INFERNUS CLUB MEMBERS]");
		foreach(new i : Player)
		{
			if(IsPlayerConnected(i))
			{
				if(PlayerInfo[i][pClub] == 1)
				{
					format(string, sizeof(string), "Nume[%s] | Rank[%s] | BP[%d] | Mute[%ds] | Jail [%ds] | Wanted [%d]", GetName(i), PlayerInfo[i][pClubRank], PlayerInfo[i][pBP], CMute[i], PlayerInfo[i][pJailTime], PlayerInfo[i][pWanted]);
					if(PlayerInfo[i][pRClub] >= 6) SCM(playerid, COLOR_RED, string);
					else SCM(playerid, COLOR_BLUE, string);
				}
			}
		}
	}
	return 1;
}
CMD:f(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pFaction]>=4&&PlayerInfo[playerid][pFaction]<=9)
	    {
	        if(FMute[playerid] != 0 ) return SCM(playerid,COLOR_LGREEN,"Ai mute.");
			new text[180]; new strr[180];
	    	if(sscanf(params, "s[180]",text)) return SendClientMessage(playerid,COLOR_GREY,"Sintaxa: {FFFFFF}/f <text>");
			GetPlayerName(playerid, strr, sizeof(strr));
			new str[256];
			if(PlayerInfo[playerid][pRFaction] <= 5) format(str, 256, "{0FC0DB}** %s %s: %s. **",PlayerInfo[playerid][pFacRank],strr, text);
			else format(str, 256, "{0FC0DB}** %s {BCD46C}%s: {B2B2B2}%s. **",PlayerInfo[playerid][pFacRank],strr, text);
	  	    foreach(new i : Player)
			{
				if(IsPlayerConnected(i))
				{
					if(PlayerInfo[i][pFaction]==PlayerInfo[playerid][pFaction])
					{
						SendClientMessage(i,COLOR_GREY,str);
					}
				}
			}
		}
		else
		if(PlayerInfo[playerid][pFaction]>=11&&PlayerInfo[playerid][pFaction]<=14)
	    {
			new text[180]; new strr[180];
	    	if(sscanf(params, "s[180]",text)) return SendClientMessage(playerid,COLOR_GREY,"Sintaxa: {FFFFFF}/f <text>");
			GetPlayerName(playerid, strr, sizeof(strr));
			new str[256];
			if(PlayerInfo[playerid][pRFaction] <= 5) format(str, 256, "{0FC0DB}** %s %s: %s. **",PlayerInfo[playerid][pFacRank],strr, text);
			else format(str, 256, "{0FC0DB}** %s {BCD46C}%s: {B2B2B2}%s. **",PlayerInfo[playerid][pFacRank],strr, text);
	  	    foreach(new i : Player)
			{
				if(IsPlayerConnected(i))
				{
					if(PlayerInfo[i][pFaction]==PlayerInfo[playerid][pFaction])
					{
						SendClientMessage(i,COLOR_GREY,str);
					}
				}
			}
		}
		else
		{
		SendClientMessage(playerid,COLOR_GREY,"Nu faci parte dintr-o factiune.");
		}
	}
	return 1;
}
function NrResetNews(playerid)
{
	CanNews[playerid] = 0;
	return 1;
}
CMD:loadpaper(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pFaction] != 14) return SCM(playerid, COLOR_GREY, "Nu esti reporter.");
		if(!IsPlayerInRangeOfPoint(playerid, 4, -2041.4490,451.6047,35.1723)) return SCM(playerid, COLOR_GREY, "Nu esti la redactie.");
		if(NewsPaperStatus == 0) return SCM(playerid, COLOR_GREY, "Reporterii nu au terminat de redactat ziarul.");
		if(LoadNP[playerid] == 1) return SCM(playerid, COLOR_GREY, "Ai luat deja ziarele de la redactie.");
		LoadNP[playerid] = 1;
		new string[256];
		format(string, sizeof(string), "{d39af4}[NR] {efcdf7}%s a luat ziare de la redactie.", GetName(playerid));
		for(new i = 0; i <= MAX_PLAYERS; i++)
			if(IsPlayerConnected(i) && PlayerInfo[i][pFaction] == 14)
				SCM(i, -1, string);
		for(new i = 0; i <= MAX_PLAYERS; i++)
		{
			SellPaperInfo[playerid][i] = 0;
			SellPaperInfo[i][playerid] = 0;
		}
		SCM(playerid, COLOR_GREY, "Foloseste comanda /sellpaper pentru a vinde ziare.");
	}
	return 1;
}
CMD:sellpaper(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pFaction] != 14) return SCM(playerid, COLOR_GREY, "Nu esti reporter.");
		if(LoadNP[playerid] == 0) return SCM(playerid, COLOR_GREY, "Nu ai ziare la tine.");
		new giverid;
		if(sscanf(params, "u", giverid)) return SendClientMessage(playerid,COLOR_GREY,"Sintaxa: {FFFFFF}/sellpaper <playerid/name>");
		if(!IsPlayerConnected(giverid)) return SCM(playerid, COLOR_GREY, "Acel jucator nu este conectat.");
		if(SellPaperInfo[playerid][giverid] == 100) return SCM(playerid, COLOR_GREY, "Acel jucator are deja o cere de la tine in asteptare.");
		if(PlayerInfo[giverid][pFaction] == 14) return SCM(playerid, COLOR_GREY, "Acel jucator este reporter.");
		new Float:varX, Float:varY, Float:varZ;
		GetPlayerPos(playerid, varX, varY, varZ);
		if(!IsPlayerInRangeOfPoint(giverid, 5, varX, varY, varZ)) return SCM(playerid, COLOR_GREY, "Acel jucator nu este langa tine.");
		SellPaperInfo[playerid][giverid] = 100;
		new string[256];
		format(string, sizeof(string), "{efcdf7}Reporterul %s ti-a oferit un ziar contra sumei de 100$. Foloseste comanda /acceptpaper %d pentru a accepta.", GetName(playerid), playerid);
		SCM(giverid, -1, string);
		format(string, sizeof(string), "{efcdf7}Ai oferit jucatorului %s un ziar.", GetName(giverid));
		SCM(playerid, -1, string);
	}
	return 1;
}
CMD:acceptpaper(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(HaveNP[playerid] == 1) return SCM(playerid, COLOR_GREY, "Ai deja un ziar, citeste-l mai intai.");
		new reporterid;
		if(sscanf(params, "u", reporterid)) return SendClientMessage(playerid,COLOR_GREY,"Sintaxa: {FFFFFF}/acceptpaper <playerid/name>");
		if(!IsPlayerConnected(reporterid)) return SCM(playerid, COLOR_GREY, "Acel jucator nu este conectat.");
		if(PlayerInfo[reporterid][pFaction] != 14) return SCM(playerid, COLOR_GREY, "Acel jucator nu este reporter.");
		SellPaperInfo[reporterid][playerid] = 0;
		if(LoadNP[reporterid] == 0) return SCM(playerid, COLOR_GREY, "Acel reporter nu mai are ziare.");
		new Float:varX, Float:varY, Float:varZ;
		GetPlayerPos(playerid, varX, varY, varZ);
		if(!IsPlayerInRangeOfPoint(reporterid, 5, varX, varY, varZ)) return SCM(playerid, COLOR_GREY, "Acel reporter nu este langa tine.");
		if(PlayerInfo[playerid][pMoney] < 100) return SCM(playerid, COLOR_GREY, "Nu ai destui bani.");
		HaveNP[playerid] = 1;
		PlayerInfo[reporterid][pNrRaport]++;
		PlayerInfo[playerid][pMoney] -= 100;
		PlayerInfo[reporterid][pMoney] += 100;
		GivePlayerMoney(playerid, -100);
		GivePlayerMoney(reporterid, 100);
		new string[256];
		format(string, sizeof(string), "{d39af4}[NR] {efcdf7}%s a vandut un ziar jucatorului %s", GetName(reporterid), GetName(playerid));
		for(new i = 0; i <= MAX_PLAYERS; i++)
			if(IsPlayerConnected(i) && PlayerInfo[i][pFaction] == 14)
				SCM(i, -1, string);
		format(string, sizeof(string), "{efcdf7}Ai cumparat ziarul de la reporterul %s. Pentru a citi ziarul foloseste comanda /readpaper.");
		SCM(playerid, -1, string);
	}
	return 1;
}
CMD:cnewspaper(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pFaction] != 14) return SCM(playerid, COLOR_GREY, "Nu esti reporter.");
		if(!IsPlayerInRangeOfPoint(playerid, 4, -2041.4490,451.6047,35.1723)) return SCM(playerid, COLOR_GREY, "Nu esti la redactie.");
		if(CanCLineNr[playerid] == 1) return SCM(playerid, COLOR_GREY, "Termina ziarul deja inceput. Pentru a anula foloseste comanda /cancelcnp");
		new string[256], titlu[64];
		if(sscanf(params, "s[64]", titlu)) return SendClientMessage(playerid,COLOR_GREY,"Sintaxa: {FFFFFF}/cnewspaper <titlu>");
		format(CreateZiar[playerid][0], 256, "{04f97b}%s", titlu);
		format(string, sizeof(string), "{d39af4}[NR] {efcdf7}%s a inceput sa redacteze un nou ziar cu titlul: %s", GetName(playerid), titlu);
		TogglePlayerControllable(playerid, 0);
		for(new i = 0; i <= MAX_PLAYERS; i++)
			if(IsPlayerConnected(i) && PlayerInfo[i][pFaction] == 14)
				SCM(i, -1, string);
		CanCLineNr[playerid] = 1;
		SCM(playerid, COLOR_GREY, "Foloseste comenzile /cline1 /cline2 /cline3 /cline4 /cline5 /cline6 pentru a scrie pe linia respectiva din ziar.");
		SCM(playerid, COLOR_GREY, "Dupa ce termini, foloseste comanda /donenp pentru a tipari ziarul.");
	}
	return 1;
}
CMD:donenp(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pFaction] != 14) return SCM(playerid, COLOR_GREY, "Nu esti reporter.");
		if(CanCLineNr[playerid] != 1) return SCM(playerid, COLOR_GREY, "Nu poti folosi aceasta comanda acum.");
		TogglePlayerControllable(playerid, 1);
		CanCLineNr[playerid] = 0;
		new string[256], year, month, day;
		getdate(year, month, day);
		format(CreateZiar[playerid][0], 256, "%s", CreateZiar[playerid][0]);
		SCM(playerid, COLOR_GREY, "Ai tiparit ziarul. Felicitari!!!");
		format(NewsPaper[0], 256, CreateZiar[playerid][0]);
		format(NewsPaper[1], 256, CreateZiar[playerid][1]);
		format(NewsPaper[2], 256, CreateZiar[playerid][2]);
		format(NewsPaper[3], 256, CreateZiar[playerid][3]);
		format(NewsPaper[4], 256, CreateZiar[playerid][4]);
		format(NewsPaper[5], 256, CreateZiar[playerid][5]);
		format(NewsPaper[6], 256, CreateZiar[playerid][6]);
		format(NewsPaper[7], 256, "{ba7dce}PlayNioN Romania - %s - %d.%d.%d", GetName(playerid), day, month, year);
		format(string, sizeof(string), "{d39af4}[NR] {efcdf7}%s a terminat de redactat un nou ziar, veniti la radactie pentru a le ridica.", GetName(playerid));
		for(new i = 0; i <= MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i) && PlayerInfo[i][pFaction] == 14)
			{
				SCM(i, -1, string);
				LoadNP[i] = 0;
			}
			SellPaperInfo[playerid][i] = 0;
			SellPaperInfo[i][playerid] = 0;
			if(HaveNP[i] == 1) SCM(i, COLOR_GREY, "Ops! Ai pierdut ziarul.");
			HaveNP[i] = 0;
		}
		NewsPaperStatus = 1;
	}
	return 1;
}
CMD:readpaper(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(HaveNP[playerid] == 0) return SCM(playerid, COLOR_GREY, "Nu ai un ziar.");
		SCM(playerid, COLOR_GREY, "=====================================");
		SCM(playerid, COLOR_WHITE, NewsPaper[0]);
		SCM(playerid, COLOR_WHITE, NewsPaper[1]);
		SCM(playerid, COLOR_WHITE, NewsPaper[2]);
		SCM(playerid, COLOR_WHITE, NewsPaper[3]);
		SCM(playerid, COLOR_WHITE, NewsPaper[4]);
		SCM(playerid, COLOR_WHITE, NewsPaper[5]);
		SCM(playerid, COLOR_WHITE, NewsPaper[6]);
		SCM(playerid, COLOR_WHITE, NewsPaper[7]);
		SCM(playerid, COLOR_GREY, "=====================================");
		HaveNP[playerid] = 0;
	}	
	return 1;
}
CMD:readnp(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pFaction] != 14) return SCM(playerid, COLOR_GREY, "Nu esti reporter.");
		if(!IsPlayerInRangeOfPoint(playerid, 4, -2041.4490,451.6047,35.1723)) return SCM(playerid, COLOR_GREY, "Nu esti la redactie.");
		if(NewsPaperStatus == 0) return SCM(playerid, COLOR_GREY, "Reporterii nu au terminat de redactat ziarul.");
		SCM(playerid, COLOR_GREY, "=====================================");
		SCM(playerid, COLOR_WHITE, NewsPaper[0]);
		SCM(playerid, COLOR_WHITE, NewsPaper[1]);
		SCM(playerid, COLOR_WHITE, NewsPaper[2]);
		SCM(playerid, COLOR_WHITE, NewsPaper[3]);
		SCM(playerid, COLOR_WHITE, NewsPaper[4]);
		SCM(playerid, COLOR_WHITE, NewsPaper[5]);
		SCM(playerid, COLOR_WHITE, NewsPaper[6]);
		SCM(playerid, COLOR_WHITE, NewsPaper[7]);
		SCM(playerid, COLOR_GREY, "=====================================");
	}	
	return 1;
}
CMD:cline1(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pFaction] != 14) return SCM(playerid, COLOR_GREY, "Nu esti reporter.");
		if(CanCLineNr[playerid] != 1) return SCM(playerid, COLOR_GREY, "Nu poti folosi aceasta comanda acum.");
		new line[256];
		if(sscanf(params, "s[256]", line)) return SendClientMessage(playerid,COLOR_GREY,"Sintaxa: {FFFFFF}/cline1 <text>");
		format(CreateZiar[playerid][1], 256, "%s", line);
		SCM(playerid, COLOR_LIGHTSKYBLUE, "Prima linie din ziar a fost scrisa:");
		SCM(playerid, COLOR_GREY, line);
	}
	return 1;
}
CMD:cline2(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pFaction] != 14) return SCM(playerid, COLOR_GREY, "Nu esti reporter.");
		if(CanCLineNr[playerid] != 1) return SCM(playerid, COLOR_GREY, "Nu poti folosi aceasta comanda acum.");
		new line[256];
		if(sscanf(params, "s[256]", line)) return SendClientMessage(playerid,COLOR_GREY,"Sintaxa: {FFFFFF}/cline2 <text>");
		format(CreateZiar[playerid][2], 256, "%s", line);
		SCM(playerid, COLOR_LIGHTSKYBLUE, "A doua linie din ziar a fost scrisa:");
		SCM(playerid, COLOR_GREY, line);
	}
	return 1;
}
CMD:cline3(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pFaction] != 14) return SCM(playerid, COLOR_GREY, "Nu esti reporter.");
		if(CanCLineNr[playerid] != 1) return SCM(playerid, COLOR_GREY, "Nu poti folosi aceasta comanda acum.");
		new line[256];
		if(sscanf(params, "s[256]", line)) return SendClientMessage(playerid,COLOR_GREY,"Sintaxa: {FFFFFF}/cline3 <text>");
		format(CreateZiar[playerid][3], 256, "%s", line);
		SCM(playerid, COLOR_LIGHTSKYBLUE, "A treia linie din ziar a fost scrisa:");
		SCM(playerid, COLOR_GREY, line);
	}
	return 1;
}
CMD:cline4(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pFaction] != 14) return SCM(playerid, COLOR_GREY, "Nu esti reporter.");
		if(CanCLineNr[playerid] != 1) return SCM(playerid, COLOR_GREY, "Nu poti folosi aceasta comanda acum.");
		new line[256];
		if(sscanf(params, "s[256]", line)) return SendClientMessage(playerid,COLOR_GREY,"Sintaxa: {FFFFFF}/cline4 <text>");
		format(CreateZiar[playerid][4], 256, "%s", line);
		SCM(playerid, COLOR_LIGHTSKYBLUE, "A patra linie din ziar a fost scrisa:");
		SCM(playerid, COLOR_GREY, line);
	}
	return 1;
}
CMD:cline5(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pFaction] != 14) return SCM(playerid, COLOR_GREY, "Nu esti reporter.");
		if(CanCLineNr[playerid] != 1) return SCM(playerid, COLOR_GREY, "Nu poti folosi aceasta comanda acum.");
		new line[256];
		if(sscanf(params, "s[256]", line)) return SendClientMessage(playerid,COLOR_GREY,"Sintaxa: {FFFFFF}/cline5 <text>");
		format(CreateZiar[playerid][5], 256, "%s", line);
		SCM(playerid, COLOR_LIGHTSKYBLUE, "A cincea linie din ziar a fost scrisa:");
		SCM(playerid, COLOR_GREY, line);
	}
	return 1;
}
CMD:cline6(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pFaction] != 14) return SCM(playerid, COLOR_GREY, "Nu esti reporter.");
		if(CanCLineNr[playerid] != 1) return SCM(playerid, COLOR_GREY, "Nu poti folosi aceasta comanda acum.");
		new line[256];
		if(sscanf(params, "s[256]", line)) return SendClientMessage(playerid,COLOR_GREY,"Sintaxa: {FFFFFF}/cline6 <text>");
		format(CreateZiar[playerid][6], 256, "%s", line);
		SCM(playerid, COLOR_LIGHTSKYBLUE, "A sasea linie din ziar a fost scrisa:");
		SCM(playerid, COLOR_GREY, line);
	}
	return 1;
}
CMD:cancelcnp(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(CanCLineNr[playerid] != 1) return SCM(playerid, COLOR_GREY, "Nu poti folosi aceasta comanda acum.");
		TogglePlayerControllable(playerid, 1);
		CanCLineNr[playerid] = 0;
 	}
	return 1;
}
CMD:news(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pFaction] != 14) return SCM(playerid, COLOR_GREY, "Nu esti reporter.");
		new string[256];
		if(sscanf(params, "s[256]", string)) return SendClientMessage(playerid,COLOR_GREY,"Sintaxa: {FFFFFF}/news <anunt>");
		if(ServerVehicles[GetPlayerVehicleID(playerid)][vFaction] != 14) return SCM(playerid, COLOR_GREY, "Nu te afli in masina factiunii.");
		if(CanNews[playerid] == 0)
		{
			format(string, sizeof(string), "{d86208}NR %s: %s", GetName(playerid), string);
			for(new i = 0; i <= MAX_PLAYERS; i++)
				if(IsPlayerConnected(i))
					SCM(i, -1, string);
			CanNews[playerid] = 1;
			SetTimerEx("NrResetNews", 60000, false, "u", playerid);
		}
		else SCM(playerid, COLOR_GREY, "Trebuie sa astepti 60s pentru a mai da un anunt.");

	}
	return 1;
}
CMD:fare(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pFaction] != 13) return SCM(playerid, COLOR_GREY, "Nu esti taximetrist, uberistule :))");
		new fare;
		if(sscanf(params, "i", fare)) return SendClientMessage(playerid,COLOR_GREY,"Sintaxa: {FFFFFF}/fare <money>");
		if(fare < 0 || fare > 5000) return SCM(playerid, COLOR_GREY, "Tariful trebuie sa fie intre 1 si 5000$ respectiv 0 pentru a scoate fare-ul.");
		if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_GREY, "Nu esti in taxi.");
		if(ServerVehicles[GetPlayerVehicleID(playerid)][vFaction] != 13 || GetPlayerVehicleSeat(playerid) != 0) return SCM(playerid, COLOR_GREY, "Nu esti soferul unui taxi.");
		if(fare == 0)
		{
			TaxiFare[playerid] = 0;
			SendClientMessage(playerid, COLOR_GREY, "You're now Off Duty.");
			return 1;
		}
		TaxiFare[playerid] = fare;
		SendClientMessage(playerid, COLOR_GREY, "You're now On Duty.");
		new string[256];
		format(string, sizeof(string), "{f4e542}**Taxi Driver {adadad}%s {1f66b7}is now OnDuty with {adadad}%d {0e772f}$ {1f66b7}Fare.", GetName(playerid), fare);
		SendClientMessageToAll(-1, string);
	}
	return 1;
}
CMD:taxidrivers(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		new string[256];
		SCM(playerid, COLOR_GREY, "{f4e000}**Taxi Drivers:");
		for(new i = 0; i <= 1000; i++)
			if(IsPlayerConnected(i))
				if(PlayerInfo[i][pFaction] == 13)
					if(TaxiFare[i] == 0)
					{
						format(string, sizeof(string), "Taxi Driver %s [ID:%d] Off Duty", GetName(i), i);
						SCM(playerid, -1, string);
					}
					else
					{
						format(string, sizeof(string), "Taxi Driver %s [ID:%d] Fare: %d", GetName(i), i, TaxiFare[i]);
						SCM(playerid, -1, string);
					}
	}
	return 1;
}
CMD:fa(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pFaction]>=4&&PlayerInfo[playerid][pFaction]<=6)
	    {
	        if(FMute[playerid] != 0 ) return SCM(playerid,COLOR_LGREEN,"Ai mute.");
			new text[180]; new strr[180];
	    	if(sscanf(params, "s[180]",text)) return SendClientMessage(playerid,COLOR_GREY,"Sintaxa: {FFFFFF}/f <text>");
			GetPlayerName(playerid, strr, sizeof(strr));
			new str[256];
			if(PlayerInfo[playerid][pFaction] == 4)
			{
				if(PlayerInfo[playerid][pRFaction] <= 5)
					format(str, 256, "{2C9B16}** [Grove] {0FC0DB}%s %s: %s. **", PlayerInfo[playerid][pFacRank], strr, text);
				else
					format(str, 256, "{2C9B16}** [Grove] {0FC0DB}%s {BCD46C}%s: {B2B2B2}%s. **", PlayerInfo[playerid][pFacRank], strr, text);
			}
			else if(PlayerInfo[playerid][pFaction] == 5)
			{
				if(PlayerInfo[playerid][pRFaction] <= 5)
					format(str, 256, "{C5D116}** [LSV] {0FC0DB}%s %s: %s. **", PlayerInfo[playerid][pFacRank], strr, text);
				else
					format(str, 256, "{C5D116}** [LSV] {0FC0DB}%s {BCD46C}%s: {B2B2B2}%s. **", PlayerInfo[playerid][pFacRank], strr, text);
			}
			else if(PlayerInfo[playerid][pFaction] == 6)
			{
				if(PlayerInfo[playerid][pRFaction] <= 5)
					format(str, 256, "{4D1504}** [The Triads] {0FC0DB}%s %s: %s. **", PlayerInfo[playerid][pFacRank], strr, text);
				else
					format(str, 256, "{4D1504}** [The Triads] {0FC0DB}%s {BCD46C}%s: {B2B2B2}%s. **", PlayerInfo[playerid][pFacRank], strr, text);
			}
	  	    foreach(new i : Player)
			{
				if(IsPlayerConnected(i))
				{
					if(PlayerInfo[i][pFaction]>=4&&PlayerInfo[i][pFaction]<=6)
					{
						SendClientMessage(i,COLOR_GREY,str);
					}
				}
			}
		}
		else
		if(PlayerInfo[playerid][pFaction]>=7&&PlayerInfo[playerid][pFaction]<=9)
	    {
			new text[180]; new strr[180];
	    	if(sscanf(params, "s[180]",text)) return SendClientMessage(playerid,COLOR_GREY,"Sintaxa: {FFFFFF}/f <text>");
			GetPlayerName(playerid, strr, sizeof(strr));
			new str[256];
			if(PlayerInfo[playerid][pFaction] == 7)
			{
				if(PlayerInfo[playerid][pRFaction] <= 5)
					format(str, 256, "{B312DB}** [Ballas] {0FC0DB}%s %s: %s. **", PlayerInfo[playerid][pFacRank], strr, text);
				else
					format(str, 256, "{B312DB}** [Ballas] {0FC0DB}%s {BCD46C}%s: {B2B2B2}%s. **", PlayerInfo[playerid][pFacRank], strr, text);
			}
			else if(PlayerInfo[playerid][pFaction] == 8)
			{
				if(PlayerInfo[playerid][pRFaction] <= 5)
					format(str, 256, "{17F0FF}** [VLA] {0FC0DB}%s %s: %s. **", PlayerInfo[playerid][pFacRank], strr, text);
				else
					format(str, 256, "{17F0FF}** [VLA] {0FC0DB}%s {BCD46C}%s: {B2B2B2}%s. **", PlayerInfo[playerid][pFacRank], strr, text);
			}
			else if(PlayerInfo[playerid][pFaction] == 9)
			{
				if(PlayerInfo[playerid][pRFaction] <= 5)
					format(str, 256, "{D01D01}** [The Mafia] {0FC0DB}%s %s: %s. **", PlayerInfo[playerid][pFacRank], strr, text);
				else
					format(str, 256, "{D01D01}** [The Mafia] {0FC0DB}%s {BCD46C}%s: {B2B2B2}%s. **", PlayerInfo[playerid][pFacRank], strr, text);
			}
	  	    foreach(new i : Player)
			{
				if(IsPlayerConnected(i))
				{
					if(PlayerInfo[i][pFaction]>=7&&PlayerInfo[i][pFaction]<=9)
					{
						SendClientMessage(i,COLOR_GREY,str);
					}
				}
			}
		}
		else
		{
		SendClientMessage(playerid,COLOR_GREY,"Nu faci parte dintr-o alianta.");
		}
	}
	return 1;
}

CMD:hc(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pHelper]>=1)
	    {
	    	new text[180]; new strr[180];
	    	if(sscanf(params, "s[180]",text)) return SendClientMessage(playerid,COLOR_GREY,"Sintaxa: {FFFFFF}/hc <text>");
			GetPlayerName(playerid, strr, sizeof(strr));
	  	    foreach(new i : Player)
			{
				if(IsPlayerConnected(i))
				{
					if(PlayerInfo[i][pHelper] != 0)
					{
						new str[256];
						format(str, 256, "{ff0000} Helper %s {ffffff} : %s .", strr, text);
						SendClientMessage(i,COLOR_GREY,str);
					}
				}
			}
  		}
	    else SendClientMessage(playerid,COLOR_GREY,"Nu esti admin.");
	}
	return 1;
}
CMD:admins(playerid, params[])
{
    if(IsPlayerConnected(playerid))
	{
        new count = 0,string[200],sendername[30];
		SendClientMessage(playerid, COLOR_SERVER, "----Admins Online----------------------------------------------------");
		foreach(new i : Player)
		{
			if(IsPlayerConnected(i))
			{
				if(PlayerInfo[i][pAdmin] != 0)
				{
					GetPlayerName(i, sendername,  sizeof(sendername));
					format(string, 256, "(%d) %s - admin level %d", i,sendername,PlayerInfo[i][pAdmin]);
					SendClientMessage(playerid, COLOR_WHITE, string);
					count++;
				}
			}
		}
		if(count == 0) SendClientMessage(playerid,COLOR_WHITE,"* Nu sunt admini conectati.");
		SendClientMessage(playerid, COLOR_SERVER, "----------------------------------------------------------------------------");
		SendClientMessage(playerid, -1, "Daca ai vreo problema, poti folosi /report. Pentru intrebari legate de joc poti folosi /n.");
		SendClientMessage(playerid, COLOR_SERVER, "----------------------------------------------------------------------------");
	}
	return 1;
}
CMD:leaders(playerid, params[])
{
    if(IsPlayerConnected(playerid))
	{
        new count = 0,string[200];
		SendClientMessage(playerid, COLOR_SERVER, "----Leaders Online----------------------------------------------------");
		foreach(new i : Player)
		{
			if(IsPlayerConnected(i))
			{
				if(PlayerInfo[i][pRFaction] == 7)
				{
					
					format(string, 256, "(%d) %s - %s Leader", i,GetName(i),PlayerInfo[i][pFacName]);
					SendClientMessage(playerid, COLOR_WHITE, string);
					count++;
				}
				if(PlayerInfo[i][pRClub] == 7)
				{
					
					format(string, 256, "(%d) %s - %s Leader", i,GetName(i),PlayerInfo[i][pClubName]);
					SendClientMessage(playerid, COLOR_WHITE, string);
					count++;
				}
			}
		}
		if(count == 0) SendClientMessage(playerid,COLOR_WHITE,"* Nu sunt lideri conectati.");
		SendClientMessage(playerid, COLOR_SERVER, "----------------------------------------------------------------------------");
	}
	return 1;
}
CMD:rfc(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
	    if(PlayerInfo[playerid][pFaction] == 0 ) return SCM(playerid,COLOR_GREY,"Nu esti intr-o factiune.");
	    if(WarStatus == 1 && IsGang(playerid))
	    {
	    	if(PlayerInfo[playerid][pRFaction] < 6)  return SendClientMessage(playerid, COLOR_LGREEN, "Nu ai acces la aceasta comanda!");
	    	new aliance, aliance1;
	    	if(PlayerInfo[playerid][pFaction] >= 4 && PlayerInfo[playerid][pFaction] <= 6) aliance = 1;
	    	else aliance = 2; 
	    	new bool:unwanted[CAR_AMOUNT];
		    foreach(new player : Player)
	     	{
	             if(IsPlayerInAnyVehicle(player))
				 {
				 	unwanted[GetPlayerVehicleID(player)]=true;
				 }
	     	}
	     	new string[256];
	     	format(string,sizeof(string),"Membrul %s a dat respawn la masini.",GetName(playerid));
			foreach(new i : Player)
			{
			    if(IsPlayerConnected(i) )
			    {
			        if(PlayerInfo[i][pFaction] >= 4 && PlayerInfo[i][pFaction] <= 6) aliance1 = 1;
	    			else aliance1 = 2; 
	    			if(aliance1 == aliance) SCM(i,COLOR_SERVER,string);
			    }
			}
	    	for(new i = 0; i <= 2001; i++)
	    		if(WarCars[i][1] == aliance && unwanted[i] == false)
	    			SetVehicleToRespawn(i);
	    	return 1;
	    }
	    if(IsGang(playerid) && CanTurf[PlayerInfo[playerid][pFaction]] == 2)
	    {
	    	new bool:unwanted[CAR_AMOUNT];
		    foreach(new player : Player)
	             if(IsPlayerInAnyVehicle(player))
				 	unwanted[GetPlayerVehicleID(player)]=true;
	     	new string[256];
	     	format(string,sizeof(string),"Membrul %s a dat respawn la masini.",GetName(playerid));
			foreach(new i : Player)
			    if(IsPlayerConnected(i) )
			        if(PlayerInfo[i][pFaction] == PlayerInfo[playerid][pFaction]) SCM(i,COLOR_SERVER,string);
	    	if(unwanted[TurfCarID[PlayerInfo[playerid][pFaction]][1]] == false) SetVehicleToRespawn(TurfCarID[PlayerInfo[playerid][pFaction]][1]);
	    	if(unwanted[TurfCarID[PlayerInfo[playerid][pFaction]][2]] == false) SetVehicleToRespawn(TurfCarID[PlayerInfo[playerid][pFaction]][2]);
	    	if(unwanted[TurfCarID[PlayerInfo[playerid][pFaction]][3]] == false) SetVehicleToRespawn(TurfCarID[PlayerInfo[playerid][pFaction]][3]);
	    	if(unwanted[TurfCarID[PlayerInfo[playerid][pFaction]][4]] == false) SetVehicleToRespawn(TurfCarID[PlayerInfo[playerid][pFaction]][4]);
	    	if(unwanted[TurfCarID[PlayerInfo[playerid][pFaction]][5]] == false) SetVehicleToRespawn(TurfCarID[PlayerInfo[playerid][pFaction]][5]);
	    	if(unwanted[TurfCarID[PlayerInfo[playerid][pFaction]][6]] == false) SetVehicleToRespawn(TurfCarID[PlayerInfo[playerid][pFaction]][6]);
	    	return 1;
	    }
		if(PlayerInfo[playerid][pRFaction] >= 5)
		{
			new bool:unwanted[CAR_AMOUNT];
		    foreach(new player : Player)
	     	{
	             if(IsPlayerInAnyVehicle(player))
				 {
				 	unwanted[GetPlayerVehicleID(player)]=true;
				 }
	     	}
	     	new string[256];
	     	format(string,sizeof(string),"Membrul %s a dat respawn la masini.",GetName(playerid));
			foreach(new i : Player)
			{
			    if(IsPlayerConnected(i) )
			    {
			        if(PlayerInfo[i][pFaction] == PlayerInfo[playerid][pFaction])
			        {
			            SCM(i,COLOR_SERVER,string);
			        }
			    }
			}
			for(new car = 1; car <= 400; car++)
			{
			    if(!unwanted[car] && ServerVehicles[car][vFaction] == PlayerInfo[playerid][pFaction] ) SetVehicleToRespawn(car);
			}
	    }
	    else
	    {
	        SendClientMessage(playerid, COLOR_LGREEN, "Nu ai acces la aceasta comanda!");
		}
	}
	return 1;
}
CMD:gov(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
	    if(PlayerInfo[playerid][pFaction] >= 1 && PlayerInfo[playerid][pFaction] <= 3)
	 	{
	 	    if(PlayerInfo[playerid][pRFaction] != 7) return SCM(playerid,COLOR_GREY,"Nu ai acces la aceasta comanda.");
	 	    new text[180];
	 	    if(sscanf(params, "s[180]",text)) return SendClientMessage(playerid,COLOR_GREY,"Sintaxa: {FFFFFF}/gov <text>");
			SendClientMessageToAll(COLOR_WHITE,"*** Government Announcements ***");
			SendClientMessageToAll(COLOR_BLUE," ");
			new string[256];
			format(string,sizeof(string),"%s %s %s : %s . ",PlayerInfo[playerid][pFacName],PlayerInfo[playerid][pFacRank],GetName(playerid),text);
			SendClientMessageToAll(COLOR_BLUE,string);
			SendClientMessageToAll(COLOR_BLUE," ");
			SendClientMessageToAll(COLOR_WHITE,"********************************************");
			
	    }
	    else
		{
		    SCM(playerid,COLOR_GREY,"Nu esti intr-o factiune.");
		}
	    
	}
	return 1;
}
CMD:rac(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 3)
	{
		new bool:unwanted[CAR_AMOUNT];
	    foreach(new player : Player)
	        if(IsPlayerInAnyVehicle(player))
				unwanted[GetPlayerVehicleID(player)]=true;
		SendClientMessageToAll(COLOR_WHITE,"Un admin a dat rac la masini.");
		for(new car = 1; car <= 2000; car++)
		{
			new model;
			model = GetVehicleModel(car);
		    if(!unwanted[car] && model != 435 && model != 450 && model != 584 && model != 591) 
		    	SetVehicleToRespawn(car);
		}
    }
    else SendClientMessage(playerid, COLOR_LGREEN, "Nu ai acces la aceasta comanda!");
    return 1;
}
CMD:helpers(playerid, params[])
{
    if(IsPlayerConnected(playerid))
	{
        new count = 0,string[200],sendername[30];
		SendClientMessage(playerid, COLOR_SERVER, "----Helpers Online----------------------------------------------------");
		foreach(new i : Player)
		{
			if(IsPlayerConnected(i))
			{
				if(PlayerInfo[i][pHelper] != 0)
				{
					GetPlayerName(i, sendername,  sizeof(sendername));
					format(string, 256, "(%d) %s - helper level %d", i,sendername,PlayerInfo[i][pHelper]);
					SendClientMessage(playerid, COLOR_WHITE, string);
					count++;
				}
			}
		}
		if(count == 0) SendClientMessage(playerid,COLOR_WHITE,"* Nu sunt helperi conectati.");
		SendClientMessage(playerid, COLOR_SERVER, "----------------------------------------------------------------------------");
		SendClientMessage(playerid, -1, "Daca ai vreo problema, poti folosi /needhelp. Pentru intrebari legate de joc poti folosi /n.");
		SendClientMessage(playerid, COLOR_SERVER, "----------------------------------------------------------------------------");
	}
	return 1;
}
CMD:apark(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pAdmin]>=1337)
	    {
	        new carm,c1,c2,f,r,plate[64],string[512];
	        if(sscanf(params, "iiiiis[64]", carm,c1,c2,f,r,plate)) return SendClientMessage(playerid,COLOR_GREY, "Sintaxa: {FFFFFF}/apark <car model> <color1> <color2> <faction> <rank> <plate>");
            format(string, 256, "AdmCmd: Adminul %s a adaugat o masina %d la factiunea %d.",GetName(playerid),carm,f);
            SendClientMessageToAll(COLOR_WHITE,string);
            nrmasinifactiune++;
            new Float:X,Float:Y,Float:Z;
            new currentveh;
			new Float:z_rot;
			currentveh = GetPlayerVehicleID(playerid);
			GetVehiclePos(currentveh, X,Y,Z);
			GetVehicleZAngle(currentveh, z_rot);
			format(string, sizeof(string),"INSERT INTO `svehicles`(`vID`, `vModel`, `LocationX`, `LocationY`, `LocationZ`, `Angle`, `Color1`, `Color2`, `Faction`, `Rank`, `NumberPlate`) VALUES (%d,%d,%f,%f,%f,%f,%d,%d,%d,%d,'%s')",nrmasinifactiune,carm,X,Y,Z,z_rot,c1,c2,f,r,plate);
            mysql_query(handle,string);


	    }
	    else
	    {
	        SendClientMessage(playerid,COLOR_GREY,"Nu ai acces la aceasta comanda.");
	    }
	}
	return 1;
}
CMD:haddcars(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pAdmin]>=1337)
	    {
	        new c1, c2, houseid, plate[64], string[512];
	        if(sscanf(params, "iiis[64]", c1, c2, houseid, plate)) return SendClientMessage(playerid,COLOR_GREY, "Sintaxa: {FFFFFF}/haddcars <color1> <color2> <houseid> <plate>");
            format(string, 256, "AdmCmd: Adminul %s a adaugat o masina la casa %d.",GetName(playerid));
            SendClientMessageToAll(COLOR_WHITE,string);
            HouseCarsNumber++;
            new Float:X,Float:Y,Float:Z;
            new currentveh;
			new Float:z_rot;
			currentveh = GetPlayerVehicleID(playerid);
			GetVehiclePos(currentveh, X,Y,Z);
			GetVehicleZAngle(currentveh, z_rot);
			format(string, sizeof(string),"INSERT INTO `housecars`(`ID`, `HouseID`, `Model`, `x`, `y`, `z`, `r`, `Color1`, `Color2`, `Plate`) VALUES (%d, %d, %d, %f, %f, %f, %f, %d, %d, '%s')",HouseCarsNumber, houseid, 418,X, Y, Z, z_rot, c1, c2, plate );
            mysql_query(handle,string);
	    }
	    else
	    {
	        SendClientMessage(playerid,COLOR_GREY,"Nu ai acces la aceasta comanda.");
	    }
	}
	return 1;
}
CMD:findhouse(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(CP[playerid][ID] == 0)
		{
			new houseid;
			if(sscanf(params, "i",houseid)) return SendClientMessage(playerid,COLOR_GREY, "Sintaxa: {FFFFFF}/findhouse <houseid>");
			if(houseid > HouseNumber && houseid < 1) return SCM(playerid, COLOR_GREY, "Nu exista aceasta casa.");
			CP[playerid][ID] = 4;
			SetPlayerCheckpoint(playerid, svHouse[houseid][hX1], svHouse[houseid][hY1],svHouse[houseid][hZ1], 3);
		}
		else SCM(playerid, COLOR_GREY, "Ai deja un CheckPoint activ.");
	}
	return 1;
}
CMD:gotohouse(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pAdmin] == 0) return SCM(playerid, COLOR_GREY, "Nu ai acces la aceasta comanda.");
		new houseid;
		if(sscanf(params, "i",houseid)) return SendClientMessage(playerid,COLOR_GREY, "Sintaxa: {FFFFFF}/gotohouse <houseid>");
		if(houseid > HouseNumber && houseid < 1) return SCM(playerid, COLOR_GREY, "Nu exista aceasta casa.");
		SetPlayerPos(playerid, svHouse[houseid][hX1], svHouse[houseid][hY1],svHouse[houseid][hZ1]);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerInterior(playerid, 0);
	}
	return 1;
}
CMD:wanted(playerid, params[])
{
	if(PlayerInfo[playerid][pFaction]<=3&&PlayerInfo[playerid][pFaction]>=1) 
	{
		new iString[512],string[300],sendername[MAX_PLAYER_NAME],count = 0,online[50];
		if(IsPlayerConnected(playerid))
		{
			new Float:X;
			new Float:Y;
			new Float:Z;
			foreach(new i : Player)
			{
				if(PlayerInfo[i][pWanted] >= 1)
				{
				    GetPlayerPos(i,X,Y,Z);
				    new Float: Distance = GetPlayerDistanceFromPoint(playerid, X, Y, Z);
				    SelectedPlayer[playerid][count] = i;
					GetPlayerName(i, sendername, sizeof(sendername));
					string[0] = 0;
					format(string, sizeof(string), "%s(%d) - Wanted Nivel: %d - Distance : %.1f m\n",sendername,i,PlayerInfo[i][pWanted],Distance);
					count++;
					strcat(iString,string);
				}
			}
			format(online, sizeof(online),"Wanted online: %d",count);
			if(count == 0) return SendClientMessage(playerid,COLOR_GREY, "Nu sunt suspecti conectati.");
			ShowPlayerDialog(playerid, DIALOG_WANTEDON, DIALOG_STYLE_LIST, online, iString , "Cancel", "");
		}
	}
	else SendClientMessage(playerid, COLOR_GREY, "Nu faci parte din factiunea politiei.");
	return 1;
}
CMD:su(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pFaction]>=1&&PlayerInfo[playerid][pFaction]<=3)
	    {
	        new id,wantedlevel,string[256];
	        if(sscanf(params,"uis[256]",id,wantedlevel,string)) return SendClientMessage(playerid,COLOR_GREY,"Sintaxa: {FFFFFF}/su <playerid/name> <wanted level> <reason>");
	        if(IsPlayerConnected(id))
	        {
	             if(PlayerInfo[id][pFaction]>=1&&PlayerInfo[id][pFaction]<=3) return SendClientMessage(playerid,COLOR_GREY,"Acel jucator este membru al politiei.");
	             if(wantedlevel>=1&&wantedlevel<=10)
		            {
		                format(PlayerInfo[id][pWantedReason], 60 ,string);
		                Update(id,pWantedReason);
		                UpdatePlayerWantedLevel(id, PlayerInfo[id][pWanted], PlayerInfo[id][pWanted] + wantedlevel);
						PlayerInfo[id][pWanted]=wantedlevel;
						PlayerInfo[id][pWantedMinute]=5;
						SetPlayerWantedLevel(id, wantedlevel);
						new str1[256];
						format(str1, sizeof(str1),"WANTED SCADE IN: %d MINUTE", PlayerInfo[id][pWantedMinute]);
						PlayerTextDrawSetString(id, wantedscade[id], str1);
						PlayerTextDrawShow(id, wantedscade[id]);
						format(str1, sizeof(str1),"Ai primit wanted %d de la %s , motiv: %s", wantedlevel, GetName(playerid),string);
						SCM(id,COLOR_YELLOW,str1);
					}
					else
					{
					    SendClientMessage(playerid,COLOR_GREY,"Poti da wanted intre 1 si 10.");
					}
	        }
	        else
	        {
	            SendClientMessage(playerid,COLOR_GREY,"Jucatorul nu este conectat.");
	        }
	    }
	    else
	    {
	        SendClientMessage(playerid,COLOR_GREY,"Nu esti politist.");
	    }
	}
	return 1;
}
CMD:mdc(playerid, params[])
{
	if(IsPlayerConnected(playerid) )
	{
		if(PlayerInfo[playerid][pFaction] >= 1 && PlayerInfo[playerid][pFaction] <= 3 )
		{
		    new id,string[256];
		    if(sscanf(params,"u",id)) return SendClientMessage(playerid,COLOR_GREY,"Sintaxa: {FFFFFF}/mdc <playerid/name>");
		    {
		        if(!IsPlayerConnected(id) ) return SCM(playerid,COLOR_GREY,"Jucatorul respectiv nu este conectat");
		        if(PlayerInfo[id][pWanted] == 0 ) return SCM(playerid , COLOR_GREY , "Jucatorul respectiv nu are wanted");
				format(string,sizeof(string),"NUME: %s | WANTED : %d | REASON : %s",GetName(id),PlayerInfo[id][pWanted],PlayerInfo[id][pWantedReason]);
				SCM(playerid,COLOR_SERVER,string);
		    }
		}
	}
	return 1;
}
CMD:wantedlevel(playerid, params[])
{
	new string[256];
    format(string, sizeof(string), "Wantedlevel %d ; Minute: %d , LastMinute: %d", PlayerInfo[playerid][pWanted],PlayerInfo[playerid][pWantedMinute], lastminute);
    SendClientMessage(playerid,COLOR_GREY,string);
	return 1;
}
CMD:dsaddvehicle(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pAdmin] <= 1337) return SCM(playerid, COLOR_GREY, "Nu ai acces la aceasta comanda.");
		new model, speed, price, stoc;
		if(sscanf(params,"iiii",model, speed, price, stoc)) return SendClientMessage(playerid,COLOR_GREY,"Sintaxa: {FFFFFF}/dsaddvehicle <model> <speed> <price> <stock>");
		new string[256];
		dsCars++;
		format(string, sizeof(string), "INSERT INTO `dscars`(`ID`, `Model`, `Speed`, `Price`, `Stock`) VALUES (%d, %d, %d, %d, %d)", dsCars, model, speed, price, stoc);
		mysql_query(handle,string);
		format(string, sizeof(string), "AdmCmd: Adminul %s a adaugat masina %d in ds", GetName(playerid), model);
		for(new i = 0; i <= MAX_PLAYERS; i++)
			if(IsPlayerConnected(i) && PlayerInfo[i][pAdmin] > 1)
				SCM(i, COLOR_RED, string);
	}
	return 1;
}
function IsInRangeOfGasStation(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid,20,1004.2475,-937.9796,42.1797)) return 1;
	if(IsPlayerInRangeOfPoint(playerid,20,1943.6311,-1772.9531,13.3906)) return 1;
	if(IsPlayerInRangeOfPoint(playerid,20,-1606.3761,-2713.7097,48.5335)) return 1;
	if(IsPlayerInRangeOfPoint(playerid,20,-2026.5939,156.7059,29.0391)) return 1;
	if(IsPlayerInRangeOfPoint(playerid,20,-1328.9844,2677.9714,50.0625)) return 1;
	if(IsPlayerInRangeOfPoint(playerid,20,608.8265,1699.7535,6.9922)) return 1;
	if(IsPlayerInRangeOfPoint(playerid,20,655.5261,-564.8308,16.3359)) return 1;
	if(IsPlayerInRangeOfPoint(playerid,20,-1675.6821,412.9916,7.1797)) return 1;
	if(IsPlayerInRangeOfPoint(playerid,20,-2409.4727,975.9866,45.2969)) return 1;
	if(IsPlayerInRangeOfPoint(playerid,20,2114.4636,920.2435,10.8203)) return 1;
	return 0;
}
function GetVehicleSpeed(vehicleid)
{
    new
        Float:x,
        Float:y,
        Float:z,
        vel;
    GetVehicleVelocity( vehicleid, x, y, z );
    vel = floatround( floatsqroot( x*x + y*y + z*z ) * 180 );           // KM/H
	//vel = floatround( floatsqroot( x*x + y*y + z*z ) * 180 / MPH_KMH ); // Mph
    return vel;
}
function abs(var)
{
	if(var<0) return -var;
	else return var;
}
function CheckSpeed()
{
    foreach(new i : Player)
    {
        if(IsPlayerConnected(i))
           {
               if(GetPlayerState(i) == PLAYER_STATE_DRIVER)
               {    new vehicle = GetPlayerVehicleID(i);
                    PlayerTextDrawShow(i,SpeedText[i][UseBox]);
                    PlayerTextDrawShow(i,SpeedText[i][White1]);
                    PlayerTextDrawShow(i,SpeedText[i][White2]);
                    PlayerTextDrawShow(i,SpeedText[i][White3]);
                    PlayerTextDrawShow(i,SpeedText[i][White4]);
                    if(!IsABike(vehicle) && !IsABoat(vehicle) && !IsAPlane(vehicle) )
                    	PlayerTextDrawShow(i,SpeedText[i][Fuel]);
                    
                    
                    new string[256];
                    new Float:health;
                    
                    format(string,sizeof(string),VehicleNames[GetVehicleModel(vehicle)-400]);
                    PlayerTextDrawSetString(i, SpeedText[i][Car], string);
                	PlayerTextDrawShow(i, SpeedText[i][Car]);
                    
                    new oldspeed = PlayerInfo[i][Speed];
                    new newspeed = GetVehicleSpeed(vehicle);
                    PlayerInfo[i][Speed]=newspeed;
                    format(string,sizeof(string),"Speed: %d KM/H",newspeed);
                	PlayerTextDrawSetString(i, SpeedText[i][Speed], string);
                	PlayerTextDrawShow(i, SpeedText[i][Speed]);
                	
                	GetVehicleHealth(vehicle,health);
                	
                	format(string,sizeof(string),"Health: %.2f",health);
                	PlayerTextDrawSetString(i, SpeedText[i][Health], string);
                	PlayerTextDrawShow(i, SpeedText[i][Health]);
                	if(!IsABike(vehicle) && !IsABoat(vehicle) && !IsAPlane(vehicle) && fuel[vehicle] > 0)
                	{
	                	new acceleration = abs(newspeed - oldspeed);
	                	new Consume = (((acceleration / 10) + 1) * (newspeed / 20));
	                 	new Float:Consume2 = float(Consume);
	                	fuel[vehicle] = fuel[vehicle]-(Consume2/500);
	                	format(string,sizeof(string),"Fuel: %.1f C:%d",fuel[vehicle],Consume);
	                	PlayerTextDrawSetString(i, SpeedText[i][Fuel], string);
	                	PlayerTextDrawShow(i, SpeedText[i][Fuel]);
                	}
                	
                	
          	   }
               else
               {
		      		PlayerTextDrawHide(i,SpeedText[i][UseBox]);
	    			PlayerTextDrawHide(i,SpeedText[i][White1]);
	       			PlayerTextDrawHide(i,SpeedText[i][White2]);
	          		PlayerTextDrawHide(i,SpeedText[i][White3]);
	       			PlayerTextDrawHide(i,SpeedText[i][White4]);
	          		PlayerTextDrawHide(i,SpeedText[i][Car]);
	            	PlayerTextDrawHide(i,SpeedText[i][Fuel]);
	            	PlayerTextDrawHide(i,SpeedText[i][Speed]);
	            	PlayerTextDrawHide(i,SpeedText[i][Health]);
				}
        }
    }
}
function LoadGPS()
{
    new Cache: db = mysql_query (handle, "SELECT * FROM `gpsinfo` ORDER BY `gpsinfo`.`ID` ASC");
    new
        x,
        result[256];
	cache_get_row_count(nrGPS);
	for(new i = 0; i < nrGPS; i++)
	{
		cache_get_value_name(i, "ID", result); 					x = strval(result);
	    GpsInfo[x][ID] = x;
	    cache_get_value_name(i, "Type", result); 				GpsInfo[x][Type] = strval(result);
	    cache_get_value_name(i, "X", result); 				    GpsInfo[x][gpX] = floatstr(result);
        cache_get_value_name(i, "Y", result); 					GpsInfo[x][gpY] = floatstr(result);
        cache_get_value_name(i, "Z", result); 					GpsInfo[x][gpZ] = floatstr(result);
        cache_get_value_name(i, "Name", result); 				format(GpsInfo[x][Name], 256, result);
	}
	printf("[MySQL GPS]: %d GPS Location loaded.", nrGPS);
	cache_delete(db);
	return 1;
}
function LoadFactionMembers()
{
	new Cache: db;
    new result[256], string[256];
    for(new i = 1; i <= 14; i++)
    {
    	format(string, sizeof(string), "SELECT * FROM `users` WHERE `Faction` = '%d'", i);
    	db = mysql_query (handle, string);
    	cache_get_row_count(FactionMembers[i][fTotalMembers]);
    	cache_delete(db);
    	format(string, sizeof(string), "SELECT * FROM `factions` WHERE `ID` = '%d'", i);
    	db = mysql_query (handle, string);
    	cache_get_value_name(0, "MaxMembers", result); 					FactionMembers[i][fMaxMembers] = strval(result);
    	cache_get_value_name(0, "MinLevel", result); 					FactionMembers[i][fMinLevel] = strval(result);
    	cache_delete(db);

    }
	cache_delete(db);
	return 1;
}
function LoadBiz()
{
	new Cache: db = mysql_query (handle, "SELECT * FROM `bizinfo` ORDER BY `bizinfo`.`ID` ASC");
    new
        x,
        result[256];
	cache_get_row_count(nrBiz);
	for(new i = 0; i < nrBiz; i++)
	{
		cache_get_value_name(i, "ID", result); 					x = strval(result);
	    BizInfo[x][ID] = x;
	    cache_get_value_name(i, "Type", result); 					BizInfo[x][Type] = strval(result);
	    cache_get_value_name(i, "Name", result); 					format(BizInfo[x][Name], 256, result);
	    cache_get_value_name(i, "OwnerID", result); 				BizInfo[x][OwnerID] = strval(result);
	    cache_get_value_name(i, "X", result); 				        BizInfo[x][bX] = floatstr(result);
        cache_get_value_name(i, "Y", result); 						BizInfo[x][bY] = floatstr(result);
        cache_get_value_name(i, "Z", result); 						BizInfo[x][bZ] = floatstr(result);
        cache_get_value_name(i, "VW", result); 						BizInfo[x][VW] = strval(result);
        cache_get_value_name(i, "Interior", result); 				BizInfo[x][Interior] = strval(result);
        cache_get_value_name(i, "iX", result); 				        BizInfo[x][iX] = floatstr(result);
        cache_get_value_name(i, "iY", result); 						BizInfo[x][iY] = floatstr(result);
        cache_get_value_name(i, "iZ", result); 						BizInfo[x][iZ] = floatstr(result);
        cache_get_value_name(i, "Money", result); 					BizInfo[x][Money] = strval(result);
        cache_get_value_name(i, "CanEnter", result); 				BizInfo[x][CanEnter] = strval(result);
        cache_get_value_name(i, "Fee", result); 					BizInfo[x][Fee] = strval(result);
        cache_get_value_name(i, "OwnerName", result); 				format(BizInfo[x][OwnerName], 256, result);
        new string[256];
        format(string, sizeof(string), "{09960d}%s\n{c1b02e}ID: {969694} %d\n{c1b02e}Owner: {969694}%s\n{c1b02e}Fee: {969694}%d $", BizInfo[x][Name], x ,BizInfo[x][OwnerName], BizInfo[x][Fee]);
        if(BizInfo[x][OwnerID] == -1) format(string, sizeof(string), "%s\n{c1b02e}Price: {969694}20.000.000$\n{c1b02e}/buybiz", string);
        BizInfo[x][TextID] = Create3DTextLabel(string, COLOR_WHITE,BizInfo[x][bX], BizInfo[x][bY], BizInfo[x][bZ],20,0,1);
		AddStaticPickup(1239, 1, BizInfo[x][bX], BizInfo[x][bY], BizInfo[x][bZ], 0);
	}
	printf("[MySQL Biz]: %d biz loaded.", nrBiz);
	cache_delete(db);
	return 1;
}
function LoadPersonalCars(playerid)
{
	new string[256];
	format(string, sizeof(string), "SELECT * FROM `personalcars` WHERE `OwnerID` = '%d'",PlayerInfo[playerid][pID]);
	new Cache: db = mysql_query (handle, string);
	new nrPersonalCars;
	new result[256];
	cache_get_row_count(nrPersonalCars);
	for(new i = 0; i < nrPersonalCars; i++)
	{
		///cauta id-ul disponibil
		new pos;
		for(new j = 1; j <= 10000; j++)
			if(EmptyPersonalCars[j] == 0)
			{
				pos = j;
				break;
			}
		EmptyPersonalCars[pos] = 1;
		PVLock[pos][playerid] = 1;
		PersonalCars[pos][OwnerID] = playerid;
		PersonalCars[pos][OwnerSQLID] = PlayerInfo[playerid][pID];
		PersonalCars[pos][VStatus] = 0;
		cache_get_value_name(i, "ID", result); 						PersonalCars[pos][ID] = strval(result);
	    cache_get_value_name(i, "Model", result); 					PersonalCars[pos][Model] = strval(result);
	    cache_get_value_name(i, "Vip", result); 					PersonalCars[pos][Vip] = strval(result);
	    cache_get_value_name(i, "X", result); 				        PersonalCars[pos][cX] = floatstr(result);
        cache_get_value_name(i, "Y", result); 						PersonalCars[pos][cY] = floatstr(result);
        cache_get_value_name(i, "Z", result); 						PersonalCars[pos][cZ] = floatstr(result);
        cache_get_value_name(i, "R", result); 				        PersonalCars[pos][cR] = floatstr(result);
        cache_get_value_name(i, "vX", result); 				        PersonalCars[pos][vX] = floatstr(result);
        cache_get_value_name(i, "vY", result); 						PersonalCars[pos][vY] = floatstr(result);
        cache_get_value_name(i, "vZ", result); 						PersonalCars[pos][vZ] = floatstr(result);
        cache_get_value_name(i, "rX", result); 				        PersonalCars[pos][rX] = floatstr(result);
        cache_get_value_name(i, "rY", result); 						PersonalCars[pos][rY] = floatstr(result);
        cache_get_value_name(i, "rZ", result); 						PersonalCars[pos][rZ] = floatstr(result);
        cache_get_value_name(i, "Plate", result); 					format(PersonalCars[pos][Plate], 256, result);
        cache_get_value_name(i, "VColor", result); 					format(PersonalCars[pos][VColor], 256, result);
        cache_get_value_name(i, "VText", result); 					format(PersonalCars[pos][VText], 256, result);
        cache_get_value_name(i, "Color1", result); 					PersonalCars[pos][Color1] = strval(result);
        cache_get_value_name(i, "Color2", result); 					PersonalCars[pos][Color2] = strval(result);
        cache_get_value_name(i, "PaintJob", result); 				PersonalCars[pos][PaintJob] = strval(result);
        cache_get_value_name(i, "Mode1", result); 					PersonalCars[pos][Mode1] = strval(result);
        cache_get_value_name(i, "Mode2", result); 					PersonalCars[pos][Mode2] = strval(result);
        cache_get_value_name(i, "Mode3", result); 					PersonalCars[pos][Mode3] = strval(result);
        cache_get_value_name(i, "Mode4", result); 					PersonalCars[pos][Mode4] = strval(result);
        cache_get_value_name(i, "Mode5", result); 					PersonalCars[pos][Mode5] = strval(result);
        cache_get_value_name(i, "Mode6", result); 					PersonalCars[pos][Mode6] = strval(result);
        cache_get_value_name(i, "Mode7", result); 					PersonalCars[pos][Mode7] = strval(result);
        cache_get_value_name(i, "Mode8", result); 					PersonalCars[pos][Mode8] = strval(result);
        cache_get_value_name(i, "Mode9", result); 					PersonalCars[pos][Mode9] = strval(result);
        cache_get_value_name(i, "Mode10", result); 					PersonalCars[pos][Mode10] = strval(result);
        cache_get_value_name(i, "Mode11", result); 					PersonalCars[pos][Mode11] = strval(result);
        cache_get_value_name(i, "Mode12", result); 					PersonalCars[pos][Mode12] = strval(result);
        cache_get_value_name(i, "Mode13", result); 					PersonalCars[pos][Mode13] = strval(result);
        cache_get_value_name(i, "Mode14", result); 					PersonalCars[pos][Mode14] = strval(result);
        cache_get_value_name(i, "RainBow", result); 				PersonalCars[pos][RainBow] = strval(result);
        PersonalCars[pos][RainBowI] = 0;
        PlayerInfo[playerid][pCarPos][i] = pos;
	}
	printf("[MySQL Personal Cars]: %d cars loaded for player %s.", nrPersonalCars, GetName(playerid));
	cache_delete(db);
}
function LoadDsCars()
{
	new Cache: db = mysql_query (handle, "SELECT * FROM `dscars` ORDER BY `dscars`.`ID` ASC");
    new
        x,
        result[256];
	cache_get_row_count(dsCars);
	for(new i = 0; i < dsCars ; i++)
	{
		cache_get_value_name(i, "ID", result); 					x = strval(result);
	    DealerCars[x][ID] = x;
	    cache_get_value_name(i, "Model", result); 					DealerCars[x][Model] = strval(result);
	    cache_get_value_name(i, "Speed", result); 					DealerCars[x][Speed] = strval(result);
	    cache_get_value_name(i, "Price", result); 					DealerCars[x][Price] = strval(result);
	    cache_get_value_name(i, "Stock", result); 					DealerCars[x][Stock] = strval(result);
    }
    printf("[MySQL DS Cars]: %d cars loaded.", HouseCarsNumber);
	cache_delete(db);
	return 1;
}
function LoadHouseCars()
{
	new Cache: db = mysql_query (handle, "SELECT * FROM `housecars` ORDER BY `housecars`.`ID` ASC");
    new
        x,
        result[256];
	cache_get_row_count(HouseCarsNumber);
	for(new i = 0; i < HouseCarsNumber ; i++)
	{
		cache_get_value_name(i, "ID", result); 					x = strval(result);
	    HouseCar[x][ID] = x;
	    cache_get_value_name(i, "HouseID", result); 					HouseCar[x][HouseID] = strval(result);
	    cache_get_value_name(i, "Model", result); 					HouseCar[x][Model] = strval(result);
	    cache_get_value_name(i, "Color1", result); 					HouseCar[x][Color1] = strval(result);
	    cache_get_value_name(i, "Color2", result); 					HouseCar[x][Color2] = strval(result);
	    cache_get_value_name(i, "x", result); 				        HouseCar[x][hcX] = floatstr(result);
        cache_get_value_name(i, "y", result); 						HouseCar[x][hcY] = floatstr(result);
        cache_get_value_name(i, "z", result); 						HouseCar[x][hcZ] = floatstr(result);
        cache_get_value_name(i, "r", result); 				        HouseCar[x][hcR] = floatstr(result);
        cache_get_value_name(i, "Plate", result); 				format(HouseCar[x][Plate], 256, result);
        new vehid;
        vehid = CreateVehicle(HouseCar[x][Model], HouseCar[x][hcX], HouseCar[x][hcY], HouseCar[x][hcZ], HouseCar[x][hcR], HouseCar[x][Color1], HouseCar[x][Color2], -1);
        CarHouse[vehid] = HouseCar[x][HouseID];
        SetVehicleNumberPlate(vehid, HouseCar[x][Plate]);
        svHouse[HouseCar[x][HouseID]][hVehID] = vehid;
    }
    printf("[MySQL House's Cars]: %d cars loaded.", HouseCarsNumber);
	cache_delete(db);
	return 1;
}
function LoadSvHouse()
{
	new Cache: db = mysql_query (handle, "SELECT * FROM `house` ORDER BY `house`.`ID` ASC");
    new
        x,
        result[256];
	cache_get_row_count(HouseNumber);
	for(new i = 0; i < HouseNumber ; i++)
	{
		cache_get_value_name(i, "ID", result); 					x = strval(result);
	    svHouse[x][ID] = x;
	    cache_get_value_name(i, "OwnerName", result); 				format(svHouse[x][hOwnerName], 256, result);
	    cache_get_value_name(i, "HName", result); 					format(svHouse[x][hName], 256, result);

	    cache_get_value_name(i, "X1", result); 				        svHouse[x][hX1] = floatstr(result);
        cache_get_value_name(i, "X2", result); 						svHouse[x][hX2] = floatstr(result);
        cache_get_value_name(i, "Y1", result); 						svHouse[x][hY1] = floatstr(result);
        cache_get_value_name(i, "Y2", result); 						svHouse[x][hY2] = floatstr(result);
        cache_get_value_name(i, "Z1", result); 						svHouse[x][hZ1] = floatstr(result);
        cache_get_value_name(i, "Z2", result); 						svHouse[x][hZ2] = floatstr(result);
        cache_get_value_name(i, "X3", result); 						svHouse[x][hX3] = floatstr(result);
        cache_get_value_name(i, "Y3", result); 						svHouse[x][hY3] = floatstr(result);
        cache_get_value_name(i, "Z3", result); 						svHouse[x][hZ3] = floatstr(result);

        cache_get_value_name(i, "Price", result); 					svHouse[x][hPrice] = strval(result);
        cache_get_value_name(i, "RentPrice", result); 				svHouse[x][hRentPrice] = strval(result);
        cache_get_value_name(i, "Owned", result); 					svHouse[x][hOwned] = strval(result);
        cache_get_value_name(i, "InteriorID1", result); 			svHouse[x][hInteriorID1] = strval(result);
        cache_get_value_name(i, "InteriorID2", result); 			svHouse[x][hInteriorID2] = strval(result);
        cache_get_value_name(i, "Level", result); 					svHouse[x][hLevel] = strval(result);
        cache_get_value_name(i, "VW", result); 						svHouse[x][hVW] = strval(result);
        cache_get_value_name(i, "Money", result); 					svHouse[x][hMoney] = strval(result);

        new string[256];
        if(svHouse[x][hOwned] == 0)
        {
        	svHouse[x][hPickup] = CreatePickup(1273, 1,svHouse[x][hX1], svHouse[x][hY1],svHouse[x][hZ1] , 0);
        	format(string,sizeof(string),"{009933}House ID: {ffffff}%d\n{009933}Owner:{ffffff} The State\n{009933}Interior: {ffffff}%s\n{009933}Price:{ffffff}%d\n{009933}Level:{ffffff}%d\n/buyhouse",svHouse[x][ID],svHouse[x][hName],svHouse[x][hPrice],svHouse[x][hLevel]);
        	svHouse[x][hTextID] =Create3DTextLabel(string,COLOR_WHITE,svHouse[x][hX1],svHouse[x][hY1],svHouse[x][hZ1],20,0,1);
        }
        else
     	{
     		svHouse[x][hPickup] = CreatePickup(1272, 1,svHouse[x][hX1], svHouse[x][hY1],svHouse[x][hZ1] , 0);
     		format(string,sizeof(string),"{009933}House ID: {ffffff}%d\n{009933}Owner:{ffffff} %s\n{009933}Interior: {ffffff}%s\n{009933}Rent Price:{ffffff}%d\n{ffffff}/rentroom",svHouse[x][ID],svHouse[x][hOwnerName],svHouse[x][hName],svHouse[x][hRentPrice]);
        	svHouse[x][hTextID] = Create3DTextLabel(string,COLOR_WHITE,svHouse[x][hX1],svHouse[x][hY1],svHouse[x][hZ1],20,0,1);
     	}	
	}
	printf("[MySQL Houses]: %d houses loaded.", HouseNumber);
	cache_delete(db);
	return 1;
}
function LoadMissions()
{
    new Cache: db = mysql_query (handle, "SELECT * FROM `missions` ORDER BY `missions`.`ID` ASC");
    new
        x,
        result[256];
	cache_get_row_count(NrMissions);
	for(new i =0 ; i < NrMissions ; i++ )
	{
	    cache_get_value_name(i, "ID", result); 					x = strval(result);
	    Missions[x][ID] = x;
	    cache_get_value_name(i, "Title", result); 				format(Missions[x][Title], 256, result);
	    cache_get_value_name(i, "Description", result); 		format(Missions[x][Description], 256, result);
	    cache_get_value_name(i, "Difficulty", result); 			format(Missions[x][Difficulty], 256, result);
	    cache_get_value_name(i, "Reward", result);              Missions[x][Reward] = strval(result);
	    cache_get_value_name(i, "Text1", result); 				format(Missions[x][Text1], 256, result);
	    cache_get_value_name(i, "Text2", result); 				format(Missions[x][Text2], 256, result);
	    cache_get_value_name(i, "Text3", result); 				format(Missions[x][Text3], 256, result);
	    cache_get_value_name(i, "Text4", result); 				format(Missions[x][Text4], 256, result);
	    cache_get_value_name(i, "Text5", result); 				format(Missions[x][Text5], 256, result);
	    cache_get_value_name(i, "Text6", result); 				format(Missions[x][Text6], 256, result);

        cache_get_value_name(i, "CP1X", result); 				Missions[x][CP1X] = floatstr(result);
        cache_get_value_name(i, "CP1Y", result); 				Missions[x][CP1Y] = floatstr(result);
        cache_get_value_name(i, "CP1Z", result); 				Missions[x][CP1Z] = floatstr(result);

        cache_get_value_name(i, "CP2X", result); 				Missions[x][CP2X] = floatstr(result);
        cache_get_value_name(i, "CP2Y", result); 				Missions[x][CP2Y] = floatstr(result);
        cache_get_value_name(i, "CP2Z", result); 				Missions[x][CP2Z] = floatstr(result);

        cache_get_value_name(i, "CP3X", result); 				Missions[x][CP3X] = floatstr(result);
        cache_get_value_name(i, "CP3Y", result); 				Missions[x][CP3Y] = floatstr(result);
        cache_get_value_name(i, "CP3Z", result); 				Missions[x][CP3Z] = floatstr(result);

        cache_get_value_name(i, "CP4X", result); 				Missions[x][CP4X] = floatstr(result);
        cache_get_value_name(i, "CP4Y", result); 				Missions[x][CP4Y] = floatstr(result);
        cache_get_value_name(i, "CP4Z", result); 				Missions[x][CP4Z] = floatstr(result);

        cache_get_value_name(i, "CP5X", result); 				Missions[x][CP5X] = floatstr(result);
        cache_get_value_name(i, "CP5Y", result); 				Missions[x][CP5Y] = floatstr(result);
        cache_get_value_name(i, "CP5Z", result); 				Missions[x][CP5Z] = floatstr(result);

        cache_get_value_name(i, "CP6X", result); 				Missions[x][CP6X] = floatstr(result);
        cache_get_value_name(i, "CP6Y", result); 				Missions[x][CP6Y] = floatstr(result);
        cache_get_value_name(i, "CP6Z", result); 				Missions[x][CP6Z] = floatstr(result);
	}
	AddStaticPickup(1277,1,1380.3617,-1088.7767,27.3844,0);
	Create3DTextLabel("Pentru a incepe o misiune tasteaza \n{009933}/mission",COLOR_WHITE,1380.3617,-1088.7767,27.3844,20,0,1);
	printf("[MySQL Missions]: %d missions loaded.", NrMissions);
	cache_delete(db);
	return 1;
}

function LoadHQ()
{
    new Cache: db = mysql_query (handle, "SELECT * FROM `svinterior` ORDER BY `svinterior`.`ID` ASC");
	new
		x,
		result[256];
	cache_get_row_count(nrhq);
	for(new i ; i<nrhq ; i++)
	{
		cache_get_value_name(i, "ID", result); 				x = strval(result);
       	SvHq[x][ID] = x;
       	cache_get_value_name(i, "Job", result); 			SvHq[x][Job] = strval(result);
       	cache_get_value_name(i, "Faction", result); 		SvHq[x][Faction] = strval(result);
       	cache_get_value_name(i, "Interior1", result); 		SvHq[x][Interior1] = strval(result);
       	cache_get_value_name(i, "VW1", result); 		    SvHq[x][VW1] = strval(result);
       	cache_get_value_name(i, "Interior2", result); 		SvHq[x][Interior2] = strval(result);
       	cache_get_value_name(i, "VW2", result); 		    SvHq[x][VW2] = strval(result);
     	cache_get_value_name(i, "X1", result); 				SvHq[x][X1] = floatstr(result);
      	cache_get_value_name(i, "X2", result); 				SvHq[x][X2] = floatstr(result);
      	cache_get_value_name(i, "Y1", result); 				SvHq[x][Y1] = floatstr(result);
      	cache_get_value_name(i, "Y2", result); 				SvHq[x][Y2] = floatstr(result);
      	cache_get_value_name(i, "Z1", result); 				SvHq[x][Z1] = floatstr(result);
      	cache_get_value_name(i, "Z2", result); 				SvHq[x][Z2] = floatstr(result);
      	cache_get_value_name(i, "Type", result); 				SvHq[x][Type] = strval(result);
      	
      	Create3DTextLabel(HqTypeEnter[SvHq[x][Type]],COLOR_WHITE,SvHq[x][X1],SvHq[x][Y1],SvHq[x][Z1],20,SvHq[x][VW1],1);
      	Create3DTextLabel(HqTypeExit[SvHq[x][Type]],COLOR_WHITE,SvHq[x][X2],SvHq[x][Y2],SvHq[x][Z2],20,SvHq[x][VW2],1);
      	AddStaticPickup(1239,1,SvHq[x][X1],SvHq[x][Y1],SvHq[x][Z1],SvHq[x][VW1]);
      	AddStaticPickup(1239,1,SvHq[x][X2],SvHq[x][Y2],SvHq[x][Z2],SvHq[x][VW2]);
	
	}
    printf("[MySQL HQ]: %d server hq loaded.", nrhq);
    cache_delete(db);
	return 1;
}
function LoadTurfInfo()
{
	new Cache: db = mysql_query (handle, "SELECT * FROM `turfinfo` ORDER BY `turfinfo`.`ID` ASC");
	new
		x,
		result[256];
	cache_get_row_count(TurfsNumber);
	for (new i = 0; i < TurfsNumber; i++)
	{
		cache_get_value_name(i, "ID", result); 				x = strval(result);
		TurfsInfo[x][tID] = x;
		cache_get_value_name(i, "OwnerID", result); 		TurfsInfo[x][tOwnerID] = strval(result);
		cache_get_value_name(i, "City", result); 			TurfsInfo[x][tCity] = strval(result);
		cache_get_value_name(i, "MaxX", result); 			TurfsInfo[x][tMaxX] = floatstr(result);
		cache_get_value_name(i, "MaxY", result); 			TurfsInfo[x][tMaxY] = floatstr(result);
		cache_get_value_name(i, "MinX", result); 			TurfsInfo[x][tMinX] = floatstr(result);
		cache_get_value_name(i, "MinY", result); 			TurfsInfo[x][tMinY] = floatstr(result);
		TurfsInfo[x][tZoneID] = GangZoneCreate(TurfsInfo[x][tMinX], TurfsInfo[x][tMinY], TurfsInfo[x][tMaxX], TurfsInfo[x][tMaxY]);
	}
	printf("[MySQL Turfs]: %d Turfs loaded.", TurfsNumber);
    cache_delete(db);
	return 1;
}
function LoadWarInfo()
{
	new Cache: db = mysql_query (handle, "SELECT * FROM `warinfo` ORDER BY `warinfo`.`ID` ASC");
	new
		x,
		result[256];
	cache_get_row_count(WarNumbers);
	for (new i = 0; i < WarNumbers; i++)
	{
		cache_get_value_name(i, "ID", result); 				x = strval(result);
		WarInfo[x][ID] = x;
		cache_get_value_name(i, "VW", result); 			WarInfo[x][VW] = strval(result);
		cache_get_value_name(i, "Name", result); 		format(WarInfo[x][Name], 256, result);
		cache_get_value_name(i, "x1", result); 			WarInfo[x][x1] = floatstr(result);
		cache_get_value_name(i, "x2", result); 			WarInfo[x][x2] = floatstr(result);
		cache_get_value_name(i, "y1", result); 			WarInfo[x][y1] = floatstr(result);
		cache_get_value_name(i, "y2", result); 			WarInfo[x][y2] = floatstr(result);
	}
	printf("[MySQL WarZone]: %d War Zone loaded.", WarNumbers);
    cache_delete(db);
    db = mysql_query (handle, "SELECT * FROM `warhistory` ORDER BY `warhistory`.`ID` ASC");
    new var;
    cache_get_row_count(var);
    if(var != 0)
    {
    	cache_get_value_name_int(var - 1, "ID", lWarID);
    	cache_get_value_name_int(var - 1, "warid", lWarZID);
    	cache_get_value_name(var - 1, "time", lWarTime);
    	cache_get_value_name_int(var - 1, "winnerid", lWarWinnerID);
    	cache_get_value_name_int(var - 1, "score1", lWarScore1);
    	cache_get_value_name_int(var - 1, "score2", lWarScore2);
    	cache_get_value_name(var - 1, "bestkiller", lWarBestKiller);
    }
    cache_delete(db);
	return 1;
}
function LoadSVehicles()
{
	new Cache: db = mysql_query (handle, "SELECT * FROM `svehicles` ORDER BY `svehicles`.`vID` ASC");
	new
		x,
		servervehs = 0,
		result[256];
	cache_get_row_count(nrmasinifactiune);
 	for (new i, j = nrmasinifactiune ; i != j; ++i)
	{
	    servervehs++;
       	cache_get_value_name(i, "vID", result); 				x = strval(result);
       	ServerVehicles[x][vID] = x;
       	cache_get_value_name(i, "vModel", result); 			ServerVehicles[x][vModel] = strval(result);
     	cache_get_value_name(i, "LocationX", result); 		ServerVehicles[x][vLocation][0] = floatstr(result);
      	cache_get_value_name(i, "LocationY", result); 		ServerVehicles[x][vLocation][1] = floatstr(result);
       	cache_get_value_name(i, "LocationZ", result); 		ServerVehicles[x][vLocation][2] = floatstr(result);
       	cache_get_value_name(i, "Angle", result); 			ServerVehicles[x][vAngle] = floatstr(result);
       	cache_get_value_name(i, "Color1", result); 			ServerVehicles[x][vColor][0] = strval(result);
      	cache_get_value_name(i, "Color2", result); 			ServerVehicles[x][vColor][1] = strval(result);
     	cache_get_value_name(i, "Faction", result); 			ServerVehicles[x][vFaction] = strval(result);
	  	cache_get_value_name(i, "Rank", result); 			ServerVehicles[x][vRank] = strval(result);
       	cache_get_value_name(i, "NumberPlate", result); 		format(ServerVehicles[x][vNumberPlate], 64, result);
       	if(ServerVehicles[x][vModel] >= 400 && ServerVehicles[x][vModel] <= 611)
		{
			CreateVehicle(ServerVehicles[x][vModel], ServerVehicles[x][vLocation][0], ServerVehicles[x][vLocation][1], ServerVehicles[x][vLocation][2], ServerVehicles[x][vAngle], ServerVehicles[x][vColor][0], ServerVehicles[x][vColor][1], -1);
			SetVehicleNumberPlate(x, ServerVehicles[x][vNumberPlate]);
			if(ServerVehicles[x][vFaction] == 1)
			{
				if(ServerVehicles[x][vModel] == 411) {
					new policecar2 = CreateObject(19327, 1034.2373, -1643.2886, 5.8373, -87.6999, 89.4001, -76.1805);
					SetObjectMaterialText(policecar2, "POLICE", 0, 50, "Arial", 25, 1, -16776216, 0, 1);
				    new lspdcar2 = CreateObject(19419,0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000);
					AttachObjectToVehicle(policecar2, x, 0.0, -1.9, 0.3, 270.0, 0.0, 0.0); // stanga dreapta || fata spate || sus jos || roteste (gen 90 grade) ||
				    AttachObjectToVehicle(lspdcar2, x, 0.0, 0.1661, 0.6957, 0.0000, 0.0000, 0.0000);
				}
			}

			else if(ServerVehicles[x][vFaction] == 2 )
			{
				if(ServerVehicles[x][vModel] == 411) {
					new policecar2 = CreateObject(19327, 1034.2373, -1643.2886, 5.8373, -87.6999, 89.4001, -76.1805);
					SetObjectMaterialText(policecar2, "F.B.I.", 0, 50, "Arial", 25, 1, -16776216, 0, 1);
				    new lspdcar2 = CreateObject(19419,0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000);
					AttachObjectToVehicle(policecar2, x, 0.0, -1.9, 0.3, 270.0, 0.0, 0.0); // stanga dreapta || fata spate || sus jos || roteste (gen 90 grade) ||
				    AttachObjectToVehicle(lspdcar2, x, 0.0, 0.1661, 0.6957, 0.0000, 0.0000, 0.0000);
				}
			}
			else if(ServerVehicles[x][vFaction] == 3)
			{
				if(ServerVehicles[x][vModel] == 411) {
					new policecar2 = CreateObject(19327, 1034.2373, -1643.2886, 5.8373, -87.6999, 89.4001, -76.1805);
					SetObjectMaterialText(policecar2, "N G", 0, 50, "Arial", 25, 1, -16776216, 0, 1);
				    new lspdcar2 = CreateObject(19419,0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000);
					AttachObjectToVehicle(policecar2, x, 0.0, -1.9, 0.3, 270.0, 0.0, 0.0); // stanga dreapta || fata spate || sus jos || roteste (gen 90 grade) ||
				    AttachObjectToVehicle(lspdcar2, x, 0.0, 0.1661, 0.6957, 0.0000, 0.0000, 0.0000);
				}
			}
			else if(ServerVehicles[x][vModel] == 560 && ServerVehicles[x][vFaction]==13)
			{
				    new taxicab = CreateObject(19308, 0.00000, 0.00000, 0.00000,   0.00000, 0.00000, 0.00000);
				    AttachObjectToVehicle(taxicab, x, 0.0, -0.200, 0.9700, 0.0000, 0.0000, 0.0000);
			}
			else if(ServerVehicles[x][vModel] == 409 && ServerVehicles[x][vFaction]==13)
			{
				    new taxicab = CreateObject(19308, 0.00000, 0.00000, 0.00000,   0.00000, 0.00000, 0.00000);
				    AttachObjectToVehicle(taxicab, x, 0.0, -0.200, 0.9700, 0.0000, 0.0000, 0.0000);
			}
			else if(ServerVehicles[x][vModel] == 541 && ServerVehicles[x][vFaction]==13)
			{
				    new taxicab = CreateObject(19308, 0.00000, 0.00000, 0.00000,   0.00000, 0.00000, 0.00000);
				    AttachObjectToVehicle(taxicab, x, 0.0, -0.200, 0.7050, 0.0000, 0.0000, 0.0000);
			}
		}

		
	}
	printf("[MySQL Vehicles]: %d server vehicles loaded.", servervehs);
    cache_delete(db);
	return 1;
}
function UpdateHouseMoney()
{
	new string[256];
	for(new i=1 ; i <= HouseNumber; i++)
	{
		mysql_format(handle, string, sizeof(string), "UPDATE `house` SET `Money`='%s' WHERE `ID`='%d'",svHouse[i][hMoney],i);
   		mysql_query(handle,string);
	}
	return 1;
}
function PayDay()
{
    foreach(new i : Player)
		{
			if(IsPlayerConnected(i))
			{
				PlayerInfo[i][pOnlineSeconds] = 0;
				PlayerInfo[i][pXp]++;
				GivePlayerMoney(i,20000);
				PlayerInfo[i][pMoney]+=20000;
				SendClientMessage(i,COLOR_GREY,"Ai primit un XP si bani.");
				new str[256];
				new wakaname[25];
				GetPlayerName(i,wakaname,25);
				mysql_format(handle, str, sizeof(str), "UPDATE `users` SET `Xp`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[i][pXp], wakaname);
				mysql_query(handle,str);
				if(PlayerInfo[i][pHouseID] != 0)
				{
					if(PlayerInfo[i][pTypeHome] == 2)
					{
						svHouse[PlayerInfo[i][pHouseID]][hMoney]+=svHouse[PlayerInfo[i][pHouseID]][hRentPrice];
						///trebuie sa scad din payday banii de chirie.
					}
					/// electricity bill
				}
				SetTimer("UpdateHouseMoney", 300000, false);
			}
		}
}
function CheckColor(playerid)
{
	if(PlayerInfo[playerid][pFaction]==0)
	{
	    SetPlayerColor(playerid,0xFFFFFFAA);
	}
	else if(PlayerInfo[playerid][pFaction]==1)
	{
	    SetPlayerColor(playerid,0x3333ffff);
	}
	else if(PlayerInfo[playerid][pFaction]==2)
	{
	    SetPlayerColor(playerid,0x0000cccc);
	}
	else if(PlayerInfo[playerid][pFaction]==3)
	{
	    SetPlayerColor(playerid,0x00006666);
	}
	else if(PlayerInfo[playerid][pFaction]==4)
	{
	    SetPlayerColor(playerid,COLOR_GROVE);
	}
	else  if(PlayerInfo[playerid][pFaction]==5)
	{
	    SetPlayerColor(playerid,COLOR_LSV);
	}
	else if(PlayerInfo[playerid][pFaction]==6)
	{
	    SetPlayerColor(playerid,COLOR_TT);
	}
	else if(PlayerInfo[playerid][pFaction]==7)
	{
	    SetPlayerColor(playerid,COLOR_BALLAS);
	}
	else if(PlayerInfo[playerid][pFaction]==8)
	{
	    SetPlayerColor(playerid,COLOR_VLA);
	}
	else if(PlayerInfo[playerid][pFaction]==9)
	{
	    SetPlayerColor(playerid,COLOR_TM);
	}
	else if(PlayerInfo[playerid][pFaction]==10)
	{
	    SetPlayerColor(playerid,0xff666666);
	}
	else if(PlayerInfo[playerid][pFaction]==11)
	{
	    SetPlayerColor(playerid, 0x94939300);
	}
	else if(PlayerInfo[playerid][pFaction]==12)
	{
	    SetPlayerColor(playerid,0xff99cccc);
	}
	else if(PlayerInfo[playerid][pFaction]==13)
	{
	    SetPlayerColor(playerid,0xE8D01FFF);
	}
	else if(PlayerInfo[playerid][pFaction]==14)
	{
	    SetPlayerColor(playerid,0xcc99ffff);
	}
	return 1;
}
function CheckWanted(id)
{
	new count=0;
    new Float:X,Float:Y,Float:Z;
	GetPlayerPos(id, X,Y,Z);
 	foreach(new i : Player)
	{
	    if(PlayerInfo[i][pFaction]>=1&&PlayerInfo[i][pFaction]<=3)
	    {
	        if(IsPlayerInRangeOfPoint(i, 50.0, X, Y, Z))
				count++;
	    }
	}
	if(count==0)
	{
		PlayerInfo[id][pWantedMinute]--;
		UpdatePlayerWantedLevel( id, PlayerInfo[id][pWantedMinute] + 1, PlayerInfo[id][pWantedMinute]);
		if(PlayerInfo[id][pWantedMinute]==0)
		{
		    PlayerInfo[id][pWanted]--;

		    if(PlayerInfo[id][pClub] != 0)
		    {
		    	if(PlayerInfo[id][pClub] == 1)
		    	{
		    		if(IsPlayerInAnyVehicle(id) && GetVehicleModel( GetPlayerVehicleID(id) ) == 411)
		    		{
		    			PlayerInfo[id][pBounty]++;
		    			if(PlayerInfo[id][pBounty] == 5)
		    			{
		    				PlayerInfo[id][pBounty] = 0;
		    				PlayerInfo[id][pBP] += 100;
		    				SCM(id, COLOR_LGREEN, "Ai primit 100 BP.");
		    				Update(id, pBP);
		    			}
		    		}
		    		
		    	}
		    	else if(PlayerInfo[id][pClub] == 2)
		    	{
		    		if(IsPlayerInAnyVehicle(id))
		    		{
		    			new model = GetVehicleModel(GetPlayerVehicleID(id));
		    			if(model == 560 ) /// aici mai pic masini de la nfs club
		    			{
		    				PlayerInfo[id][pBP] += 10;
		    				Update(id, pBP);
		    			}
		    		}
		    	}
		    }
		    if(PlayerInfo[id][pWanted]!=0)
		    {
				PlayerInfo[id][pWantedMinute]=5;
			}
	        SetPlayerWantedLevel(id, PlayerInfo[id][pWanted]);
		}
		if(PlayerInfo[id][pWantedMinute] >= 1)
			    {
					new str1[500];
					format(str1, sizeof(str1),"WANTED SCADE IN: %d MINUTE", PlayerInfo[id][pWantedMinute]);
					PlayerTextDrawSetString(id, wantedscade[id], str1);
					PlayerTextDrawShow(id, wantedscade[id]);
				}
		else PlayerTextDrawHide(id,  wantedscade[id]);
	}
}
public UpdateLicenses()
{
    foreach(new i : Player)
    {
        if(IsPlayerConnected(i) )
        {
			if(PlayerInfo[i][pCarLic] > 0)
			{
			   PlayerInfo[i][pCarLic]--;
               if(PlayerInfo[i][pCarLic] == 0) SCM(i,COLOR_RED1,"Ai primit permisul de conducere.");
			}
			if(PlayerInfo[i][pWeaponLic] > 0)
			{
			    PlayerInfo[i][pWeaponLic]--;
			    if(PlayerInfo[i][pWeaponLic] == 60) SCM(i,COLOR_RED1,"Intr-o ora iti expira licenta de arme.");
			    if(PlayerInfo[i][pWeaponLic] == 0) SCM(i,COLOR_RED1,"Ti-a expirat licenta de arme.");
			}
			if(PlayerInfo[i][pBoatLic] > 0)
			{
			    PlayerInfo[i][pBoatLic]--;
			    if(PlayerInfo[i][pBoatLic] == 60) SCM(i,COLOR_RED1,"Intr-o ora iti expira licenta de navigatie.");
			    if(PlayerInfo[i][pBoatLic] == 0) SCM(i,COLOR_RED1,"Ti-a expirat licenta de navigatie.");
			}
			if(PlayerInfo[i][pFlyLic] > 0)
			{
			    PlayerInfo[i][pFlyLic]--;
			    if(PlayerInfo[i][pFlyLic] == 60) SCM(i,COLOR_RED1,"Intr-o ora iti expira licenta de zbor.");
			    if(PlayerInfo[i][pFlyLic] == 0) SCM(i,COLOR_RED1,"Ti-a expirat licenta de zbor.");
			}
		}
    }
	return 1;
}
public EndWarFunctions()
{
	WarStatus = 0;
	if(WarAlianceKills1 > WarAlianceKills2)
		lWarWinnerID = 1;
	else if(WarAlianceKills1 < WarAlianceKills2)
		lWarWinnerID = 2;
	else lWarWinnerID = 3;
	lWarScore1 = WarAlianceKills1;
	lWarScore2 = WarAlianceKills2;
	new query[256];
	format(query, sizeof(query), "UPDATE `warhistory` SET `winnerid`= '%d', `score1` = '%d', `score2` = '%d', `bestkiller` = '%s' WHERE `ID`='%d'", lWarWinnerID, lWarScore1, lWarScore2, lWarBestKiller, lWarID);
	mysql_query(handle, query);

	SendClientMessageToAll(COLOR_RED, "WAR FINISHED");
	if(lWarWinnerID == 1) SendClientMessageToAll(COLOR_RED, "WINNER: GROVE - LSV - The Triads");
	else if(lWarWinnerID == 2) SendClientMessageToAll(COLOR_RED, "WINNER: BALLAS - VLA - TM");
	else SendClientMessageToAll(COLOR_RED, "WINNER: Egalitate");

	for(new carid = 0; carid <= 2000; carid++)
		if(WarCars[carid][1] != 0)
		{
			DestroyVehicle(carid);
			WarCars[carid][1] = 0;
		}
	for(new i = 0; i <= MAX_PLAYERS; i++)
    	if(IsPlayerConnected(i))
 			if(PlayerInfo[i][pFaction] >= 4 && PlayerInfo[i][pFaction] <= 9)
 			{
 				Update(i, pWKills);
				Update(i, pWDeaths);
				Update(i, pLWarID);
 				StopWarTXD(i);
 				GangZoneHideForPlayer(i, WarZone);
 				Slap(i);
    			SpawnPlayer(i);
    			///aici pun sa dea drugs and stuff
 			}
 	GangZoneDestroy(WarZone);
	return 1;
}
public UpdateTime()
{
    new
        day,
        year,
        month,
        hours,
        minute,
        sec,
        string[128]
    ;
    getdate(year, month, day);
    format(string, sizeof(string), "%02d.%02d.%04d", day, month, year);
    TextDrawSetString(Clock[0], string);
    gettime(hours, minute, sec);
    if(WarStatus == 1 && WarEndH == hours && WarEndM == minute) EndWarFunctions();
    format(string, sizeof(string), "%02d:%02d", hours, minute);
    TextDrawSetString(Clock[1], string);
    foreach(new i : Player)
    {
        TextDrawHideForPlayer(i, Clock[0]);
        TextDrawHideForPlayer(i, Clock[1]);
        TextDrawShowForPlayer(i, Clock[0]);
        TextDrawShowForPlayer(i, Clock[1]);

    }
    if(minute == 0 && PD==0)
    {
		PayDay();
		PD=1;
    }
    if(hours!= lasthour)
    {
    	lasthour=hours;
    	if(hours == 18 || hours == 10 || hours == 0)
    	{
    		if(CurrentMission == NrMissions) CurrentMission  = 0;
    		CurrentMission++;
    		foreach(new i : Player)
    		{
    			PlayerInfo[i][pLastMission] = 0;
    		}
    		format(string,sizeof(string),"{009900} ACTUAL MISSION : {ffffff} %s",Missions[CurrentMission][Title]);
			SendClientMessageToAll(COLOR_WHITE, string); 
			format(string,sizeof(string),"{009900} Description: {ffffff} %s {009900} | Difficulty: {ffffff}%s {009900}| Reward: {ffffff}%d",Missions[CurrentMission][Description],Missions[CurrentMission][Difficulty],Missions[CurrentMission][Reward]);
			SendClientMessageToAll(COLOR_WHITE, string);
			SendClientMessageToAll(COLOR_WHITE, "{009900}O misiune noua la in fiecare zi la ora 10:00 | 18:00 | 00:00");

    	}
    }
    if(minute == 1)
	{
	    PD=0;
	}
 	if(lastminute!=minute)
	{
		foreach(new i : Player)
		{
			if(PlayerInfo[i][pWanted]!=0)
			    CheckWanted(i);
		}
		lastminute=minute;
	}
	foreach(new i : Player)
	{
	    if(FillCar[i]==1)
	    {
	        FillCar[i]=0;
   			new carid=GetPlayerVehicleID(i);
			new price;
			new actualfuel = floatround(fuel[carid], floatround_round);
			price=(100-actualfuel)*10;
			fuel[carid]=100;
			format(string,sizeof(string),"Ai platit %d $ pentru benzina.",price);
			SCM(i,COLOR_BLUE,string);
			TogglePlayerControllable(i,1);
			
	    }
	}
    return 1;
}
CMD:unrentcar(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(PRentCarID[playerid] == 0) return SCM(playerid, COLOR_GREY, "Nu ai o masina inchiriata.");
		DestroyVehicle(PRentCarID[playerid]);
		RentCarTimer[PRentCarID[playerid]] = 0;
		RentCarPID[PRentCarID[playerid]] = -1;
		PRentCarID[playerid] = 0;
		SCM(playerid, COLOR_GREY, "Masina de la rent s-a despawnat.");
	}
	return 1;
}
CMD:rentcar(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(GetPlayerVirtualWorld(playerid) != 0) return SCM(playerid, COLOR_GREY, "Esti in Virtual World.");
		if(PRentCarID[playerid] != 0) return SCM(playerid, COLOR_GREY, "Ai deja o masina inchiriata. Foloseste /unrentcar.");
		if(IsPlayerInAnyVehicle(playerid) == 1) return SCM(playerid, COLOR_GREY, "Iesi din masina.");
		for(new i = 1; i <= nrBiz; i++)
			if(BizInfo[i][Type] == 2)
				if(IsPlayerInRangeOfPoint(playerid, 4, BizInfo[i][bX], BizInfo[i][bY], BizInfo[i][bZ]))
				{
					new string[256];
					format(string, sizeof(string), "Sultan\t%d$ \nBuffalo\t%d$ \nBanshee\t%d$ \nJester\t%d$ \nElegy\t%d$ \nFlash\t%d$ \nCheetah\t%d$",BizInfo[i][Fee], BizInfo[i][Fee], BizInfo[i][Fee], BizInfo[i][Fee], BizInfo[i][Fee], BizInfo[i][Fee], BizInfo[i][Fee]);
					ShowPlayerDialog(playerid, DIALOG_RENTCAR, DIALOG_STYLE_TABLIST, "Select car:", string, "Select", "Cancel");
					return 1;
				}
	}
	return 1;
}
CMD:stopwar(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 4) return SCM(playerid, COLOR_GREY, "Nu ai acces la aceasta comanda!");
	if(WarStatus == 1) 
	{
		EndWarFunctions();
		new string[256];
		format(string, sizeof(string), "Adminul %s a oprit WARUL.");
		SendClientMessageToAll(COLOR_RED, string);
	}
	else return SCM(playerid, COLOR_GREY, "War-ul nu este activ");
	return 1;
}
CMD:warstats(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(lWarID == 0) return SCM(playerid, COLOR_GREY, "ERROR: War-ul a fost resetat."); 
		if(WarStatus == 1) return SCM(playerid, COLOR_GREY, "ERROR: WAR-UL ESTE DEJA IN DESFASURARE");
		new string[512], line1[256], line2[256], line3[256], line4[256];
		if(lWarWinnerID == 1 ) format(line1, sizeof(line1), "{B5B5B5}WINNER ALIANCE: {0CB217}GROVE {D9EB6A}LSV {7A5010}The Triads");
		else if(lWarWinnerID == 2) format(line1, sizeof(line1), "{B5B5B5}WINNER ALIANCE: {DD3BFD}BALLAS {3BF7FD}VLA {FF0000}The Mafia");
			else format(line1, sizeof(line1), "{B5B5B5}WINNER ALIANCE : {F6FFB3}EGALITATE");
		format(line2, sizeof(line2), "{0CB217}GROVE {D9EB6A}LSV {7A5010}The Triads {B5B5B5}Kills : {22FF00}%d {B5B5B5}kills", lWarScore1);
		format(line3, sizeof(line3), "{DD3BFD}BALLAS {3BF7FD}VLA {FF0000}The Mafia {B5B5B5}Kills : {22FF00}%d {B5B5B5}kills", lWarScore2);
		format(line4, sizeof(line4), "{A2FF00}Best Killer : {FF2200}%s", lWarBestKiller);
		format(string, sizeof(string), "%s\n%s\n%s\n%s\n%s\n{0CB217}Zona : {3BF7FD}%s", line1, line2, line3, line4, lWarTime, WarInfo[lWarZID][Name]);
		ShowPlayerDialog(playerid, DIALOG_WARSTATS, DIALOG_STYLE_MSGBOX, "WarStats", string , "OK", "");
	}
	return 1;
}
CMD:wantedcp(playerid, params[])
{
	SCM(playerid,COLOR_WHITE, GetName(CP[playerid][Player]) );
	return 1;
}
public CheckCP()
{
	foreach(new i : Player)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(CP[i][ID]>0)
	        {
	            if(CP[i][ID]==1) // COP WANTED FIND
	            {
	                if(IsPlayerConnected(CP[i][Player]) )
	                {
	                    if(PlayerInfo[CP[i][Player]][pJailTime]==0 && PlayerInfo[CP[i][Player]][pWanted]>0)
	                    {
	                        new Float:x;
	                        new Float:y;
	                        new Float:z;
							DisablePlayerCheckpoint(i);
	                        GetPlayerPos(CP[i][Player],x,y,z);
	                        SetPlayerCheckpoint(i,x,y,z,3);
	                    }
	                    else
						{
							SendClientMessage(i,COLOR_BLUE,"Suspectul a intrat in jail sau a scapat de wanted.");
							DisablePlayerCheckpoint(i);
							CP[i][ID]=0;
							CP[i][ID]=-1;
						}
	                }
	                
	            }
	            if(CP[i][ID] == 6) // HITMAN
	            {
	                if(IsPlayerConnected(CP[i][Player]) )
	                {
	                    if(PlayerInfo[i][pHasContract] == CP[i][Player] && PlayerInfo[i][pFaction] == 11)
	                    {
	                        new Float:x;
	                        new Float:y;
	                        new Float:z;
							DisablePlayerCheckpoint(i);
	                        GetPlayerPos(CP[i][Player],x,y,z);
	                        SetPlayerCheckpoint(i,x,y,z,3);
	                    }
	                    else
	                    {
	                    	DisablePlayerCheckpoint(i);
							CP[i][ID]=0;
							CP[i][ID]=-1;
	                    }
	                }
	                
	            }
	            ///aici punem find-ul pentru hitman
	        }
	    }
	}
	return 1;
}
public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

/*

[ function ]

*/
function DatabaseConnect()
{
    handle = mysql_connect(SQL_HOST, SQL_USER, SQL_PASSWORD, SQL_DATABASE);
	if(mysql_errno() == 0)
	{
	    printf("Baza de date a fost conectata corect.", SQL_DATABASE);
	    printf("\n");
	}
	else
	{
   		printf("(!) Atentie: Baza de date nu a fost conectata corect!");
	}
    return 1;
}

function IsRegistered(playerid)
{
    new rows;
    cache_get_row_count(rows);
    if(!rows)
    {
        //InitRegister(playerid);
 	 	IntroMovie(playerid);
        format(gString, sizeof(gString), "Contul nu este inregistrat.\nIntrodu o parola mai jos pentru a putea continua.", GetName(playerid));
        ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, " ", gString, "Submit", "Leave");
    }
    else
    {
        IntroMovie(playerid);
        format(gString, sizeof(gString), "Contul este inregistrat.\nIntrodu parola ta mai jos pentru a putea continua.", GetName(playerid));
    	ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, " ", gString, "Submit", "Leave");
    }
    return 1;
}
function NumeFactiune(playerid)
{
	new temporar[200],r[50];
	cache_get_value_name(0,"Name",temporar) , format(PlayerInfo[playerid][pFacName],60,temporar);
	format(r,sizeof(r),"Rank%d", PlayerInfo[playerid][pRFaction]);
	cache_get_value_name(0,r,temporar) , format(PlayerInfo[playerid][pFacRank],60,temporar);
	return 1;
}
function NumeClub(playerid)
{
	new temporar[200],r[50];
	cache_get_value_name(0,"Name",temporar) , format(PlayerInfo[playerid][pClubName],60,temporar);
	format(r,sizeof(r),"Rank%d", PlayerInfo[playerid][pRClub]);
	cache_get_value_name(0,r,temporar) , format(PlayerInfo[playerid][pClubRank],60,temporar);
	return 1;
}
function WhenPlayerLogin(playerid)
{
    new rows, temporar[200];
    cache_get_row_count(rows);
    if(!rows)
    {
    	format(gString, sizeof(gString), "Parola este incorecta.\nDaca ti-ai uitat parola, accesteaza www.sa-mp.ro/panel\n\nMai ai doar %d incercari.", 5 - Tentative[playerid] - 1);
    	ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, " ", gString, "Submit", "Leave");

		Tentative[playerid] += 1;
		if(Tentative[playerid] > 5)
		{
			Kick(playerid);
			return 1;
		}
    }
    else
    {
    	cache_get_value_name(0, "Password",temporar), format(PlayerInfo[playerid][pPassword], 25, temporar); //
        cache_get_value_name_int(0, "ID", PlayerInfo[playerid][pID]); // 
        cache_get_value_name(0, "IP",temporar), format(PlayerInfo[playerid][pIP], 25, temporar); //
        cache_get_value_name(0, "Email",temporar), format(PlayerInfo[playerid][pEmail], 25, temporar); //
        cache_get_value_name_int(0, "Gender", PlayerInfo[playerid][pGender]); //
        cache_get_value_name_int(0, "Age", PlayerInfo[playerid][pAge]); //
        cache_get_value_name(0, "Refferal", PlayerInfo[playerid][pRefferal]); //
        cache_get_value_name_int(0, "RegisterStep", PlayerInfo[playerid][pRegisterStep]); //
        cache_get_value_name_int(0, "Admin", PlayerInfo[playerid][pAdmin]); //
        cache_get_value_name_int(0, "Helper", PlayerInfo[playerid][pHelper]); //
        cache_get_value_name_int(0, "Faction", PlayerInfo[playerid][pFaction]);//
        cache_get_value_name_int(0, "Club", PlayerInfo[playerid][pClub]); //
        cache_get_value_name_int(0, "RClub", PlayerInfo[playerid][pRClub]); //
        cache_get_value_name_int(0, "RFaction", PlayerInfo[playerid][pRFaction]); //
        cache_get_value_name_int(0, "Xp", PlayerInfo[playerid][pXp]); //
        cache_get_value_name_int(0, "Lvl", PlayerInfo[playerid][pLvl]); //
        cache_get_value_name_int(0, "Money", PlayerInfo[playerid][pMoney]); //
        cache_get_value_name_int(0, "Skin", PlayerInfo[playerid][pSkin]); //
        cache_get_value_name_int(0, "Mute", Mute[playerid]); //
        cache_get_value_name_int(0, "Wanted", PlayerInfo[playerid][pWanted]); //
        cache_get_value_name_int(0, "JailTime", PlayerInfo[playerid][pJailTime]); //
        cache_get_value_name_int(0, "Assists", PlayerInfo[playerid][pAssists]); //
        cache_get_value_name_int(0, "Kills", PlayerInfo[playerid][pKills]);  //
        cache_get_value_name_int(0, "Tickets", PlayerInfo[playerid][pTickets]); //
        cache_get_value_name_int(0, "Arrests", PlayerInfo[playerid][pArrests]); 
        cache_get_value_name_int(0, "FW", PlayerInfo[playerid][pFW]);
        cache_get_value_name_int(0, "FMute", FMute[playerid]);
        cache_get_value_name(0, "WantedReason",temporar), format(PlayerInfo[playerid][pWantedReason], 25, temporar);
        cache_get_value_name_int(0, "Pills", PlayerInfo[playerid][pPills]);
        cache_get_value_name_int(0, "PillsSold", PlayerInfo[playerid][pPillsSold]);
        cache_get_value_name_int(0, "HealP", PlayerInfo[playerid][pHealP]);
        cache_get_value_name_int(0, "CarLic", PlayerInfo[playerid][pCarLic]);
        cache_get_value_name_int(0, "WeaponLic", PlayerInfo[playerid][pWeaponLic]);
        cache_get_value_name_int(0, "BoatLic", PlayerInfo[playerid][pBoatLic]);
        cache_get_value_name_int(0, "FlyLic", PlayerInfo[playerid][pFlyLic]);
        cache_get_value_name_int(0, "MissionF", PlayerInfo[playerid][pMissionF]);
        cache_get_value_name_int(0, "LastMission", PlayerInfo[playerid][pLastMission]);
        cache_get_value_name_int(0, "LastOnlineYear", PlayerInfo[playerid][pLastOnlineYear]);
        cache_get_value_name_int(0, "LastOnlineMonth", PlayerInfo[playerid][pLastOnlineMonth]);
        cache_get_value_name_int(0, "LastOnlineDay", PlayerInfo[playerid][pLastOnlineDay]);
        cache_get_value_name_int(0, "LastOnlineHour", PlayerInfo[playerid][pLastOnlineHour]);
        cache_get_value_name_int(0, "LastOnlineMinute", PlayerInfo[playerid][pLastOnlineMinute]);
        cache_get_value_name_int(0, "HouseID", PlayerInfo[playerid][pHouseID]);
        cache_get_value_name_int(0, "TypeHome", PlayerInfo[playerid][pTypeHome]);
        cache_get_value_name_int(0, "SpawnType", PlayerInfo[playerid][pSpawnType]);
        cache_get_value_name_int(0, "CMute", CMute[playerid]);
        cache_get_value_name_int(0, "BP", PlayerInfo[playerid][pBP]);
        cache_get_value_name_int(0, "WKills", PlayerInfo[playerid][pWKills]);
        cache_get_value_name_int(0, "WDeaths", PlayerInfo[playerid][pWDeaths]);
        cache_get_value_name_int(0, "LWarID", PlayerInfo[playerid][pLWarID]);
        cache_get_value_name_int(0, "MaxCars", PlayerInfo[playerid][pMaxCars]);
        cache_get_value_name_int(0, "Drugs", PlayerInfo[playerid][pDrugs]);
        cache_get_value_name_int(0, "SeifDrugs", PlayerInfo[playerid][pSeifDrugs]);
        cache_get_value_name_int(0, "Mats", PlayerInfo[playerid][pMats]);
        cache_get_value_name_int(0, "SeifMats", PlayerInfo[playerid][pSeifMats]);
        cache_get_value_name_int(0, "DrugsSkill", PlayerInfo[playerid][pDrugsSkill]);
        cache_get_value_name_int(0, "Job", PlayerInfo[playerid][pJob]);
        cache_get_value_name_int(0, "BizID", PlayerInfo[playerid][pBizID]);
        cache_get_value_name_int(0, "TaxiRaport", PlayerInfo[playerid][pTaxiRaport]);
        cache_get_value_name_int(0, "NrRaport", PlayerInfo[playerid][pNrRaport]);
        cache_get_value_name_int(0, "DoneContracts", PlayerInfo[playerid][pDoneContracts]);
        cache_get_value_name_int(0, "CancelContracts", PlayerInfo[playerid][pCancelContracts]);
        cache_get_value_name_int(0, "FailContracts", PlayerInfo[playerid][pFailContracts]);
        cache_get_value_name_int(0, "PremiumPoints", PlayerInfo[playerid][pPremiumPoints]);
        cache_get_value_name_int(0, "VIP", PlayerInfo[playerid][pVIP]);
        cache_get_value_name_int(0, "NewBieMute", NewBieMute[playerid]);
        PlayerInfo[playerid][pOnlineSeconds] = 0;
        cache_get_value_name_int(0, "OnlineSeconds", PlayerInfo[playerid][pOnlineSeconds]);
        cache_get_value_name_int(0, "PSeconds", PlayerInfo[playerid][pPSeconds]);
        LoadPersonalCars(playerid);

        if(PlayerInfo[playerid][pRegisterStep] == 0)
            return ShowPlayerDialog(playerid, DIALOG_EMAIL, DIALOG_STYLE_INPUT, "Email:", "Introdu adresa ta de email mai jos.\nAceasta este necesara pentru securitatea contului.\n", "Ok", "");

    	if(PlayerInfo[playerid][pRegisterStep] == 1)
            return ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_MSGBOX, "Genul:", "Alege-ti genul mai jos:", "Baiat", "Fata");

    	if(PlayerInfo[playerid][pRegisterStep] == 2)
            return ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Varsta:", "Introdu varsta ta in chenarul de mai jos:", "Ok", "");

    	if(PlayerInfo[playerid][pRegisterStep] == 3)
            return ShowPlayerDialog(playerid, DIALOG_REFFERAL2, DIALOG_STYLE_INPUT, "Refferal:", "Cine te-a adus pe server?\n\nScrie numele complet in chenarul de mai jos.", "Ok", "Back");
		GivePlayerMoney(playerid,PlayerInfo[playerid][pMoney]);
        SpawnPlayer(playerid);
        if(PlayerInfo[playerid][pAdmin] >= 1)
			SendClientMessage(playerid,0xF2BC46FF,"Te-ai conectat ca admin.");
		if(PlayerInfo[playerid][pHelper] >=1)
		    SendClientMessage(playerid,0xF2BC46FF,"Te-ai conectat ca helper.");
  		new string[256];
	    new string1[256];
	    GetPlayerIp(playerid, string1, sizeof(string1));
	    format(string,sizeof(string),"Jucatorul %s s-a conectat pe server.| Admin %d | Helper %d | IP : %s",GetName(playerid),PlayerInfo[playerid][pAdmin],PlayerInfo[playerid][pHelper],string1);
	    foreach(new i : Player)
	    {
	        if(IsPlayerConnected(i) )
			{
				if(PlayerInfo[i][pAdmin] > 0 )
				    SCM(i,COLOR_RED1,string);
			}
	    }
  		if(PlayerInfo[playerid][pWanted]>0)
		{
			PlayerInfo[playerid][pWantedMinute]=5;
			SetPlayerWantedLevel(playerid, PlayerInfo[playerid][pWanted]);
			UpdatePlayerWantedLevel( playerid, 0, PlayerInfo[playerid][pWanted] );
			new str1[256];
			format(str1, sizeof(str1),"WANTED SCADE IN: %d MINUTE", PlayerInfo[playerid][pWantedMinute]);
			PlayerTextDrawSetString(playerid, wantedscade[playerid], str1);
			PlayerTextDrawShow(playerid, wantedscade[playerid]);
			SendClientMessage(playerid,COLOR_YELLOW,"Ai primit wanted-ul pe care il aveai.");
		}
		new
	        day,
	        year,
	        month
    	;
    	getdate(year, month, day);
		if(PlayerInfo[playerid][pLastMission]!= CurrentMission)
			PlayerInfo[playerid][pLastMission] = 0;
		else if(PlayerInfo[playerid][pLastOnlineYear] != year)
			PlayerInfo[playerid][pLastMission] = 0;
		else if(PlayerInfo[playerid][pLastOnlineMonth] != month)
			PlayerInfo[playerid][pLastMission] = 0;
		else if(PlayerInfo[playerid][pLastOnlineDay] != day)
			PlayerInfo[playerid][pLastMission] = 0;

    }
    mysql_format(handle, gQuery, sizeof(gQuery), "SELECT * FROM factions WHERE ID = '%d'", PlayerInfo[playerid][pFaction]);
    mysql_tquery(handle, gQuery, "NumeFactiune", "i", playerid);
    if(PlayerInfo[playerid][pClub] != 0)
    {
    	mysql_format(handle, gQuery, sizeof(gQuery), "SELECT * FROM club WHERE ID = '%d'", PlayerInfo[playerid][pClub]);
    	mysql_tquery(handle, gQuery, "NumeClub", "i", playerid);
    }
    if(PlayerInfo[playerid][pLWarID] != lWarID)
    {
    	PlayerInfo[playerid][pLWarID] = lWarID;
    	PlayerInfo[playerid][pWKills] = 0;
    	PlayerInfo[playerid][pWDeaths] = 0;

    }
    new m, s, h, d, y, mo;
	getdate(y, mo, d);
	gettime(h, m, s);
	if(y != PlayerInfo[playerid][pLastOnlineYear] || mo != PlayerInfo[playerid][pLastOnlineMonth] || d != PlayerInfo[playerid][pLastOnlineDay] || h != PlayerInfo[playerid][pLastOnlineHour])
		PlayerInfo[playerid][pOnlineSeconds] = 0;
	PlayerTextDrawShow(playerid, OnlineTXD[playerid]);
    return 1;
}

function Update(playerid, type)
{
	if(IsPlayerConnected(playerid))
	{
		switch(type)
		{
			case pIP:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `IP`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pIP], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pEmail:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `Email`='%s' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pEmail], GetName(playerid));
				mysql_query(handle, gQuery);
			}

			case pGender:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `Gender`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pGender], GetName(playerid));
				mysql_query(handle, gQuery);
			}

			case pAge:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `Age`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pAge], GetName(playerid));
				mysql_query(handle, gQuery);
			}

			case pRefferal:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `Refferal`='%e' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pRefferal], GetName(playerid));
				mysql_query(handle, gQuery);
			}

			case pRegisterStep:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `RegisterStep`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pRegisterStep], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pAdmin:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `Admin`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pAdmin], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pHelper:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `Helper`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pHelper], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pFaction:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `Faction`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pFaction], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pClub:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `Club`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pClub], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pRClub:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `RClub`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pRClub], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pRFaction:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `RFaction`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pRFaction], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pXp:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `Xp`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pXp], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pLvl:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `Lvl`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pLvl], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pMoney:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `Money`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pMoney], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pSkin:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `Skin`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pSkin], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pWanted:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `Wanted`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pWanted], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pTickets:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `Tickets`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pTickets], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pArrests:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `Arrests`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pArrests], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pKills:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `Kills`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pKills], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pAssists:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `Assists`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pAssists], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pFW:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `FW`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pFW], GetName(playerid));
				mysql_query(handle, gQuery);
			}
            case pPills:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `Pills`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pPills], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pPillsSold:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `PillsSold`='%d' WHERE BINARY `Name`= BINARY '%s''", PlayerInfo[playerid][pPillsSold], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pWantedReason:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `WantedReason`='%s' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pWantedReason], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pHealP:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `HealP`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pHealP], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pCarLic:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `CarLic`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pCarLic], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pWeaponLic:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `WeaponLic`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pWeaponLic], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pBoatLic:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `BoatLic`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pBoatLic], GetName(playerid));
				mysql_query(handle, gQuery);
			}
            case pFlyLic:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `FlyLic`='%d' WHERE BINARY `Name`= BINARY '%s''", PlayerInfo[playerid][pFlyLic], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pLicenseSold:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `LicenseSold`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pLicenseSold], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pMissionF:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `MissionF`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pMissionF], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pLastMission:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `LastMission`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pLastMission], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pLastOnlineYear:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `LastOnlineYear`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pLastOnlineYear], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pLastOnlineMonth:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `LastOnlineMonth`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pLastOnlineMonth], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pLastOnlineDay:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `LastOnlineDay`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pLastOnlineDay], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pLastOnlineHour:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `LastOnlineHour`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pLastOnlineHour], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pLastOnlineMinute:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `LastOnlineMinute`='%d' WHERE BINARY `Name`= BINARY '%s''", PlayerInfo[playerid][pLastOnlineMinute], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pHouseID:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `HouseID`='%d' WWHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pHouseID], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pTypeHome:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `TypeHome`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pTypeHome], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pSpawnType:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `SpawnType`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pSpawnType], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pBP:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `BP`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pBP], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pWKills:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `WKills`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pWKills], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pWDeaths:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `WDeaths`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pWDeaths], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pLWarID:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `LWarID`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pLWarID], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pMaxCars:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `MaxCars`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pMaxCars], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pDrugs:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `Drugs`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pDrugs], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pSeifDrugs:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `SeifDrugs`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pSeifDrugs], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pMats:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `Mats`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pMats], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pSeifMats:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `SeifMats`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pSeifMats], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pDrugsSkill:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `DrugsSkill`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pDrugsSkill], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pJob:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `Job`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pJob], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pBizID:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `BizID`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pBizID], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pLawyerSkill:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `LawyerSkill`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pLawyerSkill], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pLawerFree:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `LawerFree`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pLawerFree], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pTaxiRaport:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `TaxiRaport`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pTaxiRaport], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pNrRaport:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `NrRaport`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pNrRaport], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pCancelContracts:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `CancelContracts`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pCancelContracts], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pDoneContracts:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `DoneContracts`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pDoneContracts], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pFailContracts:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `FailContracts`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pFailContracts], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pPremiumPoints:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `PremiumPoints`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pPremiumPoints], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pVIP:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `VIP`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pVIP], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pOnlineSeconds:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `OnlineSeconds`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pOnlineSeconds], GetName(playerid));
				mysql_query(handle, gQuery);
			}
			case pPSeconds:
			{
				mysql_format(handle, gQuery, sizeof(gQuery), "UPDATE `users` SET `PSeconds`='%d' WHERE BINARY `Name`= BINARY '%s'", PlayerInfo[playerid][pPSeconds], GetName(playerid));
				mysql_query(handle, gQuery);
			}
		}
	}
}

// STOCKURI

stock UpdatePlayerWantedLevel( playerid, oldlevel, newlevel ) {
	if ( oldlevel > 6 || newlevel > 6 ) {
		for ( new i = min( oldlevel, newlevel ), j = max( oldlevel, newlevel ); i < j; i++ ) {
			if ( i < 0 || i > sizeof( g_aStarTextDraws ) ) continue;

			if ( i >= 6 ) {
				if ( i < newlevel ) {
					TextDrawShowForPlayer( playerid, g_aStarTextDraws[ i - 6 ] );

					#if NUM_INACTIVE_STARS > 6

					if ( i < NUM_INACTIVE_STARS )
						TextDrawHideForPlayer( playerid, g_aInactiveStarTextDraws[ i - 6 ] );

					#endif
				} else {
					TextDrawHideForPlayer( playerid, g_aStarTextDraws[ i - 6 ] );

					#if NUM_INACTIVE_STARS > 6

					if ( i < NUM_INACTIVE_STARS )
						TextDrawShowForPlayer( playerid, g_aInactiveStarTextDraws[ i - 6 ] );

					#endif
				}
			}
		}
	}

	#if NUM_INACTIVE_STARS > 6

	if ( oldlevel == 0 ) {
		for ( new i = 0; i < NUM_INACTIVE_STARS - 6; i++ ) {
			if ( i >= newlevel - 6 )
				TextDrawShowForPlayer( playerid, g_aInactiveStarTextDraws[ i ] );
		}
	}
	else if ( newlevel == 0 ) {
		for ( new i = 0; i < NUM_INACTIVE_STARS - 6; i++ )
			TextDrawHideForPlayer( playerid, g_aInactiveStarTextDraws[ i ] );
	}

	#endif
}

stock GetName(playerid)
{
	new pName[MAX_PLAYER_NAME];

	GetPlayerName(playerid, pName, sizeof(pName));
	return pName;
}

stock IntroMovie(playerid)
{
	InterpolateCameraPos(playerid, -1.9223,-1240.7756,117.9103, 1142.4589,-717.8170,139.2966, 20000, CAMERA_MOVE);
	InterpolateCameraLookAt(playerid, 186.6470,-1261.1404,78.2794,1280.0114,-640.1159,106.2128, 20000, CAMERA_MOVE);
}
stock ConvertTime(time)
{
	new string[68];
	new values[6];
    TimestampToDate(time, values[0], values[1], values[2], values[3], values[4], values[5], 3, 0);
    format(string, sizeof(string), "%i.%i.%i %i:%i:%i", values[0], values[1], values[2], values[3], values[4], values[5]);
    return string;
}