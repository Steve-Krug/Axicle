#include<Wire.h>
const int MPU_addr = 0x68; // I2C address of the MPU-6050
//Some of those boards have a pull-down resistor at AD0 (address = 0x68), others have a pull-up resistor (address = 0x69).
int16_t AcX, AcY, AcZ;

float my_time;

void setup() {


  pinMode(A4, INPUT);
  //val = digitalRead(A5);

  pinMode(A5, INPUT);
  //val = digitalRead(SCL);

  Wire.begin();
  Wire.beginTransmission(MPU_addr);
  Wire.write(0x6B);  // PWR_MGMT_1 register
  Wire.write(0);     // set to zero (wakes up the MPU-6050)
  //or one, I am not so sure
  delay(100);
  Wire.write(0x68);
  Wire.write(0);
  delay(100);
  Wire.endTransmission(true);
  Serial.begin(115200);
  my_time = micros();
}

void loop() {
  Wire.beginTransmission(MPU_addr);
  Wire.write(0x3B);  // starting with register 0x3B (ACCEL_XOUT_H)
  Wire.endTransmission(false);
  Wire.requestFrom(MPU_addr, 6, true); // request a total of 6 registers

  AcX = Wire.read() << 8 | Wire.read(); // 0x3B (ACCEL_XOUT_H) & 0x3C (ACCEL_XOUT_L)
  AcY = Wire.read() << 8 | Wire.read(); // 0x3D (ACCEL_YOUT_H) & 0x3E (ACCEL_YOUT_L)
  AcZ = Wire.read() << 8 | Wire.read(); // 0x3F (ACCEL_ZOUT_H) & 0x40 (ACCEL_ZOUT_L)

  Serial.print("AcX = "); Serial.print(AcX);
  Serial.print(" | AcY = "); Serial.print(AcY);
  Serial.print(" | AcZ = "); Serial.println(AcZ);

  //delay(333);
  float temp = my_time - micros();
  Serial.println(temp);
  my_time = micros();

}
