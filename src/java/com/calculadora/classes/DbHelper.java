/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calculadora.classes;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 *
 * @author Morales
 */
public class DbHelper {
    
    
    private Connection conn;
    
    public DbHelper() throws ClassNotFoundException, SQLException{
        startConnection();
    } 
    
    public void startConnection() throws ClassNotFoundException, SQLException{
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Biorritmos", "root", "root");
    }
    
    public List<Person> getAllSheeple() throws SQLException{
        List<Person> list = new ArrayList<Person>();
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM Persona;");
        ResultSet rs = ps.executeQuery();
        while (rs.next())           
            list.add(new Person(rs.getInt(1), rs.getString(2), rs.getString(5), rs.getString(3), new Biorritmo(rs.getString(3), rs.getString(4))));
        rs.close();
        return list;
    }
    
    public void insertPerson(String nombre, String correo, String cumple, String fecha_final) throws SQLException{
        Statement statement = conn.createStatement();
        statement.executeUpdate("INSERT INTO Persona (nombre, email, cumple, dia_final) VALUES ('"+nombre+"','"+correo+"','"+cumple+"','"+fecha_final+"');");
        statement.close();
    }
    
    public void insertPerson(Person person) throws SQLException{
        Statement statement = conn.createStatement();
        statement.executeUpdate("INSERT INTO Persona (nombre, email, cumple, dia_final) VALUES ('"+person.getName()+"','"+person.getEmail()+"','"+person.getBirthday()+"','"+person.getBio().getFinal_daystr()+"');");
        statement.close();
    }
    
    public String deletePersonById(int Id) throws SQLException{
        String name = getPersonById(Id).getName();
        Statement statement = conn.createStatement();
        PreparedStatement preparedStmt = conn.prepareStatement("delete from Persona where id = ?");
        preparedStmt.setInt(1, Id);
        preparedStmt.execute();
        statement.close();
        return name;
    }
    
    public Person updatePersonById(int Id, String nombre, String correo, String cumple, String fecha_final) throws SQLException{
        Person p = new Person(Id, nombre, correo, cumple, new Biorritmo(cumple, fecha_final));
        Statement statement = conn.createStatement();
        PreparedStatement preparedStmt = conn.prepareStatement("UPDATE Persona "
                                                            +  "SET nombre = ?, cumple = ?, dia_final = ?, email = ?"
                                                            +  "WHERE id = ?;");
        preparedStmt.setString(1, nombre);
        preparedStmt.setString(2, cumple);
        preparedStmt.setString(3, fecha_final);
        preparedStmt.setString(4, correo);
        preparedStmt.setInt(5, Id);
        preparedStmt.execute();
        statement.close();
        return p;
    }
    
    public Person getPersonById(int Id) throws SQLException{
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM Persona where id = ?;");
        ps.setInt(1, Id);
        ResultSet rs = ps.executeQuery();
        Person p;
        if(rs.next())
            p = new Person(rs.getInt(1), rs.getString(2), rs.getString(5), rs.getString(3), new Biorritmo(rs.getString(3), rs.getString(4)));
        else
            p = new Person();
        rs.close();
        return p;
    }
    
    
    public void endConnection() throws SQLException{
        conn.close();
    }
    
}
