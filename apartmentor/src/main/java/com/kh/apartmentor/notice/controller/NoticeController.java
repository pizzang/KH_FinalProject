package com.kh.apartmentor.notice.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.apartmentor.common.model.vo.PageInfo;
import com.kh.apartmentor.common.template.Pagination;
import com.kh.apartmentor.notice.model.service.NoticeService;
import com.kh.apartmentor.notice.model.vo.Notice;

@Controller
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;
	
	/**
	 * 공지사항 등록
	 */
	@RequestMapping("insert.notice")
	public String insertNotice(Notice n, MultipartFile upfile, HttpSession session, Model model) {
	
		if(!upfile.getOriginalFilename().equals("")) { // 전달될 파일이 있을 경우
			
			String changeName = saveFile(upfile, session);
			
			n.setOriginName(upfile.getOriginalFilename());
			n.setChangeName("resources/noticeImg/" + changeName);
			
		}
		
		int result = noticeService.insertNotice(n); 
		
		if(result > 0) { // 성공 => 목록 페이지로
			session.setAttribute("alertMsg2", "공지 작성에 성공하셨습니다");
			return "redirect:list.notice";
		} else { // 실패 => 작성 페이지 다시 보여주기
			model.addAttribute("alertMsg1", "공지 작성에 실패하셨습니다");
			return "redirect:enrollForm.notice";
		}
		
	}
	

	/**
	 * 실제 넘어온 파일을 변경해서 서버에 업로드
	 */
	public String saveFile(MultipartFile upfile, HttpSession session) {
		
		String originName = upfile.getOriginalFilename(); 
		
		// 년월일시분초
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		
		// 5자리 랜덤값
		int ranNum = (int)(Math.random() * 90000) + 10000;
		
		// 확장자
		String ext = originName.substring(originName.lastIndexOf("."));
		
		String changeName = currentTime + ranNum + ext;
		
		// 업로드 시키고자 하는 폴더의 물리적인 경로를 알아내기
		String savePath = session.getServletContext().getRealPath("/resources/noticeImg/");
		
		try {
			upfile.transferTo(new File(savePath + changeName));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		return changeName;
	}
	
	
	/**
	 * 공지사항 목록 페이지로 이동
	 */
	@RequestMapping("list.notice")
	public ModelAndView selectList(@RequestParam(value="cpage", defaultValue="1") int currentPage, ModelAndView mv) {
		
		PageInfo pi = Pagination.getPageInfo(noticeService.selectListCount(), currentPage, 10, 5);
		
		mv.addObject("pi", pi)
		  .addObject("list",noticeService.selectList(pi))
		  .setViewName("notice/noticeListView");
		
		return mv;
	}
	
	/**
	 * 공지사항 목록 페이지 - 공지 종류
	 */
	@RequestMapping("categoryList.notice")
	public String selectCategoryList(@RequestParam(value="cpage", defaultValue="1")int currentPage, String category, Model model) {
		
		PageInfo pi = Pagination.getPageInfo(noticeService.selectCategoryListCount(category), currentPage, 10, 5);
		
		ArrayList<Notice> list = noticeService.selectCategoryList(category, pi);
		
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		model.addAttribute("category", category);
		
		
		return "notice/noticeListView";
		
	}
	
	/**
	 * 공지사항 목록 페이지 - 검색
	 */
	@RequestMapping("search.notice")
	public String searchList(@RequestParam(value="cpage", defaultValue="1")int currentPage, String condition, String keyword, Model model) {
			
		HashMap<String, String> map = new HashMap();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		PageInfo pi = Pagination.getPageInfo(noticeService.searchListCount(map), currentPage, 10, 5);
			
		ArrayList<Notice> list = noticeService.searchList(map, pi);
			
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
			
		return "notice/noticeListView";
		
	}

	/**
	 * 공지사항 작성 페이지로 이동
	 */
	@RequestMapping("enrollForm.notice")
	public String enrollFormNotice() {
		return "notice/noticeEnrollForm";
	}

	/**
	 * 공지사항 상세 페이지로 이동
	 */
	@RequestMapping("detail.notice")
	public ModelAndView detailVist(ModelAndView mv, int nno) {
		
		Notice n = noticeService.selectNotice(nno);
		
		mv.addObject("n", n).setViewName("notice/noticeDetailView");
		
		return mv;
	}
	
	/**
	 * 공지사항 수정 페이지로 이동
	 */
	@RequestMapping("updateForm.notice")
	public String updateNotice(int nno, Model model) {
		
		model.addAttribute("n", noticeService.selectNotice(nno));
		
		return "notice/noticeUpdateForm";
		
	}
	
	/**
	 * 공지사항 수정
	 */
	@RequestMapping("update.notice")
	public String updateNotice(Notice n, MultipartFile reupfile, HttpSession session, Model model) {
		// 새로운첨부파일넘겨온 경우
		if(!reupfile.getOriginalFilename().equals("")) {
			// 기존에 첨부파일이 있는 경우 => 기존의 첨부파일을 지우기
			if(n.getOriginName() != null) {
				new File(session.getServletContext().getRealPath(n.getChangeName())).delete();
			}
			// 새로 넘어온 첨부파일을 서버에 업로드 시키기
			String changeName = saveFile(reupfile, session);
						
			// 새로운 정보(원본명, 저장경로) 담기
			n.setOriginName(reupfile.getOriginalFilename());
			n.setChangeName("resources/noticeImg/" + changeName);
			}
		
		int result = noticeService.updateNotice(n);

			if(result > 0) {
				session.setAttribute("alertMsg2", "공지사항 수정 성공");
				return "redirect:detail.notice?nno="  + n.getNoticeNo();
			} else {
				model.addAttribute("alertMsg1", "공지사항 수정 실패");
				return "updateForm.notice?nno" + n.getNoticeNo();
			}
			
	}
	
	/**
	 * 공지사항 삭제
	 */
	@RequestMapping("delete.notice")
	public String deleteNotice(int nno, String filePath, HttpSession session, Model model) {
		
		int result = noticeService.deleteNotice(nno);
		
		if(result > 0) { 
			// 만약에 첨부파일이 있었을 경우 삭제하기
			if(!filePath.equals("")) {
				// 기존에 존재하는 첨부파일을 삭제
				new File(session.getServletContext().getRealPath(filePath)).delete();
			}
			
			session.setAttribute("alertMsg2", "공지사항 삭제 성공");
			return "redirect:list.notice";
		} else {
			model.addAttribute("alertMsg1", "공지사항 삭제 실패");
			return "detail.notice?nno" + nno;
		}
	}
}
