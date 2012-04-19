import netscape.javascript.*;
import org.json.*;

class Point{
  double x;
  double y;
  
  Point(double x,double y){
    this.x=x;
    this.y=y;
  }
  
  String toString(){
    return "["+this.x+","+this.y+"]";
  }
}

int scalex;
int scaley;
float transx;
float transy;
ArrayList tiles = new ArrayList();
Map map;
Graph graph;
Dijkstra dijkstra;

void setup(){
  size(1536,1024);
  
  smooth();
  strokeWeight(0.1);
  
  graph = new Graph();
  
  scalex=17000;
  scaley=20000;
  transx=-71.065;
  transy=42.336;
  
  map = new Map();
  String[] filenames = {"-71.04-42.36.json",
    "-71.04-42.34.json",
    "-71.06-42.36.json",
    "-71.06-42.34.json", //this one
    "-71.08-42.36.json",
    "-71.08-42.34.json"
  };
  for(int i=0; i<filenames.length; i++){
    print(i+"...");
    map.addTile( filenames[i] );
    println( "done" );
  }
  
  graph = map.toGraph();
  dijkstra = new Dijkstra( graph, "1330264333" );
  
  background(255);
  map.draw(transx,transy,scalex,scaley);
  
  println( graph.adj );
  
}

void keyPressed(){
  if( key==' ' ){
    dijkstra.step();
  }
}

void draw(){
  if(mousePressed){
    transx -= float(mouseX-pmouseX)/scalex;
    transy += float(mouseY-pmouseY)/scaley;
    
    background(255);
    map.draw(transx,transy,scalex,scaley);
  }
  
  for(int i=0; i<40; i++){
  dijkstra.step();
  }
}
