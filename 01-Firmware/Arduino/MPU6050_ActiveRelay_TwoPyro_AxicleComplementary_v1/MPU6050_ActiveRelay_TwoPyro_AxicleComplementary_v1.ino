// PROPERTY OF AXICLE, INC. NOT FOR REDISTRIBUTION WITHOUT CONSENT
// 2/13/24

//Ref 2012 Jeff Rowberg
//I2C device class (I2Cdev) demonstration Arduino sketch for MPU6050 class using DMP (MotionApps v2.0)

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

#include "MultiMap.h" //Needed for lookup tables

// class default I2C address is 0x68
// specific I2C addresses may be passed as a parameter here
// AD0 low = 0x68 (default for SparkFun breakout and InvenSense evaluation board)
// AD0 high = 0x69
MPU6050 mpu;
//MPU6050 mpu(0x69); // <-- use for AD0 high

/* =========================================================================
   NOTE: In addition to connection 3.3v, GND, SDA, and SCL, this sketch
   depends on the MPU-6050's INT pin being connected to the Arduino's
   external interrupt #0 pin. On the Arduino Uno and Mega 2560, this is
   digital I/O pin 2.
 * ========================================================================= */

/* =========================================================================
   NOTE: Arduino v1.0.1 with the Leonardo board generates a compile error
   when using Serial.write(buf, len). The Teapot output uses this method.
   The solution requires a modification to the Arduino USBAPI.h file, which
   is fortunately simple, but annoying. This will be fixed in the next IDE
   release. For more info, see these links:

   http://arduino.cc/forum/index.php/topic,109987.0.html
   http://code.google.com/p/arduino/issues/detail?id=958
 * ========================================================================= */
// uncomment "OUTPUT_READABLE_GYRO" if you want to see the actual
// gryo
#define OUTPUT_READABLE_GYRO

// uncomment "OUTPUT_READABLE_YAWPITCHROLL" if you want to see the yaw/
// pitch/roll angles (in degrees) calculated from the quaternions coming
// from the FIFO. Note this also requires gravity vector calculations.
// Also note that yaw/pitch/roll angles suffer from gimbal lock (for
// more info, see: http://en.wikipedia.org/wiki/Gimbal_lock)
#define OUTPUT_READABLE_YAWPITCHROLL

// constants won't change. Used here to set a pin number:
const int ledPin =  LED_BUILTIN;// the number of the LED pin
const int relayPin1 = 12;
const int relayPin2 = 10;
const int relayReadPin1 = 11;
const int relayReadPin2 = 9;
const int printSerialPin = 8;
const int rollIdx = 2;  //Using 'pitch' due to Arduino mounting
const bool fireSimultaneous = true; // True to fire both pyros at the same time
const bool firePyro = true; // True to allow arduino to fire pyro


bool pyroState1 = false;
bool pyroState2 = false;
int startPyroCount1 = 0;
//int startPyroCount2 = 0;
int16_t triggerCount1;
//int16_t triggerCount2;

// MPU control/status vars
bool dmpReady = false;  // set true if DMP init was successful
uint8_t mpuIntStatus;   // holds actual interrupt status byte from MPU
uint8_t devStatus;      // return status after each device operation (0 = success, !0 = error)
uint16_t packetSize;    // expected DMP packet size (default is 42 bytes)
uint16_t fifoCount;     // count of all bytes currently in FIFO
uint8_t fifoBuffer[64]; // FIFO storage buffer

// orientation/motion vars
Quaternion q;           // [w, x, y, z]         quaternion container
VectorFloat gravity;    // [x, y, z]            gravity vector
float ypr[3];           // [yaw, pitch, roll]   yaw/pitch/roll container and gravity vector
int16_t gx, gy, gz;
int16_t ax, ay, az;
int16_t roll_angle_in1[] =  { 0,  10,  15}; // Might want [0, 5, 10] here
int16_t roll_angle_in2[] =  { 0,  10,  20};
int16_t roll_rate_out1[] = {20000, 1310, 0}; // 1/16.384 to get to deg/s, [1220, 80, 0]
//int16_t roll_rate_out2[] = {20000, 1310, 0}; // 1/16.384 to get to deg/s, [1220, 80, 0]
int16_t roll_rate_allowed1;
//int16_t roll_rate_allowed2;
float rotationScale = 2000.0 / 32768.0; // Or 131 LSB/(deg/s). Must have decimals
float accelerationScale = 2.0 / 32768.0; // 2g?
int16_t triggerPersistence = 7; // Number of cycles with signal high before relay triggers, 7 cycles @67 hz = ~100 milliseconds
int16_t pyroPersistence = 10; // Minimum number of cycles relay will stay active before disabling

