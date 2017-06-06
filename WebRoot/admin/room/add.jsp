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
	if(document.form1.mc.value==""||document.form1.fl.value==""||document.form1.rs.value==""||document.form1.sb.value==""||document.form1.xx.value=="" )
	{
		alert("全部内容都要填写！");
		//document.form1.xzryj.focus();
		return false;
	}
	if(isNaN(document.form1.rs.value))
	{
		alert("容纳人数为数字！");
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
	
	String username=(String)session.getAttribute("user"); 
	if(username==null){
		response.sendRedirect(path+"index.jsp");
	}
	else{ 
		String method=request.getParameter("method");  
		String id="";String mc = "";String fl=""; String rs="";String sb=""; String xx=""; 
		if(method.equals("uproom")){
			id=request.getParameter("id");
			List jlist = cb.get1Com("select * from room where id='"+id+"'",7);
			mc=jlist.get(1).toString();
			fl=jlist.get(2).toString();
			rs=jlist.get(3).toString();
			sb=jlist.get(4).toString(); 
			xx=jlist.get(5).toString(); 
		}	  
%>
<body>
<div class="right_cont">
<div class="title_right"><strong>教室信息管理</strong></div>  
<div style="width:900px;margin:auto;">
<form action="<%=basePath %>ComServlet?method=<%=method%>&id=<%=id%>" method="post" name="form1" onSubmit="return check()">
<table class="table table-bordered"> 
     <tr>
     <td width="40%" align="right" nowrap="nowrap" bgcolor="#f1f1f1">教室名称：</td>
     <td width="60"><input type="text" name="mc" class="span4" value="<%=mc %>"/></td> 
     </tr>
     <tr>
     <td width="40%" align="right" nowrap="nowrap" bgcolor="#f1f1f1">教学楼：</td>
     <td width="60"><select name="fl">
    <%if(method.equals("uproom")){ %><option value="<%=fl%>"><%=fl%></option> <%} %> 
    <%List flist=cb.getCom("select * from dep order by id asc",2);if(!flist.isEmpty()){for(int i=0;i<flist.size();i++){List list2=(List)flist.get(i);%>
    <option value=<%=list2.get(1).toString() %>><%=list2.get(1).toString() %></option>
    <%}} %>
    </select></td> 
     </tr>
     <tr>
     <td width="40%" align="right" nowrap="nowrap" bgcolor="#f1f1f1">可容纳人数：</td>
     <td width="60"><input type="text" name="rs" class="span4" value="<%=rs %>"/></td> 
     </tr>
     <tr>
     <td width="40%" align="right" nowrap="nowrap" bgcolor="#f1f1f1">教室设备：</td>
     <td width="60"><textarea name="sb" class="span4" rows="5"><%=sb %></textarea></td> 
     </tr> 
     <td width="40%" align="right" nowrap="nowrap" bgcolor="#f1f1f1">教室介绍：</td>
     <td width="60"><textarea name="xx" class="span4" rows="5"><%=xx %></textarea></td> 
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