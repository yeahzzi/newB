<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page import="com.javaex.dao.ReviewDaoImpl"%>
<%@page import="com.javaex.dao.ReviewDao"%>
<%@page import="com.javaex.dao.QuestionDaoImpl"%>
<%@page import="com.javaex.dao.QuestionDao"%>
<%@page import="com.javaex.vo.ProductVo"%>
<%@ page import="java.util.*"%>
<%
List reviewList = (List) request.getAttribute("revlist");
int proNo = ((Integer) request.getAttribute("proNo")).intValue();
int revpageNum = ((Integer) request.getAttribute("revpageNum")).intValue();
int revtotal_page = ((Integer) request.getAttribute("revtotal_page")).intValue();
int revtotal_record = ((Integer) request.getAttribute("revtotal_record")).intValue();

List questionList = (List) request.getAttribute("questionList");
int qnapageNum = ((Integer) request.getAttribute("qnapageNum")).intValue();
int qnatotal_page = ((Integer) request.getAttribute("qnatotal_page")).intValue();
int qnatotal_record = ((Integer) request.getAttribute("qnatotal_record")).intValue();
%>

<!DOCTYPE HTML>
<!--
	Forty by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
<head>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	$(function() {
		$('#onDisplay1').click(function() {
			if ($("#noneDiv1").css("display") == "none") {
				$('#noneDiv1').show();
				$('#noneDiv2').hide();
				$('#noneDiv3').hide();
			} else if ($("onDisplay1").css("display") != "none") {
				$('#noneDiv1').hide();
			}

		});
		$('#onDisplay2').click(function() {
			if ($("#noneDiv2").css("display") == "none") {
				$('#noneDiv1').hide();
				$('#noneDiv2').show();
				$('#noneDiv3').hide();
			} else if ($("onDisplay2").css("display") != "none") {
				$('#noneDiv2').hide();
			}

		});
		$('#onDisplay3').click(function() {
			if ($("#noneDiv3").css("display") == "none") {
				$('#noneDiv1').hide();
				$('#noneDiv2').hide();
				$('#noneDiv3').show();
			} else if ($("onDisplay3").css("display") != "none") {
				$('#noneDiv3').hide();
			}

		});

	});
</script>

<script type="text/javascript">
	function sayHello() {

		alert("????????? ??? ?????? ???????????????!"); //?????????????????? value??? ????????? ??????

	}
</script>
<title>Elements - Forty by HTML5 UP</title>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="assets/css/main.css" />
<link rel="stylesheet" href="assets/css/noscript.css" />
</head>
<body class="is-preload">

	<!-- Wrapper -->
	<div id="wrapper">

		<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
		<!-- Main -->
		<div id="main" class="alt">

			<!-- One -->
			<section id="one">
				<div class="inner">
					<header class="major">
						<h1>????????????</h1>
					</header>

					<hr class="major" />

					<!-- Elements -->
					<div class="col-6 col-12-medium">

						<!-- Lists -->
						<div class="row">

							<c:import url="/WEB-INF/views/includes/navigation.jsp"></c:import>
							<div class="col-9 col-12-medium">
							<form action="/mysiteB/orderInfo" method="post">
								<input type="hidden" name="proNo" value="${ProductVo.proNo}">
								<input type="hidden" name="memNo" value="${authUser.memNo}">
								<div class="col-9 col-12-medium">
									<div class="row">
										<div class="col-6 col-12-small">
											<span class="image fit"><img
												src="./upload/${ProductVo.proFileName }" alt=""
												style="max-width: 100000px; height: auto;" /></span>
										</div>
										<div class="col-6 col-12-small">
											<h1>${ProductVo.proName }</h1>
											<h3>
												<b>${ProductVo.proPrice}???</b>
											</h3>
											<h3></h3>
											<section>

												<ul class="actions">


													<li><input type=button value="-"
														onClick="javascript: if (this.form.amount.value >= 2) this.form.amount.value--;"></li>
													<li><input style="text-align: center; width: 100px"
														type=text name=amount value=1></li>
													<li><input type=button value="+"
														onClick="javascript:this.form.amount.value++;"></li>

												</ul>

												<ul class="actions">
													<c:choose>
														<c:when test="${authUser != null }">
															<li><button class="button" type="submit"
																	value="addCart" name="a">????????????</button></li>


															<li><button class="button" type="submit"
																	value="single" name="a">????????????</button></li>
														</c:when>
														<c:otherwise>
															<li><a href="/mysiteB/user?a=loginform"><input
																	type="button" value="????????????" onclick="sayHello()" /></a></li>
															<li><a href="/mysiteB/user?a=loginform"><input
																	type="button" value="????????????" onclick="sayHello()" /></a></li>
														</c:otherwise>
													</c:choose>
												</ul>
											</section>
										</div>
									</div>
								</div>
							</form>
						
