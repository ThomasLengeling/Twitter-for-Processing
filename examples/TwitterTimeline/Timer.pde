class Timer {
  int savedTime; // When Timer started
  int totalTime; // How long Timer should last

  float msTime;
  int tempTime;

  boolean end;

  Timer(int tempTotalTime) {
    totalTime = tempTotalTime;
  }

  void start() {
    // When the timer starts it stores the current time in milliseconds.
    savedTime = millis();
  }

  float getCurrentTime() {
    return (msTime = tempTime/1000.0);
  }

  void reset() {
    tempTime = 0;
    start();
  }
  
  boolean isDone(){
    return end;
  }

  // The function isFinished() returns true if 5,000 ms have passed. 
  // The work of the timer is farmed out to this method.
  void update() { 
    // Check how much time has passed
    tempTime = millis()- savedTime;
    if (tempTime > totalTime) {
      end =  true;
    } 
    else {
      end = false;
    }
  }
}
