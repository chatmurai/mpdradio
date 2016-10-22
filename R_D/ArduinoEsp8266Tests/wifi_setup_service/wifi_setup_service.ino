#include <ESP8266WiFi.h>

// WiFi WPA2-PSK key
const char WiFiAPPSK[] = "zbamzbam";

WiFiServer server(80);
WiFiClient wclient;

int n = 0;

// String delimiter for mobile app -> esp8266 data transmission
String delim = "~~~~";

void setup() 
{
  initHardware();
  setupWiFi();
  server.begin();
}

void loop() 
{
  // Check if a client has connected
  WiFiClient wclient = server.available();
  if (!wclient) {
    return;
  }
  
  String req = wclient.readStringUntil('\r');
  
  wclient.flush();
  
  if(req.indexOf("w_scan") > 0) // scan
  {
    scanWifiNetworks();
  }
  else // data
  {
    Serial.println(req);
  }

  String s = "HTTP/1.1 200 OK\r\n";
  s += "Content-Type: text/html\r\n\r\n";
  s += "<!DOCTYPE HTML>\r\n<html>\r\n";
  s += "<p>ok</p>\r\n";
  s += "</html>\n";

  // Send the response to the client
  wclient.print(s);
  
  delay(1);
}

void setupWiFi()
{
  WiFi.mode(WIFI_AP);
  uint8_t mac[WL_MAC_ADDR_LENGTH];
  WiFi.softAPmacAddress(mac);
  String macID = String(mac[WL_MAC_ADDR_LENGTH - 2], HEX) + String(mac[WL_MAC_ADDR_LENGTH - 1], HEX);
  macID.toUpperCase();
  String AP_NameString = "zbam-radio-setup-" + macID;

  char AP_NameChar[AP_NameString.length() + 1];
  memset(AP_NameChar, 0, AP_NameString.length() + 1);

  for (int i=0; i<AP_NameString.length(); i++)
    AP_NameChar[i] = AP_NameString.charAt(i);

  WiFi.softAP(AP_NameChar, WiFiAPPSK);
}

void scanWifiNetworks()
{
  Serial.println("scan start");

  // WiFi.scanNetworks will return the number of networks found
  n = WiFi.scanNetworks();
  Serial.println("scan done");
  Serial.println(wclient);

  /*String s = "HTTP/1.1 200 OK\r\n";
  s += "Content-Type: text/html\r\n\r\n";
  s += "<!DOCTYPE HTML>\r\n<html>\r\n";
  
  if (n == 0)
    s += "<p>no networks found</p>\r\n";
  else
  {
    s += "<p>some networks found</p>\r\n";
  }

   s += "</html>\n";
   wclient.print(s);*/
}

void initHardware()
{
  Serial.begin(9600);
}

