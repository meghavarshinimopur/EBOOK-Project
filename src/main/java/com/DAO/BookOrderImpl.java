package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.Entity.Book_Order;

public class BookOrderImpl implements BookOrderDAO {

    private Connection connection;  

    public BookOrderImpl(Connection connection) {
        super();
        this.connection = connection;
    }

    
    @Override
    public boolean saveOrder(List<Book_Order> blist) {
        boolean isSaved = false;
        try {
            // SQL query to insert order details into the database
            String sql = "INSERT INTO book_order(order_id, user_name, email, address, phno, book_name, author, price, payment) VALUES(?,?,?,?,?,?,?,?,?)";

            connection.setAutoCommit(false);  // Disable auto-commit to use transaction
            PreparedStatement ps = connection.prepareStatement(sql);

            for (Book_Order b : blist) {
                // Debugging output to check if the data is correctly coming from the objects
                //System.out.println("Saving Order: " + b.getOrderId() + ", Phno: " + b.getPhno() + ", Author: " + b.getAuthor());

                // Ensure valid data is being set
                ps.setString(1, b.getOrderId());
                ps.setString(2, b.getName());
                ps.setString(3, b.getEmail());
                ps.setString(4, b.getFulladd());
                ps.setString(5, b.getPhno());   // Check if the phone number is being set correctly
                ps.setString(6, b.getBookName());
                ps.setString(7, b.getAuthor()); // Check if the author is being set correctly
                ps.setString(8, b.getPrice());
                ps.setString(9, b.getPaymentType());

                ps.addBatch();  // Add the current order to the batch
            }

            // Execute batch update
            ps.executeBatch();
            connection.commit();  // Commit the transaction
            isSaved = true;
        } catch (Exception e) {
            e.printStackTrace();
            try {
                // Rollback in case of any failure during the transaction
                connection.rollback();
            } catch (Exception rollbackEx) {
                rollbackEx.printStackTrace();
            }
        } finally {
            try {
                // Reset the auto-commit back to true
                connection.setAutoCommit(true);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }

        return isSaved;  
    }

    @Override
    public boolean saveOrder(Book_Order b) {
        boolean isSaved = false;
        try {
            // SQL query to insert a single order
            String sql = "INSERT INTO book_order(order_id, user_name, email, address, phno, book_name, author, price, payment) VALUES(?,?,?,?,?,?,?,?,?)";

            PreparedStatement ps = connection.prepareStatement(sql);

            // Debugging output to check if the data is correctly coming from the object
            //System.out.println("Saving Single Order: " + b.getOrderId() + ", Phno: " + b.getPhno() + ", Author: " + b.getAuthor());

            // Ensure valid data is being set
            ps.setString(1, b.getOrderId());
            ps.setString(2, b.getName());
            ps.setString(3, b.getEmail());
            ps.setString(4, b.getFulladd());
            ps.setString(5, b.getPhno());   // Check if the phone number is being set correctly
            ps.setString(6, b.getBookName());
            ps.setString(7, b.getAuthor()); // Check if the author is being set correctly
            ps.setString(8, b.getPrice());
            ps.setString(9, b.getPaymentType());

            int rowsAffected = ps.executeUpdate();  // Execute the insert
            if (rowsAffected > 0) {
                isSaved = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return isSaved;  
    }


	@Override
	public int getOrderNo() {
		// TODO Auto-generated method stub
		return 0;
	}


	@Override
	public List<Book_Order> getBook(String email) {
		List<Book_Order> list=new ArrayList<Book_Order>();
		Book_Order o=null;
		try {
			
			String sql="select * from book_order where email=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,email);
			ResultSet rs=ps.executeQuery();
			while(rs.next())
			{
				o=new Book_Order();
				o.setId(rs.getInt(1));
				o.setOrderId(rs.getString(2));
				o.setName(rs.getString(3));
				o.setEmail(rs.getString(4));
				o.setFulladd(rs.getString(5));
				o.setPhno(rs.getString(6));
				o.setBookName(rs.getString(7));
				o.setAuthor(rs.getString(8));
				o.setPrice(rs.getString(9));
				o.setPaymentType(rs.getString(10));
				list.add(o);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}


	@Override
	public List<Book_Order> getAllOrder() {
		List<Book_Order> list=new ArrayList<Book_Order>();
		Book_Order o=null;
		try {
			
			String sql="select * from book_order";
			PreparedStatement ps = connection.prepareStatement(sql);
		
			ResultSet rs=ps.executeQuery();
			while(rs.next())
			{
				o=new Book_Order();
				o.setId(rs.getInt(1));
				o.setOrderId(rs.getString(2));
				o.setName(rs.getString(3));
				o.setEmail(rs.getString(4));
				o.setFulladd(rs.getString(5));
				o.setPhno(rs.getString(6));
				o.setBookName(rs.getString(7));
				o.setAuthor(rs.getString(8));
				o.setPrice(rs.getString(9));
				o.setPaymentType(rs.getString(10));
				list.add(o);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
		
	
	}


