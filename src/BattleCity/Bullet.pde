// stephen
class Bullet {
    float x;
    float y;
    float speed;

Bullet(float StartX, float StartY, float bulletspeed) {
    x = StartX;
    y = StartY;
    speed = bulletspeed;

}

void move() {}

void display() {
    fill(255, 20, 50);
    noStroke();
    ellipse(x, y, 8, 16);
}

}
