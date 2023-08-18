<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주소록</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
</head>
<body>
	<div class="chart-box">
		
	</div>
	<div class="select_box"></div>
<script type="text/javascript">
$(function(){
	var data = [
		
		{
			id : "a001",
			text : "홍길동",
			children : [
				{
					id : "a002",
					text : "포카리"
				},
				{
					id : "a003",
					text : "선풍기"
				}
			]
		},
		{
			id : "a004",
			text : "모니터",
			children : [
				{
					id : "a005",
					text : "핸드폰"
				}
			]
		}
	]
	
	
	$('.chart-box').jstree({
		// 트리 설정
		'core': {
			'data': data
		},
		'checkbox': {
			'keep_selected_style': false
		},
		'plugins': ['checkbox']
	});
});
</script>
</body>
</html>