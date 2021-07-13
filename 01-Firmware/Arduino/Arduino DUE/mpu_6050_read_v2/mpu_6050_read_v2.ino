#include <Wire.h>
#include <SPI.h> // Include the SPI Library
#include <SD.h>

int INS = 0x68; // MPU6050 I2C address
int16_t Gyro_X, Gyro_Y, Gyro_Z;
float P, Q, R;
int pinCS = 4;

void setup() {

  // I2Cdev and MPU6050 must be installed as libraries, or else the .cpp/.h files
  // for both classes must be in the include path of your project
#include "I2Cdev.h"

#include "MPU6050_6Axis_MotionApps20.h"
  //#include "MPU6050.h" // not necessary if using MotionApps include file

  // Arduino Wire library is required if I2Cdev I2CDEV_ARDUINO_WIRE implementation
  // is used in I2Cdev.h
#if I2CDEV_IMPLEMENTATION == I2CDEV_ARDUINO_WIRE
#include "Wire.h"
#endif

  // class default I2C address is 0x68
  // specific I2C addresses may be passed as a parameter here
  // AD0 low = 0x68 (default for SparkFun breakout and InvenSense evaluation board)
  // AD0 high = 0x69
  MPU6050 mpu;
  //MPU6050 mpu(0x69); // <-- use for AD0 high


  Serial.begin(9600);
  Wire.begin();                      // Initialize comunication
  Wire.beginTransmission(INS);       // Start communication with MPU6050 // INS=0x68
  Wire.write(0x6B);                  // Talk to the register 6B
  Wire.write(0);                     // Make reset - place a 0 into the 6B register
  Wire.endTransmission(true);        // End the transmission

  //pinMode(pinCS, OUTPUT);
  //SPI.begin();

  if (SD.begin(pinCS))
  {
    Serial.println("SD card is ready to use.");
  } else {
    Serial.println("SD card intialization failed.");
    return;
  }

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
