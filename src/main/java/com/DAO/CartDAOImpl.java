package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.Entity.Cart;

public class CartDAOImpl implements CartDAO {
    private Connection connection;

    public CartDAOImpl(Connection connection) {
        this.connection = connection;
    }

    @Override
    public boolean addCart(Cart c) {
        boolean f = false;
        String sql = "INSERT INTO cart(bid, uid, bookName, author, price, total_price) VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, c.getBid());
            ps.setInt(2, c.getUserId());
            ps.setString(3, c.getBookName());
            ps.setString(4, c.getAuthor());
            ps.setString(5, c.getPrice()); 
            ps.setString(6, c.getTotalPrice()); // Assuming totalPrice is a double

            int i = ps.executeUpdate();
            if(i == 1) {
            	f=true;
            }
        } catch (Exception e) {
           
            e.printStackTrace(); 
        }

        return f;
    }

	@Override
	public List<Cart> getBookByUser(int userId) {
		List<Cart> cartList = new ArrayList<>();
        String totalPrice = null;  // Using double for summing prices

        try {
            String sql = "SELECT * FROM cart WHERE uid=?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Cart c = new Cart();
                c.setCid(rs.getInt(1));
                c.setBid(rs.getInt(2));
                c.setUserId(rs.getInt(3));
                c.setBookName(rs.getString(4));
                c.setAuthor(rs.getString(5));
                c.setPrice(rs.getString(6)); // Assuming price is stored as a string
                
                // Convert price to double and sum it up
                totalPrice += Double.parseDouble(rs.getString(7));
                
                c.setTotalPrice(String.valueOf(totalPrice));  // Store the total price as a string

                cartList.add(c);  // Add each cart item to the list
            }

        } catch (Exception e) {
            e.printStackTrace(); // Replace with proper logging in production
        }

        return cartList;  // Return the list of cart items
    }

	@Override
	public boolean deleteBookCart(int bid,int uid,int cid) {
	  
		boolean f=false;
		try {
			String sql="delete from cart where bid=? and uid=? and cid=?";
			PreparedStatement ps=connection.prepareStatement(sql);
			ps.setInt(1, bid);
			ps.setInt(2, uid);
			ps.setInt(3, cid);
		   int i=ps.executeUpdate();
		   
		   if(i==1)
		   {
			   f=true;
		   }
		
		}catch( Exception e) {
			e.printStackTrace();
		}
	
		return f;
	}
	
    
}