int cols;
int rows;
int skip;



void setup (){
  size(800, 800, P3D);
  
  skip = 20;
  cols = width / skip;
  rows = height / skip;


}


void draw(){
  
  
  
  
  background(0);  
  
  translateGrid(-3, -42);
  beginShape(TRIANGLE_STRIP);
  for (int y = 0; y < height; y+=skip){
    
    for(int x = 0; x < width + skip ; x+=skip){
      stroke(254);
      strokeWeight(0.7);
      noFill();
      vertex(x, y, random(-1, 1));
      vertex(x, y + 20, random(-1, 1));
    }
    
  }
  endShape();

}

void translateGrid(int rotate, int depth){
  
  translate(width/2, height/2);
  rotateX(PI/rotate);
  translate(-width/2, -height/2, depth);

}
