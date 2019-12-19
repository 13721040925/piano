package cn.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import cn.mapper.UserMapper;
import cn.pojo.User;

@Service("userService")
@Transactional(propagation = Propagation.REQUIRED, timeout = -1)
public class UserServiceImpl implements UserService {
	@Resource
	private UserMapper mapper;

	@Override
	public User checkUserName(String userName) {
		// TODO 自动生成的方法存根
		return mapper.checkUserName(userName);
	}

	@Override
	public User login(User user) {
		// TODO 自动生成的方法存根
		return mapper.login(user);
	}

	@Override
	public int update(User user) {
		// TODO 自动生成的方法存根
		return mapper.update(user);
	}

}
