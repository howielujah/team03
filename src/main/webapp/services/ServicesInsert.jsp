<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="${ctx}/scheduleJS/scripts/jquery-1.11.1.min.js"></script>
<!-- Bootstrap Core CSS -->
<link href="${ctx}/admin/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="${ctx}/admin/css/sb-admin.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="${ctx}/admin/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<script type="text/javascript">
	//由<body>的onLoad事件處理函數觸發此函數
	function setFocusToUserId() {
		document.forms[0].servNo.focus(); // 將游標放在mid欄位內
	}
</script>
</head>

<body onLoad="setFocusToUserId()">
<jsp:include page="../admin/Testhead_nav.jsp"/>
<div id="wrapper">
<div id="page-wrapper">
	<div class="table-responsive">
		<div class="col-lg-6">
		<h2>新增服務</h2>
			<c:set var="funcName" value="REG" scope="session" />
			<Table class="table table-bordered table-hover">
				<TR>
					<TD colspan="3">
						<form ENCTYPE="multipart/form-data" method="POST" action="${ctx}/services/services.do" id="${ctx}/services/services.do">
							<label class="fontSize">服務編號：</label> 
							<input type="text" name="servNo" value="${param.servNo}" class="fieldWidth" style="width: 180px;">
							<!--注意value屬性的內容以及顯示錯誤訊息的寫法-->
							<font size="-1" color="#FF0000">${MsgMap.errorservNoEmpty}</font>
							<font size="-1" color="#FF0000">${MsgMap.errorIDDups1}</font> <br />
							<label class="fontSize">服務類型編號：</label> 
							<input type="text" name="servTypeNo" value="${param.servTypeNo}" class="fieldWidth"style="width: 200px;"> <font color="red" size="-1">${MsgMap.errorservTypeNoEmpty}</font>
							<br /> 
							<label class="fontSize">服務名稱：</label> 
							<input type="text" name="servName" value="${param.servName}" class="fieldWidth" style="width: 200px;"> <font color="red" size="-1">${MsgMap.errorservNameEmpty}</font>
							<br /> 
							<label class="fontSize">服務描述：</label> <input type="text" name="servDesc" value="${param.servDesc}" class="fieldWidth" style="width: 180px;"> <font color="red" size="-1">${MsgMap.errorservDesc}</font>
							<br /> 
							<label class="fontSize">服務有效日期：</label> 
							<input type="date" name="servEffectiveDate" value="${param.servEffectiveDate}" class="fieldWidth" style="width: 320px;"> <font color="red" size="-1">${MsgMap.errorservEffectiveDate}</font>
							<br /> 
							<label class="fontSize">服務狀態：</label> <input type="text"name="servStatus" value="${param.servStatus}" class="fieldWidth" style="width: 120px;"> <font color="red" size="-1">${MsgMap.errorservStatus}</font>
							<br /> 
							<label class="fontSize">服務照片：</label> <Input Type="file" size="40" class="fieldWidth" style="width: 480px;" name="file1"><BR>
							<font color="red" size="-1">${MsgMap.errPicture}</font> <br />
							<div id="btnArea" align="center">
								<button type="submit" class="btn btn-sm btn-primary">送出</button> 
								<input type="hidden" name="action" value="insert"> 
								<button type="reset" name="cancel" id="cancel" class="btn btn-sm btn-primary">重填</button>
							</div>
							<br />
						</form>
					</TD>
				</TR>
			</Table>
		</div>
	</div>
	</div>
	</div>
</body>
</html>