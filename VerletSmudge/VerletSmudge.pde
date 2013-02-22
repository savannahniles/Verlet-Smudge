//Verlet Smudge -- Savannah Niles Sept. 13


Surface thing, t2;
int maximum = 100;
int counter = 0;

Surface[] things = new Surface[maximum];

void setup() {
  size (900, 600);
  background(255);
  //  Surface (int particles, float shapeR, float shapeSkew, float tension)
  PVector startThing = new PVector (0, 0); 

}



void draw() {  
  //background (255);
  for (int i=0; i<counter; i++) {
    things[i].renderSurface();
    things[i].setColor();
  }
}

void mouseClicked () {
  PVector startMouse = new PVector (mouseX, mouseY);
  int randomParticles = int(random(4, 20));
  int randomSize = int(random(10, 50));
  float randomTension = random(.1, .5);
  PVector randomPush = new PVector(random(1, 3.5), random(1,3.5));
  float randomShapeSkew = random(1, 4);
  color randColor = color (random(175,255), random(155,255), random(255), 100);
  int randStroke = int(random(16, 35));
 
  things[counter] = new Surface(randomParticles, randomSize, randomTension, randomPush, 
      randomShapeSkew, startMouse, randColor, randStroke);
  counter++;
}

