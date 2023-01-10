#pragma config(Sensor, S1,     ,               sensorEV3_GenericI2C)
//configuring library datatypes
#include "mindsensors-ev3smux.h"
//adding library

void recall_arms();	//brings the drawing arms back to rest position
void configure();	//configure sensors
void motors(float powerA, float powerD); //motor power
void rotate(int powers, char dir);	//robot rotate
void draw(const int dir, const float dist);	//robot draw
void check_turn();	//checks when to turn the robot
void show_diagnostics();	//displays sensor values on EV3 screen
void coordinates(float encoder, int dir); //robot position(updated when turning)
int max_side(const float *array);	//returns the longest side in the room
void draw_shape();	//draws the final shape of the room
void drive_dist(int Dist_cm,int Power);	//robot drives a distance in cm
void proportional_drive();	//keeps the robot aligned with the wall

const int DRIVE_SPEED = 50;	//robot drive speed
const int DRAW_SPEED = 20;	//robot draw speed
const int ROTATE_SPEED = 35;	//robot rotate speed
const int ULTRASONIC_DIST = 10;	//ultrasonic distance when robot hits hall
const int ULTRASONIC_DIST_NO_WALL = 20;	//ultrasonic distance for no walls near robot
const int ULTASONIC_DIST_ERROR = 1;	//value to increase 2nd ultasonic to 0,255 range
const int PROPORTIONAL_DIST = 9;	//distance robot tries to stay away from wall
const float PROPORTIONAL_SENSITIVITY = 3;	//how quickly the robot turns back
const int WHEEL_RADIUS = 2.75;	//wheel radius
const int END_TOLERANCE = 25;	//error value for driving end sequence
const int MAX_SIDES = 7;	//max sides used for array
const int DRAWING_SCALE = 10;	//the the length of the longest side
const int NORTH = 0;
const int EAST = 1;
const int SOUTH = 2;
const int WEST = 3;

float walls[MAX_SIDES];	//length of sides the robot draws
int nesw[MAX_SIDES];	//direction the robot is going for each side (NorthEastSouthWest)
tMSEV3 muxedSensor[3];

int x_pos = 0;	//robot position x
int y_pos = 0;	//robot position y
int side_num = 0;	//side number the robot is driving on
bool left_turn = false;
int direction = 0;
//N:0, E:1, S:2, W:3
//Robot starts at North

tEV3SensorTypeMode typeMode[3] = {touchStateBump, touchStateBump, touchStateBump};
//configuring multiplexer ports

task main()
{
	time1[T1]=0;	//initializing time
	configure();	//initialize sensors

 	motors(DRIVE_SPEED,DRIVE_SPEED);	//start drive sequence

	while(1==1)
	{
		show_diagnostics();
		check_turn();	//checks to see if robot can turn
		proportional_drive(); //keeps robot aligned with the wall

		if((time1[T1]>20000)&&(x_pos<END_TOLERANCE && x_pos>-END_TOLERANCE && y_pos<END_TOLERANCE
				&& y_pos>-END_TOLERANCE))
		{	//if 20s has passed and robot position is between 20 and -20 in x and y direction
			motors(0,0);	//stop robot
			break;	//exit driving loop
		}
	}

	playSound(soundBlip);
	wait1Msec(1000);
	drive_dist(20,DRIVE_SPEED);
	rotate(ROTATE_SPEED,'r');
	drive_dist(20,DRIVE_SPEED);
	wait1Msec(5000);
	draw_shape();	// begins the draw sequence
	recall_arms();	//brings arms back to default position
	wait1Msec(1000);
}



