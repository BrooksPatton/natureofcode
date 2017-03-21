class Section {
  float x1, y1, x2, y2, x3, y3, x4, y4;
  
  Section(float x1_, float y1_, float x2_, float y2_, float x3_, float y3_, float x4_, float y4_) {
    x1 = x1_;
    y1 = y1_;
    x2 = x2_;
    y2 = y2_;
    x3 = x3_;
    y3 = y3_;
    x4 = x4_;
    y4 = y4_;
  }
  
  void render() {
    fill(255);
    quad(x1, y1, x2, y2, x3, y3, x4, y4);
  }
}