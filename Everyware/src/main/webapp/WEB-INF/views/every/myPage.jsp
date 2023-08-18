<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/mypage.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
.myinfo, .mycontract{
	display: none;
}
</style>
<div class="container">
		<div class="cont-header">
			<div class="root">
				HOME
				<img src="${pageContext.request.contextPath }/resources/img/root_arw.png" />
				MYPAGE
			</div>
			<h1 class="menu" >MY PAGE</h1>
		</div>
        <div class="cont-container">
            <div class="submenu-wrap">
                <ul>
                    <li><span class="current-menu submenu" onclick="ftab(0)">멤버쉽 현황</span></li>
                    <li><span class="other-menu submenu" onclick="ftab(1)">내 정보</span></li>
                    <li><span class="other-menu submenu" onclick="ftab(2)">주문내역</span></li>
                </ul>
            </div>
            <div class="cont-cont" style="display: block;">
                <h3>잔여 멤버쉽 기간</h3>
                <div class="bar-chart-container tooltip">
                    <div class="chartDate">
                        <span class="startDate">2023-01-01</span>
                        <span class="endDate">2023-12-31</span>
                    </div>
                    <div class="bar">
                        <div class="barFill">
                        </div>
                    </div>
                    <span class="tooltiptext"></span>
                </div>
                <div class="doughnut-chart-container">
                    <div class="cloud-chart-container">
                        <h3>클라우드 사용량</h3>
                        <canvas id="cloudChart"></canvas>
                    </div>
                    <div class="mail-chart-container">
                        <h3>메일 사용량</h3>
                        <canvas id="mailChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="cont-cont" style="display: none;">
				<div class="info">
					<form>
						<div>
							<div class="form-box">
								<div class="form-title"><span>아이디</span></div>
								<div class="form-cont">a001</div>
							</div>
							<div class="form-box">
								<div class="upd-password" onclick="fmodalOpen()">
									<span>비밀번호 변경</span>
									<img src="img/root_arw.png" class="btn-img"/>
								</div>
							</div>
							<div class="form-box">
								<div class="form-title"><span>사업자명</span></div>
								<div class="form-cont">(주)에브리웨어</div>
							</div>
							<div class="form-box">
								<div class="form-title"><span>사업자번호</span></div>
								<div class="form-cont">123-45-67890</div>
							</div>
							<div class="form-box">
								<div class="form-title"><span>회사코드</span></div>
								<div class="form-cont">ew</div>
							</div>
							<div class="form-box">
								<div class="form-title"><span>주소*</span></div>
	
								<div class="form-input">
									<div class="form-input-addr">
										<input type="text" name="postCode" id="postCode" placeholder="우편번호" readonly/>
										<span class="align-postCode" onclick="DaumPostcode()">우편번호 찾기</span>
										<input type="text" name="address1" id="address1" placeholder="도로명주소" readonly/>
										<input type="text" name="address2" id="address2" placeholder="상세주소"/>
									</div>
								</div>
							</div>
							<div class="form-box">
								<div class="form-title"><span>전화번호*</span></div>
								<div class="form-input"><input type="text" name="tel"/></div>
							</div>
							<div class="form-box">
								<div class="form-title"><span>담당자</span></div>
								<div class="form-input"><input type="text" name="manager"/></div>
							</div>
							<div class="form-box">
								<div class="form-title"><span>담당자 연락처</span></div>
								<div class="form-input"><input type="text" name="managerTel"/></div>
							</div>
							<div class="btn-wrap">
								<button type="submit">저장</button>
							</div>
						</div>
					</form>
				</div>
			</div>
        </div>
		<div class="cont-cont" style="display: none;">
			<table>
				<tr>
					<th>주문일자</th>
					<th>상품정보</th>
					<th>시작일자</th>
					<th>만료일자</th>
					<th>결제금액</th>
					<th>상태</th>
				</tr>
				<tr>
					<td>2023-06-01</td>
					<td>프리미엄 어쩌고 저쩌고</td>
					<td>2023-06-01</td>
					<td>2024-05-30</td>
					<td>100,000</td>
					<td>이용중</td>
				</tr>
			</table>
		</div>
	</div>
	
	<!-- 모달 시작 -->
	<div class="password-modal">
        <div class="modal-content">
            <div class="modal-close-btn"><span onclick="fmodalClose()">X</span></div>
			<div class="modal-content-wrap">
				<div class="modal-content-title"><h1>비밀번호 변경</h1></div>
				<form>
					<div class="pass-form-wrap">
						<div class="pass-form-box">
							<div class="pass-form-title"><span>현재 비밀번호</span></div>
							<div class="pass-form-input"><input type="password" name="current-password"/></div>
						</div>
						<div class="pass-form-box">
							<div class="pass-form-title"><span>새로운 비밀번호</span></div>
							<div class="pass-form-input"><input type="password" name="new-password"/></div>
						</div>
						<div class="pass-form-box">
							<div class="pass-form-title"><span>비밀번호 확인</span></div>
							<div class="pass-form-input"><input type="password" name="new-password-confirm"/></div>
						</div>
						<div class="modal-btn-wrap">
							<span class="modal-close modal-btn" onclick="fmodalClose()">취소</span>
							<span class="modal-submit modal-btn">확인</span>
						</div>
					</div>
				</form>
			</div>
        </div>
    </div>
    <!-- 모달 끝 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	const tabs = document.querySelectorAll(".cont-cont");
	const submenus = document.querySelectorAll(".submenu");
	
	function finitTab(){
        for(let i = 0; i < tabs.length; i++){
        	tabs[i].style.display = 'none';
        	submenus[i].className = "other-menu submenu";
        }
    }
    function ftab(pNum){
        finitTab();
        tabs[pNum].style.display = 'block';
        submenus[pNum].className = "current-menu submenu";
    }
	
	
	/* 멤버십 현황 시작 */
    // 차트를 그리는 함수
    function drawDateChart() {
        var startDate = new Date('2023-01-01');
        var endDate = new Date('2023-12-31');
        var today = new Date();

        // 2023년 1월 1일부터 오늘까지의 날짜 데이터를 생성합니다.
        var passDays = Math.floor((today - startDate) / (1000 * 60 * 60 * 24));
        var totalDays = Math.floor((endDate - startDate) / (1000 * 60 * 60 * 24));
        console.log(totalDays);

        var bar = document.querySelector('.bar');
        var barFill = document.querySelector('.barFill');
        var tooltiptext = document.querySelector('.tooltiptext');

        barFill.style.width = (passDays / totalDays * 100) + '%';
        tooltiptext.innerHTML = (totalDays-passDays) + '일 남았습니다!';
    }

    drawDateChart();

    function drawCloudChart(){
        const data = {
        labels: [
            '여유 용량',
            '사용 중인 용량'
        ],
        datasets: [{
            label: 'Cloud',
            data: [300, 50],
            backgroundColor: [
            'rgba(255, 255, 255, 0.1)',
            'rgba(121, 120, 210, 0.6)'
            ],
            borderColor: 'rgb(121, 120, 210)',
            hoverOffset: 4,
            borderWidth: 1
        }]
        };

        const ctx = document.getElementById('cloudChart');

        new Chart(ctx, {
            type: 'doughnut',
            data: data  
        });
    }

    function drawMailChart(){
        const data = {
        labels: [
            '여유 용량',
            '사용 중인 용량'
        ],
        datasets: [{
            label: 'Mail',
            data: [150, 180],
            backgroundColor: [
            'rgba(255, 255, 255, 0.1)',
            'rgba(0, 181, 148, 0.6)'
            ],
            borderColor: 'rgb(0, 181, 148)',
            hoverOffset: 4,
            borderWidth: 1
        }]
        };

        const mtx = document.getElementById('mailChart');

        new Chart(mtx, {
            type: 'doughnut',
            data: data  
        });
    }
    drawCloudChart();
    drawMailChart();
    
	/* 멤버십 현황 끝 */
	
	/* 내 정보 시작 */
    
    const modal = document.querySelector('.password-modal');

    function fmodalOpen() {
    	modal.style.display = 'block';
    }

    function fmodalClose(){
    	modal.style.display = 'none';
    }

    $(document).mouseup(function (e){
    	if( $(modal).has(e.target).length === 0){
    		modal.style.display = 'none';
    	}
    });


    function DaumPostcode() {
    	new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postCode').value = data.zonecode;
                document.getElementById("address1").value = addr + ' ' + extraAddr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("address2").focus();
            }
        }).open();
    }
    
	/* 내 정보 끝 */
</script>