<%@ page language="java" import="java.util.*,com.util.*"  contentType="text/html;charset=gb2312"%> 
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
<script type="text/javascript" src="<%=basePath %>images/js/jquery.jqprint-0.3.js"></script>
</head> 
 
<script language="javascript">
function  a(){
    $("#ddd").jqprint();
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
%>
<body>
<div class="right_cont">
<div class="title_right"><strong>�����ӡ</strong></div>  
<div style="width:100%;margin:auto;">
<div id="ddd">
<table class="table table-bordered table-striped table-hover">
     <tbody>
       <tr align="center"> 
         <td nowrap="nowrap"><strong>���</strong></td>
         <td nowrap="nowrap"><strong>���ñ��</strong></td>
         <td nowrap="nowrap"><strong>��������</strong></td>
         <td nowrap="nowrap"><strong>ʹ��ʱ��</strong></td>
         <td nowrap="nowrap"><strong>������;</strong></td> 
         <td nowrap="nowrap"><strong>����</strong></td> 
         <td nowrap="nowrap"><strong>˵��</strong></td> 
         <td nowrap="nowrap"><strong>�û�</strong></td> 
         <td nowrap="nowrap"><strong>����</strong></td> 
         <td nowrap="nowrap"><strong>��ѧ¥</strong></td> 
         <td nowrap="nowrap"><strong>��ϵ�绰</strong></td> 
         <td nowrap="nowrap"><strong>����ʱ��</strong></td>   
       </tr>
<%
	String mc=Common.toChineseAndTrim(request.getParameter("mc"));
	String ksj=Common.toChineseAndTrim(request.getParameter("ksj"));
	String esj=Common.toChineseAndTrim(request.getParameter("esj"));
	 
	List pagelist3 = cb.getCom("select * from prep where mc like '%"+mc+"%' and sj>='"+ksj+"' and sj<='"+esj+"' and sh='ͨ��' order by id desc",14);
	 
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
       </tr>
<% }} %>
       
     </tbody>
   </table>
</div>
<center><input type="button" onclick=" a()" value="��ӡ"/></center>
   </div>  
 </div>  
</body>
<%} %>
