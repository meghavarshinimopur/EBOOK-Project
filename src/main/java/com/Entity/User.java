package com.Entity;

public class User {
	 private int id; // Since id is an integer and auto-incremented
	    private String name;
	    private String email;
	    private String phno;
	    private String password;
	    private String cpassword;
	    private String address;
	    private String landmark;
	    private String city;
	    private String state;
	    private String pincode;
	    private String profileImage; // Add this field

	    // Other existing fields and methods...

	  

	    public String getProfileImage() { return profileImage; }
	    public void setProfileImage(String profileImage) { this.profileImage = profileImage; }
	
	    // Other getters and setters...
	
		public int getId() {
			return id;
		}
		public void setId(int id) {
			this.id = id;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public String getEmail() {
			return email;
		}
		public void setEmail(String email) {
			this.email = email;
		}
		public String getPhno() {
			return phno;
		}
		public void setPhno(String phno) {
			this.phno = phno;
		}
		public String getPassword() {
			return password;
		}
		public void setPassword(String password) {
			this.password = password;
		}
		public String getCpassword() {
			return cpassword;
		}
		public void setCpassword(String cpassword) {
			this.cpassword = cpassword;
		}
		public String getAddress() {
			return address;
		}
		public void setAddress(String address) {
			this.address = address;
		}
		public String getLandmark() {
			return landmark;
		}
		public void setLandmark(String landmark) {
			this.landmark = landmark;
		}
		public String getCity() {
			return city;
		}
		public void setCity(String city) {
			this.city = city;
		}
		public String getState() {
			return state;
		}
		public void setState(String state) {
			this.state = state;
		}
		public String getPincode() {
			return pincode;
		}
		public void setPincode(String pincode) {
			this.pincode = pincode;
		}
		public User() {
			super();
			// TODO Auto-generated constructor stub
		}
		@Override
		public String toString() {
			return "User [id=" + id + ", name=" + name + ", email=" + email + ", phno=" + phno + ", password="
					+ password + ", cpassword=" + cpassword + ", address=" + address + ", landmark=" + landmark
					+ ", city=" + city + ", state=" + state + ", pincode=" + pincode + "]";
		}

	    
}
