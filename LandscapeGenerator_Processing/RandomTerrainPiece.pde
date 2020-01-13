import ddf.minim.*;

//Global Variables

int         cols;        // variable for storing Collumns
int         rows;        // storing Rows in the grid
int         scl       =         5;        //Space between rows and collumns
int         w         =         2500;      //Width of the figure
int         h         =         1250;       //Height of the figure

float[][]         terrain;       //        Two index array for storing values in coordinates
boolean           record         =         false;       //record global variable 
float             waveIn;        //       variable for storing microphone amplitude numbers
int               u;             //       global buffer size value
float             flying         =         0;        // speed and direction of the flying effect

Minim             minim;         //        Minim Variable for storing an minim object
AudioInput        in;            //        Minim Variable for storing an audio signal 

void setup(){

  minim = new Minim(this);
  in = minim.getLineIn();
  
  size(1980, 1080, P3D);
  cols = w / scl;
  rows = h / scl;
  
  //number of boundaries of each index is equal to the number of cols and rows
  terrain = new float[cols][rows];
}



void draw(){

  //speed and direction of the relative movement
  flying += 0.17;

  //asign values to the Y axis grid movement
  float yoff = flying;
  //nested loop for asigning values to the list variable 
  //terrain[x][y] So we can have different Z value in each coordinate
  for(int y = 0; y < rows; y++){
    float xoff = 0; 
    for(int x = 0; x < cols; x++){
      //creating a PERLIN NOISE function to create a more realistic interpolation
      //of data, in this case, Z values. Then we map this value( from 0 to 1) to give us 
      //values from -80 to 80
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -80, 80);
      xoff += 0.1;
    }
    yoff += 0.1;
  }
  // MINIM LOOP for obtaining wave amplitude data from the microphone
  for(u = 0; u < in.bufferSize(); u++){
  waveIn = in.left.get(u) * 9;
  print(waveIn);
  }
/*
  background(111);
  
  stroke(255);
  fill(13);
*/  
  //Visual configuration
  background(28, 22, 98);
  //lighting
  directionalLight(62, 255, 233, -102, 0, -1);
  ambientLight(50, 73, 74);
  //Lines in the net
  noStroke();
  //fill Color
  fill(12, 83, 40);  
  //Center the figure
  translate(width/2, height/2);
  //rotate it so we get the perception of flying above it
  rotateX(PI/1);
  //relocate the grid so we see the image in front of us
  translate(-w/2, -h/2);

  //NESTED LOOP for creating the net shape made of VERTEXES
  for(int y = 0; y < rows -1 ; y++){
    beginShape(TRIANGLE_STRIP);
    for(int x = 0; x < cols; x++){
      vertex(x * scl, y * scl, terrain[x][y] + waveIn);
      vertex(x * scl, (y+1)* scl, terrain[x][y+1] + waveIn);   
    }
    endShape();
  }
  //Condition to start recording each frame
  if (record == true){
    saveFrame("output/Terrain_####.png");
  }  
}


//VOID Function to obtain key presses
void keyPressed(){
  
  if (key == 'r'  || key == 'R'){
  
  record = !record;
  
  }

}
