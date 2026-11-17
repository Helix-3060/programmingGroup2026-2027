// lucas
class EnemyTank {
    // in test:enemy pathfinder logic (not complete yet)
void chooseTacticalDirection() {
  float dx = playerX - x;
  float dy = playerY - y;

  if (abs(dx) > abs(dy)) {
    if (dx > 0) dir = 1;
    else dir = 3;
  } else {
    if (dy > 0) dir = 2;
    else dir = 0;
  }
}
}
