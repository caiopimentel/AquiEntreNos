class Timer {
  long lastTime, currentTime;
  int limitTime, cicleCount, lastCicleCount;
  boolean done;

  public Timer (int limitTime_) {
    limitTime = limitTime_;
  }

  public void runTimer () {
    currentTime = millis ();
    done = false;

    if ((currentTime - lastTime) >= limitTime) {
      cicleCount++;
      done = true;

      lastTime = currentTime;
    }
  }

  public boolean isDone () {
    return done;
  }

  public void resetTimer () {
    lastTime = currentTime; 
  }

  public int getCiclesCount () {
    return cicleCount;
  }

  public long getCurrentTime () {
    return currentTime;
  }

  public long getLastTime () {
    return lastTime;
  }

  public int getLimitTime () {
    return limitTime;
  }
  
  public float getPercentageDone () { // Retorna quantos porcento do timer ja passou
    float timeLapsed = currentTime - lastTime;
    float percentage = timeLapsed/limitTime;
    
    return percentage;
  }
}
