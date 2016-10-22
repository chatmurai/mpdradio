char inChar;
String data = "";

void setup() {
  Serial.begin(57600, SERIAL_8N1);
  delay(500);
  Serial.println("ready!");
}

void loop() {
  if (Serial.available()) 
  {
      inChar = (char)Serial.read();
      Serial.println(inChar);
      if(inChar == '\n')
      {
        Serial.println("!!!");
      }
  }
}
