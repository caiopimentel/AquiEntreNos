void displayScreen (int motionState_) {
  int positionTextY = 125;
  int positionTextX = 150;
  int textSizeCountries = 30;
  int textSizeNiveis = 26;
  int circleIconSize = 75;
  color colorText = color (255);

  if (motionCenter.isMoving() != motionCenter.previousIsMoving()) { 
    // Se a deteccao de movimento atual for diferente da anterior sortear novamente paises para distancia amostrada
    paisProx = dataCenter.getCountry(distanceCentimeters, 1);
    paisCon = dataCenter.getCountry(distanceCentimeters, 2);
    paisDesc = dataCenter.getCountry(distanceCentimeters, 3);
  }

  switch (motionState_) {
  case 0: // tela inicial
    screenMaster0.animateOpacity(8, false); // fading in
    float [] masterColor0 = {255, screenMaster0.getOpacity()};
    
    screenMaster1.animateOpacity(1.5, true); // fading out
    screenMaster2.animateOpacity(1.5, true); // fading out
  
    fill (masterColor0[0],masterColor0[1]);
    textFont (fontRegular);
    textSize (27);
    textAlign (LEFT);
    text ("QUAL DISTÂNCIA TE DEIXA MAIS CONFORTÁVEL? ", width/2 - 100, 570);
    textSize (23);
    text ("descubra qual país mais se adequa ao seu espaço pessoal ", width/2 - 100, 600);

    imageMode (CENTER);
    logo.resize (width/3 + 30, 0);
    tint (masterColor0[0],masterColor0[1]);
    image (logo, width/2, height/2 - textSizeCountries);
    break;

  case 1: //tela interativa
    screenMaster1.animateOpacity(8, false);
    float [] masterColor1 = {255, screenMaster1.getOpacity()};
    
    screenMaster0.animateOpacity(1.5, true); // fading out
    screenMaster2.animateOpacity(1.5, true); // fading out
    
    tint (masterColor1[0], masterColor1[1]);
    fill (masterColor1[0], masterColor1[1]); // added
    
    float positionUserOneIcon = width/2 - (mapValuesDistUserToPixels (distanceCentimeters));
    float positionUserTwoIcon = width/2 + (mapValuesDistUserToPixels (distanceCentimeters));

    bodyLeft.resize (300, 0);
    bodyRight.resize (300, 0);

    imageMode (CENTER);
    image (bodyLeft, positionUserOneIcon, positionIconsY - 30);
    image (bodyRight, positionUserTwoIcon, positionIconsY - 30);

    strokeWeight (3);
    stroke (242, 250, 88, masterColor1[1]);
    /*desenha linha entre icones dos usuarios
     o +35 é a dist entre o icone e o inicio/fim da linha */
    line(positionUserOneIcon + 35, positionIconsY + 140, positionUserTwoIcon - 40, positionIconsY + 140);

    textAlign (CENTER);
    textFont (fontRegular);
    textSize (30);
    
    if (distanceCentimeters <= 150) {
      text ((int (distanceCentimeters) + " cm"), (width/2), positionIconsY + 190);  
    } else {
      text ("Não existem combinações para distâncias maiores 150cm", (width/2), positionIconsY + 190);
    }
    
    
    //alinhamento dos icones - conhecidos niveis
    int positionIconsX = int(- circleIconSize);

    conhecidosIcon.resize (circleIconSize, 0);
    proximosIcon.resize (circleIconSize, 0);
    desconhecidosIcon.resize (circleIconSize, 0);

    textAlign (LEFT);
    textFont (fontRegular);
    textSize (textSizeNiveis);   

    image (conhecidosIcon, positionTextX, positionTextY);
    text ("conhecido", positionTextX + 60, positionTextY - 10);

    image (proximosIcon, positionTextX + 390, positionTextY);
    text ("próximo", positionTextX + 450, positionTextY - 10);

    image (desconhecidosIcon, positionTextX + 790, positionTextY);
    text ("desconhecido", positionTextX + 850, positionTextY - 10);

    textFont (fontBold);
    textSize (textSizeCountries);

    text (paisCon, positionTextX + 60, positionTextY + 25); //Conhecidos
    text (paisProx, positionTextX + 450, positionTextY  + 25); //Proximos
    text (paisDesc, positionTextX + 850, positionTextY  + 25); //Desconhecidos
    break;


  case 2: //tela do mexa-se
    screenMaster2.animateOpacity(8, false);
    float [] masterColor2 = {255, screenMaster2.getOpacity()};
    
    screenMaster0.animateOpacity(1.5, true); // fading out
    screenMaster1.animateOpacity(1.5, true); // fading out
  
    fill (masterColor2[0], masterColor2[1]);
    textFont (fontRegular);
    textSize (textSizeCountries);
    textAlign (LEFT, CENTER);
    text ("descubra outras relações", width/8, height/3 + 30);
    text ("teste distâncias, divirta-se! ", width/8, height/3 + 65);
    
    tint (masterColor2[0], masterColor2[1]);
    
    imageMode (CORNER);
    bodyMoving.resize (872, 0);
    image (bodyMoving, width/3 -80, height/6 );
    experimenteLogo.resize (400, 0);
    image(experimenteLogo, width/11, height/3 -75);
    
    break;
  }
}


