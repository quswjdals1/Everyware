<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">


    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/LoginPage.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	<style type="text/css">
		.context {
    width: 100%;
    position: absolute;
    top:50vh;
    
}

.context h1{
    text-align: center;
    color: #fff;
    font-size: 50px;
}


.area{
    background: #4e54c8;  
    background: -webkit-linear-gradient(to left, #8f94fb, #4e54c8);  
    width: 100%;
    height:100vh;
    
    position: absolute;
    z-index: -999;
    
   
}

.circles{
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    overflow: hidden;
}

.circles li{
    position: absolute;
    display: block;
    list-style: none;
    width: 20px;
    height: 20px;
    background: rgba(255, 255, 255, 0.2);
    animation: animate 25s linear infinite;
    bottom: -150px;
    
}

.circles li:nth-child(1){
    left: 25%;
    width: 80px;
    height: 80px;
    animation-delay: 0s;
}


.circles li:nth-child(2){
    left: 10%;
    width: 20px;
    height: 20px;
    animation-delay: 2s;
    animation-duration: 12s;
}

.circles li:nth-child(3){
    left: 70%;
    width: 20px;
    height: 20px;
    animation-delay: 4s;
}

.circles li:nth-child(4){
    left: 40%;
    width: 60px;
    height: 60px;
    animation-delay: 0s;
    animation-duration: 18s;
}

.circles li:nth-child(5){
    left: 65%;
    width: 20px;
    height: 20px;
    animation-delay: 0s;
}

.circles li:nth-child(6){
    left: 75%;
    width: 110px;
    height: 110px;
    animation-delay: 3s;
}

.circles li:nth-child(7){
    left: 35%;
    width: 150px;
    height: 150px;
    animation-delay: 7s;
}

.circles li:nth-child(8){
    left: 50%;
    width: 25px;
    height: 25px;
    animation-delay: 15s;
    animation-duration: 45s;
}

.circles li:nth-child(9){
    left: 20%;
    width: 15px;
    height: 15px;
    animation-delay: 2s;
    animation-duration: 35s;
}

.circles li:nth-child(10){
    left: 85%;
    width: 150px;
    height: 150px;
    animation-delay: 0s;
    animation-duration: 11s;
}



@keyframes animate {

    0%{
        transform: translateY(0) rotate(0deg);
        opacity: 1;
        border-radius: 0;
    }

    100%{
        transform: translateY(-1000px) rotate(720deg);
        opacity: 0;
        border-radius: 50%;
    }

}
	</style>

</head>
<body>
	<div class="area" >
            <ul class="circles">
                    <li></li>
                    <li></li>
                    <li></li>
                    <li></li>
                    <li></li>
                    <li></li>
                    <li></li>
                    <li></li>
                    <li></li>
                    <li></li>
            </ul>
    </div >

<div class="login-content">
    <div class="center">

        <div class="left-login">

            <img src="${pageContext.request.contextPath }/resources/img/everywareWlogo.png" alt="" height="70">
            <video autoplay loop muted >
                <source src="${pageContext.request.contextPath }/resources/video/loginVideo.mp4">
            </video>
        </div>

        <form action="/everyware/login" method="post" id="form">
            <div class="right-login">
                <div class="input-total">
                    <b class="login-title">LOGIN</b>
                    <div class="login-form">
                        <div class="login-input">
                            <p style="color: #007bff; font-size: 20px;">ID</p>
                            <input class="logInput"  type="text" id="empId" name="username" required placeholder="아이디를 입력해주세요">
                        </div>
                        <br>
                        <div>
                            <p style="color: #007bff; font-size: 20px;">Password</p>
                            <input class="logInput" type="password" required id="empPass" name="password"  placeholder="비밀번호를 입력해주세요">
                        </div>
                        <button type="submit" class="login-button">LOGIN</button>
                        <div class="search-login" style="color: #007bff;">
                            <h5> <input type="checkbox"> 아이디 저장</h5>
                            <h5>비밀번호 찾기</h5>
                        </div>
                        <div style="display: flex;">
                            <button class="cheat" id="emp">사원</button>
                            <button class="cheat" id="client">관리자</button>
                        </div>
                    </div>
                </div>
            </div>
            <sec:csrfInput/>
        </form>
    </div>
</div>
</body>
<script type="text/javascript">
$(function(){
	$("#emp").on('click',function(){
		$("#empId").val("c009")
		$("#empPass").val("c009")
	})
	$("#client").on('click',function(){
		$("#empId").val("cust001")
		$("#empPass").val("cust001")
	})
})
</script>
</html>