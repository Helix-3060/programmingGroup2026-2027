class StartScreen {
  // skyline building
  Building[] skyline = new Building[8];
  ArrayList<Missile> missiles = new ArrayList<Missile>();
  ArrayList<FireParticle> fires = new ArrayList<FireParticle>();
  
  // Scrolling text variables
  float textY;
  String[] loreLines = {
    "THE YEAR IS 20X6.",
    "GLOBAL FACTIONS CLASH ACROSS THE GRID.",
    "",
    "THE IMPERIAL ARMADA HAS BREACHED THE OUTER DEFENSES,",
    "RAZING CITIES TO ASH IN THEIR WAKE.",
    "",
    "ONLY THE COMMANDER REMAINS TO PROTECT",
    "THE LAST MILITARY BASE.",
    "",
    "PREPARE FOR BATTLE."
  };
  
  StartScreen() {
    // Initialize skyline buldings across the bottom
    float bWidth = width / 8.0;
    for (int i = 0; i < skyline.length; i++) {
      float bHeight = random(80, 180);
      skyline[i] = new Building(i * bWidth, height - bHeight, bWidth - 2, bHeight);
    }
    textY = height + 50; // Start text below the screen
  }
  
  void update() {
    // sawn incoming missiles randomly
    if (frameCount % 40 == 0) {
      Building target = skyline[int(random(skyline.length))];
      missiles.add(new Missile(random(width), 0, target.x + target.w / 2, target.y));
    }
    
    // Update missiles
    for (int i = missiles.size() - 1; i >= 0; i--) {
      Missile m = missiles.get(i);
      m.update();
      if (m.arrived) {
        // Trigger fire/explosion on impact
        fires.add(new FireParticle(m.targetX, m.targetY));
        missiles.remove(i);
      }
    }
    
    // Update fires
    for (int i = fires.size() - 1; i >= 0; i--) {
      FireParticle f = fires.get(i);
      f.update();
      if (f.life <= 0) fires.remove(i);
    }
    
    // Scroll backstory text upward slowly (Changed from 0.6 to 0.3 to slow it down)
    textY -= 0.3;
    if (textY < -300) {
      textY = height + 50; // Loop the crawl
    }
  }
  
  void draw() {
    update();
    
    // 1.dark night sky
    background(10, 10, 25);
    
    // Draw background grid stars/dots
    fill(255, 255, 255, 100);
    noStroke();
    ellipse(80, 60, 2, 2);
    ellipse(200, 40, 2, 2);
    ellipse(340, 90, 2, 2);
    ellipse(150, 130, 2, 2);
    
    // 2.scrolling backstory
    textAlign(CENTER, TOP);
    textSize(12);
    for (int i = 0; i < loreLines.length; i++) {
      float currentLineY = textY + (i * 22);
      // Fade out text near top and bottom edges
      float alpha = map(currentLineY, 0, height, 0, 255);
      alpha = constrain(alpha, 0, 255);
      
      fill(200, 200, 220, alpha);
      text(loreLines[i], width / 2, currentLineY);
    }
    
    // 3. Draw top biulding
    for (Building b : skyline) {
      b.draw();
    }
    
    // 4. Draw missle
    for (Missile m : missiles) {
      m.draw();
    }
    
    // 5. draw boom
    for (FireParticle f : fires) {
      f.draw();
    }
    
    // 6. tile/flassh
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
    
    // building with windows
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
