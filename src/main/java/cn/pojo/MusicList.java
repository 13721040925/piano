package cn.pojo;

import java.io.Serializable;

import org.springframework.stereotype.Component;

@Component("musicList")
public class MusicList implements Serializable {
	private static final long serialVersionUID = -8423176500942274562L;
	private Integer id;
	private String title;
	private String content;

	public MusicList() {
	}

	public MusicList(Integer id, String title, String content) {
		this.id = id;
		this.title = title;
		this.content = content;
	}

	public MusicList(String title, String content) {
		this.title = title;
		this.content = content;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Override
	public String toString() {
		return "MusicList [id=" + id + ", title=" + title + ", content=" + content + "]";
	}

}
