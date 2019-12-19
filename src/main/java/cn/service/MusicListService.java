package cn.service;

import java.util.List;

import cn.pojo.MusicList;

public interface MusicListService {
	List<MusicList> getMusicListLimit();

	int addMusic(MusicList musicList);
}
