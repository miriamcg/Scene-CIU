import processing.sound.*;

Cube spaceship, shot;

PImage bg, logo, spaceship_texture, shot_texture;
PFont font;
SoundFile sound;
PShape octopus, crab, squid;
boolean cam;
int x, y;

void setup(){
  size(1422,800,P3D);
  
  bg = loadImage("retrowave.jpg");
  logo = loadImage("atari.png");
  spaceship_texture = loadImage("texture_1.jpg");
  shot_texture = loadImage("shot.jpg");
  
  font = createFont("SFAlienEncounters-Italic.ttf", 52);
  
  sound = new SoundFile(this, "soundtrack.wav");
  
  crab = loadShape("Space_Invader_1.obj");
  octopus = loadShape("Space_Invader_2.obj");
  squid = loadShape("Space_Invader_3.obj");
  
  shot = new Cube(8, 30, 5, width/2 + 300, height/2 + 130, 0, shot_texture);
  spaceship = new Cube(80, 30, 15, width/2 + 300, height/2 + 340, 0, spaceship_texture);
  
  cam = false;
  
  thread("sfx");
}

void draw(){
  background(bg);
  
  lights();
  directionalLight(255, 255, 255, width/2, height/2, (height/2.0) / tan(PI*30.0 / 180.0));
  ambientLight(71, 71, 71);
  
  title();
  instructions();
  
  shot.display();
  spaceship.display();
  
  showSquid();
  showCrab();
  showOctopus();
  
  logo.resize(80, 70);
  image(logo, width/2 - 480, height/2 - 360);
  
  logo.resize(80, 70);
  image(logo, width/2 + 380, height/2 - 360);
  
   if(!cam){
    defaultCamera();
  }else{
    modeCamera();
  }
}

void defaultCamera(){
  camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
}

void modeCamera(){
  camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0 - x, height/2.0 - y, 0, 0, 1, 0);
}

void keyPressed(){
   if(keyPressed){
     if(key == 'a'){
       x -= 20;
     }else if (key == 'd'){
       x += 20;
    }else if (key == 'w'){
       y += 20;
    }else if (key == 's'){
       y -= 20;
    }else if (key == 'p'){
      cam = true;
    } else if (key == 'o'){
      cam = false;
    }
  }
}

void sfx(){
  sound.loop();
}

void showCrab(){
  for(int i = 0; i < 1200; i += 120){
    pushMatrix();
    translate(170 + i, height/2 - 30, 0);
    scale(0.8);
    rotateX(radians(180));
    crab.setFill(color(81, 229, 238));
    shape(crab);
    popMatrix();
  }
}

void showOctopus(){
  for(int i = 0; i < 1200; i += 120){
    pushMatrix();
    translate(170 + i, height/2 - 150, 0);
    rotateX(radians(180));
    octopus.setFill(color(238, 81, 233));
    shape(octopus);
    popMatrix();
  }
}

void showSquid(){
  for(int i = 0; i < 1200; i += 120){
    pushMatrix();
    translate(170 + i, height/2 + 80, 0);
    scale(0.7);
    rotateX(radians(180));
    squid.setFill(color(142, 19, 212));
    shape(squid);
    popMatrix();
  }
}

void title(){
  smooth();
  textFont(font, 82);
  stroke(0);
  fill(247, 9, 197);
  text("Space Invaders", width/2 - 380, height/2 - 300);
  filter(BLUR, 3);
  stroke(0);
  fill(9, 229, 247);
  text("Space Invaders", width/2 - 380, height/2 - 300);
}

void instructions(){
  textFont(font, 24);
  stroke(0);
  fill(36, 223, 253);
  text("Camera mode", width/2 - 680, height/2 + 340);
  if(!cam){
    text("Press P to use the camera mode", width/2 - 680, height/2 + 380);
  }else{
    text("Press A/D/W/S to move the camera", width/2 - 680, height/2 + 370);
    text("Press O to use the default view", width/2 - 680, height/2 + 390);
  }
}
