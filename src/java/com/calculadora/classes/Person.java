/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calculadora.classes;

/**
 *
 * @author Morales
 */
public class Person {
    
    private int ID;
    private String Name;
    private String Birthday;
    private Biorritmo Bio;
    
    public Person(int ID, String Name, String Birthday, Biorritmo Bio) {
        this.ID = ID;
        this.Name = Name;
        this.Birthday = Birthday;
        this.Bio = Bio;
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
