package cn.controller;

import java.util.List;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.github.qcloudsms.SmsSingleSender;
import com.github.qcloudsms.SmsSingleSenderResult;

import cn.pojo.MusicList;
import cn.pojo.User;
import cn.service.MusicListService;
import cn.service.UserService;

@Controller
@RequestMapping("/music")
public class MainController {
	@Resource
	private MusicListService musicListService;
	@Resource
	private UserService userService;

	@RequestMapping("/welcome")
	public ModelAndView userList(ModelAndView md) {
		List<MusicList> list = musicListService.getMusicListLimit();
		md.addObject("list", list);
		md.setViewName("welcome");// 转发
		return md;
	}

	@RequestMapping("/login")
	public String login() {
		return "redirect:/jsp/login.jsp";
	}

	@RequestMapping(value = "/checkUser", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String checkUser(String userName) {
		User user = userService.checkUserName(userName);
		if (user != null) {
			return JSON.toJSONString("ok");
		}
		return JSON.toJSONString("no");
	}

	@RequestMapping("/doLogin")
	public Object doLogin(User user, Model mod, ModelAndView md, HttpServletRequest request) {
		user = userService.login(user);
		HttpSession session = request.getSession();
		if (user != null) {
			mod.addAttribute("USER_LOGIN", user);
			session.setAttribute("USER_LOGIN", user);
			List<MusicList> list = musicListService.getMusicListLimit();
			md.addObject("list", list);
			md.setViewName("welcome");// 转发
			return md;
		}
		session.setAttribute("ERROR", "错误的用户名或密码");
		return "redirect:/jsp/login.jsp";// 不是逻辑视图名
	}

	@RequestMapping("/logOut")
	public Object logOut(HttpSession session) {
		session.invalidate();
		return "redirect:welcome";// 不是逻辑视图名
	}

	@RequestMapping(value = "/addMusic", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String addMusic(String title, String content) {
		System.out.println(title + "," + content);
		MusicList musicList = new MusicList(title, content);
		int i = musicListService.addMusic(musicList);
		if (i > 0) {
			return JSON.toJSONString("ok");
		}
		return JSON.toJSONString("no");
	}

	@RequestMapping("/toAdd")
	public String toAdd() {
		return "add";
	}

	@RequestMapping("/toupdatepass")
	public String toupdatepass() {
		return "updatepass";
	}

	@RequestMapping("/userUpdate")
	public String userUpdate(User user, HttpServletRequest request) {
		int i = userService.update(user);
		HttpSession session = request.getSession();
		if (i > 0) {
			session.setAttribute("result", "修改成功!");
		} else {
			session.setAttribute("result", "修改失败!");
		}
		return "updatepass";// 不是逻辑视图名
	}

	@RequestMapping("/upSuccess")
	public Object upSuccess(HttpSession session) {
		session.invalidate();
		return "redirect:/jsp/login.jsp";// 不是逻辑视图名
	}

	@RequestMapping(value = "/sendSms", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String sendSms(HttpServletRequest request, HttpServletResponse response, String phone) {
		// try {
		// JSONObject json = null;
		// // 生成6位验证码
		// String verifyCode = String.valueOf(new Random().nextInt(899999) + 100000);
		// System.out.println("验证码是:" + verifyCode);
		// // 发送短信
		// ZhenziSmsClient client = new
		// ZhenziSmsClient("https://sms_developer.zhenzikj.com", "100243",
		// "ZmFkYTQ2ODQtODMxYi00MTlkLTk5ZWUtY2M1MjhjNTlmYTIx");
		// String result = client.send(phone, "您的验证码为:" + verifyCode +
		// "，该码有效期为5分钟，该码只能使用一次！【短信签名】");
		// // System.out.println(result+"1");
		// json = JSONObject.parseObject(result);//
		// System.out.println(json + "---------");
		// // System.out.println(json.getIntValue("code"));
		// if (json.getIntValue("code") != 0) {// 发送短信失败
		// return null;
		// }
		// // 将验证码存到session中,同时存入创建时间
		// // 以json存放，这里使用的是阿里的fastjson
		// HttpSession session = request.getSession();
		// json = new JSONObject();
		// json.put("verifyCode", verifyCode);
		// json.put("createTime", System.currentTimeMillis());
		// /* String str=JSON.stringify(json); */
		// // 将认证码存入SESSION
		// session.setAttribute("verifyCode", json);
		// System.out.println(json);// 验证码，和发送的时间(createTime)
		// return JSON.toJSONString(json);
		// } catch (Exception e) {
		// e.printStackTrace();
		// }

		try {
			JSONObject json = null;
			String verifyCode = String.valueOf(new Random().nextInt(899999) + 100000);
			SmsSingleSender ssender = new SmsSingleSender(1400176976, "dce1cef81fe79d900167fe528a6c616a");
			SmsSingleSenderResult result = ssender.send(0, "86", phone,
					"【来自冰山的贪吃蛇】您的验证码是: " + verifyCode + "，该码有效期为5分钟，该码只能使用一次！如非本人操作，请忽略本短信。", "", "");
			json = JSONObject.parseObject(result.toString());//
			if (json.getIntValue("code") != 0) {// 发送短信失败
				return null;
			}
			HttpSession session = request.getSession();
			json = new JSONObject();
			json.put("verifyCode", verifyCode);
			json.put("createTime", System.currentTimeMillis());
			session.setAttribute("verifyCode", json);
			System.out.println(json);// 验证码，和发送的时间(createTime)
			return JSON.toJSONString(json);
		} catch (Exception e) {
			// HTTP响应码错误
			e.printStackTrace();
		}
		return null;
	}
}