// Complementary Vars
float tau_s_hp = 10;
float tau_s = 10000;
float tau_s_lp = 0.00001;
float dt = 0.015; // 66.667 hz
float alpha_comp = dt/(dt+tau_s);
float alpha_hp = dt/(dt+tau_s_hp);
float alpha_lp_accel = dt/(dt+tau_s_lp);



float gyro_LP_dps;
float gyro_LP_dps_Previous = 0.0;
float rate_dps;
float gyro_HP_dps;
float thetaX_Accel_deg;
float thetaX_LP_Accel_deg;
float thetaX_LP_Accel_deg_Previous = 0.0;
float thetaX_GyroIntegration_deg;
float thetaX_Complementary_deg;
float thetaX_Complementary_deg_Previous = 0.0;
float thetaX_Integration_HP_deg;
float thetaX_Integration_HP_deg_Previous = 0.0;




// ================================================================
// ===               INTERRUPT DETECTION ROUTINE                ===
// ================================================================

volatile bool mpuInterrupt = false;     // indicates whether MPU interrupt pin has gone high
void dmpDataReady() {
    mpuInterrupt = true;
}

// ================================================================
// ===                      INITIAL SETUP                       ===
// ================================================================

void setup() {
    // join I2C bus (I2Cdev library doesn't do this automatically)
    #if I2CDEV_IMPLEMENTATION == I2CDEV_ARDUINO_WIRE
        Wire.begin();
        TWBR = 24; // 400kHz I2C clock (200kHz if CPU is 8MHz)
        Wire.setClock(400000); // 400kHz I2C clock.
        Wire.setWireTimeout(10000, true);
    #elif I2CDEV_IMPLEMENTATION == I2CDEV_BUILTIN_FASTWIRE
        Fastwire::setup(400, true);
    #endif

    // initialize serial communication
    // (115200 chosen because it is required for Teapot Demo output, but it's
    // really up to you depending on your project)
    Serial.begin(230400);
    while (!Serial); // wait for Leonardo enumeration, others continue immediately

    // NOTE: 8MHz or slower host processors, like the Teensy @ 3.3v or Ardunio
    // Pro Mini running at 3.3v, cannot handle this baud rate reliably due to
    // the baud timing being too misaligned with processor ticks. You must use
    // 38400 or slower in these cases, or use some kind of external separate
    // crystal solution for the UART timer.

    // initialize device
    Serial.println(F("Initializing I2C devices..."));
    mpu.initialize();

    // verify connection
    Serial.println(F("Testing device connections..."));
    Serial.println(mpu.testConnection() ? F("MPU6050 connection successful") : F("MPU6050 connection failed"));

    // wait for ready
    //Serial.println(F("\nSend any character to begin DMP programming and demo: "));
    //while (Serial.available() && Serial.read()); // empty buffer
    //while (!Serial.available());                 // wait for data
    while (Serial.available() && Serial.read()); // empty buffer again

    // load and configure the DMP
    Serial.println(F("Initializing DMP..."));
    devStatus = mpu.dmpInitialize();

    // supply your own gyro offsets here, scaled for min sensitivity
    mpu.setXGyroOffset(0);    // 220
    mpu.setYGyroOffset(0);      // 76
    mpu.setZGyroOffset(0);      // -85
    mpu.setZAccelOffset(1788+400); // 1788, 1688 factory default for my test chip

    // make sure it worked (returns 0 if so)
    if (devStatus == 0) {
        // turn on the DMP, now that it's ready
        Serial.println(F("Enabling DMP..."));
        mpu.setDMPEnabled(true);

        // enable Arduino interrupt detection
        Serial.println(F("Enabling interrupt detection (Arduino external interrupt 0)..."));
        attachInterrupt(0, dmpDataReady, RISING);
        mpuIntStatus = mpu.getIntStatus();

        // set our DMP Ready flag so the main loop() function knows it's okay to use it
        Serial.println(F("DMP ready! Waiting for first interrupt..."));
        dmpReady = true;

        // get expected DMP packet size for later comparison
        packetSize = mpu.dmpGetFIFOPacketSize();
    } else {
        // ERROR!
        // 1 = initial memory load failed
        // 2 = DMP configuration updates failed
        // (if it's going to break, usually the code will be 1)
        Serial.print(F("DMP Initialization failed (code "));
        Serial.print(devStatus);
        Serial.println(F(")"));
    }

    // configure inputs and outputs
    pinMode(ledPin, OUTPUT);
    pinMode(relayPin1, OUTPUT);
    pinMode(relayPin2, OUTPUT);
    pinMode(relayReadPin1, INPUT);
    pinMode(relayReadPin2, INPUT);
    pinMode(printSerialPin, INPUT_PULLUP);
   
  }



