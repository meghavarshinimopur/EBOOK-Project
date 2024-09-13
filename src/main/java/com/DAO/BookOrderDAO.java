package com.DAO;

import java.util.List;

import com.Entity.Book_Order;

public interface BookOrderDAO {

	public int getOrderNo();
	
	public boolean saveOrder(Book_Order b);

	boolean saveOrder(List<Book_Order> b);
	
	public List<Book_Order> getAllOrder();

	List<Book_Order> getBook(String email);
}
