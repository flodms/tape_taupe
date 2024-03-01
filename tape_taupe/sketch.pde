/**
  @author: KduckGames
*/


/*TODO:
*review lost screen graphism
*create menu
=> UI
*different modes
*/



Taupe[] taupes = new Taupe[20];
Taupe currTaupe;

Button bRestart;

PImage img; 
PImage vide;

int score;

boolean lost;
int timeout;
int time;

class Button {
  int x,y,w,h;
  Button(int xb,int yb,int wb,int hb) {
   x=xb;
   y=yb;
   w=wb;
   h=hb; 
  }
  
  boolean isPressed() {
    if(abs(mouseX-x)<w/2 && abs(mouseY-y)<h/2) {
      return true;
    } else return false;
  }
  
  void show() {
    textAlign(CENTER);
    rect(x,y,w,h);
  }
}

class Taupe {
  int x,y,w,h;
  boolean show = false;
  Taupe(int xt,int yt,int wt,int ht) {
   x=xt;
   y=yt;
   w=wt;
   h=ht; 
  }
  
  void drawt() {
    //fill(255);
    //if(show) fill(0,255,0);
    //rect(x,y,w,h);
    imageMode(CENTER);
    image(show? img:vide,x,y,w,h);
  }
  
  boolean isPressed() {
    if(abs(mouseX-x)<w/2 && abs(mouseY-y)<h/2) {
      return true;
    } else return false;
  }
}

void setup() {
  img = loadImage("taupe.png");
  vide = loadImage("vide.png");
  timeout=0;
  time=60;
  score=0;
  lost = false;
  int index = 0;
  int wsize = width/6;
  for(int xpos = 0; xpos<4; xpos++) {
    for(int ypos = 1; ypos<6; ypos++) {
      //println(index++);
      taupes[index++] = new Taupe(width/7+(width/7-wsize/2+wsize)*xpos,height/6*ypos,wsize,wsize);
      //rect(xpos,ypos,100,100);
    }
  }
  currTaupe = taupes[int(random(taupes.length-1))];
  bRestart = new Button(width/2,height/4*3,400,100);
}

void draw() {
  background(200);
  if(!lost) {
    rectMode(CENTER);
    currTaupe.show = true;
    for(Taupe taupe : taupes) {
      taupe.drawt();
    }
    
    fill(0);
    textAlign(CENTER);
    textSize(100);
    text(score,width/2,100);
  
    if(timeout > time) {
     lost = true;
    } else timeout++;
  } else drawLostScreen();
}

void mouseReleased() {
  if(!lost) {
  if(currTaupe.isPressed()) {
    score++;
    Taupe t = currTaupe;
    while(t==currTaupe) {
      t = taupes[int(random(taupes.length-1))];
    }
    currTaupe.show = false;
    currTaupe = t;
    timeout = 0;
    if(time > 20) time--;
  }
  } else {
    if(bRestart.isPressed()) {
      setup();
    }
  }
}

void drawLostScreen() {
  fill(0);
  textSize(100);
  textAlign(CENTER);
  text("PERDU", width/2,height/4);
  text("SCORE: "+ score,width/2,height/2);
  bRestart.show();
  fill(255);
  textSize(60);
  text("RESTART",bRestart.x,bRestart.y+bRestart.h/4,bRestart.w,bRestart.h);
}