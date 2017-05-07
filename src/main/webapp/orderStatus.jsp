<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<!--[if IE 6]>
<html id="ie6" dir="ltr" lang="zh-TW">
<![endif]-->
<!--[if IE 7]>
<html id="ie7" dir="ltr" lang="zh-TW">
<![endif]-->
<!--[if IE 8]>
<html id="ie8" dir="ltr" lang="zh-TW">
<![endif]-->
<!--[if !(IE 6) | !(IE 7) | !(IE 8)  ]><!-->
<html dir="ltr" lang="zh-TW">
<!--<![endif]-->
<head>

<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>訂單狀態</title>

<!-- 中文字型 CSS -->
<link href="http://fonts.googleapis.com/earlyaccess/notosanstc.css"
	rel="stylesheet">

<!-- Bootstrap Core CSS -->
<link href="vendor/bootstrap/css/bootstrap.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css">
<link href='https://fonts.googleapis.com/css?family=Kaushan+Script'
	rel='stylesheet' type='text/css'>
<link
	href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic'
	rel='stylesheet' type='text/css'>
<link
	href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700'
	rel='stylesheet' type='text/css'>

<!-- Theme CSS -->
<link href="css/agency.css" rel="stylesheet">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js" integrity="sha384-0s5Pv64cNZJieYFkXYOTId2HMA2Lfb6q2nAcx2n0RTLUnCAoTTsS0nKEO27XyKcY" crossorigin="anonymous"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js" integrity="sha384-ZoaMbDF+4LeFxg6WdScQ9nnR1QC2MIRxA1O9KWEXQwns1G8UNyIEZIQidzb0T1fo" crossorigin="anonymous"></script>
    <![endif]-->

<link href="css/revision.css" rel="stylesheet">
 
<!-- jQuery -->
<script src="js/jquery.js"></script>
<script src="vendor/jquery/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery-ui.js"></script> 
<!--[if lt IE 9]>
	<script src="https://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->

<link rel="stylesheet" type="text/css" href="css/jquery-ui.css" /> 	

<!-- Bootstrap Core JavaScript -->
<script src="vendor/bootstrap/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/blitzer/theme.css" id="THEME_CSS"/>

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

	<style type="text/css">	
		.img-services{
			width:360px;
			height:260px;
		}
		.big-img-services{
			width:700px;
			height:500px;
		}
		.nav-fut-li{
			width: 114px;
			height: 50px;
			text-align: center;
			margin:0px 0px 0px 15px ;
		}
		.menu-fut-li{
			width: 114px;
			height: 50px;
			text-align: center;
			margin:10px 0px 0px 5px ;
		}		
		.fun-btn{
			width: 100%;
			height: 100%;
			padding:0px;
			margin:0px auto;
		    color: white;
		    background-color: #fed136;
		    border-color: #fed136;
		    font-family: "Noto Sans TC","Montserrat", "Helvetica Neue", Helvetica, Arial, sans-serif;
		    text-transform: uppercase;
		    font-weight: 700;					
		}		
		.fun-btn:hover{
			width: 100%;
			height: 100%;
			padding:0px;
			margin:0px auto;
		    color: #fed136;
		    background-color: transparent;
		    border-color: #fed136;
		    font-family: "Noto Sans TC","Montserrat", "Helvetica Neue", Helvetica, Arial, sans-serif;
		    text-transform: uppercase;
		    font-weight: 700;						
		}
		.mem-btn{
			width: 100%;
			height: 100%;
			padding:0px;
			margin:0px auto;
		    color: #fed136;
		    background-color: transparent;
		    border:0px;
		    font-family: "Noto Sans TC","Montserrat", "Helvetica Neue", Helvetica, Arial, sans-serif;
		    text-transform: uppercase;
		    font-weight: 700;					
		}
		.mem-btn:hover{
			width: 100%;
			height: 100%;
			padding:0px;
			margin:0px auto;
		    color: #fed136;
		    background-color: transparent;
		    border-color: #fed136;
		    font-family: "Noto Sans TC","Montserrat", "Helvetica Neue", Helvetica, Arial, sans-serif;
		    text-transform: uppercase;
		    font-weight: 700;						
		}	
		.dropdown-menu {
		    color: #fed136;
		    background-color: #222222;
			text-align: center;
 		    min-width: 114px; 
		}				
		.dropdown:hover .dropdown-menu {
			
			display: block;
		}		
	</style>




