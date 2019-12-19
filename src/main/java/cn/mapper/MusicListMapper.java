package cn.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import cn.pojo.MusicList;

public interface MusicListMapper {
	@Select(" select * from musiclist ")
	List<MusicList> getMusicListLimit();

	@Insert(" insert into musiclist (title,content) values (#{title},#{content}) ")
	int addMusic(MusicList musicList);
}
