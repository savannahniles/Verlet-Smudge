class Surface {

  int particles, bonds;
  float shapeRadius, tension;
  PVector push;
  float shapeSkew;
  PVector startingPosition;
  color bodyColor;
  int strokeW;
  
  float theta;

  VerletBall[] balls;
  VerletStick[] sticks;

  //default constructor
  Surface () {
  }
  
  /*
  
  //constructor 1-- particles, shapeRadius, tension,
  Surface (int particles, float shapeRadius, float tension) {
    this.particles = particles;
    this.shapeRadius = shapeRadius;
    this.tension = tension;
    shapeSkew = 1;
    startingPosition = new PVector (width/2, height/2);

    bonds = particles + particles/2;
    balls = new VerletBall[particles];
    sticks = new VerletStick[bonds];

    verletSystem();
  }
  
  //constructor 2-- particles, shapeRadius, tension, shapeSkew
  Surface (int particles, float shapeRadius, float tension, float shapeSkew) {
    this.particles = particles;
    this.shapeRadius = shapeRadius;
    this.tension = tension;
    this.shapeSkew = shapeSkew;
    startingPosition = new PVector (width/2, height/2);

    bonds = particles + particles/2;
    balls = new VerletBall[particles];
    sticks = new VerletStick[bonds];

    verletSystem();
  }
  
  */
  
  //constructor 3-- particles, shapeRadius, tension, shapeSkew, starting position, color, stroke
  
  Surface (int particles, float shapeRadius, float tension, PVector push, float shapeSkew, PVector startingPosition, color bodyColor, int strokeW) {
    this.particles = particles;
    this.shapeRadius = shapeRadius;
    this.tension = tension;
    this.push = push;
    this.shapeSkew = shapeSkew;
    this.startingPosition = startingPosition;
    this.bodyColor = bodyColor;
    this.strokeW = strokeW;

    bonds = particles + particles/2;
    balls = new VerletBall[particles];
    sticks = new VerletStick[bonds];

    verletSystem();
  }

  void verletSystem () {
    
    for (int i=0; i<particles; i++) {
      PVector p = new PVector(startingPosition.x+cos(theta)*shapeRadius*shapeSkew, startingPosition.y+sin(theta)*shapeRadius);
      balls[i] = new VerletBall(p, push, 1);
      theta += TWO_PI/particles;
    }

    for (int i=0; i<particles; i++) {
      if (i>0) {
        sticks[i-1] = new VerletStick(balls[i-1], balls[i], tension);
      }
      if (i==particles-1) {
        sticks[i] = new VerletStick(balls[i], balls[0], tension);
      }
    } 

    for (int i=particles; i<bonds; i++) {
      sticks[i] = new VerletStick(balls[i-particles], balls[i-particles/2], tension);
    }

  }
  
  void setColor(){
    stroke(bodyColor);
    strokeWeight(strokeW);
    noFill();
  }
  

  void renderSurface() {

    for (int i=0; i<bonds; i++) {
      sticks[i].render();
      sticks[i].constrainLen();
    }

    for (int i=0; i<particles; i++) {
      balls[i].verlet();
      balls[i].render();
      balls[i].boundsCollision();
    }
  }
}

