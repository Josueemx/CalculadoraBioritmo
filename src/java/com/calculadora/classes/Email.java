/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calculadora.classes;

import java.io.UnsupportedEncodingException;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author Morales
 */
public class Email {
    
    private final String Username = "cuentafalsadejosue@gmail.com";
    private final String Password = "megustaelcafe";
    public Person person;
    private final String host = "smtp.gmail.com";
    
    public Email(Person Person) {
        this.person = Person;
    }
    
    public Person getPerson() {
        return person;
    }

    public void setPerson(Person Person) {
        this.person = Person;
    }
    
    public void send() throws MessagingException, UnsupportedEncodingException{
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", "587");
        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(Username, Password);
            }
        });
        Message message = new MimeMessage(session);
        message.setHeader("Content-Type", "text/html; charset=UTF-8");
        message.setFrom(new InternetAddress(Username, "Calculadora Bioritmo"));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(person.getEmail()));
        message.setSubject("Cuenta de Calculadora Biorritmo");
        message.setContent(
                "<!DOCTYPE html>" +
                "<html>" +
                "<head>" +  
                    "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">" +
                    "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">" +
                    "<link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css\">" +
                    "<script src=\"https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js\"></script>" +
                    "<script src=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js\"></script>" +
                "</head>" +
                "<body>"+
                "<h1>¡Gracias "+person.getName()+"!</h1>" +
                "<br>"+
                "<p>Tu cuenta se ha creado exitosamente.</p>" +
                "<p><span style=\"font-weight: bold;\">Usuario: </span> "+person.getEmail()+"</p>" +
                "<p><span style=\"font-weight: bold;\">Contraseña: </span> "+person.getPassword()+"</p>" +
                /*"<table class=\"table table-bordered\">" +
                    "<tbody>" +
                        "<tr>" +
                            "<td>Cumpleaños</td>" +
                            "<td>" +
                                person.getBirthday() +
                            "</td>" +
                        "</tr>"+
                        "<tr>" +
                            "<td>Fecha fin" +
                            "<td>" +
                                person.getBio().getFinal_daystr() +
                            "</td>" +
                        "</tr>"+
                        "<tr>" +
                            "<td>Dias vividos a la fecha de calculo</td>" +
                            "<td>" +
                                person.getBio().getDays() +
                            "</td>" +
                        "</tr>"+
                        "<tr>"+
                            "<td>Dias del Ciclo fisico (23)</td>" +
                            "<td style=\"background: "+person.getBio().getPhysicalColor()+"\">" +
                                person.getBio().getPhysicalCycle() +
                            "</td>" +
                        "</tr>" +
                        "<tr>" +
                            "<td>Dias del Ciclo Emocional (28)</td>" +
                            "<td style=\"background: "+person.getBio().getEmotionalColor()+"\">" +                        
                                person.getBio().getEmotionalCycle() +
                            "</td>" +
                        "</tr>" +
                        "<tr>" +
                            "<td>Dias del Ciclo Intelectual (33)</td>"+
                            "<td style=\"background: "+person.getBio().getIntelectualColor()+"\">" +
                                person.getBio().getIntelectualCycle() +
                            "</td>" +
                        "</tr>" +
                    "</tbody>" +
                "</table>"+*/
                "</body>"+
                "</html>"
                , "text/html; charset=utf-8");
        message.saveChanges();
        Transport.send(message);
    }
    
    
        
    
}
