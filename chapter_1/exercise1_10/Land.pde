class Land 
{
  int plot_width;
  int plot_height;
  int land_width;
  int land_height;
  float[][] peaks;
  float xoff, yoff, zoff;
  float noise_increment;

  Land()
  {
    plot_width = 25;
    plot_height = 25;
    land_width = 1000 / plot_width;
    land_height = 3000 / plot_height;
    peaks = new float[land_width][land_height];
    noise_increment = 0.1;
    zoff = 0;
  }

  void calculate_peaks() {
    zoff -= 0.03;
    yoff = zoff;
    for (int j = 0; j < land_width; j++) {
      xoff = 0;
      for (int i = 0; i < land_height; i++) {
        peaks[j][i] = map(noise(xoff, yoff), 0, 1, -160, 160);
        xoff += noise_increment;
      }
      yoff += noise_increment;
    }
  }

  void render()
  {
    fill(0);
    stroke(255);
    for (int j = 0; j < peaks.length - 1; j++) {
      for (int i = 0; i < peaks[j].length - 1; i++) {
        pushMatrix();
        translate(plot_width * i - 500, plot_height * j, 0);
        beginShape(QUADS);
        vertex(0, 0, peaks[j][i]);
        vertex(plot_width, 0, peaks[j][i + 1]);
        vertex(plot_width, plot_height, peaks[j + 1][i + 1]);
        vertex(0, plot_height, peaks[j + 1][i]);
        endShape();
        popMatrix();
      }
    }
  }
}