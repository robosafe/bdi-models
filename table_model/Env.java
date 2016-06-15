// Environment code for project timed_hri.mas2j

import jason.asSyntax.*;
import jason.environment.*;
import java.util.logging.*;
import java.util.Random;
import java.io.FileWriter;
import java.io.FileReader;
import java.io.BufferedReader;
import java.io.IOException;
import jason.NoValueException;

public class Env extends Environment {

    private Logger logger = Logger.getLogger("timed_hri.mas2j."+Env.class.getName());
	private Random randomGenerator = new Random();
	private int human_timer= 0;
	private int robot_timer= 0;
	private int gaze = 0;
	private int pressure = 0;
	private int location = 0;
	

    /** Called before the MAS execution with the args informed in .mas2j */
    @Override
    public void init(String[] args) {
    }

	@Override
	public boolean executeAction(String agName, Structure action) {
		/** The robot code's internal actions **/
		if (action.getFunctor().equals("add_time")) {
			try{
				robot_timer = robot_timer + (int)((NumberTerm)action.getTerm(0)).solve();
			}catch(NoValueException e){
			}
			return true;
		} 
		else if (action.getFunctor().equals("check_time")) {
			try{
				int thre = (int)((NumberTerm)action.getTerm(0)).solve();
				if (robot_timer >= thre){	
					addPercept("robot_code",Literal.parseLiteral("timeup"));
				}
			}catch (NoValueException e){
			}
			return true;
		} 
		else if (action.getFunctor().startsWith("coverage_robot")) {
			String th = action.getTerm(0).toString();
			th = th.substring(1, th.length( ) - 1);
			try{
				addPercept("meta",Literal.parseLiteral(action.getTerm(0).toString()));	
				coverage_robot(th);
			} catch (IOException e) {
			}
			return true;
		}
		else if (action.getFunctor().startsWith("reset_time")) {
			robot_timer= 0;
			return true;
		}
/** The human's internal actions **/
		else if (action.getFunctor().equals("add_time_h")) {
			try{
				human_timer = human_timer + (int)((NumberTerm)action.getTerm(0)).solve();
			}catch(NoValueException e){
			}
			return true;
		}
		else if (action.getFunctor().startsWith("tofile")) {
			String th = action.getTerm(0).toString();
			th = th.substring(1, th.length( ) - 1);
			try{
				tofile(th);
			} catch (IOException e) {
			}
			return true;
		}
		else if (action.getFunctor().startsWith("coverage")) {
			String th = action.getTerm(0).toString();
			th = th.substring(1, th.length( ) - 1);
			try{
				addPercept("meta",Literal.parseLiteral(action.getTerm(0).toString()));	
				coverage(th);
			} catch (IOException e) {
			}
			return true;
		}
		else if (action.getFunctor().equals("movehuman000")) {
			positioning(0);
			return true;
		} 
		else if (action.getFunctor().equals("movehuman001")) {
			positioning(1);
			return true;
		} 
		else if (action.getFunctor().equals("movehuman010")) {
			positioning(2);
			return true;
		} 
		else if (action.getFunctor().equals("movehuman011")) {
			positioning(3);
			return true;
		} 
		else if (action.getFunctor().equals("movehuman100")) {
			positioning(4);
			return true;
		} 
		else if (action.getFunctor().equals("movehuman101")) {
			positioning(5);
			return true;
		} 
		else if (action.getFunctor().equals("movehuman110")) {
			positioning(6);
			return true;
		} 
		else if (action.getFunctor().equals("movehuman111")) {
			positioning(7);
			return true;
		} 
		else if (action.getFunctor().equals("check_time_h")) {
			if (human_timer >= 200){
				addPercept("human",Literal.parseLiteral("bored"));	
				} 
			return true;
		} 
		else if (action.getFunctor().equals("reset_time")){
			human_timer = 0;
			return true;
		}
/** The meta internal actions **/
		else if (action.getFunctor().equals("get_beliefs")) {
			try{
				get_beliefs();
			} catch (IOException e){
			}
			return true;
		}
		else {	
			logger.info("executing: "+action+", but not implemented!");
			return false;
		}
    }
	
