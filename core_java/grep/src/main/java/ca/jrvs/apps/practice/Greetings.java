package ca.jrvs.apps.practice;

import java.util.Calendar;
import java.util.Date;
import java.util.Scanner;

public class Greetings {

    public static void main(String[] args) {
        String name = "";
        Scanner in = new Scanner(System.in);
        System.out.println("Enter your name: ");
        name = in.nextLine();
        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        int hours = cal.get(Calendar.HOUR_OF_DAY);

        if(hours < 11)
            System.out.println(   "Good morning, " + name);
        else if (hours <15)
            System.out.println("Good afternoon, " + name);
        else
            System.out.println("Good evening, " + name);

    }
}
