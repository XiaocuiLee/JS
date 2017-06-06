<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<jsp:useBean id="cb" scope="page" class="com.bean.ComBean" />
<%
//解决jsp测试和生产环境路径不同的问题
String path = request.getContextPath(); 
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="<%=basePath %>images/css/bootstrap.css" />
<link rel="stylesheet" href="<%=basePath %>images/css/css.css" />
<script type="text/javascript" src="<%=basePath %>images/js/jquery1.9.0.min.js"></script>
<script type="text/javascript" src="<%=basePath %>images/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=basePath %>images/js/sdmenu.js"></script>
<script type="text/javascript" src="<%=basePath %>images/js/laydate/laydate.js"></script>
</head>
<SCRIPT language=javascript>
//检验表单的合法性
function check() {
	if (document.form1.username.value.replace(/\s+$|^\s+/g,"").length<=0) {  //学号以一个或多个空格开始，替换全部空格为空，
		alert("\请填写学生学号！");
		document.form1.username.focus();    //输入焦点移至对象上
		return false;
	}
	if (document.form1.password.value.replace(/\s+$|^\s+/g,"").length<=0) {
		alert("\请填写登录密码！");
		document.form1.password.focus();
		return false;
	} 
	if (document.form1.realname.value.replace(/\s+$|^\s+/g,"").length<=0) {
		alert("\请填写姓名！");
		document.form1.realname.focus();
		return false;
	} 
	if (document.form1.age.value.replace(/\s+$|^\s+/g,"").length<=0) {
		alert("\请填写年龄！");
		document.form1.age.focus();
		return false;
	} 
	if (document.form1.tel.value.replace(/\s+$|^\s+/g,"").length<=0) {
		alert("\请填写电话！");
		document.form1.tel.focus();
		return false;
	} 
	if (document.form1.address.value.replace(/\s+$|^\s+/g,"").length<=0) {
		alert("\请填写班级信息！");
		document.form1.address.focus();
		return false;
	} 
	
}
</SCRIPT>
<%
String message = (String)request.getAttribute("message"); //得到页面中message的值
	if(message == null){
		message = "";
	}
	if (!message.trim().equals("")){ 	//去掉页面传来的message的值（去两端的空格）与""比较 
		out.println("<script language='javascript'>");  //弹出一个对话框，输出message的值
		out.println("alert('"+message+"');");
		out.println("</script>");
	}
	//request.removeAttribute("message"); 
	
	String username=(String)session.getAttribute("user");  //从session对象中提取user
	if(username==null){
		response.sendRedirect(basePath+"index.jsp");   //跳转到index.jsp的页面
	}
	else{
		String method=request.getParameter("method"); //获取method的值
		String id="";
		String usernam="";
		String password="";
		String realname="";
		String sex="";
		String age="";
		String address="";
		String tel="";
		if(method.equals("upxs")){ //修改学生用户
			id=request.getParameter("id");
			List alist=cb.get1Com("select * from admin where id='"+id+"'",9);
			usernam=alist.get(1).toString();
			password=alist.get(2).toString();
			realname=alist.get(3).toString();
			sex=alist.get(4).toString();
			age=alist.get(5).toString();
			address=alist.get(6).toString();
			tel=alist.get(7).toString();
		}
%>
<body>
<div class="right_cont">
<div class="title_right"><strong>学生用户管理</strong></div>  
<div style="width:900px;margin:auto;">
<form action="<%=basePath %>AdminServlet?method=<%=method%>&id=<%=id%>" method="post" name="form1" onSubmit="return check()">
<table class="table table-bordered">
	 <tr>
     <td width="40%" align="right" nowrap="nowrap" bgcolor="#f1f1f1">学生学号：</td>
     <td width="60"><%if(method.equals("upxs")){ %><input type="text" name="username" class="span4" value="<%=usernam %>" readonly/><%}else{ %><input type="text" class="span4" name="username"/><% } %></td> 
     </tr>
     <tr>
     <td width="40%" align="right" nowrap="nowrap" bgcolor="#f1f1f1">初始密码：</td>
     <td width="60"><input type="password" name="password" class="span4" value="<%=password %>"/></td> 
     </tr>
     <tr>
     <td width="40%" align="right" nowrap="nowrap" bgcolor="#f1f1f1">用户姓名：</td>
     <td width="60"><input type="text" name="realname" class="span4" value="<%=realname %>"/></td> 
     </tr>
     <tr>
     <td width="40%" align="right" nowrap="nowrap" bgcolor="#f1f1f1">用户性别：</td>
     <td width="60"><input type="radio" name="sex" value="男" checked="checked"> 男 <input type="radio" name="sex" value="女"> 女</td> 
     </tr>
     <tr>
     <td width="40%" align="right" nowrap="nowrap" bgcolor="#f1f1f1">用户年龄：</td>
     <td width="60"><input type="text" name="age" class="span4" value="<%=age %>"/></td> 
     </tr>
     <tr>
     <td width="40%" align="right" nowrap="nowrap" bgcolor="#f1f1f1">联系电话：</td>
     <td width="60"><input type="text" name="tel" class="span4" value="<%=tel %>"/></td> 
     </tr>
     <tr>
     <td width="40%" align="right" nowrap="nowrap" bgcolor="#f1f1f1">班级信息：</td>
     <td width="60"><input type="text" name="address" class="span4" value="<%=address %>"/></td> 
     </tr> 
     <tr>
     	<td class="text-center" colspan="2"><input type="submit" value="确定" class="btn btn-info  " style="width:80px;" /></td>
     </tr>
     </table> 
</form>
   </div>  
 </div>  
</body>
<%} %>