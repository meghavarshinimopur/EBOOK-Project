package com.DAO;


import java.util.List;

import com.Entity.Cart;

public interface CartDAO {
	
 public boolean addCart(Cart c);
 
 public List<Cart> getBookByUser(int userId);
 public boolean deleteBookCart(int bid,int uid,int cid);
 
 
}