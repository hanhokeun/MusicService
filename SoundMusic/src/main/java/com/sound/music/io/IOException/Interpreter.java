package com.sound.music.io.IOException;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.InputStreamReader;

public class Interpreter {
	
	public static void service(){
		try{
		   String prg = "import sys\nprint int(sys.argv[1])+int(sys.argv[2])\n";
		   BufferedWriter out = new BufferedWriter(new FileWriter("concert_dataupdate.py"));
		   out.write(prg);
		   out.close();
		   int number1 = 10;
		   int number2 = 32;
	
		   ProcessBuilder pb = new ProcessBuilder("python","concert_dataupdate.py",""+number1,""+number2);
		   Process p = pb.start();
	
		   BufferedReader in = new BufferedReader(new InputStreamReader(p.getInputStream()));
		   int ret = new Integer(in.readLine()).intValue();
		   System.out.println("value is : "+ret);
		}
		catch(Exception e){
			System.out.println(e);
		}
	}
}
