//Stephen P. Wallace | Start Screen PDE | nov 8th
class StartScreen {
  Building[] skyline = new Building[8];
  ArrayList<Missile> missiles = new ArrayList<Missile>();
  ArrayList<FireParticle> fires = new ArrayList<FireParticle>();
  
  float textY;
  String[] loreLines = {
    "IN THE YEAR 20XX",
    "ANOTHER SIMI WORLD WAR HAD BROKEN OUT...",
    "",
    "THE UNITED STATES IS TO BE CARVED UP LIKE POLAND...",
    "",
    "CHINA, JAPAN, RUSSIA, FRANCE, BRITAIN...",
    "ALL TO TAKE OUR LANDS OF DEMOCRACY...",
    "",
    "YOU ARE ONE OF THE LAST STANDING...",
    "AND THEY WILL STOP AT NOTHING...",
    "",
    "PREPARE FOR BATTLE."
  };
  
  StartScreen() {
    float bWidth = width / 8.0;
    for (int i = 0; i < skyline.length; i++) {
      float bHeight = random(80, 180);
      skyline[i] = new Building(i * bWidth, height - bHeight, bWidth - 2, bHeight);
    }
    textY = height + 50;
  }
  
  void update() {
    if (frameCount % 40 == 0) {
      Building target = skyline[int(random(skyline.length))];
      missiles.add(new Missile(random(width), 0, target.x + target.w / 2, target.y));
    }
    
    for (int i = missiles.size() - 1; i >= 0; i--) {
      Missile m = missiles.get(i);
      m.update();
      if (m.arrived) {
        fires.add(new FireParticle(m.targetX, m.targetY));
        missiles.remove(i);
      }
    }
    
    for (int i = fires.size() - 1; i >= 0; i--) {
      FireParticle f = fires.get(i);
      f.update();
      if (f.life <= 0) fires.remove(i);
    }
    
    textY -= 0.3;
    if (textY < -350) {
      textY = height + 50;
    }
  }
  
  void draw() {
    update();
    
    background(10, 10, 25);
    
    fill(255, 255, 255, 100);
    noStroke();
    ellipse(80, 60, 2, 2);
    ellipse(200, 40, 2, 2);
    ellipse(340, 90, 2, 2);
    ellipse(150, 130, 2, 2);
    
    textAlign(CENTER, TOP);
    textSize(11);
    for (int i = 0; i < loreLines.length; i++) {
      float currentLineY = textY + (i * 22);
      float alpha = map(currentLineY, 0, height, 0, 255);
      alpha = constrain(alpha, 0, 255);
      
      fill(200, 200, 220, alpha);
      text(loreLines[i], width / 2, currentLineY);
    }
    
    for (Building b : skyline) {
      b.draw();
    }
    
    for (Missile m : missiles) {
      m.draw();
    }
    
    for (FireParticle f : fires) {
      f.draw();
    }
    
    fill(0, 0, 0, 150);
    rect(0, 0, width, 55);
    rect(0, height - 45, width, 45);
    
    textAlign(CENTER, CENTER);
    fill(255, 210, 0);
    textSize(28);
    text("BATTLE CITY", width / 2, 28);
    
    if ((frameCount / 25) % 2 == 0) {
      fill(255, 60, 60);
      textSize(14);
      text("PRESS SPACE TO DEPLOY", width / 2, height - 22);
    }
  }
}

class Building {
  float x, y, w, h;
  Building(float x, float y, float w, float h) {
    this.x = x; this.y = y; this.w = w; this.h = h;
  }
  void draw() {
    fill(35, 35, 50);
    noStroke();
    rect(x, y, w, h);
    
    fill(255, 255, 150, 150);
    for (float wy = y + 8; wy < y + h - 10; wy += 14) {
      for (float wx = x + 6; wx < x + w - 8; wx += 10) {
        rect(wx, wy, 4, 6);
      }
    }
  }
}

class Missile {
  float x, y, targetX, targetY;
  float speed = 4.0;
  boolean arrived = false;
  
  Missile(float startX, float startY, float tx, float ty) {
    x = startX; y = startY; targetX = tx; targetY = ty;
  }
  
  void update() {
    float angle = atan2(targetY - y, targetX - x);
    x += cos(angle) * speed;
    y += sin(angle) * speed;
    
    if (dist(x, y, targetX, targetY) < speed) {
      arrived = true;
    }
  }
  
  void draw() {
    stroke(255, 150, 0);
    strokeWeight(2);
    line(x, y, x - cos(atan2(targetY - y, targetX - x)) * 10, y - sin(atan2(targetY - y, targetX - x)) * 10);
    noStroke();
  }
}

class FireParticle {
  float x, y;
  int life = 30;
  
  FireParticle(float x, float y) {
    this.x = x; this.y = y;
  }
  
  void update() {
    life--;
  }
  
  void draw() {
    noStroke();
    fill(255, 100, 0, map(life, 30, 0, 255, 0));
    ellipse(x, y, 20 + (30 - life), 20 + (30 - life));
    fill(255, 255, 0, map(life, 30, 0, 255, 0));
    ellipse(x, y, 10, 10);
  }
}
