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
            list.add(new Person(rs.getInt(1), rs.getString(2), rs.getString(3), new Biorritmo(rs.getString(3), rs.getString(4))));
        rs.close();
        return list;
    }
    
    public void insertPerson(String nombre, String cumple, String fecha_final) throws SQLException{
        Statement statement = conn.createStatement();
        statement.executeUpdate("INSERT INTO Persona (nombre, cumple, dia_final) VALUES ('"+nombre+"','"+cumple+"','"+fecha_final+"');");
        statement.close();
    }
    
    public void deletePersonById(int Id) throws SQLException{
        Statement statement = conn.createStatement();
        PreparedStatement preparedStmt = conn.prepareStatement("delete from Persona where id = ?");
        preparedStmt.setInt(1, Id);
        preparedStmt.execute();
        statement.close();
    }
    
    
    public void endConnection() throws SQLException{
        conn.close();
    }
    
}