	void positioning(int code){
		int randomIntLoc = randomGenerator.nextInt(100);
		if (code == 0){
			addPercept("sensors",Literal.parseLiteral("handpos(0.0)"));
			addPercept("sensors",Literal.parseLiteral("pressure(0.0)"));
			addPercept("sensors",Literal.parseLiteral("gaze(0.0)"));
			try{
				tofile("set_param location = 0"); 
				tofile("set_param pressure = 0");
				tofile("set_param gaze = 0"); 
			} catch (IOException e) {
			}
		}
		if (code == 1) {
			addPercept("sensors",Literal.parseLiteral("handpos(1.0)"));
			addPercept("sensors",Literal.parseLiteral("pressure(0.0)"));
			addPercept("sensors",Literal.parseLiteral("gaze(0.0)"));
			try{
				tofile("set_param location = 1"); 
				tofile("set_param pressure = 0");
				tofile("set_param gaze = 0"); 
			} catch (IOException e) {
			}
		}
		if (code == 2) {
			addPercept("sensors",Literal.parseLiteral("handpos(0.0)"));
			addPercept("sensors",Literal.parseLiteral("pressure(1.0)"));
			addPercept("sensors",Literal.parseLiteral("gaze(0.0)"));
			try{
				tofile("set_param location = 0"); 
				tofile("set_param pressure = 1");
				tofile("set_param gaze = 0"); 
			} catch (IOException e) {
			}
		}
		if (code == 3) {
			addPercept("sensors",Literal.parseLiteral("handpos(1.0)"));
			addPercept("sensors",Literal.parseLiteral("pressure(1.0)"));
			addPercept("sensors",Literal.parseLiteral("gaze(0.0)"));
			try{
				tofile("set_param location = 1"); 
				tofile("set_param pressure = 1");
				tofile("set_param gaze = 0"); 
			} catch (IOException e) {
			}
		}
		if (code == 4) {
			addPercept("sensors",Literal.parseLiteral("handpos(0.0)"));
			addPercept("sensors",Literal.parseLiteral("pressure(0.0)"));
			addPercept("sensors",Literal.parseLiteral("gaze(1.0)"));
			try{
				tofile("set_param location = 0"); 
				tofile("set_param pressure = 0");
				tofile("set_param gaze = 1"); 
			} catch (IOException e) {
			}
		}
		if (code == 5) {
			addPercept("sensors",Literal.parseLiteral("handpos(1.0)"));
			addPercept("sensors",Literal.parseLiteral("pressure(0.0)"));
			addPercept("sensors",Literal.parseLiteral("gaze(1.0)"));
			try{
				tofile("set_param location = 1"); 
				tofile("set_param pressure = 0");
				tofile("set_param gaze = 1"); 
			} catch (IOException e) {
			}
		}
		if (code == 6) {
			addPercept("sensors",Literal.parseLiteral("handpos(0.0)"));
			addPercept("sensors",Literal.parseLiteral("pressure(1.0)"));
			addPercept("sensors",Literal.parseLiteral("gaze(1.0)"));
			try{
				tofile("set_param location = 0"); 
				tofile("set_param pressure = 1");
				tofile("set_param gaze = 1"); 
			} catch (IOException e) {
			}
		}
		if (code == 7) {
			addPercept("sensors",Literal.parseLiteral("handpos(1.0)"));
			addPercept("sensors",Literal.parseLiteral("pressure(1.0)"));
			addPercept("sensors",Literal.parseLiteral("gaze(1.0)"));
			try{
				tofile("set_param location = 1"); 
				tofile("set_param pressure = 1");
				tofile("set_param gaze = 1"); 
			} catch (IOException e) {
			}
		}
	}
	
//	void sensing(){
//		int randomIntG = randomGenerator.nextInt(100);
//		int randomIntP = randomGenerator.nextInt(100);
//		int randomIntL = randomGenerator.nextInt(100);
//		if (location == 0 & randomIntL <= 5){
//			addPercept("robot",Literal.parseLiteral("handpos(1.0)"));
//		}
//		else if (location == 1 & randomIntL <= 5){
//			addPercept("robot",Literal.parseLiteral("handpos(0.0)"));
//		}
//		else if (pressure == 0 & randomIntP <= 5){
//			addPercept("robot",Literal.parseLiteral("pressure(1.0)"));	
//		}
//		else if (pressure == 1 & randomIntP <= 5){
//			addPercept("robot",Literal.parseLiteral("pressure(0.0)"));	
//		}
//		else if (gaze == 0 & randomIntG <= 5){
//			addPercept("robot",Literal.parseLiteral("gaze(1.0)"));	
//		}
//		else if (gaze == 1 & randomIntG <= 5){
//			addPercept("robot",Literal.parseLiteral("gaze(0.0)"));	
//		}
//		addPercept("robot",Literal.parseLiteral("sensing(true)"));	
//	}
	
	void tofile(String str) throws IOException {
		FileWriter fw = new FileWriter("output.txt",true);
		
		fw.write(str+"\n");
		fw.close();
	}
	
	void coverage(String str) throws IOException {
		FileWriter fw = new FileWriter("coverage.txt",true);
		
		fw.write(str+"\n");
		fw.close();
	}
	void coverage_robot(String str) throws IOException {
		FileWriter fw = new FileWriter("coverage_robot.txt",true);
		
		fw.write(str+"\n");
		fw.close();
	}
	void get_beliefs() throws IOException {
		try(BufferedReader br = new BufferedReader(new FileReader("meta_orders.txt"))) {
			for(String line; (line = br.readLine()) != null; ) {
				if (line != ""){
					addPercept("human",Literal.parseLiteral(line));
				}
			}
		}catch (IOException e) {
		}
	}

    /** Called before the end of MAS execution */
    @Override
    public void stop() {
        super.stop();
    }
}

