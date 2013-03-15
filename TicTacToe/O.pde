class O{
  
 int x, y; 
  
  O(int _x, int _y){
    
    x = _x;
    y = _y;
  }
  void init(){
    noFill();
    ellipse(50 + x, 50+y, 100, 100);
  }
  
}
