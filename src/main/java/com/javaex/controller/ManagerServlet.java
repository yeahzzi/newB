package com.javaex.controller;

import java.io.IOException;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.javaex.dao.AnswerDao;
import com.javaex.dao.AnswerDaoImpl;
import com.javaex.dao.MemberDao;
import com.javaex.dao.MemberDaoImpl;
import com.javaex.dao.OrderInfoDao;
import com.javaex.dao.OrderInfoDaoImpl;
import com.javaex.dao.PointDao;
import com.javaex.dao.PointDaoImpl;
import com.javaex.dao.QnaAnswerDao;
import com.javaex.dao.QnaAnswerDaoImpl;
import com.javaex.dao.QnaBoardDao;
import com.javaex.dao.QnaBoardDaoImpl;
import com.javaex.dao.QuestionDao;
import com.javaex.dao.QuestionDaoImpl;
import com.javaex.dao.ReviewDao;
import com.javaex.dao.ReviewDaoImpl;
import com.javaex.util.WebUtil;
import com.javaex.vo.AnswerVo;
import com.javaex.vo.MemberVo;
import com.javaex.vo.OrderInfoVo;
import com.javaex.vo.QnaAnswerVo;
import com.javaex.vo.QnaBoardVo;
import com.javaex.vo.QuestionVo;
import com.javaex.vo.ReviewVo;
import com.javaex.controller.test;