void recall_arms()
{
	bool exit_loop_b = false;	//bool to exit loop when drawing arm reaches touch sensor
	bool exit_loop_c = false;	//bool to exit loop when drawing arm reaches touch sensor
  if (!initSensor(&muxedSensor[0], msensor_S1_1, typeMode[0]))
  	writeDebugStreamLine("initSensor() failed! for msensor_S1_1");
	//if sensor fails to initialize, type message on debug line
  if (!initSensor(&muxedSensor[1], msensor_S1_2, typeMode[1]))
  	writeDebugStreamLine("initSensor() failed! for msensor_S1_2");
	//if sensor fails to initialize, type message on debug line
  if (!initSensor(&muxedSensor[2], msensor_S1_3, typeMode[2]))
  	writeDebugStreamLine("initSensor() failed! for msensor_S1_3");
	//if sensor fails to initialize, type message on debug line
  while (true && (exit_loop_b==false||exit_loop_c==false))
  {	//while true and both exit loops are not true
 		for (int i = 0; i < 3; i++)
 		{	//for each port on multiplexer
			if (!readSensor(&muxedSensor[i]))
				writeDebugStreamLine("readSensor() failed! for %d", i);
			//if multiplexer fails to read, type message on debug line
 			switch(muxedSensor[i].typeMode)
 			{//switch sensor mode
		 		case touchStateBump:
					if(!muxedSensor[i].touch)
					{ //if the sensor if not touched
						(i==0)? motor[motorC] = -DRAW_SPEED: motor[motorB] = DRAW_SPEED;
						//if port is C1 activate motorC, if port is C2 activate motorB
					}
					else
					{	//if the sensor is touched
				  	(i==0)? motor[motorC] = 0: motor[motorB] = 0;
				  	//if port is C1 stop motorC, if port is C2 stop motorB
				  	(i==0)? exit_loop_c = true: exit_loop_b = true;
				  	displayString(6,"%d",exit_loop_b);
				  	displayString(7,"%d",exit_loop_c);
				  	//if port is C1 exit loop C is true, if port is C2 exit loop B is true
					}
		 			break;
		  }
 		}
  	sleep(100);
  	if(exit_loop_b==true&&exit_loop_c==true)
  	{
  		time1[T2]= 0;
  		while(time1[T2]<500)
  		{
  			playSound(soundBeepBeep);
 		 	}
  		SensorValue[S3]=0;
			motor[motorA] = ROTATE_SPEED;
			motor[motorD] = -ROTATE_SPEED;
			while (SensorValue[S3]<180)
			{}
			wait1Msec(1000);
			motor[motorA] = DRIVE_SPEED;
			motor[motorD] = DRIVE_SPEED;
			nMotorEncoder[motorA]=0;
			while (nMotorEncoder[motorA]<10*180/(PI*WHEEL_RADIUS))
			{}
			wait1Msec(1000);
			SensorValue[S3]=0;
			motor[motorA] = -ROTATE_SPEED;
			motor[motorD] = ROTATE_SPEED;
			while (SensorValue[S3]>-90)
			{}
			wait1Msec(1000);
			motor[motorA] = DRIVE_SPEED;
			motor[motorD] = DRIVE_SPEED;
			nMotorEncoder[motorA]=0;
			while (nMotorEncoder[motorA]<10*180/(PI*WHEEL_RADIUS))
			{ }
			stopAllTasks();
  	}
  }
}



void configure()
{
	SensorType[S1] = sensorEV3_Touch;
	wait1Msec(50);
	SensorType[S2] = sensorEV3_Ultrasonic;
  wait1Msec(50);
  SensorType[S2] = sensorEV3_Ultrasonic;
  wait1Msec(50);
	SensorType[S3] = sensorEV3_Gyro;
  wait1Msec(50);
  SensorMode[S3] = modeEV3Gyro_Calibration;
  wait1Msec(100);
  SensorMode[S3] = modeEV3Gyro_RateAndAngle;
  wait1Msec(50);
  SensorType[S4] = sensorEV3_Ultrasonic;
  wait1Msec(50);
  return;
}



void motors(float powerA,float powerD)
{
	motor[motorA] = powerA;
	motor[motorD] = powerD;
	return;
}



void rotate(int powers, char dir)
{
	resetGyro(S3);	//reset the gyro
	coordinates(nMotorEncoder[motorA],direction);
	//stores coordinates when turning the robot
	if(dir == 'l')
	{	//if input dir equals l (left)
		motors(-powers, powers);
		while (SensorValue[S3]>-90)
		{ }	//turn counterclockwise
		direction--;	//update robot direction
		if(direction==-1)
		{	//changes direction from North to West
			direction = WEST;
		}
	}
	else
	{	//if input dir equals r (right)
		motors(powers,-powers);
		while (SensorValue[S3]<90)
		{ }	//turn clockwise
		direction++;	//update robot direction
		if(direction==4)
		{	//changes direction from West to North
			direction = NORTH;
		}
	}
	nMotorEncoder[motorA]=0;	//reset encoder
	motors(0,0);	//stop robot
	return;
}



void draw(const int dir, const float dist)
{
	int pow_b = 0;
	int pow_c = 0;
	int encoder = dist*180/PI*WHEEL_RADIUS;
	//turns the encoder into a cm distance
	nMotorEncoder[motorB]=0;
	//resets the motor encoder for the drawing arm
	if(dir==WEST)
	{	//draw to the left
		pow_b = -DRAW_SPEED;
		pow_c = -DRAW_SPEED;
	}
	else if(dir==EAST)
	{	//draw to the right
		pow_b = DRAW_SPEED;
		pow_c = DRAW_SPEED;
	}
	else if(dir==NORTH)
	{	//draw up
		pow_b = -DRAW_SPEED;
		pow_c = DRAW_SPEED;
	}
	else if(dir==SOUTH)
	{	//draw down
		pow_b = DRAW_SPEED;
		pow_c = -DRAW_SPEED;
	}
	motor[motorB]=pow_b;
	motor[motorC]=pow_c;//powers motors
	while(abs(nMotorEncoder[motorB])<encoder)
	{}
	motor[motorB]=0;
	motor[motorC]=0;//stops motors
	return;
}



