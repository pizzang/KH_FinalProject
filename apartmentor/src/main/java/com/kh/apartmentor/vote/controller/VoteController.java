package com.kh.apartmentor.vote.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.apartmentor.common.model.vo.PageInfo;
import com.kh.apartmentor.common.template.Pagination;
import com.kh.apartmentor.notice.model.vo.Notice;
import com.kh.apartmentor.vote.model.service.VoteService;
import com.kh.apartmentor.vote.model.vo.Vote;
import com.kh.apartmentor.vote.model.vo.VoteItem;

@Controller
public class VoteController {
	
	@Autowired
	private VoteService voteService;
	
	@RequestMapping("list.vote")
	public String voteList(@RequestParam(value="cpage", defaultValue="1") int currentPage, Model model) {
		
		PageInfo pi = Pagination.getPageInfo(voteService.selectListCount(), currentPage, 10, 5);
		
		ArrayList<Vote> list = voteService.selectVoteList(pi);
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		
		return "vote/voteList";
	}
	
	@RequestMapping("categoryList.vote")
	public String selectCategoryList(@RequestParam(value="cpage", defaultValue="1")int currentPage, String category, Model model) {
		
		PageInfo pi = Pagination.getPageInfo(voteService.selectCategoryListCount(category), currentPage, 10, 5);
		
		ArrayList<Vote> list = voteService.selectCategoryList(category, pi);
		
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		model.addAttribute("category", category);
		
		
		return "vote/voteList";
		
	}
	
	@RequestMapping("search.vote")
	public String searchList(@RequestParam(value="cpage", defaultValue="1")int currentPage, String keyword, Model model) {
			

		PageInfo pi = Pagination.getPageInfo(voteService.searchListCount(keyword), currentPage, 10, 5);
			
		ArrayList<Vote> list = voteService.searchList(keyword, pi);
			
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		model.addAttribute("keyword", keyword);
		
			
		return "vote/voteList";
		
	}
	
	
	@RequestMapping("enroll.vote")
	public String voteEnroll() {
		return "vote/voteEnroll";
	}
	
	@RequestMapping("insert.vote")
	public String insertVote(Vote v, VoteItem vi, MultipartFile[] upfile, HttpSession session, Model model) {
		
		String[] itemName = vi.getItemName().split(",");
		
		List<VoteItem> voteItemList = new ArrayList<VoteItem>();
		
		for(int i = 0; i < itemName.length; i++) {
			if(!upfile[i].getOriginalFilename().equals("")) {
				String changeName = saveFile(upfile[i], session);
				voteItemList.add(new VoteItem(0, 0, itemName[i], 0, upfile[i].getOriginalFilename(), "/apartmentor/resources/uploadFiles/" + changeName, 0));
			} else {
				voteItemList.add(new VoteItem(0, 0, itemName[i], 0, "null", "null", 0));
			}
		}

		int result = voteService.insertVote(v, voteItemList);
		setVoteStatus();
		
		if(result > 0) { // ?????? => ?????? ????????????
			session.setAttribute("alertMsg2", "?????? ????????? ?????????????????????");
			return "redirect:list.vote";
		} else { // ?????? => ?????? ????????? ?????? ????????????
			model.addAttribute("alertMsg1", "?????? ????????? ?????????????????????");
			return "redirect:enroll.vote";
		}
		
		
	}
	
	// ?????? ????????? ????????? ????????? ???????????? ????????? ?????????
	public String saveFile(MultipartFile upfile, HttpSession session) {
		String originName = upfile.getOriginalFilename();
		// ??????
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		// 5?????? ?????????
		int ranNum = (int)(Math.random() * 90000) + 10000; 
		// ?????????
		String ext = originName.substring(originName.lastIndexOf("."));
		// ????????? ???????????? ???
		String changeName = currentTime + ranNum + ext;
		// ???????????? ????????? ????????? ???????????? ?????? 
		String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
		// 
		try {
			upfile.transferTo(new File(savePath + changeName));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		
		return changeName;
		
	}
	
	@Scheduled(cron="1 00 00 * * ?")
	public void setVoteStatus() {
		int result = voteService.setVoteStatus();
		System.out.println("???????????? ???????????? ?????? :" + result + "?????? ??????????????? ???????????? ???????????????.");
	}
	
	@RequestMapping("detail.vote")
	public String detailVote(Model model, int voteNo, int userNo) {
		
		VoteItem voteMember = new VoteItem();
		voteMember.setVoteNo(voteNo);
		voteMember.setUserNo(userNo);
		
		Vote v = voteService.selectVote(voteNo); // ??????
		ArrayList<VoteItem> vi = voteService.selectVoteItem(voteNo); // ????????????

		int result = voteService.chkVoteMember(voteMember);	// ????????? ??????????????? ????????????
		
		if(result > 0 || v.getStatus().equals("N")) { // ????????? ????????? ????????? ????????? ????????? ???????????? ???????????? ?????????
			model.addAttribute("totalCount", voteService.totalCount(voteNo)); // ??? ?????????
			model.addAttribute("voteNo", voteNo);
			model.addAttribute("v", v);
			model.addAttribute("vi", vi);
			return "vote/voteResult";
		} else { // ????????? ???????????? ?????? ???????????? ?????????
			model.addAttribute("v", v);
			model.addAttribute("v", v);
			model.addAttribute("vi", vi);
			return "vote/voteDetail";
		}
	}
	
	@RequestMapping("submit.vote")
	public String submitVote(int itemNo, int userNo, int voteNo, HttpSession session, Model model) {
		
		VoteItem vi = new VoteItem();
		vi.setItemNo(itemNo);
		vi.setUserNo(userNo);
		vi.setVoteNo(voteNo);
		
		int result = voteService.submitVote(vi);
		
		if(result > 0) { 
			int countResult = voteService.increaseItemCount(itemNo);
			if(countResult > 0){
				model.addAttribute("voteNo", voteNo);
				model.addAttribute("userNo", userNo);
				return "redirect:detail.vote";
			} else {
				session.setAttribute("alertMsg1", "????????? ?????????????????????");
				return "redirect:detail.vote";
			}
		} else {
			session.setAttribute("alertMsg1", "????????? ?????????????????????");
			return "redirect:detail.vote";
		}
		
	}
	
	@RequestMapping("re.vote")
	public String reVote(VoteItem vi, HttpSession session) {
		
		List<VoteItem> viList = voteService.selectVoteMember(vi);
			
		int countResult = voteService.decreaseItemCount(viList);
		
		if(countResult == -1) {
			
			if(voteService.deleteVoteMember(vi) > 0) {
				return "redirect:detail.vote?voteNo=" + vi.getVoteNo() + "&userNo=" + vi.getUserNo();
			} else {
				session.setAttribute("alertMsg2", "?????????????????? ??????");
				return "";
			}
			
		} else {
			session.setAttribute("alertMsg2", "?????????????????? ??????");
			return "";
		}
		
	}
	
	@RequestMapping("delete.vote")
	public String deleteVote(int voteNo, HttpSession session) {
		
		int result = voteService.deleteVote(voteNo);
		
		if(result > 0) {
			session.setAttribute("alertMsg2", "?????? ????????? ?????????????????????");
			return "redirect:list.vote";
		} else {
			session.setAttribute("alertMsg1", "?????? ????????? ?????????????????????");
			return "redirect:list.vote";
		}
	}
	

}
