class StartScreen {
  void draw() {
    textAlign(CENTER, CENTER);
    
    fill(255, 230, 0);
    textSize(36);
    text("BATTLE CITY", width / 2, height / 2 - 50);
    
    fill(255);
    textSize(14);
    text("Use W A S D or Arrow Keys to Move", width / 2, height / 2 + 10);
    text("Press SPACE to Shoot", width / 2, height / 2 + 35);
    
    if ((frameCount / 30) % 2 == 0) {
      fill(180, 50, 0);
      textSize(16);
      text("PRESS SPACE TO START", width / 2, height / 2 + 90);
    }
  }
}
