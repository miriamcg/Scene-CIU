class Cube{
  
  int cubeW;
  int cubeH;
  int cubeZ;
  int x;
  int y;
  int z;
  PImage img;
  
  Cube(int cubeW, int cubeH, int cubeZ, int x, int y, int z, PImage img){
    this.cubeW = cubeW;
    this.cubeH = cubeH;
    this.cubeZ = cubeZ;
    this.x = x;
    this.y = y;
    this.z = z;
    this.img = img;
  }
  
  void TexturedCube(PImage tex, int cubeW, int cubeH, int cubeZ) {
    beginShape(QUADS);
    texture(tex);

    // +Z "front" face
    vertex(-cubeW, -cubeH, cubeZ, 0, 0);
    vertex(cubeW, -cubeH, cubeZ, cubeH, 0);
    vertex(cubeW, cubeH, cubeZ, cubeH, cubeH);
    vertex(-cubeW,  cubeH, cubeZ , 0, cubeH);

    // -Z "back" face
    vertex(cubeW, -cubeH, -cubeZ, 0, 0);
    vertex(-cubeW, -cubeH, -cubeZ, cubeH, 0);
    vertex(-cubeW,  cubeH, -cubeZ, cubeH, cubeH);
    vertex(cubeW, cubeH, -cubeZ, 0, cubeH);

    // +Y "bottom" face
    vertex(-cubeW,  cubeH, cubeZ, 0, 0);
    vertex(cubeW, cubeH, cubeZ, cubeW, 0);
    vertex(cubeW, cubeH, -cubeZ, cubeW, cubeW);
    vertex(-cubeW, cubeH, -cubeZ, 0, cubeW);

    // -Y "top" face
    vertex(-cubeW, -cubeH, -cubeZ, 0, 0);
    vertex(cubeW, -cubeH, -cubeZ, cubeW, 0);
    vertex(cubeW, -cubeH,  cubeZ, cubeW, cubeW);
    vertex(-cubeW, -cubeH, cubeZ, 0, cubeW);

    // +X "right" face
    vertex(cubeW, -cubeH,  cubeZ, 0, 0);
    vertex(cubeW, -cubeH, -cubeZ, cubeW, 0);
    vertex(cubeW, cubeH, -cubeZ, cubeW, cubeW);
    vertex(cubeW, cubeH, cubeZ, 0, cubeW);

    // -X "left" face
    vertex(-cubeW, -cubeH, -cubeZ, 0, 0);
    vertex(-cubeW, -cubeH,  cubeZ, cubeW, 0);
    vertex(-cubeW, cubeH, cubeZ, cubeW, cubeW);
    vertex(-cubeW, cubeH, -cubeZ, 0, cubeW);

    endShape();
  }
  
  void display(){
    pushMatrix();
    translate(x, y, z);
    shininess(100);
    rotateY(radians(180));
    TexturedCube(img, cubeW, cubeH, cubeZ);
    popMatrix();
  }
}