void calculateDistance () { // Calcula distancia entre as pessoas
  for (int i = 0; i < MAX_USERS; i++) {
    for (int j = i; j < MAX_USERS; j++) {
      if (i != j) {
        if (!((cmDataBody[i].x == 0.0 && cmDataBody[i].y == 0.0 && cmDataBody[i].z == 0.0) || (cmDataBody[j].x == 0.0 && cmDataBody[j].y == 0.0 && cmDataBody[j].z == 0.0 ))) 
        {
          distanceDepth = dist(cmDataBody[i].x, cmDataBody[i].y, cmDataBody[i].z, cmDataBody[j].x, cmDataBody[j].y, cmDataBody[j].z);
          distanceCentimeters = convertDepthToCentimeters(distanceDepth);
        }
      }
    }
  }
}


float convertDepthToCentimeters (float depthIn_) {
  //transforma distancia em depth (milimetros) para centimetros

  float depthIn = depthIn_; //Em milimetros
  float centimetersOut = depthIn/10;

  return centimetersOut;
}


float mapValuesDistUserToPixels (float distUsers_) {
  //mapeia a posicao real do usuario 1 para pixels
  float distUsers = distUsers_;

  //mapeia o cmDataBody[i]x - centro de massa eixo X usuario 1 - de 0 a 3500mm 
  float distUsersPixel = map (distUsers, 15, 180, 30, width/2 - 380);

  return distUsersPixel;
}


void runKinectFundation () {
  //updates the cam
  context.update();

  depthMap = context.depthMap();
  userMap = context.userMap();

  // inicializa vetor com as coordenadas de todos os usuarios
  for (int i = 0; i < MAX_USERS; i++) {
    allDataBody[i] = new PVector(0, 0, 0);
  }

  // inicializa vetor com as coordenadas do centro de massa de todos os usuarios
  for (int i = 0; i < MAX_USERS; i++) {
    cmDataBody[i] = new PVector(0, 0, 0);
  }

  // draw the skeleton if it's available
  int[] userList = context.getUsers();

  for (int i=0; i<userList.length; i++) {
    context.getJointPositionSkeleton(userList[i], SimpleOpenNI.SKEL_HEAD, allDataBody[userList[i] - 1]);

    // draw the center of mass
    if (context.getCoM(userList[i], com)) {
      cmDataBody[i].x = com.x;
      cmDataBody[i].y = com.y;
      cmDataBody[i].z = com.z;
    }
  }
}


void runKinectSetup () {
  if (context.isInit() == false)
  {
    println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
    exit();
    return;
  }

  // disable mirror
  context.setMirror(false);
  // enable depthMap generation 
  context.enableDepth();
  // enable skeleton generation for all joints
  context.enableUser();
}

