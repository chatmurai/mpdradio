#include <ESP8266WiFi.h>

// WiFi WPA2-PSK key
const char WiFiAPPSK[] = "zbamzbam";
String wifiNetworks = "[{}]";         // a string to hold wifi networks incoming data

WiFiServer server(80);

void setup()
{
  wifiNetworks.reserve(10000);  // reserve 10KB for wifiNetworks String
  initHardware();
  setupWiFi();
  server.begin();
}

void loop()
{
  // ################# READ SERIAL DATA FROM RASPBERRY PI
  if (Serial.available() > 0) {
      data = Serial.readStringUntil('\n');
      if(data.startsWith("[{") ) // this is the JSON containing wifi networks data
      {
        wifiNetworks = data;
      }
      else if(data.indexOf("*wifi_ok*")) // this is RBPI telling that wifi cred. were changed with success
      {
        
      }
      else if(data.indexOf("*error*")) // this is RBPI telling that there was an error with wifi cred. change
      {
        
      }

      data = "";
      
      //wifiNetworks = Serial.readStringUntil('\n');
  }
  
  // Check if a client has connected
  WiFiClient client = server.available();
  if (!client) {
    return;
  }

  // ################# ANSWER TO MOBILE APP REQUESTS
  String req = client.readStringUntil('\r');

  // Prepare the response. Start with the common header:
  String s = "HTTP/1.1 200 OK\r\n";
  s += "Content-Type: application/json\r\n\r\n";
  
  if (req.indexOf("g_wi-sc") != -1)
  {
    s += wifiNetworks + "\n";
  }
  else if(req.indexOf("s_wi-cr") != -1)
  {
    
  }
  
  //Serial.println(req);
  client.flush();

  // Send the response to the client
  client.print(s);
  delay(1);
  Serial.println("Client disonnected");
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

  for (int i = 0; i < AP_NameString.length(); i++)
    AP_NameChar[i] = AP_NameString.charAt(i);

  WiFi.softAP(AP_NameChar, WiFiAPPSK);
}

void initHardware()
{
  Serial.begin(115200);
}

// rot47 obfuscation encode / decode
char *rot47(char *s)
{
  char *p = s;
  while (*p)
  {
    if (*p >= '!' && *p <= 'O')
      *p = ((*p + 47) % 127);
    else if (*p >= 'P' && *p <= '~')
      *p = ((*p - 47) % 127);
    p++;
  }
  return s;
}

