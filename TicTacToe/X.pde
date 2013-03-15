class X{
  int x, y;
  
  X(int _x, int _y){
    
    x = _x;
    y = _y;
    
    }
  
  void init(){
    noFill();
    line(20+x, 20+y, 100+x, 120+y);
    line(100+x, 20+y, 20+x, 120+y);
    
   }
}
