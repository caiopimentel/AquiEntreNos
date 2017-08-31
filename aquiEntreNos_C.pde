///////////////////Aqui entre nos
////////Projeto de design de interação realizado para matéria de DPPVIII na ESDI
////////Desenvolvido por Caio Pimentel e Taís Fernandes
////////Grupo: Arthur Bandoli, Caio Pimentel, Letícia Martha, Taís Fernandes
////////Turma 50


import SimpleOpenNI.*;

SimpleOpenNI context;
DataDigest dataCenter;
MotionDetection motionCenter;
AnimationToolSet screenMaster0, screenMaster1, screenMaster2;

void setup()
{
  size (1280, 720);
  background (colorBg);

  dataCenter = new DataDigest(); //Objeto responsavel pelo data handling
  motionCenter = new MotionDetection(4); //Objeto responsavel por retornar o estado do movimento das pessoas capturadas pelo kinect

  screenMaster0 = new AnimationToolSet();
  screenMaster1 = new AnimationToolSet();
  screenMaster2 = new AnimationToolSet();

  screenMaster0.setOpacity(0, 255);
  screenMaster1.setOpacity(0, 255);
  screenMaster2.setOpacity(0, 255);

  logo = loadImage ("logo.png");
  conhecidosIcon = loadImage ("conhecidos.png");
  desconhecidosIcon = loadImage ("desconhecidos.png");
  proximosIcon = loadImage ("proximos.png");
  bodyMoving = loadImage ("bodyMoving.png");
  experimenteLogo = loadImage ("experimente.png");
  bodyLeft = loadImage ("bodyLeft.png");
  bodyRight = loadImage ("bodyRight.png");

  context = new SimpleOpenNI(this);
  runKinectSetup ();

  fontRegular = createFont ("Oswald-Regular.ttf", 30);
  fontBold = createFont ("Oswald-DemiBold.ttf", 30);

  dataCenter.loadData("tabela_distancias.csv"); // Carrega dados da tabela
}


void draw()
{
  background (colorBg);
  runKinectFundation ();
  calculateDistance ();
  displayScreen (motionCenter.getMotionState(distanceCentimeters));
}

