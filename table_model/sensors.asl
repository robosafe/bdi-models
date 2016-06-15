// Agent sensing in project hri.mas2j

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */
+sense <- -sense[source(robot_code)];.print("sensing"); !getGaze.

+!getGaze : not gaze(_) <- .print("Undefined gaze"); !getGaze.
+!getGaze : gaze(1.0) <- .send(robot_code,tell,gaze(1.0)); !getPressure.
+!getGaze : gaze(0.0) <- .send(robot_code,tell,gaze(0.0)); !getPressure.

+!getPressure : not pressure(_) <- .print("Undefined pressure"); !getPressure.
+!getPressure : pressure(1.0) <- .send(robot_code,tell,pressure(1.0)); !getLocation.
+!getPressure : pressure(0.0) <-.send(robot_code,tell,pressure(0.0)); !getLocation.

+!getLocation : not handpos(_) <- .print("Undefined location"); !getLocation.
+!getLocation : handpos(1.0) <- .send(robot_code,tell,handpos(1.0)); !finish.
+!getLocation : handpos(0.0) <- .send(robot_code,tell,handpos(0.0)); !finish.

+!finish : true <- .send(robot_code,tell,sensorsReady); -gaze(1.0)[source(self)]; -gaze(0.0)[source(self)]; -pressure(1.0)[source(self)];-pressure(0.0)[source(self)];-handpos(1.0)[source(self)]; -handpos(0.0)[source(self)].


