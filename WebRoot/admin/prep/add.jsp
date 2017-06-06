<%@ page language="java" import="java.util.*"  contentType="text/html;charset=gb2312"%>  
<jsp:useBean id="cb" scope="page" class="com.bean.ComBean" />  
<%
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
<script type="text/javascript">
function check()
{// 
	if(document.form1.sj.value==""||document.form1.zt.value==""||document.form1.rs.value==""||document.form1.sm.value=="" )
	{
		alert("全部内容都要填写！"); 
		return false;
	}
	if(isNaN(document.form1.rs.value))
	{
		alert("人数为数字！");
		document.form1.rs.focus();
		return false;
	}
}
</script>

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
	request.removeAttribute("message"); 
	
	String user=(String)session.getAttribute("user"); 
	if(user==null){
		response.sendRedirect(path+"index.jsp");
	}
	else{ 
		String method=request.getParameter("method");  
		String id=request.getParameter("id");  
		List yylist=cb.get1Com("select * from prep where id='"+id+"'",13);
%>
<body>
<div class="right_cont">
<div class="title_right"><strong>教室借用管理</strong></div>  
<div style="width:900px;margin:auto;">
<form action="<%=basePath %>ComServlet?method=<%=method%>&id=<%=id%>&roomid=<%=yylist.get(1).toString()%>" method="post" name="form1" onSubmit="return check()">
<table class="table table-bordered"> 
     <tr>
     <td width="40%" align="right" nowrap="nowrap" bgcolor="#f1f1f1">教室名称：</td>
     <td width="60"><%=yylist.get(2).toString()%></td> 
     </tr>
     <tr>
     <td width="40%" align="right" nowrap="nowrap" bgcolor="#f1f1f1">使用时间：</td>
     <td width="60"><input type="date" name="sj" class="span4" value="<%=yylist.get(3).toString()%>"/></td> 
     </tr>
     <tr>
     <td width="40%" align="right" nowrap="nowrap" bgcolor="#f1f1f1">借用用途：</td>
     <td width="60"><input type="text" name="zt" class="span4" value="<%=yylist.get(4).toString()%>"/></td> 
     </tr>
     <tr>
     <td width="40%" align="right" nowrap="nowrap" bgcolor="#f1f1f1">上课人数：</td>
     <td width="60"><input type="text" name="rs" class="span4" value="<%=yylist.get(5).toString()%>" /></td> 
     </tr> 
     <tr>
     <td width="40%" align="right" nowrap="nowrap" bgcolor="#f1f1f1">说明信息：</td>
     <td width="60"><textarea name="sm" class="span4" rows="5"><%=yylist.get(6).toString()%></textarea></td> 
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