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
		
		if(result > 0) { // 성공 => 목록 페이지로
			session.setAttribute("alertMsg2", "투표 작성에 성공하셨습니다");
			return "redirect:list.vote";
		} else { // 실패 => 작성 페이지 다시 보여주기
			model.addAttribute("alertMsg1", "투표 작성에 실패하셨습니다");
			return "redirect:enroll.vote";
		}
		
		
	}
	
	// 실제 넘어온 파일의 이름을 변경해서 서버에 업로드
	public String saveFile(MultipartFile upfile, HttpSession session) {
		String originName = upfile.getOriginalFilename();
		// 날짜
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		// 5자리 랜덤값
		int ranNum = (int)(Math.random() * 90000) + 10000; 
		// 확장자
		String ext = originName.substring(originName.lastIndexOf("."));
		// 수정된 첨부파일 명
		String changeName = currentTime + ranNum + ext;
		// 첨부파일 저장할 폴더의 물리적인 경로 
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
		System.out.println("투표상태 업데이트 결과 :" + result + "개의 투표상태를 업데이트 하였습니다.");
	}
	
	@RequestMapping("detail.vote")
	public String detailVote(Model model, int voteNo, int userNo) {
		
		VoteItem voteMember = new VoteItem();
		voteMember.setVoteNo(voteNo);
		voteMember.setUserNo(userNo);
		
		Vote v = voteService.selectVote(voteNo); // 투표
		ArrayList<VoteItem> vi = voteService.selectVoteItem(voteNo); // 투표항목

		int result = voteService.chkVoteMember(voteMember);	// 멤버가 투표했는지 여부확인
		
		if(result > 0 || v.getStatus().equals("N")) { // 투표를 했거나 기간이 종료된 투표면 투표결과 페이지로 보낸다
			model.addAttribute("totalCount", voteService.totalCount(voteNo)); // 총 투표수
			model.addAttribute("voteNo", voteNo);
			model.addAttribute("v", v);
			model.addAttribute("vi", vi);
			return "vote/voteResult";
		} else { // 투표를 안했으면 투표 페이지로 보낸다
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
				session.setAttribute("alertMsg1", "투표에 실패하셨습니다");
				return "redirect:detail.vote";
			}
		} else {
			session.setAttribute("alertMsg1", "투표에 실패하셨습니다");
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
				session.setAttribute("alertMsg2", "다시투표하기 실패");
				return "";
			}
			
		} else {
			session.setAttribute("alertMsg2", "다시투표하기 실패");
			return "";
		}
		
	}
	
	@RequestMapping("delete.vote")
	public String deleteVote(int voteNo, HttpSession session) {
		
		int result = voteService.deleteVote(voteNo);
		
		if(result > 0) {
			session.setAttribute("alertMsg2", "투표 삭제에 성공하셨습니다");
			return "redirect:list.vote";
		} else {
			session.setAttribute("alertMsg1", "투표 삭제에 실패하셨습니다");
			return "redirect:list.vote";
		}
	}
	

}
