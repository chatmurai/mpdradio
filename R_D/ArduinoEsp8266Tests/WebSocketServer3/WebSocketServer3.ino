#include <Arduino.h>

#include <ESP8266WiFi.h>
#include <WebSocketsServer.h>
#include <ESP8266WebServer.h>
#include <ESP8266mDNS.h>
#include <Hash.h>

const char WiFiAPPSK[] = "zbamzbam";
WebSocketsServer webSocket = WebSocketsServer(81);

/**
   Handle websocket events
*/
void webSocketEvent(uint8_t num, WStype_t type, uint8_t * payload, size_t lenght) {
    switch (type) {
  
      case WStype_DISCONNECTED:
        //Serial.printf("[%u] Disconnected!\n", num);
        break;
  
      case WStype_CONNECTED: {
          //IPAddress ip = webSocket.remoteIP(num);
          //Serial.printf("[%u] Connected from %d.%d.%d.%d url: %s\n", num, ip[0], ip[1], ip[2], ip[3], payload);
  
          // send message to client
          webSocket.sendTXT(num, "Welcome, you're connected !");
          break;
        }
  
      case WStype_TEXT:
        String p = (char * ) payload;
        Serial.println(p);
        break;
    }
  
  }

/**
   Generate a unique Wifi SSID based on Esp8266 MAC address
*/
char *generateSSID() {
    uint8_t mac[WL_MAC_ADDR_LENGTH];
    WiFi.softAPmacAddress(mac);
    String macID = String(mac[WL_MAC_ADDR_LENGTH - 2], HEX) + String(mac[WL_MAC_ADDR_LENGTH - 1], HEX);
    macID.toUpperCase();
    String AP_NameString = "zbam-radio-setup-" + macID;
    char AP_NameChar[AP_NameString.length() + 1];
    
    memset(AP_NameChar, 0, AP_NameString.length() + 1);
    for (int i = 0; i < AP_NameString.length(); i++) AP_NameChar[i] = AP_NameString.charAt(i);
    
    return AP_NameChar;
  }

void setup() {
    Serial.begin(115200);
    delay(100);
    WiFi.mode(WIFI_AP);
    delay(500);
  
    Serial.flush();
    //Serial.println();
  
    // Create WiFi network
    char *ssid = generateSSID();
    WiFi.softAP(ssid, WiFiAPPSK, 12, false);
    delay(500);
  
    //Serial.print("Esp8266 IP address = ");
    //Serial.println(WiFi.softAPIP());
    //WiFi.printDiag(Serial);
  
    // start webSocket server
    webSocket.begin();
    webSocket.onEvent(webSocketEvent);
  }

  void loop() {
    webSocket.loop();
    if(Serial.available() > 0){
        String r = Serial.readStringUntil('\n');
        webSocket.broadcastTXT(r);
    }
}

