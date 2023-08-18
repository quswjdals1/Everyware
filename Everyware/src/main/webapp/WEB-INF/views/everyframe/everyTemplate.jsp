<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <!-- <meta name="viewport" content="width=device-width, initial-scale=1.0">
     -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />

    <title>EveryWare</title>

  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
  
  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/signup.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/EveryWare.css">
  <%-- <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/introduce.css"> --%>
 <%--  <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/membership.css"> --%>
  <%-- <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/mypage.css"> --%>
  
  
  <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
  <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
  
  <script src="${pageContext.request.contextPath }/resources/js/everyHome.js"></script>
  <%-- <script src="${pageContext.request.contextPath }/resources/js/introduce.js"></script> --%>
  <script>history.scrollRestoration = "manual"</script>
  
  <style type="text/css">
   body{-ms-overflow-style:none; }
body::-webkit-scrollbar { display:none; } 
  </style>
</head>
<body>
	<!-- header 영역 -->
	<tiles:insertAttribute name="header"/>

	<!-- content 영역 -->
	<tiles:insertAttribute name="content"/>
	
</body>
</html>