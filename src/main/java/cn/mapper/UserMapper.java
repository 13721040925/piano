package cn.mapper;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import cn.pojo.User;

public interface UserMapper {
	@Select(" select * from user where userName=#{userName} ")
	User checkUserName(@Param("userName") String userName);

	@Select(" select * from user where userName = #{userName} and passWord =#{passWord} ")
	User login(User user);

	@Update(" update  user set userName=#{userName},passWord=#{passWord},phone=#{phone} where id=#{id} ")
	int update(User user);
}
