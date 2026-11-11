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

void move() {
    y + y - 20;
}

void display() {
    fill(255, 20, 50);
    noStroke();
    ellispe(x, y, 8, 16);
}

}
