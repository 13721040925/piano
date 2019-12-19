package cn.service;

import cn.pojo.User;

public interface UserService {
	User checkUserName(String userName);

	User login(User user);

	int update(User user);
}
