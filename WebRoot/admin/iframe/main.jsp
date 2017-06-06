<%@ page language="java" import="java.util.*,java.text.SimpleDateFormat"  contentType="text/html;charset=gb2312"%>
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
%>
<%
	String username=(String)session.getAttribute("user");String sf=(String)session.getAttribute("sf");
	if(username==null){
		response.sendRedirect(basePath+"/error.jsp");
	}
	else{ 
		String date2=new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
%>
<body>
<div class="right_cont">
<div class="title_right"><strong>当前用户：<%=username %> 身份：<%=sf %> 教室借用提醒 今天是：<%=date2 %>，借用在今天的教室有：</strong></div>  
<div style="width:100%;margin:auto;"> 
<table class="table table-bordered table-striped table-hover">
     <tbody>
       <tr align="center"> 
         <td nowrap="nowrap"><strong>序号</strong></td>
         <td nowrap="nowrap"><strong>借用编号</strong></td>
         <td nowrap="nowrap"><strong>教室名称</strong></td>
         <td nowrap="nowrap"><strong>使用时间</strong></td>
         <td nowrap="nowrap"><strong>借用用途</strong></td> 
         <td nowrap="nowrap"><strong>人数</strong></td> 
         <td nowrap="nowrap"><strong>说明</strong></td> 
         <td nowrap="nowrap"><strong>用户</strong></td> 
         <td nowrap="nowrap"><strong>姓名</strong></td> 
         <td nowrap="nowrap"><strong>分类</strong></td> 
         <td nowrap="nowrap"><strong>联系电话</strong></td> 
         <td nowrap="nowrap"><strong>借用时间</strong></td>  
         <td nowrap="nowrap"><strong>状态</strong></td>  
       </tr>
<% 
	List pagelist3 = cb.getCom( "select * from prep where sh='通过' and sj='"+date2+"' order by id desc",14); 
		if(!pagelist3.isEmpty()){
		for(int i=0;i<pagelist3.size();i++){
			List pagelist2 =(ArrayList)pagelist3.get(i);
%>       
       <tr align="center">
         <td nowrap="nowrap"><%=i+1 %></td> 
         <td nowrap="nowrap"><%=pagelist2.get(13).toString() %></td>
         <td nowrap="nowrap"><%=pagelist2.get(2).toString() %></td>
         <td nowrap="nowrap"><%=pagelist2.get(3).toString() %></td>
         <td nowrap="nowrap"><%=pagelist2.get(4).toString() %></td>
         <td nowrap="nowrap"><%=pagelist2.get(5).toString() %></td>
         <td nowrap="nowrap"><%=pagelist2.get(6).toString() %></td>
         <td nowrap="nowrap"><%=pagelist2.get(7).toString() %></td>
         <td nowrap="nowrap"><%=pagelist2.get(8).toString() %></td>
         <td nowrap="nowrap"><%=pagelist2.get(9).toString() %></td>
         <td nowrap="nowrap"><%=pagelist2.get(10).toString() %></td>
         <td nowrap="nowrap"><%=pagelist2.get(11).toString() %></td>
         <td nowrap="nowrap"><%=pagelist2.get(12).toString() %></td> 
       </tr>
<% }} %>
       
     </tbody>
   </table>
   </div>  
 </div>  
</body>
<%} %>
 
