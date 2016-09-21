#include <ESP8266WiFi.h>

// WiFi WPA2-PSK key
const char WiFiAPPSK[] = "put_key_here";

WiFiServer server(80);

// String delimiter for app -> esp8266 data transmission
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
  WiFiClient client = server.available();
  if (!client) {
    return;
  }

  // Read the first line of the request
  String req = client.readStringUntil('\r');
  //Serial.println(req);
  client.flush();

  int d1 = req.indexOf(delim, 0);
  int d2 = req.indexOf(delim, d1 + 1);
  int d3 = req.indexOf(delim, d2 + 1);

  String a = req.substring(d1 + delim.length(), d2);
  String b = req.substring(d2 + delim.length(), d3);

  char ssid[a.length() + 1];
  char pass[b.length() + 1];

  a.toCharArray(ssid, a.length() + 1);
  b.toCharArray(pass, b.length() + 1);
  
  //Serial.println("~~~~{\"ssid\":\"" + String(ssid) + "\",\"pass\":\"" + String(pass) + "\"}~~~~");
  client.flush();

  // Prepare the response. Start with the common header:
  String s = "HTTP/1.1 200 OK\r\n";
  s += "Content-Type: text/html\r\n\r\n";
  s += "<!DOCTYPE HTML>\r\n<html>\r\n";
  s += "<p>ok</p>\r\n";
  s += "</html>\n";

  // Send the response to the client
  client.print(s);
  delay(1);
  //Serial.println("Client disonnected");

  // The client will actually be disconnected 
  // when the function returns and 'client' object is detroyed
}

void setupWiFi()
{
  WiFi.mode(WIFI_AP);

  // Do a little work to get a unique-ish name. Append the
  // last two bytes of the MAC (HEX'd) to "Thing-":
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

void initHardware()
{
  Serial.begin(9600);
  // Don't need to set ANALOG_PIN as input, 
  // that's all it can be.
}

// rot47 obfuscation encode / decode
char *rot47(char *s)
{
  char *p = s;
  while(*p) 
  {
    if(*p >= '!' && *p <= 'O')
      *p = ((*p + 47) % 127);
    else if(*p >= 'P' && *p <= '~')
      *p = ((*p - 47) % 127);
    p++;
  }
 return s;
}
