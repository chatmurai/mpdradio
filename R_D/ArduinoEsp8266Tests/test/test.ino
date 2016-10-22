#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>
#include <ESP8266mDNS.h>

ESP8266WebServer server(80);

void handleGetWifiScan() {
  Serial.println("handleGetWifiScan");
  server.send(200, "text/plain", "handleGetWifiScan");
}

void handleSetWifiCredentials() {
  Serial.println("handleSetWifiCredentials");
  Serial.println(server.arg("d"));
  server.send(200, "text/plain", "handleSetWifiCredentials");
}

void setup() {
  Serial.begin(115200);
  WiFi.softAP("zouzou3000", "totocaca");
  /*if (MDNS.begin("esp8266")) {
    Serial.println("MDNS responder started");
  }*/

  server.on("/g_wi-sc", handleGetWifiScan);
  server.on("/s_wi-cr", handleSetWifiCredentials);
  
  
  server.begin();
  Serial.println("HTTP server started");
}


void loop() {
  server.handleClient();
}
