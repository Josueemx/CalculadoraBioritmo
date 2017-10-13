/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calculadora.classes;

import java.io.UnsupportedEncodingException;
import javax.mail.MessagingException;

/**
 *
 * @author Morales
 */
public class Person {
    
    private int ID;
    private String Name;
    private String Email;
    private String Password;
    private String Birthday;
    private Biorritmo Bio;
    
    public Person(){}
    
    public Person(int ID, String Name, String Email, String Birthday, Biorritmo Bio, String Password) {
        this.ID = ID;
        this.Name = Name;
        this.Birthday = Birthday;
        this.Bio = Bio;
        this.Email = Email;
        this.Password = Password;
    }
     
    public void sendEmail() throws MessagingException, UnsupportedEncodingException{
        Email email = new Email(this);
        email.send();
    }
    
    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }
    
    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getName() {
        return Name;
    }

    public void setName(String Name) {
        this.Name = Name;
    }
    
    public String getPassword() {
        return Password;
    }

    public void setPassword(String Password) {
        this.Password = Password;
    }

    public String getBirthday() {
        return Birthday;
    }

    public void setBirthday(String Birthday) {
        this.Birthday = Birthday;
    }
    
    public Biorritmo getBio() {
        return Bio;
    }

    public void setBio(Biorritmo Bio) {
        this.Bio = Bio;
    }
}
