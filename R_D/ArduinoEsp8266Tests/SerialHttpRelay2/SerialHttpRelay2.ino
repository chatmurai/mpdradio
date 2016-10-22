#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>

ESP8266WebServer server(80);
String data;
char inChar;
const char WiFiAPPSK[] = "zbamzbam";

void handlePing() {
  Serial.println("ping");
  server.send(200, "text/plain", "pong");
}

void handleGetWifiScan() {
  Serial.println("g_wi-sc");
}

void handleSetWifiCredentials() {
  Serial.println("s_wi-cr~~~~" + server.arg("d") + "~~~~");
}

char *generateSSID() {
  uint8_t mac[WL_MAC_ADDR_LENGTH];
  WiFi.softAPmacAddress(mac);
  String macID = String(mac[WL_MAC_ADDR_LENGTH - 2], HEX) + String(mac[WL_MAC_ADDR_LENGTH - 1], HEX);
  macID.toUpperCase();
  String AP_NameString = "zbam-radio-setup-" + macID;
  char AP_NameChar[AP_NameString.length() + 1];
  
  memset(AP_NameChar, 0, AP_NameString.length() + 1);
  for (int i=0; i<AP_NameString.length(); i++) AP_NameChar[i] = AP_NameString.charAt(i);

  return AP_NameChar;
}

void setup() {
  Serial.begin(115200); // 8 bits, no parity, stop bit = 1
  //data.reserve(10000);  // reserve 10KB for wifiNetworks String
  char *ssid = generateSSID();
  WiFi.softAP(ssid, WiFiAPPSK);

  server.on("/ping", handlePing);
  server.on("/g_wi-sc", handleGetWifiScan);
  server.on("/s_wi-cr", handleSetWifiCredentials);
  server.begin();
}

void loop() 
{
  server.handleClient();
}
