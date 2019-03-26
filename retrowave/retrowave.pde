//import processing.sound.*;
import ddf.minim.*;
import ddf.minim.effects.*;
import ddf.minim.ugens.*;
import ddf.minim.analysis.*;
import ddf.minim.signals.*;
 

Cube spaceship, shot;

Minim minim;

AudioInput IN;
AudioRecorder recorder;
AudioOutput OUT;
FilePlayer player;
LowPassSP lpf;

PImage bg, logo, spaceship_texture, shot_texture;
PFont font;
PShape octopus, crab, squid;
//SoundFile soundtrack;
boolean cam, sound, st;
int x, y;

void setup(){
  size(1422,800,P3D);
  
  bg = loadImage("retrowave.jpg");
  logo = loadImage("atari.png");
  spaceship_texture = loadImage("texture_1.jpg");
  shot_texture = loadImage("shot.jpg");
  
  font = createFont("SFAlienEncounters-Italic.ttf", 52);
  
  crab = loadShape("Space_Invader_1.obj");
  octopus = loadShape("Space_Invader_2.obj");
  squid = loadShape("Space_Invader_3.obj");
  
  //soundtrack = new SoundFile(this, "soundtrack.wav");
  
  shot = new Cube(8, 30, 5, width/2 + 300, height/2 + 130, 0, shot_texture);
  spaceship = new Cube(80, 30, 15, width/2 + 300, height/2 + 340, 0, spaceship_texture);
  
  cam = false;
  sound = false; 
  st = false;
  
  minim = new Minim(this);
  
  OUT = minim.getLineOut(Minim.STEREO);
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
  
  keysPiano();
}

void defaultCamera(){
  camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
}

void modeCamera(){
  camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0 - x, height/2.0 - y, 0, 0, 1, 0);
}

void keyPressed(){
  switch(key) {
    case 'a': x -= 20; break;
    case 'd': x += 20; break;
    case 'w': y += 20; break;
    case 's': y -= 20; break;
    case 'p': cam = true; break;
    case 'o': cam = false; break;
    case 'f': sound = true; break;
    case 'x': sound = false; break;
    case 'n': st = !st; break;
    case 'e': OUT.playNote( 0.0, 0.9, new SineInstrument(Frequency.ofPitch("A3").asHz())); break;
    case 'r': OUT.playNote( 0.0, 0.9, new SineInstrument(Frequency.ofPitch("B3").asHz())); break;
    case 't': OUT.playNote( 0.0, 0.9, new SineInstrument(Frequency.ofPitch("C4").asHz())); break;
    case 'y': OUT.playNote( 0.0, 0.9, new SineInstrument(Frequency.ofPitch("D4").asHz())); break;
    case 'u': OUT.playNote( 0.0, 0.9, new SineInstrument(Frequency.ofPitch("E4").asHz())); break;
    case 'i': OUT.playNote( 0.0, 0.9, new SineInstrument(Frequency.ofPitch("F4").asHz())); break;
    case 'k': OUT.playNote( 0.0, 0.9, new SineInstrument(Frequency.ofPitch("G4").asHz())); break;
    case 'l': OUT.playNote( 0.0, 0.9, new SineInstrument(Frequency.ofPitch("A4").asHz())); break;
  }
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

void keysPiano(){
  if(sound){
    textFont(font, 32);
    text("X", 160, height/2 - 250);
    text("E", 160 + 120, height/2 - 250);
    text("R", 160 + 240, height/2 - 250);
    text("T", 160 + 360, height/2 - 250);
    text("Y", 160 + 480, height/2 - 250);
    text("U", 160 + 600, height/2 - 250);
    text("I", 160 + 720, height/2 - 250);
    text("K", 160 + 840, height/2 - 250);
    text("L", 160 + 960, height/2 - 250);
    //text("N", 160 + 1080, height/2 - 250);
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
  textFont(font, 20);
  stroke(0);
  fill(36, 223, 253);
  if(!cam && !sound){
    text("Mode", width/2 - 680, height/2 + 330);
    text("Press P - Camera mode", width/2 - 680, height/2 + 360);
    text("Press F - Sound mode", width/2 - 680, height/2 + 390);
  }else{
    if(cam){
      text("Press A/D/W/S to move the camera", width/2 - 680, height/2 + 360);
      text("Press O to use the default view", width/2 - 680, height/2 + 390);
    }
    if(sound){
      text("Press keys E/R/T/Y/U/I/K/L to play piano", width/2 - 680, height/2 + 330);
      text("Press N to play and stop soundtrack", width/2 - 680, height/2 + 360);
      text("Press X to back", width/2 - 680, height/2 + 390);
    }
  }
}

class SineInstrument implements Instrument{
  Oscil wave;
  Line  ampEnv;
  
  SineInstrument(float frequency){
    wave   = new Oscil( frequency, 0, Waves.SINE );
    ampEnv = new Line();
    ampEnv.patch( wave.amplitude );
  }
  
  void noteOn(float duration){
    ampEnv.activate( duration, 0.5f, 0 );
    wave.patch(OUT);
  }
  
  void noteOff(){
    wave.unpatch(OUT);
  }
}
