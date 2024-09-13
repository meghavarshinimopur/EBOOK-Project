package com.DAO;

import com.Entity.User;

public interface UserDAO {
	
	public boolean userRegister(User us);
	
	public User login(String email, String password);

	boolean isEmailRegistered(String email);
	public boolean checkPassword(int id,String pst);
	public boolean updateProfile(User us);
}
