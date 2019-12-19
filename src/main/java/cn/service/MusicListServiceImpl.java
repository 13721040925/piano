package cn.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import cn.mapper.MusicListMapper;
import cn.pojo.MusicList;

@Service("musicListService")
@Transactional(propagation = Propagation.REQUIRED, timeout = -1)
public class MusicListServiceImpl implements MusicListService {
	@Resource
	private MusicListMapper mapper;

	@Override
	public List<MusicList> getMusicListLimit() {
		// TODO 自动生成的方法存根
		return mapper.getMusicListLimit();
	}

	@Override
	public int addMusic(MusicList musicList) {
		// TODO 自动生成的方法存根
		return mapper.addMusic(musicList);
	}

}
