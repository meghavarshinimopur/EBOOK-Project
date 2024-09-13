package com.DAO;

import java.util.List;

import com.Entity.BookDtls;

public interface BookDAO {

	public boolean addBook(BookDtls b);
	
	public List<BookDtls> getAllBooks();

	List<BookDtls> getBooksByCategoryAndStatus(String category, String status);
	
	public BookDtls getBookById(int id);
	
	public boolean updateEditBooks(BookDtls book);
	public boolean deleteBook(int id);
	
	List<BookDtls> getBookByOld(String  email, String  cate);
	public boolean OldDeleteBook(String  email, String  cat, int bid);
	
public 	List<BookDtls> getBookBySearch(String ch);
}

