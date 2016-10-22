#include "ESP8266WiFi.h"

int n = 0;

void setup() {
  Serial.begin(115200);
  delay(100);
  scan();
}

void loop() {
  
  //delay(5000);
}

void scan() {

  // Set WiFi to station mode and disconnect from an AP if it was previously connected
  WiFi.mode(WIFI_STA);
  WiFi.disconnect();
  delay(500);

  Serial.println("station mode ok");
  Serial.println("scan start");

  // WiFi.scanNetworks will return the number of networks found
  n = WiFi.scanNetworks();
  Serial.println("scan done");
  if (n == 0)
    Serial.println("no networks found");
  else
  {
    Serial.print(n);
    Serial.println(" networks found");
    for (int i = 0; i < n; ++i)
    {
      // Print SSID and RSSI for each network found
      Serial.print(i + 1);
      Serial.print(": ");
      Serial.print(WiFi.SSID(i));
      Serial.print(" (");
      Serial.print(WiFi.RSSI(i));
      Serial.print(") - encryption : ");
      Serial.println((WiFi.encryptionType(i) == ENC_TYPE_NONE)?"0":String(WiFi.encryptionType(i)));
      delay(10);
    }
  }
  Serial.println("");
}

