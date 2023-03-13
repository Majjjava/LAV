PImage myImage;
boolean obrni = true;
int cnt = 0;
float heading;
float posX, posY;
float h;
float R = 20;
float kot =0;
float e, u, up, ud, ui,ed, es, et;
float Kp = -0.05;
float Ki = -0.00;
float Kd = -0.00;
float T = 0.02;
Vehicle v = new Vehicle(50, 50);

void setup() {
  size(600, 600);
  myImage = loadImage("labirint.jpg");
  
  heading = v.getHeading();
  v.printHeading();
}

void draw() {
  background(255);
  image(myImage, 0, 0);

  PVector p = new PVector();
  PVector s = v.distanceV(); // enotin vektor v smeri vožnje
  PVector d = v.distanceV();
  d.rotate(PI/2);            // enotin vektor pravokoten na smer vožnje
  
  p = v.position.copy();
  p.add(s);
  int dFront=0;
  while(get((int)p.x,(int)p.y)!=0xff000000){
    point(p.x,p.y);
    p.add(s);
    //println(d.x+" "+d.y);
    dFront++; //<>//
    if(dFront > 400) break;
  }
  
  p = v.position.copy();
  p.add(d);
  int dRight=0;
  while(get((int)p.x,(int)p.y)!=0xff000000){
    point(p.x,p.y);
    p.add(d);
    dRight++;
    if(dRight > 400) break;
  }

  e = R-dRight;
  up=Kp*e;
  es = es + e;
  ui = Ki*T*es;
  ud = Kd+(e-et)/T;
  u = up +ui + ud;
  v.setHeading(up);
  println(up);
  
  if(dFront < 20){
    v.setHeading(-60);
  }
  if(dFront < 25){
    v.setHeading(-30);
  }
  if(dFront < 30){
    v.setHeading(-10);
  }
  /*if(dRight < 15){
    v.setHeading(-20);
  }*/
    
  v.update();
  v.display();
  
  text("kot: ",0,40);
  text(v.getHeading(), 30,40);
  text("dFront: ",0,50);
  text(dFront, 40,50);
  text("dRight: ",0,60);
  text(dRight, 40,60);
}
