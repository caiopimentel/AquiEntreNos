int MAX_USERS = 10; //com apenas 2 context buga quando capta 3 pessoas e o programa dá crash
int x = 0;

// the data from openni comes upside down
float distanceDepth;  // distancia entre pessoas em raw depth
float distanceCentimeters;

int[] depthMap;
int[] userMap;
PVector realWorldPoint;

//relativas ao layout
color colorBg =  color (37, 64, 143);
PFont fontRegular, fontBold;
PImage bodyMoving, bodyLeft, bodyRight, logo, experimenteLogo;
PImage conhecidosIcon, desconhecidosIcon, proximosIcon, contextIcon;

String paisProx = "";
String paisCon = "";
String paisDesc = "";

//linha da distancia entre os dois bonecos
float positionBeginLine, positionEndLine;

float positionUserOneIcon;
float positionUserTwoIcon; 

int positionIconsY = 450;

//relativas às funções do OpenNi
boolean      autoCalib=true;

PVector[]    allDataBody = new PVector[MAX_USERS]; // informações do usuário 
PVector[]    cmDataBody = new PVector[MAX_USERS]; // centro de massa do usuário
PVector      bodyCenter = new PVector();
PVector      bodyDir = new PVector();
PVector      com = new PVector();
PVector      com2d = new PVector();