@WebServlet("/manager")
public class ManagerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String CHARSET = "utf-8";
	private static final int LISTCOUNT = 3;
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		System.out.println("UserServlet.doGet() ??????");
		request.setCharacterEncoding("utf-8");

		String actionName = request.getParameter("a");

		System.out.println("a->" + actionName);
		response.setContentType("text/html; charset = UTF-8");
		PrintWriter out = response.getWriter();
		

		if ("managelist".equals(actionName)) {
			
			OrderInfoDao dao = new OrderInfoDaoImpl();
			ArrayList<OrderInfoVo> list = dao.getList();
			System.out.println("????????? ?????????");
			// ????????? ????????? ?????????
			request.setAttribute("list", list);

			WebUtil.forward(request, response, "/WEB-INF/views/manager/orderinfomanage.jsp");
		}else if("before".equals(actionName)) {
			
			OrderInfoDao dao = new OrderInfoDaoImpl();
			ArrayList<OrderInfoVo> list = dao.getList1();
			System.out.println("????????? ?????????");
			System.out.println(list.toString());

			// ????????? ????????? ?????????
			request.setAttribute("list", list);

			WebUtil.forward(request, response, "/WEB-INF/views/manager/orderinfomanage2.jsp");
		}else if("after".equals(actionName)) {
			
			OrderInfoDao dao = new OrderInfoDaoImpl();
			ArrayList<OrderInfoVo> list = dao.getList2();
			System.out.println("????????? ?????????");
			System.out.println(list.toString());

			// ????????? ????????? ?????????
			request.setAttribute("list", list);

			WebUtil.forward(request, response, "/WEB-INF/views/manager/orderinfomanage3.jsp");
		}else if("change".equals(actionName)) {
			// ?????? ????????? ?????? ??????????????? ????????? -> ?????? ????????? ????????? ??????!!
			int orderNo = Integer.parseInt(request.getParameter("orderNo"));
			int memNo = Integer.parseInt(request.getParameter("memNo"));
			System.out.println("orderNo: "  + orderNo + "memNo: " + memNo);

			OrderInfoDao dao = new OrderInfoDaoImpl();
			
			System.out.println("?????? ??????: " + orderNo);
			dao.change(orderNo);
			System.out.println("??????");
			
			if(dao.change(orderNo)==1) {
				PointDao ppdao = new PointDaoImpl();
				ppdao.orderPoint(orderNo, memNo);	
			}
			
			ArrayList<OrderInfoVo> list = dao.getList();
			System.out.println("????????? ?????????");
			System.out.println(list.toString());

			// ????????? ????????? ?????????
			request.setAttribute("list", list);
			

			WebUtil.forward(request, response, "/WEB-INF/views/manager/orderinfomanage.jsp");
		}else if("specific".equals(actionName)) {
			// ?????? ?????? ?????? ?????? ???????????? ????????? ?????? ?????? ??????
			int orderNo = Integer.parseInt(request.getParameter("orderNo"));

			WebUtil.forward(request, response, "/WEB-INF/views/manager/specificinfo.jsp");
			
			//??????????????? ???????????????
		}else if("inquiry".equals(actionName)) {
			
			String typ = request.getParameter("t");
			String pag = request.getParameter("p");

			String type = "?????? ??????";
			if (typ != null && !typ.equals("")) {
				type = typ;
			}

			int page = 1;
			if (pag != null && !pag.equals("")) {
				page = Integer.parseInt(pag);
			}

			QnaBoardDao dao = new QnaBoardDaoImpl();
			List<QnaBoardVo> list = dao.getList(type, page);
			int count = dao.getBoardCount(type);
			System.out.println(count);
			System.out.println(list.toString());
			
			request.setAttribute("list", list);
			request.setAttribute("count", count);

			WebUtil.forward(request, response, "/WEB-INF/views/manager/inquirypage.jsp");
		
			
		} else if("listNoAnswer".equals(actionName)) {
			//???????????? ??????????????????
			
			String pag = request.getParameter("p");

			int page = 1;
			if (pag != null && !pag.equals("")) {
				page = Integer.parseInt(pag);
			}

			QnaBoardDao dao = new QnaBoardDaoImpl();
			List<QnaBoardVo> list = dao.getNoAnswerList(page);
			int count = dao.getNoAnswerCount();
			System.out.println(count);
			System.out.println(list.toString());
			
			request.setAttribute("list", list);
			request.setAttribute("count", count);
			WebUtil.forward(request, response, "/WEB-INF/views/manager/noansqnalist.jsp");
			
			
		}else if("pinquiry".equals(actionName)) {
			//???????????? ???????????????
			requestQnaList (request);
			WebUtil.forward(request, response, "/WEB-INF/views/manager/pinquirypage.jsp");

		}else if("reviewAll".equals(actionName)) {
			// ????????? ???????????????
			requestReviewListAll(request);
			WebUtil.forward(request, response, "/WEB-INF/views/manager/allreviewlist.jsp");

		}else if("specificinquiry".equals(actionName)) {
			// ?????? or ?????? ?????? ??? ??? ?????? ???????????? ?????? ?????? ??? ??????X ????????? ?????????
			int no = Integer.parseInt(request.getParameter("qnaNo"));
			QnaBoardDao dao = new QnaBoardDaoImpl();
			QnaBoardVo qnaboardVo = dao.getBoard(no);
			QnaBoardVo prevVo = dao.prevQna(no);
			QnaBoardVo nextVo = dao.nextQna(no);
			
			QnaAnswerDao ansDao = new QnaAnswerDaoImpl();
			List<QnaAnswerVo> list = ansDao.getAnsList(no);	
			
			System.out.println(list.toString());
			request.setAttribute("QnaboardVo", qnaboardVo);
			request.setAttribute("prevVo", prevVo);
			request.setAttribute("nextVo", nextVo);
			request.setAttribute("list",list);
			WebUtil.forward(request, response, "/WEB-INF/views/manager/specificinquiry.jsp");
		
		}else if("specificreview".equals(actionName)) {
			// ????????? ???????????? ??????
			
			int revno = Integer.parseInt(request.getParameter("revNo"));
			ReviewDao dao = new ReviewDaoImpl();
			ReviewVo reviewVo = dao.getReview(revno);
		
			request.setAttribute("revVo",reviewVo);

			WebUtil.forward(request, response, "/WEB-INF/views/manager/specificReview.jsp");
		
			//?????? ?????? ????????????
		}else if("insertAnswer".equals(actionName)) {
			int qnum = Integer.parseInt(request.getParameter("qNo"));
			MemberVo authUser = getAuthUser(request);
			int memNo = authUser.getMemNo();
			String acontent = request.getParameter("answerContent");
			AnswerDao adao = new AnswerDaoImpl();
			AnswerVo avo = new AnswerVo(qnum, memNo, acontent);
			adao.insert(avo);

			WebUtil.redirect(request, response, "/mysiteB/manager?a=specificpinquiry&qno="+qnum);
			
			//?????? ?????? ?????? ??????
		}else if("deletepAnswer".equals(actionName)){
			int qnum = Integer.parseInt(request.getParameter("qNo"));
			int anum = Integer.parseInt(request.getParameter("aNo"));
			AnswerDao adao = new AnswerDaoImpl();
			adao.delete(anum);
		
			WebUtil.redirect(request, response, "/mysiteB/manager?a=specificpinquiry&qno="+qnum);
			
		} else if("specificpinquiry".equals(actionName)) {
			//?????? ?????? ??? ?????? ??????
			
			int no = Integer.parseInt(request.getParameter("qno"));
			QuestionDao dao = new QuestionDaoImpl();
			QuestionVo questionVo = dao.getQuestion(no);
			
			List<AnswerVo> list = dao.getAnswerlist(no);
			
			request.setAttribute("qVo", questionVo);
			request.setAttribute("alist", list);
			
			WebUtil.forward(request, response, "/WEB-INF/views/manager/specificpinquiry.jsp");
		} else {
			WebUtil.redirect(request, response, "/WEB-INF/views/manager/manage.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	// ????????? ?????? ?????? ????????? ????????????
	protected MemberVo getAuthUser(HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberVo authUser = (MemberVo) session.getAttribute("authUser");

		return authUser;
	}

	public void requestReviewListAll(HttpServletRequest request) {
		ReviewDao dao = ReviewDaoImpl.getInstance();
		List<ReviewVo> reviewAllList = new ArrayList<ReviewVo>();
		
		int pageNum = 1;
		int limit = LISTCOUNT;
		
		if(request.getParameter("pageNum") != null)
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		
		int total_record = dao.getAllListCount();
		
		reviewAllList = dao.getAllList(pageNum, limit);
		
		int total_page;
		
		if(total_record % limit == 0) {
			total_page = total_record / limit;
			Math.floor(total_page);
		}
		else {
			total_page = total_record / limit;
			Math.floor(total_page);
			total_page = total_page + 1;
		}
		
		request.setAttribute("reviewAllList", reviewAllList);
		request.setAttribute("revpageNum", pageNum);
		request.setAttribute("revtotal_page", total_page);
		request.setAttribute("revtotal_record", total_record);
		
	}
	
	public void requestQnaList(HttpServletRequest request) {
		QuestionDao qdao = QuestionDaoImpl.getInstance();
		List<QuestionVo> qnaList = new ArrayList<QuestionVo>();
		
		int qnapageNum = 1;
		int qnalimit = LISTCOUNT;  
		
		if(request.getParameter("qnapageNum") != null)
			qnapageNum = Integer.parseInt(request.getParameter("qnapageNum"));
		
		
		int qnatotal_record = qdao.allQlistCount();
		qnaList = qdao.allQlist(qnapageNum, qnalimit);
		System.out.println("qnatotal_record: "+ qnatotal_record);
		System.out.println("qnaList: "+ qnaList);
		int qnatotal_page;
		
		if(qnatotal_record % qnalimit == 0) {
			qnatotal_page = qnatotal_record / qnalimit;
			Math.floor(qnatotal_page);
		}
		else {
			qnatotal_page = qnatotal_record / qnalimit;
			Math.floor(qnatotal_page);
			qnatotal_page = qnatotal_page + 1;
		}

		request.setAttribute("qnaList", qnaList);
		request.setAttribute("qnapageNum", qnapageNum);
		request.setAttribute("qnatotal_page", qnatotal_page);
		request.setAttribute("qnatotal_record", qnatotal_record);
		
		
	}
}
