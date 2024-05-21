#include <SparkFun_u-blox_SARA-R5_Arduino_Library.h> 
#include <ArduinoJson.h>
#include <IPAddress.h>
#include <ICM20948_WE.h>
#include <timestamp32bits.h>
#include "AssetTrackerPins.h" 

#include <Time.h>
 
#define SERIAL_PORT Serial
SARA_R5 assetTracker(SARA_PWR);

ICM20948_WE IMU = ICM20948_WE(IMU_CS, true);

#define ARDUINOJSON_USE_LONG_LONG 1

// MQTT Server Info
String brokerName = "146.190.141.74"; // MQTT Broker
const int brokerPort = 1889; // MQTT port (TCP, no encryption)
String myUsername = "testboard";
String myClientID = "testboard";
String myPassword = "testpass";
String myChannelID = "1225363"; //

// Settings
const int batch_size = 200; // number of datapoints to collect before sending data
const int buffer_rate = 20; // speed at which the buffer fills.  Lower is faster.

timestamp32bits stamp = timestamp32bits();
long long current_time;
int previous_millis;

void setup() {

  initializeAssetTrackerPins();
  SERIAL_PORT.begin(115200);
  SERIAL_PORT.println("Starting Axicle Tracker...");
  setupSara();
  setupClock();
  setupIMU();
}

void setupIMU() {

  enableIMUPower();
  enableMicroSDPower();

  delay(2000);

  Wire.begin();
  Serial.begin(115200);
  //while(!Serial) {}
  
  if(!IMU.init()){
    Serial.println("ICM20948 does not respond");
  }
  else{
    Serial.println("ICM20948 is connected");
  }

  IMU.setAccRange(ICM20948_ACC_RANGE_4G);
  IMU.setAccDLPF(ICM20948_DLPF_6); 
  IMU.setAccSampleRateDivider(20);

  IMU.setGyrRange(ICM20948_GYRO_RANGE_500);
  IMU.setGyrDLPF(ICM20948_DLPF_6);
  IMU.setGyrSampleRateDivider(20);

  IMU.setFifoMode(ICM20948_STOP_WHEN_FULL);
  IMU.enableFifo(true);
  delay(100);
  IMU.startFifo(ICM20948_FIFO_ACC_GYR);

}

void loop() {

  if (IMU.getNumberOfFifoDataSets()>200) {

    Serial.println(String(IMU.getNumberOfFifoDataSets()));
    sendJSONData();

  }

  assetTracker.bufferedPoll(); // Keep processing data from the SARA
  delay(10);

}

void sendJSONData() {

  SERIAL_PORT.println();

  int a = millis();

  assetTracker.deleteFile("testfile");

  //SERIAL_PORT.println(String(millis() - a) + " ms to delete old JSON file");

  int inc = updateTime();

  JsonDocument doc;
  JsonArray docarray = doc.to<JsonArray>();

  docarray.add(current_time);
  docarray.add(inc);

  for (int i = 0; i < batch_size; i++) {

    xyzFloat a = IMU.getGValuesFromFifo();
    xyzFloat w = IMU.getGyrValuesFromFifo();

    docarray.add((int) (a.x * 100));
    docarray.add((int) (a.y * 100));
    docarray.add((int) (a.z * 100));
    docarray.add((int) (w.x * 100));
    docarray.add((int) (w.y * 100));
    docarray.add((int) (w.z * 100));

  }

  //SERIAL_PORT.println(String(millis() - a) + " ms to create JSON string.");
  
  String DataString;
  size_t filesize = serializeJson(doc, DataString);
  SERIAL_PORT.println(DataString);
  assetTracker.appendFileContents("testfile", DataString.c_str(), filesize);

  //SERIAL_PORT.println(String(millis() - a) + " ms to save JSON string to file.");

  String Topic = "v1/devices/me/telemetry";
  SARA_R5_error_t e = assetTracker.mqttPublishFromFile(Topic, "testfile");

  //SERIAL_PORT.println(String(millis() - a) + " ms to publish file via MQTT.");

  SERIAL_PORT.print("Sent " + String(batch_size) + " datapoints in " + String(millis() - a));
  SERIAL_PORT.println("ms (Error Code " + String(e) + ")");

  if (e != SARA_R5_ERROR_SUCCESS) {

    SERIAL_PORT.println("Send failed, wait 5 seconds then reboot SARA and reconnect...");
    delay(5000);

  }

}