<!-- 驗證 -->
<script src="js/jquery.validate.js" type="text/javascript"></script>

  <script>
  $( function() {
	  
			//進入網頁後，判斷螢幕大小，設定登入按鈕及註冊按鈕樣式
		var wdth = $(window).width();
		if(wdth<975){					
 		        $("#nav-log-in").addClass("menu-fut-li");
 		  		$("#nav-register").addClass("menu-fut-li");
		}
		if(wdth>=975){
 		        $("#nav-log-in").addClass("nav-fut-li");
 		  		$("#nav-register").addClass("nav-fut-li"); 
		}
		//結束
		
		//不斷監控(監聽)螢幕大小，藉此判斷登入、註冊按鈕是在nav上或者在menu內，來設定不同的樣式
 		$(window).resize(function() {
			var wdth = $(window).width();
			var logIn = $("#nav-log-in").attr("class");
			var regst = $("#nav-register").attr("class");
			var numln = null;
			var numrn = null;
			var numlm = null;
			var numrm =	null;

			console.log(logIn);
			console.log(regst);				
			
			if(logIn != undefined){
				numln =	logIn.indexOf("nav-fut-li");
				numlm =	logIn.indexOf("menu-fut-li");
			}				
			
			//當會員登入後，註冊按鈕會不存在，所以不用去比對註冊按鈕的class
			if(regst != undefined){
				numrn =	regst.indexOf("nav-fut-li");
				numrm =	regst.indexOf("menu-fut-li");
			}

			if( (wdth < 975) && (numln > -1) && (numrn > -1) ){
	   		        $("#nav-log-in").removeClass("nav-fut-li");
	   		  		$("#nav-register").removeClass("nav-fut-li");					
	   		        $("#nav-log-in").addClass("menu-fut-li");
	   		  		$("#nav-register").addClass("menu-fut-li");
			}
			if( (wdth >= 975) && (numlm > -1) && (numrm > -1) ){
	   		        $("#nav-log-in").removeClass("menu-fut-li");
	   		  		$("#nav-register").removeClass("menu-fut-li");
	   		        $("#nav-log-in").addClass("nav-fut-li");
	   		  		$("#nav-register").addClass("nav-fut-li"); 	   		  		
			}
 		});
 			//結束  	
    
    
    
    
    
  } );
  
  
  </script>


<style>
	
	
	
</style>	
	