void check_turn()
{
	if(SensorValue[S4] < ULTRASONIC_DIST)
	{	//if wall is detected in front of robot
		motors(0,0);	//stop
		wait1Msec(200);
		if(SensorValue[S2]*ULTASONIC_DIST_ERROR < ULTRASONIC_DIST_NO_WALL)
		{	//if wall is detected to the left of the robot
			rotate(ROTATE_SPEED, 'r');
		}	//turn right
		else
		{	//if no wall is detected to the left of the robot
			rotate(ROTATE_SPEED, 'l');
		}	//turn left
		wait1Msec(200);
		motors(DRIVE_SPEED,DRIVE_SPEED);
		//turns on motors after turning
	}
	else if(SensorValue[S2]*ULTASONIC_DIST_ERROR > ULTRASONIC_DIST_NO_WALL && SensorValue[S4]
					> ULTRASONIC_DIST_NO_WALL && left_turn == false)
  {	//if no wall is detected in front of the robot or to the left
  	left_turn = true;
  	motors(DRIVE_SPEED,DRIVE_SPEED);
  	wait1Msec(1200);	//wait for robot to pass the corner
  	motors(0,0);	//stop robot
  	wait1Msec(200);
    rotate(ROTATE_SPEED, 'l');//turn left
    wait1Msec(200);
		motors(DRIVE_SPEED,DRIVE_SPEED);
		wait1Msec(1000);
  }	//continue driving forward
	return;
}



void show_diagnostics()
{
	displayString(1,"X_Pos");
	displayString(2,"%d cm",x_pos);	//display x position
	displayString(5,"Y_Pos");
	displayString(6,"%d cm",y_pos);	//display y position
	displayString(9,"Front Ultrasonic");
	displayString(10,"%d cm",SensorValue[S4]);	//display front ultrasonic
	displayString(13,"Side Ultrasonics");
	displayString(14,"%d cm",SensorValue[S2]);	//display left ultrasonics
	return;
}



void coordinates(float encoder, int dir)
{
	int dist = encoder*PI*WHEEL_RADIUS/180;
	//convert encoder to dist
	nesw[side_num] = dir;	//adds direction to array parallel to side[]
	walls[side_num] = dist;	//adds dist to side array
	if(dir==NORTH)
	{	//if north
		y_pos += dist;
	}	//increase y value
	else if(dir==EAST)
	{	//if east
		x_pos += dist;
	}	//increase x value
	else if(dir==SOUTH)
	{	//if south
		y_pos -= dist;
	}	//decrease y value
	else if(dir==WEST)
	{	//if west
		x_pos -= dist;
	}	//decrease x value
	side_num++;	//increases index to next array value
	return;
}



int max_side(const float *array)
{
	int max = 0;
	for(int index = 0; index < MAX_SIDES; index++)
	{	//compares max to each value in the side array
		if(array[index]>max)
		{	//if the side value is greater than the max side value
			max = array[index];
		}	//max side value equals current side value
	}
	return max;
}	//return max side value



void draw_shape()
{
	//play sound when draw_shape runs
	float scale=0;
	scale=max_side(walls);
	draw(0,7);
	//scale is equal to the value of the max side
	for(int index = 0; index < MAX_SIDES; index++)
	{
	playSound(soundBlip);
	draw(nesw[index],(walls[index]/scale)*DRAWING_SCALE);
	}	//draw each side scalled down
	wait1Msec(1000);
	return;
}



void drive_dist(int Dist_cm,int Power)
{
motors(Power,Power);
nMotorEncoder[motorA]=0;
while (nMotorEncoder[motorA]<Dist_cm*180/(PI*WHEEL_RADIUS))
{ }
motor[motorA]=motor[motorD]=0;
return;
}



void proportional_drive()
{
	float proportional_drive_a = -PROPORTIONAL_SENSITIVITY*(SensorValue[S2]
															- PROPORTIONAL_DIST) + DRIVE_SPEED;
	float proportional_drive_d = PROPORTIONAL_SENSITIVITY*(SensorValue[S2]
															- PROPORTIONAL_DIST)	+ DRIVE_SPEED;
	//the closer to the wall the more the robot drives to the right
	//the further from the wall the robot drives more to the left
	motors(proportional_drive_a,proportional_drive_d);
	return;
}
