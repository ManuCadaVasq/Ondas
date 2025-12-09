import processing.serial.*;

Serial myPort;
int estado = 0;
int timer = 0;

void setup() {
  fullScreen();
  
  String[] portNames = Serial.list();
  println("Puertos Seriales Disponibles:");
  for (int i = 0; i < portNames.length; i++) {
    println("[" + i + "] " + portNames[i]); 
  }

  try {
    myPort = new Serial(this, portNames[2], 9600); 
    myPort.clear();
  } catch (Exception e) {
    println("Error al abrir el puerto serial en el índice [2].");
  }
}

void draw() {
  background(5);

  while (myPort != null && myPort.available() > 0) {
    String dato = myPort.readStringUntil('\n'); 
    
    if (dato != null) {
      dato = trim(dato);
      
      if (dato.equals("T")) {
        
        float probabilidad = random(1); 
        
        if (probabilidad < 0.40) { 
          estado = 1;
          timer = 0;
          println("¡Toque detectado, hay interferencia.");
        } else {
          println("Toque detectado, no hay interferencia"); 
        }
      }
    }
  }

  float intensidad = (estado == 0) ? 30 : 120;
  float velocidad = (estado == 0) ? 0.045 : 0.15;

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

