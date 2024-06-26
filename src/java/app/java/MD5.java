/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package app.java;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 *
 * @author Sadew
 */
public class MD5 {
    
    public static String getMD5(String input){
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            
            byte[] messageDigest = md.digest(input.getBytes());
            
            BigInteger no = new BigInteger(1,messageDigest);
            
            String hashtext = no.toString(16);
            while(hashtext.length()<32){
                hashtext = "0" + hashtext;
            }
            
            return hashtext;
            
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
           
            
        }
    }
    
    
}
