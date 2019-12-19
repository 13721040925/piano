package cn.pojo;

import java.io.Serializable;

import org.springframework.stereotype.Component;

@Component("user")
public class User implements Serializable {
	private static final long serialVersionUID = -2266296016354842224L;
	private Integer id;
	private String userName;
	private String passWord;
	private String phone;
	private Integer status;

	public User() {
	}

	public User(Integer id, String userName, String passWord, String phone, Integer status) {
		this.id = id;
		this.userName = userName;
		this.passWord = passWord;
		this.phone = phone;
		this.status = status;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassWord() {
		return passWord;
	}

	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", userName=" + userName + ", passWord=" + passWord + ", phone=" + phone + ", status="
				+ status + "]";
	}

}
