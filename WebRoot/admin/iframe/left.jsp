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
		<span>������Ϣ����</span>
		<a href="<%=basePath %>admin/system/editpwd.jsp" target="MainFrame">������Ϣ����</a> 
	</div>
<%if(sf.equals("�����û�")){ %>
	<div class="collapsed">
		<span>��ʦ�û�����</span>
		 <a href="<%=basePath %>admin/system/index.jsp" target="MainFrame">��ʦ�û�����</a>
		 <a href="<%=basePath %>admin/system/add.jsp?method=addm" target="MainFrame">���ӽ�ʦ�û�</a> 
		 <a href="<%=basePath %>admin/system/s.jsp" target="MainFrame">��ʦ�û���ѯ</a> 
	</div> 
	<div class="collapsed">
		<span>ѧ���û�����</span>
		 <a href="<%=basePath %>admin/xs/index.jsp" target="MainFrame">ѧ���û�����</a>
		 <a href="<%=basePath %>admin/xs/add.jsp?method=addxs" target="MainFrame">����ѧ���û�</a> 
		 <a href="<%=basePath %>admin/xs/s.jsp" target="MainFrame">ѧ���û���ѯ</a> 
	</div> 
 	<div class="collapsed">
		<span>��ѧ¥����</span>
		<a href="<%=basePath %>admin/dep/index.jsp" target="MainFrame">��ѧ¥����</a>
		<a href="<%=basePath %>admin/dep/add.jsp?method=adddep" target="MainFrame">���ӽ�ѧ¥</a>
		<a href="<%=basePath %>admin/dep/s.jsp" target="MainFrame">��ѧ¥��ѯ</a> 
	</div>
	<div class="collapsed">
		<span>������Ϣ����</span>
		<a href="<%=basePath %>admin/room/index.jsp" target="MainFrame">������Ϣ����</a>
		<a href="<%=basePath %>admin/room/add.jsp?method=addroom" target="MainFrame">���ӽ�����Ϣ</a>
		<a href="<%=basePath %>admin/room/s.jsp" target="MainFrame">������Ϣ��ѯ</a> 
	</div>
 	<div class="collapsed">
		<span>������Ϣ����</span>
		<a href="<%=basePath %>admin/prep/index.jsp" target="MainFrame">������Ϣ����</a>
		<a href="<%=basePath %>admin/prep/s.jsp" target="MainFrame">������Ϣ��ѯ</a> 
	</div>
	<div class="collapsed">
		<span>��Ϣͳ�Ʊ���</span>
		<a href="<%=basePath %>admin/prep/t.jsp" target="MainFrame">ʹ����Ϣͳ��</a>
		<a href="<%=basePath %>admin/prep/t2.jsp" target="MainFrame">��Ϣ�����ӡ</a> 
	</div>
<%}else if(sf.equals("��ʦ�û�")){ %>
	<div class="collapsed">
		<span>�û�������Ϣ</span>
		<a href="<%=basePath %>admin/system/index3.jsp" target="MainFrame">�û�������Ϣ</a>  
	</div>
	<div class="collapsed">
		<span>���ҽ�����Ϣ</span>
		<a href="<%=basePath %>admin/yy/index.jsp" target="MainFrame">���ҽ�����Ϣ</a>
		<a href="<%=basePath %>admin/yy/s.jsp" target="MainFrame">��ѯ������Ϣ</A>
	</div> 
	<div class="collapsed">
		<span>������Ϣ����</span>
		<a href="<%=basePath %>admin/yy/yy.jsp" target="MainFrame">������Ϣ����</a>
		<a href="<%=basePath %>admin/yy/yys.jsp" target="MainFrame">��ѯ������Ϣ</a>
	</div> 	
	<div class="collapsed">
		<span>�γ�֪ͨ����</span>
		<a href="<%=basePath %>admin/msg/index.jsp" target="MainFrame">�γ�֪ͨ����</a>
		<a href="<%=basePath %>admin/msg/add.jsp?method=addtz" target="MainFrame">���Ϳγ�֪ͨ</A>
		<a href="<%=basePath %>admin/msg/s.jsp" target="MainFrame">�γ�֪ͨ��ѯ</A>
	</div>
<%}else{ %>
	<div class="collapsed">
		<span>�û�������Ϣ</span>
		<a href="<%=basePath %>admin/xs/index3.jsp" target="MainFrame">�û�������Ϣ</a>  
	</div>
	<div class="collapsed">
		<span>���ҽ�����Ϣ</span>
		<a href="<%=basePath %>admin/yy/index.jsp" target="MainFrame">���ҽ�����Ϣ</a>
		<a href="<%=basePath %>admin/yy/s.jsp" target="MainFrame">��ѯ������Ϣ</A>
	</div> 
	<div class="collapsed">
		<span>������Ϣ����</span>
		<a href="<%=basePath %>admin/yy/yy.jsp" target="MainFrame">������Ϣ����</a>
		<a href="<%=basePath %>admin/yy/yys.jsp" target="MainFrame">��ѯ������Ϣ</a>
	</div> 
	<div class="collapsed">
		<span>�γ�֪ͨ��Ϣ</span>
		<a href="<%=basePath %>admin/msg/index3.jsp" target="MainFrame">�γ�֪ͨ��Ϣ</a> 
		<a href="<%=basePath %>admin/msg/s3.jsp" target="MainFrame">�γ�֪ͨ��ѯ</A>
	</div>
<%} %>	
 	<div class="collapsed">
		<span>ע���˳�ϵͳ</span>
		<a onclick="if (confirm('ȷ��Ҫ�˳���')) return true; else return false;" href="<%=basePath %>AdminServlet?method=adminexit" target="_top" >ע���˳�ϵͳ</a>
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
