package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.Entity.User;

public class UserDAOImpl implements UserDAO { // Removed 'abstract' to make it instantiable

    private Connection connection;

    public UserDAOImpl(Connection connection) {
        this.connection = connection;
    }

    @Override
	public boolean userRegister(User us) {
        boolean f = false;

        try {
            // Check if the email is already registered
            if (isEmailRegistered(us.getEmail())) {
                return false; // Email is already registered
            }

            // Prepare the SQL statement
            String sql = "INSERT INTO users(name, email, phno, password, cpassword) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setString(1, us.getName());
            ps.setString(2, us.getEmail());
            ps.setString(3, us.getPhno());
            ps.setString(4, us.getPassword());
            ps.setString(5, us.getCpassword());

            // Execute the statement
            int i = ps.executeUpdate();

            if (i == 1) {
                f = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    @Override
    public User login(String email, String password) {
        User us = null;
        try {
            // Prepare the SQL statement
            String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                us = new User();
                us.setId(rs.getInt("id"));
                us.setName(rs.getString("name"));
                us.setEmail(rs.getString("email"));
                us.setPhno(rs.getString("phno")); // Corrected to match column name in the table
                us.setPassword(rs.getString("password"));
                us.setAddress(rs.getString("address"));
                us.setLandmark(rs.getString("landmark"));
                us.setCity(rs.getString("city"));
                us.setState(rs.getString("state"));
                us.setPincode(rs.getString("pincode"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return us;
    }

    @Override
    public boolean isEmailRegistered(String email) {
        boolean isRegistered = false;

        try {
            // SQL query to check if email exists
            String sql = "SELECT email FROM users WHERE email = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // If a result is returned, the email is already registered
                isRegistered = true;
            }

            rs.close();
            ps.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return isRegistered;
    }

	@Override
	public boolean checkPassword( int id,String ps) {
		   
		
		boolean f=false;
		
		try {
			  
			String sql="select * from users where id=? and password=?";
			PreparedStatement pst = connection.prepareStatement(sql);
			
			pst.setInt(1, id);
            pst.setString(2, ps);
            
            ResultSet rs=pst.executeQuery();
            while(rs.next())
            	f=true;
            {
            	
            }
            
			
		}catch (Exception e) {
            e.printStackTrace();
		}
		return f;
	}

	@Override
	public boolean updateProfile(User us) {
		boolean f=false;
		try {
		 String sql = "update users set name = ?, email=?, phno=? where id=?";
         PreparedStatement ps = connection.prepareStatement(sql);

         ps.setString(1, us.getName());
         ps.setString(2, us.getEmail());
         ps.setString(3, us.getPhno());
         ps.setInt(4,us.getId());

         // Execute the statement
         int i = ps.executeUpdate();

         if (i == 1) {
             f = true;
         }

     } catch (Exception e) {
         e.printStackTrace();
     }
		
		
		return f;
	}
    
}
