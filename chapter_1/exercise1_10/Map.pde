class Map {
  int segments;
  Section s;
  Section[] sections;
  float x1, x2, x3, x4, y1, y2, y3, y4;
  float xoff1, xoff2, yoff1, yoff2;
  float increment;
  
  Map(int segments_) {
    segments = segments_;
    sections = new Section[segments];
    x1 = 0;
    y1 = height / 2;
    xoff1 = 0;
    yoff1 = 0;
    xoff2 = 10000;
    yoff2 = 10000;
    increment = 0.01;
  }
  
  void init() {
    s = new Section(x1, y1, x2, y2, x3, y3, x4, y4);
  }
}