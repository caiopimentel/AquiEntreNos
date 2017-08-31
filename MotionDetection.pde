class MotionDetection {
  Timer holdTimer;
  float [] capturedDistances = new float[0];
  int motionThreshold, motionState;
  boolean capturingDone = false;
  boolean moved = false;
  boolean previousMoved = false;
  boolean timerDone = true;


  public MotionDetection (int motionThreshold_) 
  {
    holdTimer = new Timer(16000); //24000 aproximadamente 23 segundos totais
    motionThreshold = motionThreshold_; // Margem de tolerancia em que se ignorara diferencas entre distancias capturadas
  }


  private void captureDistance(float distance_) {
      capturedDistances = append(capturedDistances, distance_);
  }

  
  private void calculateState() {
    float lastDistanceCaptured = capturedDistances [(capturedDistances.length) - 1];
    
    if (abs(capturedDistances [0] - capturedDistances [(capturedDistances.length) - 1]) > motionThreshold) 
    { // Se for true a pessoa se moveu significativamente, compara diferenca entre primeira e ultima captura
      for (int i = 0; i < capturedDistances.length; i++) {
        capturedDistances = shorten(capturedDistances); // Limpa todo as distancias capturadas para uma nova avaliacao
      }
      
      capturedDistances [0] = lastDistanceCaptured; // A ultima distancia da ultima comparacao se torna a base para a nova avaliacao de movimento
      motionState = 1;
      moved = true;
      
    } else { 
      //Pessoas nao se moveram, a diferenca entre a primeira e ultima captura NAO eh significativa
      if (moved) { // Se for a primeira vez apos movimento que houver ausencia de movimento: resete o timer
        holdTimer.resetTimer();
        timerDone = false;
      }
      moved = false; // impede que o timer seja resetado novamente sem que haja antes uma nova movimentacao
      
      if (holdTimer.getPercentageDone() >= 0.5) { // Se o tempo passado for menor ou igual a 50 porcento to tempo total do timer
        motionState = 2;
      }
      
      if (!timerDone) { //Se o timer nao tiver acabado ele continua rodando
        holdTimer.runTimer();
      }
      
      if (holdTimer.isDone()) {
        motionState = 0;
        timerDone = true;
      }
    }
  }


  public int getMotionState (float distance_) {
    previousMoved = moved;
    captureDistance(distance_);
    calculateState();

    return motionState;
  }
  
  
  public boolean previousIsMoving () {
    return previousMoved;
  }
  
  
  public boolean isMoving () {
    return moved;
  }
  
  
}
