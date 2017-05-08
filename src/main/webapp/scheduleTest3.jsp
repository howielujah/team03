<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title id='Description'>水膜汽車美容-預約排程表 </title>
    <link rel="stylesheet" href="${ctx}/scheduleJS/jqwidgets/styles/jqx.base.css" type="text/css" />
    <link rel="stylesheet" href="${ctx}/scheduleJS/jqwidgets/styles/jqx.ui-sunny.css" type="text/css" />
    <script type="text/javascript" src="${ctx}/scheduleJS/scripts/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="${ctx}/scheduleJS/scripts/demos.js"></script>
    <script type="text/javascript" src="${ctx}/scheduleJS/jqwidgets/jqxcore.js"></script>
    <script type="text/javascript" src="${ctx}/scheduleJS/jqwidgets/jqxbuttons.js"></script>
    <script type="text/javascript" src="${ctx}/scheduleJS/jqwidgets/jqxscrollbar.js"></script>
    <script type="text/javascript" src="${ctx}/scheduleJS/jqwidgets/jqxdata.js"></script>
    <script type="text/javascript" src="${ctx}/scheduleJS/jqwidgets/jqxdata.export.js"></script>	
    <script type="text/javascript" src="${ctx}/scheduleJS/jqwidgets/jqxdate.js"></script>
    <script type="text/javascript" src="${ctx}/scheduleJS/jqwidgets/jqxscheduler.js"></script>
    <script type="text/javascript" src="${ctx}/scheduleJS/jqwidgets/jqxscheduler.api.js"></script>
    <script type="text/javascript" src="${ctx}/scheduleJS/jqwidgets/jqxdatetimeinput.js"></script>
    <script type="text/javascript" src="${ctx}/scheduleJS/jqwidgets/jqxmenu.js"></script>
    <script type="text/javascript" src="${ctx}/scheduleJS/jqwidgets/jqxcalendar.js"></script>
    <script type="text/javascript" src="${ctx}/scheduleJS/jqwidgets/jqxtooltip.js"></script>
    <script type="text/javascript" src="${ctx}/scheduleJS/jqwidgets/jqxwindow.js"></script>
    <script type="text/javascript" src="${ctx}/scheduleJS/jqwidgets/jqxcheckbox.js"></script>
    <script type="text/javascript" src="${ctx}/scheduleJS/jqwidgets/jqxlistbox.js"></script>
    <script type="text/javascript" src="${ctx}/scheduleJS/jqwidgets/jqxdropdownlist.js"></script>
    <script type="text/javascript" src="${ctx}/scheduleJS/jqwidgets/jqxnumberinput.js"></script>
    <script type="text/javascript" src="${ctx}/scheduleJS/jqwidgets/jqxradiobutton.js"></script>
    <script type="text/javascript" src="${ctx}/scheduleJS/jqwidgets/jqxinput.js"></script>
    <script type="text/javascript" src="${ctx}/scheduleJS/jqwidgets/globalization/globalize.js"></script>
    <script type="text/javascript" src="${ctx}/scheduleJS/jqwidgets/globalization/globalize.culture.de-DE.js"></script>
    <script type="text/javascript">   
    	var globalView = "weekView";
    	var newFields = [];
    	var isSave = false;
        $(document).ready(function () {
        	init();
        	$('#loading_data').hide();		//隱藏loading圖
        	$('#btn_search').click(function(){
        		var today = new Date();
        		var formatDay = today.getFullYear()+"-"+(today.getMonth()+1)+"-"+today.getDate()
//         		alert(formatDay);
        		dataClean();
        		dataSearch(formatDay,globalView); //weekly
        	});
        	$("#excelExport").click(function () {
                $("#scheduler").jqxScheduler('exportData', 'xls');
            });
        });
  
        function init(){
        	addNewFields();
        	createScheduler();
        	changeEvent();
            editEvent();
        }
        
        function addNewFields(){
        	newFields = [];
        	newFields.push({'fieldID':'status','fieldName':'Status','type':'text','hidden':'hidden'});
        	newFields.push({'fieldID':'serviceS','fieldName':'綜合服務(單選)','type':'radio','values':searchXXX1Date()});
        	newFields.push({'fieldID':'serviceM','fieldName':'單一服務(多選)','type':'checkbox','values':searchXXX2Date()});
        }
        function searchXXX1Date(){
        	var fromAjax;
        	var finalData = [];
        	$.ajax({
        		url: "OptionServlet",
        		dataType: "json",
        		data: {'option':'radio'},
        		async:false,
        		method:"POST",
        		success:function(data){
        			fromAjax = data;
        			for(var i=0;i<fromAjax.length;i++){
                		if(i==0){
                			finalData.push({'name':fromAjax[i].ServName,'value':fromAjax[i].ServNo,'checked':'checked'});	//,'checked':'checked'
                		}else{
                			finalData.push({'name':fromAjax[i].ServName,'value':fromAjax[i].ServNo});
                		}
                	}
        		},
        		error:function(data){
        			alert("ERROR");
        			//alert(JSON.stringify(data));
        		}
        	});	
        	//[{'servNo':'1001','servName':'引擎室清洗護理'},{'servNo':'1002','servName':'內裝清洗護理'},{'servNo':'1003','servName':'玻璃清潔拋光'},{'servNo':'1004','servName':'車燈霧化處理'}];
        	
        	return finalData;
        }
        
		function searchXXX2Date(){
			var fromAjax;
        	var finalData = [];
        	$.ajax({
        		url: "OptionServlet",
        		dataType: "json",
        		data: {'option':'checkbox'},
        		method:"POST",
        		async:false,
        		success:function(data){
        			fromAjax = data;
        			for(var i=0;i<fromAjax.length;i++){
                		finalData.push({'name':fromAjax[i].ServName,'value':fromAjax[i].ServNo});
                	}
        		},
        		error:function(data){
        			alert("ERROR");
        			//alert(JSON.stringify(data));
        		}
        	});	
			//[{'name':'測試CheckBox1','value':'1'},{'name':'測試CheckBox2','value':'2'},{'name':'測試CheckBox3','value':'3'},{'name':'測試CheckBox4','value':'4'}];
			
			return finalData;
        }
        
        /*畫面載入時建立Scheduler*/
    	function createScheduler(){
    		$('#scheduler').remove();
    		$('#scheduler_body').append('<div id="scheduler"></div>');	//不能.html('')跟.empty()，只能remove再append
    		var date = new Date();
    		var adapter = new $.jqx.dataAdapter(getSource());
            $("#scheduler").jqxScheduler({
             	timeZone:'Taipei Standard Time',
            	date: new $.jqx.date(date.getFullYear(), date.getMonth()+1, date.getDate()),
                width: 850,
                height: 600,
                source: adapter,
                view: 'weekView',
                theme: 'ui-sunny',
                showLegend: true,
                editDialogDateTimeFormatString: 'yyyy/MM/dd HH:mm',		//24小時制
                
                //contextMenu: false,		//鎖右鍵
                ready: function () {
                    $("#scheduler").jqxScheduler('ensureAppointmentVisible', 'id0');	//進入畫面時日期''當日，'id0'第一筆資料處
                },
             	
		/*-----------------------------Dialog 與 在地化設定----------------------------------------------------*/
                // called when the dialog is craeted.
                editDialogCreate: function (dialog, fields, editAppointment) {
                    fields.subjectLabel.html("預約項目");
                    fields.fromLabel.html("起始時間");
                    fields.toLabel.html("結束時間");
                    fields.resourceLabel.html("師傅");
                    
                    for(var i=0;i<newFields.length;i++){
//                     	alert(JSON.stringify(newFields));
                    	if(newFields[i].type=='text'){
                    		$newField = fields.locationLabel.parent().clone();
                            $('div',$newField).eq(0).html(newFields[i].fieldName);
                            $('input',$newField).eq(0).prop('id',newFields[i].fieldID);
                            $('input',$newField).eq(0).prop('name',newFields[i].fieldID);
                            fields.descriptionLabel.parent().before($newField);
                            eval('fields.'+newFields[i].fieldID+' = $newField;');
                            if(newFields[i].hidden == 'hidden'){
                            	$newField.hide();
                            }else{
                            	$newField.show();
                            }
                    	}else if(newFields[i].type=='checkbox' || newFields[i].type=='radio'){
                    		$newField = fields.locationLabel.parent().clone();
                            $('div',$newField).eq(0).html(newFields[i].fieldName);
                            $('input',$newField).eq(0).prop('id',newFields[i].fieldID);
                            $fieldTable = $('<table width="100%"></table>');
                            $fieldTr= $('<tr></tr>');
                            for(var j=0;j<newFields[i].values.length;j++){
                            	if(j%2 == 1 || (j+1) ==newFields[i].values.length){
                            		$fieldTable.append($fieldTr);
                            	}else{
                            		$fieldTr = $('<tr></tr>');
                            	}
                            	$fieldTd = $('<td></td>');
                            	$fieldInput = $('<input type="'+newFields[i].type+'" name="'+newFields[i].fieldID+'" value="'+newFields[i].values[j].value+'">');
                            	$fieldTd.append($fieldInput);
                            	$fieldTd.append(newFields[i].values[j].name);
                            	$fieldTr.append($fieldTd);
                            }
                            $('input',$newField).eq(0).after($fieldTable);
                            $('input',$newField).eq(0).remove();
                            fields.descriptionLabel.parent().before($newField);
                            eval('fields.'+newFields[i].fieldID+' = $newField;');
                            if(newFields[i].hidden == 'hidden'){
                            	$newField.hide();
                            }else{
                            	$newField.show();
                            }
                    	}else{
//                     		alert('目前不支援:'+newFields[i].type);
                    	}
                    }
                    
                },editDialogOpen: function (dialog, fields, editAppointment) {
                	isSave=false;
                	fields.repeatContainer.hide();
                	fields.repeatLabel.hide();
                	fields.timeZoneContainer.hide();
                    fields.locationContainer.hide();
                    fields.statusContainer.hide();
                    fields.allDayContainer.hide();
                    fields.resourceLabel.show();
                    fields.colorContainer.hide();
                    for(var i=0;i<newFields.length;i++){
                    	eval('$objField=fields.'+newFields[i].fieldID+';');
                    	$('input[type="text"]',$objField).each(function(){
                			$(this).val('');
                		});
                    	$('input[type="radio"],input[type="checkbox"]',$objField).each(function(){
                			$(this).prop('checked',false);
                		});
                    	if(newFields[i].type=='checkbox' || newFields[i].type=='radio'){
                    		for(var j=0;j<newFields[i].values.length;j++){
                        		if(newFields[i].values[j].checked == 'checked'){
                        			$('input[value="'+newFields[i].values[j].value+'"]',$objField).prop('checked',true);
                            	}
                        	}
                    	}
                    	if(editAppointment!=null){
                    		var fieldValue = $('#scheduler').jqxScheduler('getAppointmentProperty', editAppointment.originalData.id, newFields[i].fieldID);
                        	if(null!=fieldValue && ""!=fieldValue){
                        		if($('input[type="text"]',$objField) != null && $('input[type="text"]',$objField).length == 1){
                        			$('#'+newFields[i].fieldID,$objField).val(fieldValue);
                        		}else{
                        			valueArray = fieldValue.split(',');
                        			for(var j=0;j<valueArray.length;j++){
                        				$('input[value="'+valueArray[j]+'"]',$objField).prop('checked',true);
                        			}
                        		}
                        	}
                    	}
                    }
                },
                editDialogClose: function (dialog, fields, editAppointment) {
                	if(editAppointment!=null && isSave){
                		for(var i=0;i<newFields.length;i++){
                    		eval('$objField=fields.'+newFields[i].fieldID+';');
                    		fieldVal = "";
                    		$('input[type="text"]',$objField).each(function(){
                    			fieldVal += ","+$(this).val();
                    		});
                    		
                    		$('input[type="radio"],input[type="checkbox"]',$objField).each(function(){
                    			if($(this).prop('checked')){
                    				fieldVal += ","+$(this).val();
                    			}
                    		});
                    		$('#scheduler').jqxScheduler('setAppointmentProperty', editAppointment.originalData.id, newFields[i].fieldID, fieldVal.substring(1));
                    	}
                	}
                },
                localization: {
                    // separator of parts of a date (e.g. '/' in 11/05/1955)
                    '/': "/",
                    // separator of parts of a time (e.g. ':' in 05:44 PM)
                    ':': ":",
                    // the first day of the week (0 = Sunday, 1 = Monday, etc)
                    firstDay: 1,
                    days: {
                        // full day names
                        names: ["週日", "週一", "週二", "週三", "週四", "週五", "週六"],
                        // abbreviated day names
                        namesAbbr: ["週日", "週一", "週二", "週三", "週四", "週五", "週六"],
                        // shortest day names
                        namesShort: ["日", "一", "二", "三", "四", "五", "六"]
                    },
                    months: {
                        // full month names (13 months for lunar calendards -- 13th month should be "" if not lunar)
                        names: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月", ""],
                        // abbreviated month names
                        namesAbbr: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月", ""]
                    },
                    twoDigitYearMax: 2100,
                    dayViewString: "日檢視",
                    weekViewString: "週檢視",
                    monthViewString: "月檢視",
                    editDialogTitleString: "預約單",
                    editDialogCreateTitleString: "加入新預約單",
                    contextMenuEditAppointmentString: "修改預約單",
                    contextMenuCreateAppointmentString: "加入新預約單",
                    editDialogDescriptionString: "描述",
                    editDialogStatusString: "狀態",
                    editDialogColorString: "顏色",
                    editDialogColorPlaceHolderString: "選擇顏色",
                    editDialogSaveString: "保存",
                    editDialogDeleteString: "刪除",
                    editDialogCancelString: "取消"
                },
		/*------------------------------------------------------------------------------------------------*/
                resources:
                {
                    colorScheme: "scheme05",
                    dataField: "calendar",
                    source: getCalendar()
                },
                appointmentDataFields:
                {
                    from: "start",
                    to: "end",
                    id: "id",
                    description: "description",
                    subject: "subject",
                    resourceId: "calendar",	
//                     status: "status",
//                     readOnly: "readOnly",		/* 1. */	//設唯讀，不可點兩下修改資料
//                     resizable: "resizable",					//設不可調方框大小(更動起始.結束時間)
//                     draggable: "draggable",					//設不可拖曳
                    borderColor:"addSys"
                },
                views:
                [
                	'dayView',
                    {type:'weekView',
                     workTime:{	fromDayOfWeek: 1,
	                        	toDayOfWeek: 6,		//工作日:一到六
	                        	fromHour: 9,		//營業時間:9~21
	                        	toHour: 21
	                 },
	                 timeRuler:{
	                	 scaleStartHour : 9,		//頁面顯示時間
	                	 scaleEndHour : 21,
	                	 formatString  : "HH:mm"	//24小時制
	                 }
                    },
                    {type:'monthView',
                    	workTime:{	fromDayOfWeek: 1,
                        	toDayOfWeek: 6		//工作日:一到六
                 		}
                    }
                ]
                
            });
    	}
    	
    	function getSource(data){
        	var source =
        		{	
                    dataType: "array",
                    dataFields: [
                        { name: 'id', type: 'string' },
                        { name: 'description', type: 'string' },
                        { name: 'subject', type: 'string' },
                        { name: 'calendar', type: 'string' },
                        { name: 'start', type: 'date' },
                        { name: 'end', type: 'date' },
//                         { name: 'status', type: 'string' },
//                         { name: 'readOnly', type: 'boolean' },		/* 2. */
//                         { name: 'resizable', type: 'boolean' },
//                         { name: 'draggable', type: 'boolean' },
                        { name: 'addSys', type: 'string' }
                    ],
                    id: 'id',
                    localData: data
                };
        	return source;
        }
    	/*-------create時 讀取所有師傅-------*/
    	function getCalendar(){
    		//var calendars = [{'calendar':'蕭天怡'},{'calendar':'陳致鈞'},{'calendar':'周柏元'}];
    		var fromAjax;
    		var calendars = [];
	    		$.ajax({
	        		url: "emp/GetEmpJSON.do",
	        		dataType: "json",
	        		method:"POST",
	        		async:false,	//有return要設async:false
	        		success: function(data){
	        			fromAjax = data;
	        			for(var i=0;i<fromAjax.length;i++){
	        				calendars.push({'calendar':""+fromAjax[i].empName});
	                	}
	        		},
	        		error:function(data){	
	        		}
	        	});
    		return calendars;
    	}
    	
    	/*-------頁面切換時觸發事件-------*/
    	function changeEvent(){
    		//換日期時
    		$('#scheduler').on('dateChange', function (event) { 
    			var date = event.args.date; 
    			//alert("dateChange");alert(date);
    			
    			//當跳頁時 先clean在search當頁的資料	//***已設定***跳頁時不會去刪除新增資料庫,人工手動的save add delete才會
    			dataClean();
    			dataSearch(date.toString().substring(0, 10),globalView);
    		});
    		
    		//換檢視模式時
    		$('#scheduler').on('viewChange', function (event) { 
    			var newViewType = event.args.newViewType;
    			var date = event.args.date; 
    			//alert("viewChange");
    			globalView = newViewType;
    			dataClean();
    			dataSearch(date.toString().substring(0, 10),globalView);
    		});
    	}
    	
    	/*-------人工異動預約資料時觸發事件-------*/
    	function editEvent(){
			//Save 事件
			$('#scheduler').on('appointmentChange', function (event) { 
				var args = event.args; var appointment = args.appointment; 
				isSave = true;
				$('#scheduler').jqxScheduler('closeDialog');
				alert("Save");
				appointment.id = appointment.originalData.addSys;
// 				var jsonFinal = JSON.parse(JSON.stringify(appointment.originalData));
// 				jsonFinal.id = (appointment.id);
				alert("修改資料:"+JSON.stringify(getFinalJson(appointment)));
				editToServlet(JSON.stringify(getFinalJson(appointment)),"update");
			});
			//刪除事件
			$('#scheduler').on('appointmentDelete', function (event) { 
				var args = event.args; var appointment = args.appointment;
				if(!$('#scheduler').jqxScheduler('getAppointmentProperty', appointment.originalData.id, "delSys")){ //沒有delSys=true時
					alert("Delete");
// 					var jsonFinal = JSON.parse(JSON.stringify(appointment.originalData));
// 					jsonFinal.id = (appointment.id);
					alert("刪除資料"+JSON.stringify(getFinalJson(appointment)));
					editToServlet(JSON.stringify(getFinalJson(appointment)),"delete");
				}
			});
			//增加事件
			$('#scheduler').on('appointmentAdd', function (event) { 
				var args = event.args; var appointment = args.appointment;
				isSave = true;
				if(appointment.originalData.addSys == null || "" == appointment.originalData.addSys ){ //沒有addSys=true時
					$('#scheduler').jqxScheduler('closeDialog');
					alert("Add");
					alert("新增資料:"+JSON.stringify(appointment.originalData));
					addDate = appointment.originalData.end.toISOString().substring(0, 10);
// 					var jsonFinal = JSON.parse(JSON.stringify(appointment.originalData));
// 					jsonFinal.id = (appointment.id);
					editToServlet(JSON.stringify(getFinalJson(appointment)),"insert",addDate);
				}else{
					appointment.id = appointment.originalData.addSys;
					$('#scheduler').jqxScheduler('setAppointmentProperty', appointment.originalData.id, "addSys", true);
				}
			});
		}
    	
    	function getFinalJson(appointment){
    		var jsonFinal = JSON.parse(JSON.stringify(appointment.originalData));
    		jsonFinal.id = (appointment.id);
    		for(var i=0;i<newFields.length;i++){
    			eval("jsonFinal."+newFields[i].fieldID+"=$('#scheduler').jqxScheduler('getAppointmentProperty', appointment.originalData.id, '"+newFields[i].fieldID+"');");
    		}
    		
    		return jsonFinal;
    	}
    	
    	/*-------人工在畫面值皆新增預約時觸發事件(寫入資料庫後會同步刷新頁面資料)-------*/
    	function editToServlet(data,action,addDate){
    		$('#loading_data').show();			//顯示loading圖
    		$.ajax({
        		url: "scheduleTestServlet2",
        		dataType: "text",	//server端回傳至client端型態
        		data: {'data':data,'status':action},
        		method:"POST",
        		success: function(data){
        			alert("success");
        			if(action == 'insert'){
        				dataClean();
        				dataSearch(addDate,globalView);
        			}else{
        				$('#loading_data').hide();
        			}
        		},        		
        		error:function(data){
        			//alert("ERROR");
        			$('#loading_data').hide();		//關掉loading圖
        			//alert(JSON.stringify(data));
        		}
        	});
    	}
    	
    	/*-------(上下週.上下月.週檢視.月檢視.人工異動預約單  時觸發),傳日期'date'跟區間'view'至servlet-------*/
    	function dataSearch(date,view){
    		$('#loading_data').show();
        	$.ajax({
        		url: "MyJSON",
        		dataType: "json",
        		data:{'date':date,'view':view},
        		method:"POST",
        		success:function(data){
        			//alert(JSON.stringify(data));
        			showData(data);
        			$('#loading_data').hide();//關掉loading
        			if(view=='monthView'){
        				$('tr',$('tbody',$('#tablescheduler'))).each(function(){
        					$('td',$(this)).eq(5).prop('class','jqx-cell jqx-grid-cell jqx-item jqx-center-align jqx-top-align');
        				});
        			}
        		},
        		error:function(data){
        			alert("ERROR");
        			$('#loading_data').hide();
        			//alert(JSON.stringify(data));
        		}
        	});	
        }

        function showData(data){
        	for(var i=0;i<data.length;i++){
        		//alert(JSON.stringify(data[i]));
        		serviceM = "";					/*	讀車牌	*/
        		for(var j=0;j<data[i].CheckBox.length;j++){
        			if(j!=0){
        				serviceM += ",";
        			}
        			serviceM += data[i].CheckBox[j];					/*	讀服務項目	*/
        		}
        		var startTime = (data[i].Start).split(":");		/*	讀起始時間	*/
        		var endTime = (data[i].End).split(":");			/*	讀結束時間	*/
        		var appointment ={
                    id: data[i].ReservNo,
                    description: "NoteC: "+data[i].NoteC + ", NoteE: "+data[i].NoteE,
                    subject:  data[i].License,
                    calendar: data[i].EmpName,					/*	讀師傅	*/
                    start: new Date(data[i].Year, data[i].Month-1, data[i].Day, parseInt(startTime[0]), parseInt(startTime[1]), 0),
                    end: new Date(data[i].Year, data[i].Month-1, data[i].Day, parseInt(endTime[0]), parseInt(endTime[1]), 0),
//                     readOnly: true,			/* 3. */
//                     resizable: false,
//                     draggable: false,
                    addSys:data[i].ReservNo
                };
        		//alert(JSON.stringify(appointment));
        		$('#scheduler').jqxScheduler('addAppointment', appointment);
        		var serviceS = ""+data[i].Radio;
        		setFinalAppointment(data[i].ReservNo,{'status':data[i].Status,'serviceS':serviceS,'serviceM':serviceM})
        	}
        }
    	
        function setFinalAppointment(id,data){
        	var jsonData = $("#scheduler").jqxScheduler('getAppointments');
        	for(var i=0;i<jsonData.length;i++){
        		if(jsonData[i].id == id){
        			for(var j=0;j<newFields.length;j++){
        				eval('var fieldValue=data.'+newFields[j].fieldID+';');
        				fieldValue = fieldValue==null?"":fieldValue;
        				$('#scheduler').jqxScheduler('setAppointmentProperty', jsonData[i].originalData.id, newFields[j].fieldID, fieldValue);
        			}
        		}
        	}
    	}
        
        /*-------全頁資料清除 且不會異動到資料庫------*/
    	function dataClean(){
        	var jsonData = $("#scheduler").jqxScheduler('getAppointments');
        	for(var i=0;i<jsonData.length;i++){
        		$('#scheduler').jqxScheduler('setAppointmentProperty', jsonData[i].originalData.id, "delSys", true); // 多傳參數(set isSys=true) 讓事件知道此為系統動作
        		$('#scheduler').jqxScheduler('deleteAppointment',jsonData[i].originalData.id);
        	}
        }
    </script>
</head>
<body>
	<input type="button" id="btn_search" value="查詢" />
	<input type="button" value="匯出至Excel" id='excelExport' />
    <div><img id="loading_data" src="${ctx}/img/loading/ajax-loader.gif" /></div>
    <div id="scheduler_body" >
        <div id="scheduler"></div>
    </div>
    
</body>
</html>