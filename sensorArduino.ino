
const int pinSensor = 2; 

const long BAUDS = 9600;

int estadoSensorAnterior = LOW; 

void setup() {
  pinMode(pinSensor, INPUT);
  
  Serial.begin(BAUDS); 
}

void loop() {
  int estadoSensorActual = digitalRead(pinSensor);

  if (estadoSensorActual == HIGH && estadoSensorAnterior == LOW) {
    Serial.println("T");
 
    
    
  }

  estadoSensorAnterior = estadoSensorActual; 
  
  delay(50); 
}