/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calculadora.classes;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
/**
 *
 * @author Morales
 */
public class Biorritmo {

    final DateFormat Format = new SimpleDateFormat("dd/MM/yyyy");
    Date birthday;
    Date final_day;
    
    public Biorritmo(String birthday, String final_day){
        try{
            this.birthday = Format.parse(birthday);
            this.final_day = Format.parse(final_day);
        }
        catch(Exception e){
            System.out.println("No se pudo hacer esta madre.");
            birthday = null;
            final_day = null;
        }
    }
    
    public int getDays(){
        int res = 0;
        double op = Math.floor((final_day.getTime() - birthday.getTime()) / (1000*60*60*24));
        res = (int) op;
        return res;
    }
    
    public int getPhysicalCycle(){
        int res = 0;
        res = getDays()%23;
        return res;
    }
    
    public int getEmotionalCycle(){
        int res = 0;
        res = getDays()%28;
        return res;
    }
    
    public int getIntelectualCycle(){
        int res = 0;
        res = getDays()%33;
        return res;
    }
    
    protected String getColor(double value){
        if(value>=0.5){
            return "green";
        }
        if(value<=-0.5){
            return "red";
        }
        return "yellow";
    }
    
    public String getPhysicalColor(){
        double res = (double) Math.sin(2*Math.PI*getDays()/23);
        return getColor(res);
    }
    
    public String getEmotionalColor(){
        double res = (double) Math.sin(2*Math.PI*getDays()/28);
        return getColor(res);
    }
    
    public String getIntelectualColor(){
        double res = (double) Math.sin(2*Math.PI*getDays()/33);
        return getColor(res);
    }
    
    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public Date getFinal_day() {
        return final_day;
    }

    public void setFinal_day(Date final_day) {
        this.final_day = final_day;
    }    
}
