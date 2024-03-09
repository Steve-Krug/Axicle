/*
  Arduino LSM6DS3 - Simple Accelerometer

  This example reads the acceleration values from the LSM6DS3
  sensor and continuously prints them to the Serial Monitor
  or Serial Plotter.

  The circuit:
  - Arduino Uno WiFi Rev 2 or Arduino Nano 33 IoT

  created 10 Jul 2019
  by Riccardo Rizzo

  This example code is in the public domain.
*/

#include <Arduino_LSM6DS3.h>

void setup() {
  Serial.begin(9600);
  while (!Serial);

  if (!IMU.begin()) {
    Serial.println("Failed to initialize IMU!");

    while (1);
  }

  Serial.print("Accelerometer sample rate = ");
  Serial.print(IMU.accelerationSampleRate());
  Serial.println(" Hz");
  Serial.println();
  Serial.println("Acceleration in g's");
  Serial.println("X\tY\tZ");


  Serial.print("Gyroscope sample rate = ");
  Serial.print(IMU.gyroscopeSampleRate());
  Serial.println(" Hz");
  Serial.println();
  Serial.println("Gyroscope in degrees/second");
  Serial.println("X\tY\tZ");
}

void loop() {
  float Ax, Ay, Az;
  float Wx, Wy, Wz;

  if (IMU.accelerationAvailable() && IMU.gyroscopeAvailable()) {
    IMU.readAcceleration(Ax, Ay, Az);
    IMU.readGyroscope(Wx, Wy, Wz);

    Serial.print(millis());
    Serial.print(",\t");
    Serial.print(Ax);
    Serial.print(",\t");
    Serial.print(Ay);
    Serial.print(",\t");
    Serial.print(Az);
    Serial.print(",\t");
    Serial.print(Wx);
    Serial.print(",\t");
    Serial.print(Wy);
    Serial.print(",\t");
    Serial.print(Wz);
    ///Serial.print(",\t");
    Serial.println();




  }



  //if (IMU.gyroscopeAvailable()) {
  //  IMU.readGyroscope(Wx, Wy, Wz);

    
 // }




}
