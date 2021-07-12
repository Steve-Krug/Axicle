#include <Wire.h>

int INS = 0x68; // MPU6050 I2C address
int16_t Gyro_X, Gyro_Y, Gyro_Z;
float P, Q, R;

void setup() {
  Serial.begin(9600);
  Wire.begin();                      // Initialize comunication
  Wire.beginTransmission(INS);       // Start communication with MPU6050 // INS=0x68
  Wire.write(0x6B);                  // Talk to the register 6B
  Wire.write(0);                     // Make reset - place a 0 into the 6B register
  Wire.endTransmission(true);        // End the transmission


}
void loop() {

  // Write to INS Requesting Gyroscope Data
  Wire.beginTransmission(INS);
  Wire.write(0x43); //
  Wire.endTransmission();
  Wire.requestFrom(INS, 6, true);

  // Read Gyroscope Data and Convert to Physical Units (DPS)
  Gyro_X = (Wire.read() << 8 | Wire.read());
  Gyro_Y = (Wire.read() << 8 | Wire.read());
  Gyro_Z = (Wire.read() << 8 | Wire.read());

  Q = Gyro_X / 131.0;
  P = Gyro_Y / 131.0;
  R = Gyro_Z / 131.0;

  // Print the values on the serial monitor
  Serial.print("\t");
  Serial.print(P);
  Serial.print("\t");
  Serial.print(Q);
  Serial.print("\t");
  Serial.println(R);

  //////////Data Log//////////
  String dataString = "";
  dataString += String(Q);
  dataString += ",";
  dataString += String(R);
  dataString += ",";
  dataString += String(P);
  //dataString += ",";
  //dataString += String(blinkState); //roll sensor


  File dataFile = SD.open("datalog20.txt", FILE_WRITE);

  //If file is available, write it to:
  if (dataFile) {
    dataFile.println(dataString);
    dataFile.close();
  }
  //print to serial
  //Serial.println(dataString);
  //If file isn't working, throw error
  else {
    Serial.println("error writing data packet to SD");
  }

  //delay(10);
}
