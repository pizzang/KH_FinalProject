package com.kh.apartmentor.board.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.kh.apartmentor.board.model.service.BoardService;
import com.kh.apartmentor.board.model.vo.Board;
import com.kh.apartmentor.board.model.vo.Reply;
import com.kh.apartmentor.common.model.vo.PageInfo;
import com.kh.apartmentor.common.template.Pagination;

@Controller
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	// 게시글 조회 
	@RequestMapping("list.bo")
	public String selectList(@RequestParam(value="cpage", defaultValue="1") int currentPage, Model model) {
		// 페이징바 처리
		PageInfo pi = Pagination.getPageInfo(boardService.selectListCount(), currentPage, 10, 5);
		
		ArrayList<Board> list = boardService.selectList(pi);
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		
		return "board/boardListView";
	}
	
	// 게시글 작성 페이지로 포워딩
	@RequestMapping("enrollForm.bo")
	public String enrollForm() {
		return "board/boardEnrollForm";
	}
	
	// 게시글 작성
	@RequestMapping("insert.bo")
	public String insertBoard(Board b, MultipartFile upfile, HttpSession session) {
		
		// 전달된 파일이 있을 경우 => 파일명 수정 후 서버 업로드 => 원본명, 서버 업로드된 경로를 b에 담기(파일이 있을 때만)
		if( !upfile.getOriginalFilename().equals("") ) { // getOriginalFilename() == filename 필드값을 반환해줌
			
			String changeName = saveFile(upfile, session);
			
			// Board b에 originName과 ChangeName을 set해주기
			b.setOriginName(upfile.getOriginalFilename());
			b.setChangeName("/apartmentor/resources/uploadFiles/" + changeName);
		}

		int result = boardService.insertBoard(b);
		
		if(result > 0) { // 성공=> 게시글 리스트 페이지(boardListView.jsp)
			session.setAttribute("alertMsg2", "게시글 작성 성공!!");
			return "redirect:list.bo";
		}else {
			session.setAttribute("alertMsg1", "게시글 작성 실패!");
			return "board/boardListView";
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
		
	// 게시글 수정 페이지로 포워딩
	@RequestMapping("updateForm.bo")
	public String updateBoard(int bno, Model model) {
		// DB에 있는 해당 게시글을 model에 담아 포워딩하기
		Board b = boardService.selectBoard(bno);
		model.addAttribute("b", b);
		return "board/boardUpdateForm";
	}
	
	// 게시글 수정
	@RequestMapping("update.bo")
	public String updateBoard(Board b, MultipartFile reupfile, HttpSession session) {
		
		// 새로 첨부파일이 넘어온 경우
		if(!reupfile.getOriginalFilename().equals("")) {
			//기존 첨부파일 삭제
			if(b.getOriginName() != null) {
				new File(session.getServletContext().getRealPath(b.getChangeName())).delete();
			}
			// 새로 넘어온 첨부파일을 서버에 업로드 시키기
			// saveFile()을 호출해서 현재 넘어온 첨부파일을 서버에 저장 (session필요)
			String changeName = saveFile(reupfile, session);
			
			// b라는 Board객체에 새로운 정보(원본명, 저장경로) 담기
			b.setOriginName(reupfile.getOriginalFilename());
			b.setChangeName("/apartmentor/resources/uploadFiles/" + changeName);
		}
		
		// 수정 한 결과 result에 담기
		int result = boardService.updateBoard(b);
		
		if(result > 0) {
			session.setAttribute("alertMsg2", "게시글 수정 성공!");
			return "redirect:detail.bo?bno=" + b.getBoardNo();
		} else {
			session.setAttribute("alertMsg2", "게시글 수정 실패");
			return "";
		}
		
		
	}
	
		
	
	// 게시글 삭제
	@RequestMapping("delete.bo")
	public String deleteBoard(int bno, String filePath, HttpSession session) {
		
		int result = boardService.deleteBoard(bno);
		
		if(result > 0) {
			// 첨부파일이 있는 게시글인 경우 해당 첨부파일도 삭제
			if(!filePath.equals("")) {
				new File(session.getServletContext().getRealPath(filePath)).delete();
			}
			// 게시판 리스트 리다이렉트
			session.setAttribute("alertMsg2", "게시글 삭제 성공!");
			return "redirect:list.bo";
		}else {
			session.setAttribute("alertMsg1", "게시글 삭제 실패!");
			return "board/boardListView";
		}
	}
	
	
	
	
	// 게시글 상세조회
	@RequestMapping("detail.bo")
	public String selectBoard(int bno, Model model) {
		
		// 해당 게시글 조회수 증가
		int result = boardService.increaseCount(bno);
		
		// 해당 게시글 상세조회
		if(result > 0) { // 게시글 조회수 증가 성공
			Board b = boardService.selectBoard(bno);
			model.addAttribute("b", b);
			return "board/boardDetailView";
		} else { // 게시글 조회수 증가 실패
			return "redirect:/";
		}
		
	}
	
	// 상세보기페이지 댓글 조회
	@ResponseBody
	@RequestMapping(value="replyList.bo", produces="application/json; charset=UTF-8")
	public String selectReplyList(int bno) {
		ArrayList<Reply> list = boardService.selectReplyList(bno);
		
		return new Gson().toJson(list);
	}
	
	// 제목 키워드 검색 조회
	@RequestMapping("search.bo")
	public String searchBoard(@RequestParam(value="cpage", defaultValue="1") int currentPage, String keyword, Model model) {
		
		// 검색한 게시글의 총 갯수로 검색결과에 따른 페이징바 다시 만들기
		PageInfo pi = Pagination.getPageInfo(boardService.selectSearchCount(keyword), currentPage, 10, 5);
		
		// 페이징바로 나눌 검색결과에 따른 리스트 조회 
		ArrayList<Board> list = boardService.selectSearchList(keyword, pi);
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		model.addAttribute("keyword", keyword);
		
		return "board/boardListView";
	}
	
	// 정렬 리스트 조회 
	@RequestMapping("option.bo")
	public String selectOption(@RequestParam(value="cpage", defaultValue="1") int currentPage, String option, Model model) {

		// 정렬한 게시글의 총 갯수로 페이징바 다시 만들기 - 리스트의 총 갯수는 변함이 없으므로 기존에 만든 selectListCount호출
		PageInfo pi = Pagination.getPageInfo(boardService.selectListCount(), currentPage, 10, 5);
		
		ArrayList<Board> oList = boardService.selectOption(option, pi);

		model.addAttribute("pi", pi);
		model.addAttribute("oList", oList);
		model.addAttribute("option", option);
		return "board/boardListView";
	}
	
	// 댓글 작성
	@ResponseBody
	@RequestMapping("replyInsert.bo")
	public String insertReply(Reply r) {
		return boardService.insertReply(r) > 0 ? "success" : "fail";
	}
	
	// 댓글 삭제
	@ResponseBody
	@RequestMapping("replyDelete.bo")
	public String deleteReply(int replyNo) {
		return boardService.deleteReply(replyNo) > 0 ? "success" : "fail";
	}
	
	
}