// ================================================================
// ===                    MAIN PROGRAM LOOP                     ===
// ================================================================

void loop() {
    // if programming failed, don't try to do anything
    if (!dmpReady) return;
    int relayReadValue1 = digitalRead(relayReadPin1);
    int relayReadValue2 = digitalRead(relayReadPin2);
    int printSerialValue = LOW; //digitalRead(printSerialPin);


    // wait for MPU interrupt or extra packet(s) available
    while (!mpuInterrupt && fifoCount < packetSize) {
        // other program behavior stuff here
        // .
        // .
        // .
        // if you are really paranoid you can frequently test in between other
        // stuff to see if mpuInterrupt is true, and if so, "break;" from the
        // while() loop to immediately process the MPU data
        // .
        // .
        // .
    }

    // reset interrupt flag and get INT_STATUS byte
    mpuInterrupt = false;
    mpuIntStatus = mpu.getIntStatus();

    // get current FIFO count
    fifoCount = mpu.getFIFOCount();

    // check for overflow (this should never happen unless our code is too inefficient)
    if ((mpuIntStatus & 0x10) || fifoCount == 1024) {
        // reset so we can continue cleanly
        mpu.resetFIFO();
        Serial.println(F("FIFO overflow!"));

    // otherwise, check for DMP data ready interrupt (this should happen frequently)
    } else if (mpuIntStatus & 0x02) {
        // wait for correct available data length, should be a VERY short wait
        while (fifoCount < packetSize) fifoCount = mpu.getFIFOCount();

        // read a packet from FIFO
        mpu.getFIFOBytes(fifoBuffer, packetSize);
        
        // track FIFO count here in case there is > 1 packet available
        // (this lets us immediately read more without waiting for an interrupt)
        fifoCount -= packetSize;

       // #ifdef OUTPUT_READABLE_YAWPITCHROLL
            // display Euler angles in degrees
           // mpu.dmpGetQuaternion(&q, fifoBuffer);
           // mpu.dmpGetGravity(&gravity, &q);
           // mpu.dmpGetYawPitchRoll(ypr, &q, &gravity);
           // if (printSerialValue == LOW){
             //Serial.print(millis());Serial.print(",\t");
             //Serial.print("yrp,\t");
              //Serial.print(ypr[0] * 180/M_PI);
              //Serial.print(",\t");
              //Serial.print(ypr[1] * 180/M_PI);
              //Serial.print(",\t");
              //Serial.print(ypr[2] * 180/M_PI);
             // Serial.print(",\t");
           // }
       // #endif

        #ifdef OUTPUT_READABLE_GYRO
            mpu.getRotation(&gx, &gy, &gz);

            if (printSerialValue == LOW){
              //Serial.print("RPY_rate\t,");
              //Serial.print(gx*rotationScale); Serial.print(",\t"); // 2000 deg/s or 131 deg/s
              //Serial.print(gy*rotationScale); Serial.print(",\t");
             //Serial.print(gz*rotationScale); Serial.print(",\t");
            }
        #endif

        
            mpu.getAcceleration(&ax, &ay, &az);
             if(printSerialValue == LOW){
              //Serial.print("Ax, Ay, Az\t,");
              //Serial.print(ax*accelerationScale); Serial.print(",\t");
              //Serial.print(ay*accelerationScale); Serial.print(",\t");
              //Serial.print(az*accelerationScale); Serial.print(",\t");
             }

// ================================================================
// ===                    Axicle Complementary Filter           ===
// ================================================================
rate_dps = gx*rotationScale;

gyro_LP_dps = rate_dps*alpha_hp + (1-alpha_hp)*gyro_LP_dps_Previous; //Low pass the gyro data

gyro_LP_dps_Previous = gyro_LP_dps; //Store previous value in RAM for filtiering in next step

gyro_HP_dps = rate_dps - gyro_LP_dps; // High pass the gyro data from the low pass

thetaX_Accel_deg = (atan2(ay, az)*180/M_PI); // Try negative calculation for now to be in right coordinate system for complementary filter calc. Test in plot when printing to serial window

thetaX_LP_Accel_deg = (thetaX_Accel_deg*alpha_lp_accel) + (1-alpha_lp_accel)*thetaX_LP_Accel_deg_Previous;

thetaX_LP_Accel_deg_Previous = thetaX_LP_Accel_deg; //Store previous value in RAM for filtiering in next step

thetaX_GyroIntegration_deg = thetaX_Complementary_deg_Previous + gyro_HP_dps*dt; // Pure integration of highpassed gyro data, adding previous complementary filtered angle

thetaX_Integration_HP_deg = thetaX_Integration_HP_deg_Previous + gyro_HP_dps*dt; // Pure integration just for testing purposes. Not used in complementary calculation.

thetaX_Integration_HP_deg_Previous = thetaX_Integration_HP_deg; //Store previous value in RAM for filtiering in next step

thetaX_Complementary_deg = alpha_comp*thetaX_LP_Accel_deg + (1-alpha_comp)*(thetaX_GyroIntegration_deg); // Apply acceleration complementary filter

thetaX_Complementary_deg_Previous = thetaX_Complementary_deg; //Store previous value in RAM for filtiering in next step

if(printSerialValue == LOW){
              
              //Serial.print("CA,\t");
              Serial.print(thetaX_Complementary_deg);Serial.print(",\t");
              //Serial.print("AA\t");            
              //Serial.print(thetaX_Accel_deg);Serial.print(",\t");
              Serial.println();
}

// ===                        Firing Logic                      ===
    
        roll_rate_allowed1 = multiMap<int16_t>(abs(thetaX_Complementary_deg), roll_angle_in1, roll_rate_out1, 3); // Replaced ypr[rollIdx] with complementary filtered roll angle.
        
        if ((gy >= roll_rate_allowed1 && gy>=0) || (-gy >= roll_rate_allowed1 && gy<0)){ //check if actual roll rate is outside the allowed range, still using absolute value for now
          if (printSerialValue == LOW){
            //Serial.print(roll_rate_allowed1);
            //Serial.print(",\t");
            //Serial.print(abs(gy/131.0));
            //Serial.print(abs(gy*rotationScale));
            //Serial.print(",\t");
          }
            triggerCount1 += 1;
            if (triggerCount1 >= triggerPersistence){ //persistence of 3 cycles
              startPyroCount1 = pyroPersistence; //latch pyro state for 10 cycles
              pyroState1 = 1;
              }

        } else {
          triggerCount1 = 0;
          if (startPyroCount1 > 0){
            startPyroCount1 -=1;
            pyroState1 = 1;
          }
          else{
            pyroState1 = 0;
          }
          if (printSerialValue == LOW){
            //Serial.print(roll_rate_allowed1);
            //Serial.print(",\t");
            //Serial.print(abs(gy/131.0));
            //Serial.print(abs(gy*rotationScale));
            //Serial.print(",\t");
        }

        } 

          if (fireSimultaneous) {
            pyroState2 = pyroState1;
          }
        
          if (printSerialValue == LOW){
            Serial.print(millis());Serial.print(",\t");
            Serial.print(pyroState1);
            Serial.print(",\t");
            Serial.print(pyroState2);
            Serial.print(",\t");
            //Serial.print(startPyroCount1);
            //Serial.print(",\t");
            //Serial.print(relayReadValue1);
            //Serial.println();
            //Serial.print(relayReadValue2);
            //Serial.println();
        }

        // blink LED to indicate activity
        digitalWrite(ledPin, pyroState1);
        if (firePyro) {
          digitalWrite(relayPin1, pyroState1);
          digitalWrite(relayPin2, pyroState2);
        }
        else {
          digitalWrite(relayPin1, 0);
          digitalWrite(relayPin2, 0);
        }

    }
}
