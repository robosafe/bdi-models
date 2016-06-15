// Agent environment in project hri.mas2j

/* Initial beliefs and rules */

/* Initial goals */
!setup.

/* Plans */

+!setup : meta <- !activate.
+!setup : true <- !setup.

+!activate : leg1 <- -meta[source(meta)];.print("Leg please"); .send(robot_code,tell,leg); tofile("tell leg"); tofile("receivesignal");coverage("plan1");!waitingLeg.
+!activate : leg2 <- -meta[source(meta)];.print("Leg please"); .send(robot_code,tell,leg); tofile("tell leg"); tofile("receivesignal");coverage("plan2");!waitingLeg.
+!activate : leg3 <- -meta[source(meta)];.print("Leg please"); .send(robot_code,tell,leg); tofile("tell leg"); tofile("receivesignal");coverage("plan3");!waitingLeg.
+!activate : leg4 <- -meta[source(meta)];.print("Leg please"); .send(robot_code,tell,leg); tofile("tell leg"); tofile("receivesignal");coverage("plan4");!waitingLeg.

+!waitingLeg: not legReady & not bored <-.print("Waiting"); coverage("plan5");!waitingLeg.
+!waitingLeg: legReady <- -legReady[source(robot_code)]; coverage("plan6"); !setGPL.
+!waitingLeg: bored <- -bored[source(meta)]; tofile("bored");.print ("I am out for a bit"); coverage("plan7");!waitDiscard.

+!setGPL : true <- .print("Moving"); coverage("plan8"); !chooseMove.

+!chooseMove : m000l1 & leg1 <- movehuman000; -m000l1[source(percept)]; coverage("plan9"); !tellReady.
+!chooseMove : m001l1 & leg1 <- movehuman001; -m000l1[source(percept)]; coverage("plan10"); !tellReady.
+!chooseMove : m010l1 & leg1 <- movehuman010; -m010l1[source(percept)]; coverage("plan11"); !tellReady.
+!chooseMove : m011l1 & leg1 <- movehuman011; -m011l1[source(percept)]; coverage("plan12"); !tellReady.
+!chooseMove : m100l1 & leg1 <- movehuman100; -m100l1[source(percept)]; coverage("plan13"); !tellReady.
+!chooseMove : m101l1 & leg1 <- movehuman101; -m101l1[source(percept)]; coverage("plan14"); !tellReady.
+!chooseMove : m110l1 & leg1 <- movehuman110; -m110l1[source(percept)]; coverage("plan15"); !tellReady.
+!chooseMove : m111l1 & leg1 <- movehuman111; -m111l1[source(percept)]; coverage("plan16"); !tellReady.


+!chooseMove : m000l2 & leg2 <- movehuman000; -m000l2[source(percept)]; coverage("plan17"); !tellReady.
+!chooseMove : m001l2 & leg2 <- movehuman001; -m001l2[source(percept)]; coverage("plan18"); !tellReady.
+!chooseMove : m010l2 & leg2 <- movehuman010; -m010l2[source(percept)]; coverage("plan19"); !tellReady.
+!chooseMove : m011l2 & leg2 <- movehuman011; -m011l2[source(percept)]; coverage("plan20"); !tellReady.
+!chooseMove : m100l2 & leg2 <- movehuman100; -m100l2[source(percept)]; coverage("plan21"); !tellReady.
+!chooseMove : m101l2 & leg2 <- movehuman101; -m101l2[source(percept)]; coverage("plan22"); !tellReady.
+!chooseMove : m110l2 & leg2 <- movehuman110; -m110l2[source(percept)]; coverage("plan23"); !tellReady.
+!chooseMove : m111l2 & leg2 <- movehuman111; -m111l2[source(percept)]; coverage("plan24"); !tellReady.


+!chooseMove : m000l3 & leg3 <- movehuman000; -m000l3[source(percept)]; coverage("plan25"); !tellReady.
+!chooseMove : m001l3 & leg3 <- movehuman001; -m001l3[source(percept)]; coverage("plan26"); !tellReady.
+!chooseMove : m010l3 & leg3 <- movehuman010; -m010l3[source(percept)]; coverage("plan27"); !tellReady.
+!chooseMove : m011l3 & leg3 <- movehuman011; -m011l3[source(percept)]; coverage("plan28"); !tellReady.
+!chooseMove : m100l3 & leg3 <- movehuman100; -m100l3[source(percept)]; coverage("plan29"); !tellReady.
+!chooseMove : m101l3 & leg3 <- movehuman101; -ml01l3[source(percept)]; coverage("plan30"); !tellReady.
+!chooseMove : m110l3 & leg3 <- movehuman110; -m110l3[source(percept)]; coverage("plan31"); !tellReady.
+!chooseMove : m111l3 & leg3 <- movehuman111; -m111l3[source(percept)]; coverage("plan32"); !tellReady.


+!chooseMove : m000l4 & leg4 <- movehuman000; -m000l4[source(percept)]; coverage("plan33"); !tellReady.
+!chooseMove : m001l4 & leg4 <- movehuman001; -m001l4[source(percept)]; coverage("plan34"); !tellReady.
+!chooseMove : m010l4 & leg4 <- movehuman010; -m010l4[source(percept)]; coverage("plan35"); !tellReady.
+!chooseMove : m011l4 & leg4 <- movehuman011; -m011l4[source(percept)]; coverage("plan36"); !tellReady.
+!chooseMove : m100l4 & leg4 <- movehuman100; -m100l4[source(percept)]; coverage("plan37"); !tellReady.
+!chooseMove : m101l4 & leg4 <- movehuman101; -m101l4[source(percept)]; coverage("plan38"); !tellReady.
+!chooseMove : m110l4 & leg4 <- movehuman110; -m110l4[source(percept)]; coverage("plan39"); !tellReady.
+!chooseMove : m111l4 & leg4 <- movehuman111; -m111l4[source(percept)]; coverage("plan40"); !tellReady.


+!tellReady: true <- .send(robot_code,tell,humanReady); tofile("tell humanReady"); coverage("plan41");!waitResult.


+!waitResult : not release & not failure & not sensingError <- coverage("plan42");!waitResult.
+!waitResult : failure | sensingError <- -failure[source(robot_code)]; -sensingError[source(robot_code)]; coverage("plan43");!countLegs.
+!waitResult : release <- -release[source(robot_code)];.print("Got leg"); coverage("plan44");!countLegs.

+!waitDiscard : discarded <--discarded[source(robot_code)];!countLegs.
+!waitDiscard : not discarded <-!waitDiscard.

+!countLegs : leg1 <- -leg1[source(percept)]; +leg2;coverage("plan45");!activate.
+!countLegs : leg2 <- -leg2[source(percept)]; -leg2[source(self)];+leg3;coverage("plan46");!activate.
+!countLegs : leg3 <- -leg3[source(percept)]; -leg3[source(self)];+leg4;coverage("plan47");!activate.
+!countLegs : leg4 <- -leg4[source(percept)]; -leg4[source(self)]; coverage("plan48"); tofile("--------------------"); coverage("--------------------").

