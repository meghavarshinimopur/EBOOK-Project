package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.Entity.BookDtls;

public class BookDAOImpl implements BookDAO {

	private Connection connection;

	public BookDAOImpl(Connection connection) {
		super();
		this.connection = connection;
	}

	@Override
	public boolean addBook(BookDtls b) {
		boolean result = false;
		String sql = "INSERT INTO addbook (bookName, author, price, bookCategory, status, photo, user_email) VALUES (?, ?, ?, ?, ?, ?, ?)";
		try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
			pstmt.setString(1, b.getBookName());
			pstmt.setString(2, b.getAuthor());
			pstmt.setString(3, b.getPrice()); // Set price as DOUBLE
			pstmt.setString(4, b.getBookCategory());
			pstmt.setString(5, b.getStatus());
			pstmt.setString(6, b.getPhotoName()); // Set image data as STRING (assuming URL or path)
			pstmt.setString(7, b.getEmail());

			int rowsAffected = pstmt.executeUpdate();
			result = (rowsAffected > 0);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<BookDtls> getAllBooks() {
		List<BookDtls> list = new ArrayList<>();
		String sql = "SELECT * FROM addbook";

		try (PreparedStatement ps = connection.prepareStatement(sql)) {
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				BookDtls b = new BookDtls();
				b.setBookId(rs.getInt("bookId"));
				b.setBookName(rs.getString("bookName"));
				b.setAuthor(rs.getString("author"));
				b.setPrice(rs.getString("price")); // Use getDouble for price if stored as DOUBLE
				b.setBookCategory(rs.getString("bookCategory"));
				b.setStatus(rs.getString("status"));
				b.setPhotoName(rs.getString("photo"));
				b.setEmail(rs.getString("user_email"));

				list.add(b);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}

	// New method to get books by category and status
	@Override
	public List<BookDtls> getBooksByCategoryAndStatus(String category, String status) {
		List<BookDtls> list = new ArrayList<>();
		String sql = "SELECT * FROM addbook WHERE bookCategory = ? AND status = ?";

		try (PreparedStatement ps = connection.prepareStatement(sql)) {
			ps.setString(1, category);
			ps.setString(2, status);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				BookDtls b = new BookDtls();
				b.setBookId(rs.getInt("bookId"));
				b.setBookName(rs.getString("bookName"));
				b.setAuthor(rs.getString("author"));
				b.setPrice(rs.getString("price")); // Use getDouble for price if stored as DOUBLE
				b.setBookCategory(rs.getString("bookCategory"));
				b.setStatus(rs.getString("status"));
				b.setPhotoName(rs.getString("photo"));
				b.setEmail(rs.getString("user_email"));

				list.add(b);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public BookDtls getBookById(int id) {
		BookDtls book = null;
		try {
			// Update the query to match your actual table name and column names
			String sql = "SELECT * FROM addbook WHERE bookId=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				book = new BookDtls();
				book.setBookId(rs.getInt("bookId")); // Use column names if possible
				book.setBookName(rs.getString("bookName"));
				book.setAuthor(rs.getString("author"));
				book.setPrice(rs.getString("price"));
				book.setBookCategory(rs.getString("bookCategory"));
				book.setStatus(rs.getString("status"));
				book.setPhotoName(rs.getString("photo"));
				book.setEmail(rs.getString("user_email"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return book;
	}

	@Override
	public boolean updateEditBooks(BookDtls book) {

		boolean f = false;
		try {

			String sql = "UPDATE addbook SET bookName = ?, author = ?, price = ?, status = ? WHERE bookId = ?";

			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, book.getBookName());
			ps.setString(2, book.getAuthor());
			ps.setString(3, book.getPrice());
			ps.setString(4, book.getStatus());
			ps.setInt(5, book.getBookId());

			// Execute the update
			int rowsUpdated = ps.executeUpdate();

			// If the update was successful, set f to true
			if (rowsUpdated > 0) {
				f = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	@Override
	public boolean deleteBook(int id) {
		boolean f = false; // Default to false

		try {
			// Prepare the SQL DELETE statement
			String sql = "DELETE FROM addbook WHERE bookId = ?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, id);

			// Execute the delete operation
			int i = ps.executeUpdate();

			// Check if the deletion was successful
			if (i == 1) {
				f = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return f; // Return the result
	}

	@Override
	public List<BookDtls> getBookByOld(String email, String cate) {

		List<BookDtls> list = new ArrayList<BookDtls>();
		BookDtls b = null;
		try {
			String sql = "select * from addbook where bookCategory=? and user_email=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, cate);
			ps.setString(2, email);
			

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				b = new BookDtls();
				b.setBookId(rs.getInt("bookId"));
				b.setBookName(rs.getString("bookName"));
				b.setAuthor(rs.getString("author"));
				b.setPrice(rs.getString("price")); // Use getDouble for price if stored as DOUBLE
				b.setBookCategory(rs.getString("bookCategory"));
				b.setStatus(rs.getString("status"));
				b.setPhotoName(rs.getString("photo"));
				b.setEmail(rs.getString("user_email"));

				list.add(b);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public boolean OldDeleteBook(String email, String cat , int bid) {
		boolean f =false;
		try {
			String sql="delete from addbook where bookCategory=? and user_email=? and bookId=?";
			PreparedStatement ps=connection.prepareStatement(sql);
			ps.setString(1, cat);
			ps.setString(2, email);
			ps.setInt(3, bid);
			
			int i=ps.executeUpdate();
			if (i==1) {
				f=true;
			}
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	
		
		return f;
	}

	@Override
	public List<BookDtls> getBookBySearch(String ch) {

		List<BookDtls> list = new ArrayList<BookDtls>();
		BookDtls b = null;
		try {
			String sql = "select * from addbook where bookname like ? or author like ? or bookCategory like ? and status=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, "%"+ch+"%");
			ps.setString(2, "%"+ch+"%");
			ps.setString(3, "%"+ch+"%");
			ps.setString(4, "Active");

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				b = new BookDtls();
				b.setBookId(rs.getInt("bookId"));
				b.setBookName(rs.getString("bookName"));
				b.setAuthor(rs.getString("author"));
				b.setPrice(rs.getString("price")); // Use getDouble for price if stored as DOUBLE
				b.setBookCategory(rs.getString("bookCategory"));
				b.setStatus(rs.getString("status"));
				b.setPhotoName(rs.getString("photo"));
				b.setEmail(rs.getString("user_email"));

				list.add(b);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	

}
