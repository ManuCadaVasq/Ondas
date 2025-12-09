import processing.serial.*;

Serial myPort;
int estado = 0;
int timer = 0;

void setup() {
  fullScreen();
  printArray(Serial.list());
  
  myPort = new Serial(this, Serial.list()[2], 9600); 
  myPort.clear();
}

void draw() {
  background(5);

 
  while (myPort.available() > 0) {
    String dato = myPort.readStringUntil('\n'); 
    if (dato != null) {
      dato = trim(dato);
      if (dato.equals("T")) {
        estado = 1;
        timer = 0;
      }
    }
  }

  float intensidad = (estado == 0) ? 30 : 120;
  float velocidad = (estado == 0) ? 0.045 :0.15;

  stroke(255);
  noFill();

  int cantidadOndas = 5;
  float separacion = height / (cantidadOndas + 1.0);

  for (int i = 1; i <= cantidadOndas; i++) {
    beginShape();
    for (int x = 0; x <= width; x++) {
      float yBase = separacion * i;
      float yOffset = noise(x * 0.04, i * 10, frameCount * velocidad) * intensidad
                      - intensidad / 2.0;
      float y = yBase + yOffset;
      vertex(x, y);
    }
    endShape();
  }

  if (estado == 1) {
    timer++;
    if (timer > 150) {
      estado = 0;
      timer = 0;
    }
  }
}