</div>
</div>
						<hr class="major" />

						<div class="row" style="text-align: center">
							<!-- Break -->
							<div class="col-4 col-12-medium">
								<a class="list-group-item" id="onDisplay1"
									style="font-weight: bold">??????</a>
							</div>
							<div class="col-4 col-12-medium">
								<a class="list-group-item" id="onDisplay2"
									style="font-weight: bold">??????</a><a style="color: orange"> (<%=revtotal_record%>)
								</a>
							</div>
							<div class="col-4 col-12-medium">
								<a class="list-group-item" id="onDisplay3"
									style="font-weight: bold">QNA</a>
							</div>

</div>
						</div>



						<div class="row"></div>

						<hr class="major" />

					
					<div id="noneDiv1" style="display:;">${ProductVo.proDesc }</div>

					<div id="noneDiv2" style="display: none;">
						<form id="search_form" action="" method="post">
							<input type="hidden" name="a" value="search">
							<!-- put options as orderBy -->
							<select name="revOrder" class="txt" style="width: auto">
								<option value="revHit">?????????</option>
								<option value="revDate">?????? ?????????</option>
								<option value="rate">?????????</option>
							</select>
						</form>

						<div class="col-6 col-12-small">
							<ul class="actions stacked">
								<c:if test="${wavail == 1}">
									<li style="text-align: right"><a
										onclick="window.open('/mysiteB/product?a=reviewform&proNo=<%=proNo%>', 'win', 'width=400,height=500')"
										class="button small">?????? ????????????</a></li>
								</c:if>
							</ul>
						</div>

						<div class="box alt">
							<form method="post" action="/mysiteB/product">
								<input type="hidden" name="a" value="reviewList" />

								<div class="contact-method">
									<c:forEach items="${revlist}" var="revList">
										<input type="hidden" name="revNo" value="${revList.revNo }">
										<section>
											<div class="contact-method">
												<span class="icon solid alt"><img src="images/??????.png"
													alt="" style="max-width: 2em; height: auto;" /></span>
												<h4>
													${revList.memId}<br>
												</h4>
												<h5>
													${revList.rate}&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp${revList.revDate}
												</h5>
												<br>
												<h4>${revList.title }</h4>
												
												<c:if test="${revList.uavail == 1}">
													
													<a
														onclick="window.open('/mysiteB/product?a=updateRevform&proNo=${revList.proNo }&revNo=${revList.revNo }&memNo=${revList.memNo }', 'win', 'width=400,height=500')"
														class="button small">?????? ????????????</a>
													<a
														onclick="window.open('/mysiteB/product?a=deleteRevform&proNo=${revList.proNo }&revNo=${revList.revNo }&memNo=${revList.memNo }', 'win', 'width=400,height=500')"
														class="button small">?????? ????????????</a>
												</c:if>
												
												<div>
													<p style="float: left;">
														<c:if test="${not empty fn:trim(revList.file1)}">
															<img src="./upload/${revList.file1 }"
																width="200px" height="200px" border="1px" />&nbsp&nbsp&nbsp&nbsp
														</c:if>
														<c:if test="${not empty fn:trim(revList.file2)}">
														<img src="./upload/${revList.file2 }" width="200px"
															height="200px" border="1px" />
														
													</c:if>
													</p>
													

													
													<p>${revList.content}</p>
													<div style="clear: left;"></div>
												</div>

											</div>
										</section>

									</c:forEach>
								</div>

								<c:set var="pageNum" value="<%=revpageNum%>" />
								<c:forEach var="i" begin="1" end="<%=revtotal_page%>">
									<a
										href="/mysiteB/product?a=readProduct&pageNum=${i}&proNo=<%=proNo%>">
										<c:choose>
											<c:when test="${revpageNum==i}">
												<font color='4C5317'><b> [${i}]</b></font>
											</c:when>
											<c:otherwise>
												<font color='4C5317'> [${i}]</font>
											</c:otherwise>
										</c:choose>
									</a>
								</c:forEach>
							</form>

						</div>
					</div>
					<div id="noneDiv3" style="display: none;" class="row">
						<form method="post" action="/mysiteB/product">
							<input type="hidden" name="a" value="questionList" />
							<div class="col-6 col-12-small">
								<h3>QNA</h3>
							</div>

							<div class="col-6 col-12-small">
								<ul class="actions stacked">
									<c:if test="${!(authUser.adminCk).equals('1')}">
										<li style="text-align: right"><a
											onclick="window.open('/mysiteB/product?a=inquiryBox&proNo=<%=proNo%>', 'win', 'width=400,height=500')"
											class="button small">????????????</a></li>
									</c:if>
								</ul>
							</div>

							<ul style="font-size: 13px;">
								<li>????????? ????????? ??????/????????? mysiteB ?????????????????? ?????? ???????????????.</li>
								<li>???????????? ??? ?????????????????? ?????? ????????? ??????, ?????? ?????? ???????????? ????????????.</li>
								<li>??????, ?????????, ??????/?????? ??? ?????? ??? ?????? ?????? ????????? ?????? ?????? ????????? ???????????? ??? 1:1
									??????????????? ??????????????????.</li>
								<li>"?????? ?????? ??????"??? ???????????? ???, ??????, ?????????, ??????, ??????, ?????? ?????? ?????? ?????? ?????? ??????,
									????????????, ?????? ?????? ????????? ????????? ??? ????????????.</li>
							</ul>

							<hr class="major" />

							<div class="table-wrapper">
								<table>
									<tbody>

										<c:forEach items="${questionList }" var="qvo">
											<c:choose>
												<c:when
													test="${authUser.memNo == qvo.memno || authUser.adminCk == '1'}">
													<tr>

														<td
															style="font-size: 14px; text-align: center; vertical-align: middle"><b>??????</b></td>
														<td
															style="font-size: 12px; text-align: center; vertical-align: middle"><b>${qvo.memId }</b><br>${qvo.qdate}</td>
														<td style="font-size: 12px; vertical-align: middle">${qvo.qcontent }</td>
														<td><c:if test="${authUser.adminCk == '1'}">
																<td style="text-align: right"><a
																	onclick="window.open('/mysiteB/product?a=answerBox&qNo=${qvo.qno}', 'win', 'width=400,height=500')"
																	class="button small">????????????</a></td>
															</c:if></td>
													</tr>

													<tr>
														<c:forEach items="${qvo.alist}" var="alist">
															<td
																style="font-size: 14px; width: 100px; text-align: center; vertical-align: middle"><b>???
																	??????</b></td>
															<td
																style="font-size: 12px; width: 120px; text-align: center; vertical-align: middle"><b>?????????</b><br>${alist.aDate}</td>
															<td style="font-size: 12px; vertical-align: middle">${alist.aContent}</td>
														</c:forEach>

													</tr>



												</c:when>
												<c:otherwise>
													<tr>

														<td
															style="font-size: 14px; text-align: center; vertical-align: middle"><b>??????</b></td>
														<td
															style="font-size: 12px; text-align: center; vertical-align: middle"><b>${qvo.memId }</b><br>${qvo.qdate}</td>
														<td style="font-size: 12px; vertical-align: middle">????????????
															????????? ???????????????</td>


													</tr>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</tbody>
								</table>
							</div>
							<c:set var="qnapageNum" value="<%=qnapageNum%>" />
							<c:forEach var="i" begin="1" end="<%=qnatotal_page%>">
								<a
									href="/mysiteB/product?a=readProduct&qnapageNum=${i}&proNo=${ProductVo.proNo}">
									<c:choose>
										<c:when test="${qnapageNum==i}">
											<font color='4C5317'><b> [${i}]</b></font>
										</c:when>
										<c:otherwise>
											<font color='4C5317'> [${i}]</font>
										</c:otherwise>
									</c:choose>
								</a>
							</c:forEach>
						</form>

					</div>

					<hr class="major" />

				</div>
		</div>
		<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>


		<!-- Scripts -->
		<script src="assets/js/jquery.min.js"></script>
		<script src="assets/js/jquery.scrolly.min.js"></script>
		<script src="assets/js/jquery.scrollex.min.js"></script>
		<script src="assets/js/browser.min.js"></script>
		<script src="assets/js/breakpoints.min.js"></script>
		<script src="assets/js/util.js"></script>
		<script src="assets/js/main.js"></script>
</body>
</html>