void setupSara() {

  //assetTracker.enableDebugging();
  assetTracker.invertPowerPin(true); 

  // Hard reboot SARA.  It doesn't seem to restart when new firmware is uploaded.
  SERIAL_PORT.print(F("Rebooting SARA..."));
  assetTracker.powerOff();
  delay(1000);
  SERIAL_PORT.print(F("."));
  delay(1000);
  SERIAL_PORT.print(F("."));
  assetTracker.modulePowerOn();
  delay(1000);
  SERIAL_PORT.print(F("."));
  
  // Initialize SARA
  if (assetTracker.begin(Serial1, 115200) )
  {
    SERIAL_PORT.println(F("Done."));
  }
  else
  {
    SERIAL_PORT.println(F("Unable to communicate with the SARA."));
    SERIAL_PORT.println(F("Manually power-on (hold the SARA On button for 3 seconds) on and try again."));
    while (1) ; // Loop forever on fail
  }

  connect();

}

void connect() {

  String currentOperator = "";

  SERIAL_PORT.print(F("Connecting to carrier..."));

  // First check to see if we're connected to an operator:
  while (assetTracker.getOperator(&currentOperator) != SARA_R5_SUCCESS && currentOperator == "")
  {
    SERIAL_PORT.print(".");
    delay(500);
  }

  SERIAL_PORT.println(currentOperator + ".");
 

  if (assetTracker.performPDPaction(0, SARA_R5_PSD_ACTION_DEACTIVATE) != SARA_R5_SUCCESS)
  {
    //SERIAL_PORT.println(F("Warning: performPDPaction (deactivate profile) failed. Probably because no profile was active."));
  }

  if (assetTracker.performPDPaction(0, SARA_R5_PSD_ACTION_LOAD) != SARA_R5_SUCCESS)
  {
    SERIAL_PORT.println(F("performPDPaction (load from NVM) failed! Freezing..."));
    while (1)
      ; // Do nothing more
  }

  if (assetTracker.performPDPaction(0, SARA_R5_PSD_ACTION_ACTIVATE) != SARA_R5_SUCCESS)
  {
    SERIAL_PORT.println(F("performPDPaction (activate profile) failed! Freezing..."));
    while (1)    
      ; // Do nothing more
  }

  SERIAL_PORT.print(F("Connecting to MQTT server..."));

  assetTracker.setMQTTCommandCallback(processMQTTcommandResult);
  assetTracker.setMQTTsecure(false);
  assetTracker.setMQTTclientId(myClientID);
  assetTracker.setMQTTserver(brokerName, brokerPort);
  assetTracker.setMQTTcredentials(myUsername, myPassword);

  // Connect
  if (assetTracker.connectMQTT() == SARA_R5_SUCCESS)
    SERIAL_PORT.println(F("Done."));
  else
    SERIAL_PORT.println(F("MQTT connect: failed!"));

}

void processMQTTcommandResult(int command, int result) {
  SERIAL_PORT.println();
  SERIAL_PORT.print(F("MQTT Command Result:  command: "));
  SERIAL_PORT.print(command);
  SERIAL_PORT.print(F("  result: "));
  SERIAL_PORT.print(result);
  if (result == 0)
    SERIAL_PORT.print(F(" (fail)"));
  if (result == 1)
    SERIAL_PORT.print(F(" (success)"));
  SERIAL_PORT.println();

  // Get and print the most recent MQTT protocol error
  int error_class;
  int error_code;
  assetTracker.getMQTTprotocolError(&error_class, &error_code);
  SERIAL_PORT.print(F("Most recent MQTT protocol error:  class: "));
  SERIAL_PORT.print(error_class);
  SERIAL_PORT.print(F("  code: "));
  SERIAL_PORT.print(error_code);
  if (error_code == 0)
    SERIAL_PORT.print(F(" (no error)"));
  SERIAL_PORT.println();
}

double round2(double value) {
   return (int)(value * 100 + 0.5) / 100.0;
}

void setupClock() {

  //Get time from SARA and convert to UTC in milliseconds
  uint8_t y, mo, d, h, min, s;
  int8_t tz;
  assetTracker.clock(&y, &mo, &d, &h, &min, &s, &tz);
  current_time = stamp.timestamp(y, mo, d, h, min, s);
  current_time = (current_time - (900*tz)) * 1000;
  previous_millis = millis();

}

int updateTime() {
  
  int m = millis();
  int dt = m - previous_millis;
  previous_millis = m;
  SERIAL_PORT.println("dt = " + String(dt));
  current_time = current_time + dt;
  return dt/batch_size;

}
