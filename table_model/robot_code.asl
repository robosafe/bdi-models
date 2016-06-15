// Agent robot_model in project hri.mas2j

/* Initial beliefs and rules */

/* Initial goals */
!reset.

/* Plans */

+!reset :  true <- add_time(20);.print("Robot is resetting"); coverage_robot("p1");!waiting.

+!waiting : not leg <- .print("Waiting"); !waiting.
+!waiting : leg <- add_time(40);.print("You asked for leg");coverage_robot("p2"); -leg[source(human)]; !grabLeg.

+!grabLeg : true <- add_time(100);.print("Grabbed object"); coverage_robot("p3");!tellReady.

//+!tellReady : true <- add_time(20);.print("Leg is ready");coverage_robot("sent signal");!waitReady.
+!tellReady : true <- add_time(20);.print("Leg is ready");.send(human,tell,legReady); coverage_robot("p4");!waitReady. 

+!waitReady : not humanReady & not timeup <- check_time(400);add_time(1);.print("Waiting"); !waitReady.
+!waitReady : humanReady <- -humanReady[source(human)];.print("Got it");coverage_robot("p5");!readSensors.
+!waitReady : not humanReady & timeup <- -timeup; reset_time; .print("Timed out"); .send(human,tell,failure); coverage_robot("p6");!discardLeg.

+!readSensors : not sensorsReady & not timeup<- check_time(600);add_time(1); .send(sensors,tell,sense);!readSensors.
//+!readSensors : timeup <- .print("Timed out"); coverage_robot("timed out 2");!discardLeg.
+!readSensors : timeup <- -timeup; reset_time; .print("Timed out");.send(human,tell,sensingError); coverage_robot("p7");!discardLeg.
+!readSensors : sensorsReady <- -sensorsReady[source(sensors)];.print("Sensed completed"); coverage_robot("p8");!decision.

//+!decision : not handpos(1.0) | not pressure(1.0) | not gaze(1.0) <- .print ("Not released"); coverage_robot("decision no");!discardLeg.
+!decision : not handpos(1.0) | not pressure(1.0) | not gaze(1.0) <- -handpos(_); -pressure(_); -gaze(_);.print ("Not released"); .send(human,tell,failure); coverage_robot("p9");!discardLeg. 
//+!decision : handpos(1.0) & pressure(1.0) & gaze(1.0) <- .print("Released"); coverage_robot("decision yes");!legdone.
+!decision : handpos(1.0) & pressure(1.0) & gaze(1.0) <- -handpos(_); -pressure(_); -gaze(_);.print("Released"); .send(human,tell,release); coverage_robot("p10");!legdone.

+!legdone : true <- coverage_robot("p11");!waiting.

+!discardLeg : true <- coverage_robot("p12");!legdone.
