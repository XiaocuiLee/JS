<%@ page language="java" contentType="text/html;charset=gb2312" %>
<jsp:useBean id="code" scope="page" class="com.util.CheckCode" />
<% 
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="<%=basePath %>images/css/bootstrap.css" />
 
<script type="text/javascript" src="<%=basePath %>images/js/jquery1.9.0.min.js"></script>
<script type="text/javascript" src="<%=basePath %>images/js/bootstrap.min.js"></script>
<style type="text/css">
body{ background: url(images/img/mc1.jpg) no-repeat fixed center}
.tit{ margin:auto; margin-top:10px; margin-left:10px; text-align:left; width:350px; padding-bottom:30px;}
.login-wrap{ width:230px; padding:30px 50px 0 330px; height:250px; background:#fff url(images/img/2.jpg) no-repeat 30px 40px; margin:auto; overflow: hidden;}
.login_input{ display:block;width:210px;}
.login_user{ background: url(images/img/input_icon_1.png) no-repeat 200px center; font-family: "Lucida Sans Unicode", "Lucida Grande", sans-serif}
.login_password{ background: url(images/img/input_icon_2.png) no-repeat 200px center; font-family:"Courier New", Courier, monospace}
.login_sf{no-repeat 200px center; font-family:"Courier New", Courier, monospace}
.btn-login{ background:#40454B; box-shadow:none; text-shadow:none; color:#fff; border:none;height:35px;width:85px; line-height:26px; font-size:14px; font-family:"microsoft yahei";}
.btn-login:hover{ background:#333; color:#fff;}

/*随着屏幕高度改变字体大小*/
@media (max-height: 700px) {.tit{ margin:auto; margin-top:100px; }}
@media (max-height: 500px) {.tit{ margin:auto; margin-top:50px; }}
</style>
</head>
<SCRIPT language=javascript>
//检验表单的合法性
function checklogin() {
	if (document.loginform.username.value.replace(/\s+$|^\s+/g,"").length<=0) {
		alert("\请输入您的登陆账号！");
		document.loginform.username.focus();
		return false;
	}
	if (document.loginform.password.value.replace(/\s+$|^\s+/g,"").length<=0) {
		alert("\请输入您的密码！");
		document.loginform.password.focus();
		return false;
	} 
	else if(document.loginform.checkcode.value.replace(/\s+$|^\s+/g,"").length<=0) {
		alert("\请输入验证码！");
		document.loginform.checkcode.focus();
		return false;
	} 
	else if (document.loginform.checkcode.value != document.loginform.yzm.value) {
		alert("\验证码错误！");
		document.loginform.checkcode.focus();
		return false;
	}
}
function reg() {
	window.location="reg.jsp";
}
function lost() {
	window.location="lost.jsp";
}
</SCRIPT>
<%
String message = (String)request.getAttribute("message");
	if(message == null){
		message = "";
	}
	if (!message.trim().equals("")){
		out.println("<script language='javascript'>");
		out.println("alert('"+message+"');");
		out.println("</script>");
	}
	request.removeAttribute("message");String yzm=code.getCheckCode();
%>
<body>
<div class="tit"><img src="<%=basePath %>images/img/tit.png" alt="" /></div>
<div class="login-wrap">
<FORM name="loginform" method="post" action="<%=basePath %>AdminServlet" onSubmit="return checklogin();"> 
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td height="25" valign="bottom">用户名：</td>
    </tr><input type=hidden name=method value="one"/>
    <tr>
      <td><input type="text" class="login_input login_user" name="username" /></td>
    </tr>
    <tr>
      <td height="25" valign="bottom">密  码：</td>
    </tr>
    <tr>
      <td><input type="password"  class="login_input login_password" name="password" /></td>
    </tr>
    <tr>
      <td height="25" valign="bottom">身  份：</td>
    </tr>
    <tr>
      <td><select name="sf" class="login_input login_sf"/>
      <option value="学生用户">学生用户</option>
      <option value="教师用户">教师用户</option>
      <option value="管理用户">管理用户</option>
      </select></td>
    </tr>
     <tr>
      <td height="25" valign="bottom">验证码：</td><input type="hidden" name="yzm" value="<%=yzm %>" >
    </tr>
    <tr>
      <td><input type="text" id=checkcode  name="checkcode" /> <%=yzm %></td>
    </tr>
    <tr>
      <td height="20" valign="bottom" align="center"><input type="submit" value="用户登录"/> </td>
    </tr> 
  </table>
</FORM>
</div>
</body>
</html>