</head>
<body id="page-top" class="index">
	<!-- Navigation -->
	<nav id="mainNav" class="navbar navbar-default navbar-custom navbar-fixed-top affix">
		<div class="container">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header page-scroll">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span> Menu <i class="fa fa-bars"></i>
				</button>
				<a class="navbar-brand page-scroll" href="index.jsp">Car
					Detailing</a>
			</div>
	
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav navbar-right">
                   <li class="hidden">
                        <a href="#page-top"></a>
                    </li>
                    <li>
                        <a class="page-scroll ff-word" href="start_reserve.jsp">進行預約</a>                    	
                    </li>                    
                    <li>
                        <a class="page-scroll ff-word" href="#services">各類服務</a>
                    </li>
                    <li>
                        <a class="page-scroll ff-word" href="#portfolio">美容項目</a>
                    </li>
                    <li>
                        <a class="page-scroll ff-word" href="#about">關於我們</a>
                    </li>
                    <li>
                        <a class="page-scroll ff-word" href="#team">團隊成員</a>
                    </li>
                    <li>
                        <a class="page-scroll ff-word" href="#contact">聯絡我們</a>
                    </li>
                    
						<!--	未登入	-->
				<c:if test="${empty Code}">                    
                    <li id="nav-log-in" class="">                    
	                    <button class="page-scroll ff-word btn btn-xs fun-btn" onclick="location.href='login.jsp'">
	   		
							<span class="glyphicon glyphicon-log-in"></span> 登入															
	                        
	                    </button>
	                </li>
                    <li id="nav-register" class="">
                    	<button class="page-scroll ff-word btn btn-xs fun-btn" onclick="location.href='register.jsp'">
   		
							<span class="glyphicon glyphicon-user"></span> 免費註冊															
                        
                        </button>                    
                    </li>	                 
				</c:if>

						<!--	已登入	-->
				<c:if test="${!empty Code}"> 
					<li id="nav-log-in" class="dropdown">     
						<button class="page-scroll ff-word dropdown-toggle mem-btn" data-toggle="dropdown">
							<li class="glyphicon glyphicon-user"></li>&nbsp;&nbsp;&nbsp;${memberInfo.memberName}
						</button>
						
						<ul class="dropdown-menu" role="menu">
						    <li><a href="orderStatus">訂單狀態</a></li>
						    <li><a href="#">修改資料</a></li>
						    <li class="divider"></li>
						    <li><a href="#">登出</a></li>
						</ul>				              
	 				</li>
				</c:if>                    
                    										
				</ul>
			</div>
	
		</div>
	</nav>

	<section id="services">
		<div class="container">
			<div class="row">
				<div class="col-xs-1 col-sm-2 col-md-2 col-lg-2"></div>
	
				<div class="col-xs-10 col-sm-8 col-md-8 col-lg-8">
					<div class="panel panel-danger" style="border-color:salmon">
						<div class="panel-heading" style="background-color:salmon;border-color:salmon;color:white;">
							<h3 class="panel-title">註冊會員</h3>
						</div>
						
						<div class="panel-body">
							<div class="flot-chart">
								<div class="flot-chart-content" id="flot-bar-chart">

									<form id="cmxform" class="form-signin" role="form" action="MemberServlet" method="post">
									
										<br>
										
										<div class="input-group" style="border:1px solid #FFB6C1">
										  	<span class="input-group-addon" style="border-right:1px solid #FFB6C1"><i class="glyphicon glyphicon-user"></i></span>

										  	<input id="name" type="text" class="form-control required" name="name" placeholder="輸入您的姓名" value='${param.name}'>
											<small><Font color='red' >${ErrorMsgKey.NameEmptyError}</Font></small><br>
										</div>										
										
										<br>
										
										<div class="input-group" style="border:1px solid #FFB6C1">
										  	<span class="input-group-addon" style="border-right:1px solid #FFB6C1"><i class="glyphicon glyphicon-envelope"></i></span>

										  	<input id="email" type="text" class="form-control required email" name="email" placeholder="輸入您的電子郵件" value='${param.email}'>
											<small><Font color='red' >${ErrorMsgKey.EmailEmptyError}</Font></small><br>
										</div>
										
										<br>
										
										<div class="input-group" style="border:1px solid #FFB6C1">
										    <span class="input-group-addon" style="border-right:1px solid #FFB6C1"><i class="glyphicon glyphicon-lock"></i></span>

										    <input id="password" type="password" class="form-control required" name="password" placeholder="輸入您的密碼" value='${param.password}'>
										    <small><Font color='red' >${ErrorMsgKey.PasswordEmptyError}</Font></small><br>										
										</div>
										
										<br>
										
										<div class="input-group" style="border:1px solid #FFB6C1">
										    <span class="input-group-addon" style="border-right:1px solid #FFB6C1"><i class="glyphicon glyphicon-phone"></i></span>

										    <input id="phone" class="form-control required" name="phone" placeholder="輸入您的電話" value='${param.phone}'>
										    <small><Font color='red' >${ErrorMsgKey.PhoneEmptyError}</Font></small><br>

										</div>
										
										<br>										

										<div class="input-group" style="border:1px solid #FFB6C1">
										    <span class="input-group-addon" style="border-right:1px solid #FFB6C1"><i class="glyphicon glyphicon-time"></i></span>

										    <input id="datepicker" class="form-control required dateISO" name="datepicker" placeholder="輸入您的出生年月日" value='${param.birthday}'>
										    <small><Font color='red' >${ErrorMsgKey.BirthdayEmptyError}</Font></small><br>
										</div>
										
										<br>
										
										<div class="input-group" style="border:1px solid #FFB6C1">
										    <span class="input-group-addon" style="border-right:1px solid #FFB6C1"><i class="glyphicon glyphicon-time"></i></span>
										    <input id="address" type="text" class="form-control required" name="address" placeholder="輸入您的地址" value='${param.address}'>
										    <small><Font color='red' >${ErrorMsgKey.AddressEmptyError}</Font></small><br>
										</div>
										
										<br>																																			
																	
										<input type="hidden" name="action" value="insert">
										<button class="btn btn-lg btn-info btn-block" type="submit" style="background-color:#FFB6C1;border-color:#FFB6C1;color:white;" >下一步</button>
										
									</form>	
								</div>
							</div>
						</div>
						
					</div>	
				</div>
				
				<div class="col-xs-1 col-sm-2 col-md-2 col-lg-2"></div>
	
			</div>
		</div>
	</section>
	


</body>
</html>