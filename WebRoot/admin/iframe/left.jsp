<%@ page language="java" import="java.util.*" contentType="text/html;charset=gb2312"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="<%=basePath %>images/css/bootstrap.css" />
<link rel="stylesheet" href="<%=basePath %>images/css/css.css" />
<script type="text/javascript" src="<%=basePath %>images/js/jquery1.9.0.min.js"></script>
<script type="text/javascript" src="<%=basePath %>images/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=basePath %>images/js/sdmenu.js"></script>
<script type="text/javascript" src="<%=basePath %>images/js/laydate/laydate.js"></script>
</HEAD>
<%
	String username=(String)session.getAttribute("user");  String sf=(String)session.getAttribute("sf");  
	if(username==null){
		response.sendRedirect(path+"index.jsp");
	}
	else{ 
%>
<body>
<div class="left">
     
<script type="text/javascript">
var myMenu;
window.onload = function() {
	myMenu = new SDMenu("my_menu");
	myMenu.init();
};
</script>

<div id="my_menu" class="sdmenu">
	<div class="collapsed">
		<span>密码信息管理</span>
		<a href="<%=basePath %>admin/system/editpwd.jsp" target="MainFrame">密码信息管理</a> 
	</div>
<%if(sf.equals("管理用户")){ %>
	<div class="collapsed">
		<span>教师用户管理</span>
		 <a href="<%=basePath %>admin/system/index.jsp" target="MainFrame">教师用户管理</a>
		 <a href="<%=basePath %>admin/system/add.jsp?method=addm" target="MainFrame">增加教师用户</a> 
		 <a href="<%=basePath %>admin/system/s.jsp" target="MainFrame">教师用户查询</a> 
	</div> 
	<div class="collapsed">
		<span>学生用户管理</span>
		 <a href="<%=basePath %>admin/xs/index.jsp" target="MainFrame">学生用户管理</a>
		 <a href="<%=basePath %>admin/xs/add.jsp?method=addxs" target="MainFrame">增加学生用户</a> 
		 <a href="<%=basePath %>admin/xs/s.jsp" target="MainFrame">学生用户查询</a> 
	</div> 
 	<div class="collapsed">
		<span>教学楼管理</span>
		<a href="<%=basePath %>admin/dep/index.jsp" target="MainFrame">教学楼管理</a>
		<a href="<%=basePath %>admin/dep/add.jsp?method=adddep" target="MainFrame">增加教学楼</a>
		<a href="<%=basePath %>admin/dep/s.jsp" target="MainFrame">教学楼查询</a> 
	</div>
	<div class="collapsed">
		<span>教室信息管理</span>
		<a href="<%=basePath %>admin/room/index.jsp" target="MainFrame">教室信息管理</a>
		<a href="<%=basePath %>admin/room/add.jsp?method=addroom" target="MainFrame">增加教室信息</a>
		<a href="<%=basePath %>admin/room/s.jsp" target="MainFrame">教室信息查询</a> 
	</div>
 	<div class="collapsed">
		<span>借用信息管理</span>
		<a href="<%=basePath %>admin/prep/index.jsp" target="MainFrame">借用信息管理</a>
		<a href="<%=basePath %>admin/prep/s.jsp" target="MainFrame">借用信息查询</a> 
	</div>
	<div class="collapsed">
		<span>信息统计报表</span>
		<a href="<%=basePath %>admin/prep/t.jsp" target="MainFrame">使用信息统计</a>
		<a href="<%=basePath %>admin/prep/t2.jsp" target="MainFrame">信息报表打印</a> 
	</div>
<%}else if(sf.equals("教师用户")){ %>
	<div class="collapsed">
		<span>用户个人信息</span>
		<a href="<%=basePath %>admin/system/index3.jsp" target="MainFrame">用户个人信息</a>  
	</div>
	<div class="collapsed">
		<span>教室借用信息</span>
		<a href="<%=basePath %>admin/yy/index.jsp" target="MainFrame">教室借用信息</a>
		<a href="<%=basePath %>admin/yy/s.jsp" target="MainFrame">查询教室信息</A>
	</div> 
	<div class="collapsed">
		<span>借用信息管理</span>
		<a href="<%=basePath %>admin/yy/yy.jsp" target="MainFrame">借用信息管理</a>
		<a href="<%=basePath %>admin/yy/yys.jsp" target="MainFrame">查询借用信息</a>
	</div> 	
	<div class="collapsed">
		<span>课程通知管理</span>
		<a href="<%=basePath %>admin/msg/index.jsp" target="MainFrame">课程通知管理</a>
		<a href="<%=basePath %>admin/msg/add.jsp?method=addtz" target="MainFrame">发送课程通知</A>
		<a href="<%=basePath %>admin/msg/s.jsp" target="MainFrame">课程通知查询</A>
	</div>
<%}else{ %>
	<div class="collapsed">
		<span>用户个人信息</span>
		<a href="<%=basePath %>admin/xs/index3.jsp" target="MainFrame">用户个人信息</a>  
	</div>
	<div class="collapsed">
		<span>教室借用信息</span>
		<a href="<%=basePath %>admin/yy/index.jsp" target="MainFrame">教室借用信息</a>
		<a href="<%=basePath %>admin/yy/s.jsp" target="MainFrame">查询教室信息</A>
	</div> 
	<div class="collapsed">
		<span>借用信息管理</span>
		<a href="<%=basePath %>admin/yy/yy.jsp" target="MainFrame">借用信息管理</a>
		<a href="<%=basePath %>admin/yy/yys.jsp" target="MainFrame">查询借用信息</a>
	</div> 
	<div class="collapsed">
		<span>课程通知信息</span>
		<a href="<%=basePath %>admin/msg/index3.jsp" target="MainFrame">课程通知信息</a> 
		<a href="<%=basePath %>admin/msg/s3.jsp" target="MainFrame">课程通知查询</A>
	</div>
<%} %>	
 	<div class="collapsed">
		<span>注销退出系统</span>
		<a onclick="if (confirm('确定要退出吗？')) return true; else return false;" href="<%=basePath %>AdminServlet?method=adminexit" target="_top" >注销退出系统</a>
	</div> 
</div>
     </div>
     <div class="Switch"></div>
     <script type="text/javascript">
	$(document).ready(function(e) {
    $(".Switch").click(function(){
	$(".left").toggle();
	 
		});
});
</script> 
</body>
<%} %>

</html>
