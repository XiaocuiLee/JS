package com.action;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletConfig;   
//import javax.servlet.annotation.WebServlet;  
 
import org.apache.log4j.Logger;  

import com.bean.ComBean;
import com.util.Constant;
import com.mucfc.Log4JInitServlet;

@SuppressWarnings({ "unused", "serial" })
public class ComServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;  
    private static Logger logger = Logger.getLogger(ComServlet.class); 
	/**
	 * Constructor of the object.
	 */
	public ComServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	 public void init(ServletConfig config) throws ServletException {  
	        // TODO Auto-generated method stub  
	    } 
	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request,response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType(Constant.CONTENTTYPE);
		request.setCharacterEncoding(Constant.CHARACTERENCODING);
		HttpSession session = request.getSession();
		ComBean cBean = new ComBean();
		String date=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());
		String date2=new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
		String method = request.getParameter("method"); 
		 
		if(method.equals("addroom")){ //���ӽ�����Ϣ
			String mc = request.getParameter("mc"); 
			String fl = request.getParameter("fl"); 
			String rs = request.getParameter("rs"); 
			String sb = request.getParameter("sb");
			String xx = request.getParameter("xx");  
			String str=cBean.getString("select id from room where mc='"+mc+"'");
			if(str==null){
				int flag = cBean.comUp("insert into room(mc,fl,rs,sb,xx) values('"+mc+"','"+fl+"','"+rs+"','"+sb+"','"+xx+"')");
				if(flag == Constant.SUCCESS){
					request.setAttribute("message", "�����ɹ���");
					request.getRequestDispatcher("admin/room/index.jsp").forward(request, response);
					logger.debug("���ӽ���:"+request.getParameter("fl")+request.getParameter("mc")+"\t"+"�ɹ�\n");
				}
				else{
					request.setAttribute("message", "����ʧ�ܣ�");
					request.getRequestDispatcher("admin/room/index.jsp").forward(request, response);
					logger.debug("���ӽ���:"+request.getParameter("fl")+request.getParameter("mc")+"\t"+"ʧ��\n");
				} 
			}
			else{ 
				request.setAttribute("message", "��Ϣ�ظ���");
				request.getRequestDispatcher("admin/room/index.jsp").forward(request, response); 
				logger.debug("��Ϣ�ظ������ӽ���:"+request.getParameter("fl")+request.getParameter("mc")+"\t"+"ʧ��\n");
			} 
		}  
		else if(method.equals("uproom")){ //�޸Ľ�����Ϣ
			String id=request.getParameter("id");
			String mc = request.getParameter("mc"); 
			String fl = request.getParameter("fl"); 
			String rs = request.getParameter("rs"); 
			String sb = request.getParameter("sb");
			String xx = request.getParameter("xx");  
			String str=cBean.getString("select rs from room where mc='"+mc+"' and id!='"+id+"'");
			if(str==null){
				int flag = cBean.comUp("update room set mc='"+mc+"',fl='"+fl+"',rs='"+rs+"',sb='"+sb+"',xx='"+xx+"' where id='"+id+"'");
				if(flag == Constant.SUCCESS){ 
					request.setAttribute("message", "�����ɹ���");
					request.getRequestDispatcher("admin/room/index.jsp").forward(request, response);
					logger.debug("�޸Ľ���:"+request.getParameter("fl")+request.getParameter("mc")+"\t"+"�ɹ�\n");
				}
				else{
					request.setAttribute("message", "����ʧ�ܣ�");
					request.getRequestDispatcher("admin/room/index.jsp").forward(request, response);
					logger.debug("�޸Ľ���:"+request.getParameter("fl")+request.getParameter("mc")+"\t"+"ʧ��\n");
				}
			}
			else{ 
				request.setAttribute("message", "��Ϣ�ظ���");
				request.getRequestDispatcher("admin/room/index.jsp").forward(request, response); 
				logger.debug("��Ϣ�ظ����޸Ľ���:"+request.getParameter("fl")+request.getParameter("mc")+"\t"+"ʧ��\n");
			}  
		} 
		else if(method.equals("delroom")){//ɾ��������Ϣ
			String id = request.getParameter("id"); 
			int flag = cBean.comUp("delete from room where id='"+id+"'");
			if(flag == Constant.SUCCESS){ 
				request.setAttribute("message", "�����ɹ���");
				request.getRequestDispatcher("admin/room/index.jsp").forward(request, response);
				logger.debug("ɾ������:"+request.getParameter("fl")+request.getParameter("mc")+"\t"+"�ɹ�\n");
			}
			else{
				request.setAttribute("message", "����ʧ�ܣ�");
				request.getRequestDispatcher("admin/room/index.jsp").forward(request, response);
				logger.debug("ɾ������:"+request.getParameter("fl")+request.getParameter("mc")+"\t"+"ʧ��\n");
			}
		}
		else if(method.equals("ztroom")){ //�޸Ľ���״̬
			String id=request.getParameter("id");
			String zt = request.getParameter("zt");  
			int flag = cBean.comUp("update room set zt='"+zt+"' where id='"+id+"'");
			if(flag == Constant.SUCCESS){ 
				request.setAttribute("message", "�����ɹ���");
				request.getRequestDispatcher("admin/room/index.jsp").forward(request, response);
				logger.debug("�޸Ľ���:"+request.getParameter("fl")+request.getParameter("mc")+"״̬"+"\t"+"�ɹ�\n");
			}
			else{
				request.setAttribute("message", "����ʧ�ܣ�");
				request.getRequestDispatcher("admin/room/index.jsp").forward(request, response);
				logger.debug("�޸Ľ���:"+request.getParameter("fl")+request.getParameter("mc")+"״̬"+"\t"+"ʧ��\n");
			} 
		} 
		//--------------------------------------------------------
		else if(method.equals("adddep")){ //���ӽ�ѧ¥��Ϣ   
			String mc = request.getParameter("mc"); 
			String sm = request.getParameter("sm");  
			String str=cBean.getString("select id from dep where mc='"+mc+"'");
			if(str==null){
				int flag = cBean.comUp("insert into dep(mc,sm) values('"+mc+"','"+sm+"' )");
				if(flag == Constant.SUCCESS){
					request.setAttribute("message", "�����ɹ���");
					request.getRequestDispatcher("admin/dep/index.jsp").forward(request, response);
					logger.debug("���ӽ�ѧ¥:"+request.getParameter("mc")+"\t"+"�ɹ�\n");
				}
				else{
					request.setAttribute("message", "����ʧ�ܣ�");
					request.getRequestDispatcher("admin/dep/index.jsp").forward(request, response);
					logger.debug("���ӽ�ѧ¥:"+request.getParameter("mc")+"\t"+"ʧ��\n");
				} 
			}
			else{ 
				request.setAttribute("message", "��Ϣ�ظ���");
				request.getRequestDispatcher("admin/dep/index.jsp").forward(request, response); 
				logger.debug("��Ϣ�ظ������ӽ�ѧ¥:"+request.getParameter("mc")+"\t"+"ʧ��\n");
			} 
		}  
		else if(method.equals("updep")){ //�޸Ľ�ѧ¥��Ϣ
			String id=request.getParameter("id");
			String mc = request.getParameter("mc"); 
			String sm = request.getParameter("sm");  
			String str=cBean.getString("select rs from dep where mc='"+mc+"' and id!='"+id+"'");
			if(str==null){
				int flag = cBean.comUp("update dep set mc='"+mc+"',sm='"+sm+"' where id='"+id+"'");
				if(flag == Constant.SUCCESS){ 
					request.setAttribute("message", "�����ɹ���");
					request.getRequestDispatcher("admin/dep/index.jsp").forward(request, response);
					logger.debug("�޸Ľ�ѧ¥:"+request.getParameter("mc")+"\t"+"�ɹ�\n");
				}
				else{
					request.setAttribute("message", "����ʧ�ܣ�");
					request.getRequestDispatcher("admin/dep/index.jsp").forward(request, response);
					logger.debug("�޸Ľ�ѧ¥:"+request.getParameter("mc")+"\t"+"ʧ��\n");
				}
			}
			else{ 
				request.setAttribute("message", "��Ϣ�ظ���");
				request.getRequestDispatcher("admin/dep/index.jsp").forward(request, response);
				logger.debug("��Ϣ�ظ����޸Ľ�ѧ¥:"+request.getParameter("mc")+"\t"+"ʧ��\n");
			}  
		} 
		else if(method.equals("deldep")){//ɾ����ѧ¥��Ϣ
			String id = request.getParameter("id"); 
			int flag = cBean.comUp("delete from dep where id='"+id+"'");
			if(flag == Constant.SUCCESS){ 
				request.setAttribute("message", "�����ɹ���");
				request.getRequestDispatcher("admin/dep/index.jsp").forward(request, response);
				logger.debug("ɾ����ѧ¥:"+request.getParameter("mc")+"\t"+"�ɹ�\n");
			}
			else{
				request.setAttribute("message", "����ʧ�ܣ�");
				request.getRequestDispatcher("admin/dep/index.jsp").forward(request, response);
				logger.debug("ɾ����ѧ¥:"+request.getParameter("mc")+"\t"+"ʧ��\n");
			}
		}
		
		else if(method.equals("yyroom")){ //���ý�����Ϣ 
			String roomid=request.getParameter("roomid");
			String sj = request.getParameter("sj"); 
			String zt = request.getParameter("zt"); 
			String rs = request.getParameter("rs"); 
			String sm = request.getParameter("sm");  
			String member=(String)session.getAttribute("user"); 
			String mc=cBean.getString("select mc from room where id='"+roomid+"'");
			String rnrs=cBean.getString("select rs from room where id='"+roomid+"'");
			String xm=cBean.getString("select realname from admin where username='"+member+"'");
			String bm=cBean.getString("select fl from room where id='"+roomid+"'");
			String dh=cBean.getString("select tel from admin where username='"+member+"'");
			String str=cBean.getString("select id from prep where roomid='"+roomid+"' and sj='"+sj+"'");
			long yybh=System.currentTimeMillis();
			if(str==null){
				if(Integer.parseInt(rnrs)>=Integer.parseInt(rs)){
					int flag = cBean.comUp("insert into prep(roomid,mc,sj,zt,rs,sm,member,xm,bm,dh,ydsj,yybh) " +
							"values('"+roomid+"','"+mc+"','"+sj+"','"+zt+"','"+rs+"','"+sm+"','"+member+"','"+xm+"','"+bm+"','"+dh+"','"+date2+"','"+yybh+"' )");
					if(flag == Constant.SUCCESS){ 
						request.setAttribute("message", "�����ɹ���");
						request.getRequestDispatcher("admin/yy/yy.jsp").forward(request, response);
						logger.debug("�û���"+member+"\t���ý���:"+bm+mc+"\t"+"�ɹ�\n");
					}
					else{
						request.setAttribute("message", "����ʧ�ܣ�");
						request.getRequestDispatcher("admin/yy/yy.jsp").forward(request, response);
						logger.debug("�û���"+member+"\t���ý���:"+bm+mc+"\t"+"ʧ��\n");
					} 
				}
				else{
					request.setAttribute("message", "�������꣡");
					request.getRequestDispatcher("admin/yy/yy.jsp").forward(request, response);
					logger.debug("�������꣬�û���"+member+"\t���ý���:"+bm+mc+"\t"+"ʧ��\n");
				} 
			}
			else{
				request.setAttribute("message", "ʹ��ʱ���ͻ��");
				request.getRequestDispatcher("admin/yy/yy.jsp").forward(request, response);
				logger.debug("����ʹ��ʱ���ͻ���û���"+member+"\t���ý���:"+bm+mc+"\t"+"ʧ��\n");
			} 
		} 
		else if(method.equals("xgyy")){ //���ý�����Ϣ 
			String id=request.getParameter("id");
			String roomid=request.getParameter("roomid");
			String sj = request.getParameter("sj"); 
			String zt = request.getParameter("zt"); 
			String rs = request.getParameter("rs"); 
			String sm = request.getParameter("sm");
			String member=(String)session.getAttribute("user"); 
			String bm=cBean.getString("select fl from room where id='"+roomid+"'");
			String mc=cBean.getString("select mc from room where id='"+roomid+"'");
			String rnrs=cBean.getString("select rs from room where id='"+roomid+"'"); 
			String str=cBean.getString("select mc from prep where roomid='"+roomid+"' and sj='"+sj+"' and id!='"+id+"'");
			if(str==null){
				if(Integer.parseInt(rnrs)>=Integer.parseInt(rs)){
					int flag = cBean.comUp("update prep set roomid='"+roomid+"',mc='"+mc+"',sj='"+sj+"',zt='"+zt+"',rs='"+rs+"',sm='"+sm+"' where id='"+id+"'");
					if(flag == Constant.SUCCESS){ 
						request.setAttribute("message", "�����ɹ���");
						request.getRequestDispatcher("admin/prep/index.jsp").forward(request, response);
						logger.debug("�û���"+member+"\t���ý���:"+bm+mc+"\t"+"�ɹ�\n");
					}
					else{
						request.setAttribute("message", "����ʧ�ܣ�");
						request.getRequestDispatcher("admin/prep/index.jsp").forward(request, response);
						logger.debug("�û���"+member+"\t���ý���:"+bm+mc+"\t"+"ʧ��\n");
					} 
				}
				else{
					request.setAttribute("message", "�������꣡");
					request.getRequestDispatcher("admin/prep/index.jsp").forward(request, response);
					logger.debug("�����������꣬�û���"+member+"\t���ý���:"+bm+mc+"\t"+"ʧ��\n");
				} 
			}
			else{
				request.setAttribute("message", "ʹ��ʱ���ͻ��");
				request.getRequestDispatcher("admin/prep/index.jsp").forward(request, response);
				logger.debug("����ʹ��ʱ���ͻ���û���"+member+"\t���ý���:"+bm+mc+"\t"+"ʧ��\n");
			} 
		} 
		else if(method.equals("delyy")){//ɾ������
			String roomid=request.getParameter("roomid");
			String member=(String)session.getAttribute("user"); 
			String bm=cBean.getString("select fl from room where id='"+roomid+"'");
			String mc=cBean.getString("select mc from room where id='"+roomid+"'");
			String id = request.getParameter("id"); 
			
			logger.debug("�û�:"+member+"\tȡ�����ý���:"+bm+mc+"\t"+"�ɹ�\n");
			int flag = cBean.comUp("delete from prep where id='"+id+"'");
			if(flag == Constant.SUCCESS){ 
				request.setAttribute("message", "�����ɹ���");
				request.getRequestDispatcher("admin/yy/yy.jsp").forward(request, response);
			}
			
			else{
				request.setAttribute("message", "����ʧ�ܣ�");
				request.getRequestDispatcher("admin/yy/yy.jsp").forward(request, response);
				logger.debug("�û�:"+member+"\tȡ�����ý���:"+bm+mc+"\t"+"ʧ��\n");
			}
		}
		else if(method.equals("delyy2")){//ɾ������
			String roomid=request.getParameter("roomid");
			String member=(String)session.getAttribute("user"); 
			String bm=cBean.getString("select fl from room where id='"+roomid+"'");
			String mc=cBean.getString("select mc from room where id='"+roomid+"'");
			String id = request.getParameter("id"); 
			
			logger.debug("�û�:"+member+"\tȡ�����ý���:"+bm+mc+"\t"+"�ɹ�\n");
			int flag = cBean.comUp("delete from prep where id='"+id+"'");
			if(flag == Constant.SUCCESS){ 
				request.setAttribute("message", "�����ɹ���");
				request.getRequestDispatcher("admin/prep/index.jsp").forward(request, response);
				
			}
			else{
				request.setAttribute("message", "����ʧ�ܣ�");
				request.getRequestDispatcher("admin/prep/index.jsp").forward(request, response);
				logger.debug("�û�:"+member+"\tȡ�����ý���:"+bm+mc+"\t"+"ʧ��\n");
			}
		}
		
		else if(method.equals("shyy")){ //��˽���
			String roomid=request.getParameter("roomid");
			String member=(String)session.getAttribute("user"); 
			String bm=cBean.getString("select fl from room where id='"+roomid+"'");
			String mc=cBean.getString("select mc from room where id='"+roomid+"'");
			String id=request.getParameter("id");
			String sh = request.getParameter("sh");  
			int flag = cBean.comUp("update prep set sh='"+sh+"' where id='"+id+"'");
			if(flag == Constant.SUCCESS){ 
				request.setAttribute("message", "�����ɹ���");
				request.getRequestDispatcher("admin/prep/index.jsp").forward(request, response);
				logger.debug("�û���"+member+"\t���ý��ң�"+bm+mc+"\t��˳ɹ�\n");
			}
			else{
				request.setAttribute("message", "����ʧ�ܣ�");
				request.getRequestDispatcher("admin/prep/index.jsp").forward(request, response);
				logger.debug("�û���"+member+"\t���ý��ң�"+bm+mc+"\t��˳ɹ�\n");
			} 
		} 
		
		
		else if(method.equals("addtz")){ //���ӿγ�֪ͨ   
			String bt = request.getParameter("bt"); 
			String sj = request.getParameter("sj"); 
			String nr = request.getParameter("nr");  
			String js=(String)session.getAttribute("user");  
			int flag = cBean.comUp("insert into msg(bt,sj,nr,js) values('"+bt+"','"+sj+"','"+nr+"','"+js+"' )");
			if(flag == Constant.SUCCESS){
				request.setAttribute("message", "�����ɹ���");
				request.getRequestDispatcher("admin/msg/index.jsp").forward(request, response);
				logger.debug(js+"\t����"+bt+"�γ���Ϣ\t�ɹ�\n");
			}
			else{
				request.setAttribute("message", "����ʧ�ܣ�");
				request.getRequestDispatcher("admin/msg/index.jsp").forward(request, response);
				logger.debug(js+"\t����"+bt+"�γ���Ϣ\tʧ��\n");
			}  
		}  
		else if(method.equals("uptz")){ //�޸Ŀγ�֪ͨ  
			String id = request.getParameter("id"); 
			String bt = request.getParameter("bt"); 
			String sj = request.getParameter("sj"); 
			String nr = request.getParameter("nr");   
			int flag = cBean.comUp("update msg set bt='"+bt+"',sj='"+sj+"',nr='"+nr+"' where id='"+id+"' ");
			if(flag == Constant.SUCCESS){
				request.setAttribute("message", "�����ɹ���");
				request.getRequestDispatcher("admin/msg/index.jsp").forward(request, response);
				logger.debug((String)session.getAttribute("user")+"\t�޸�"+bt+"�γ���Ϣ\t�ɹ�\n");
			}
			else{
				request.setAttribute("message", "����ʧ�ܣ�");
				request.getRequestDispatcher("admin/msg/index.jsp").forward(request, response);
				logger.debug((String)session.getAttribute("user")+"\t�޸�"+bt+"�γ���Ϣ\t�ɹ�\n");
			}  
		}  
		else if(method.equals("deltz")){//��ʦɾ���γ�֪ͨ
			String id = request.getParameter("id"); 
			String bt = cBean.getString("select bt from msg where id='"+id+"'");
			//logger.debug((String)session.getAttribute("user")+"\tɾ��"+bt+"�γ���Ϣ\t�ɹ�\n");	
			int flag = cBean.comUp("delete from msg where id='"+id+"'");
			if(flag == Constant.SUCCESS){ 
				request.setAttribute("message", "�����ɹ���");
				request.getRequestDispatcher("admin/msg/index.jsp").forward(request, response);
				logger.debug((String)session.getAttribute("user")+"\tɾ��"+bt+"�γ���Ϣ\t�ɹ�\n");	
				
			}
			else{
				request.setAttribute("message", "����ʧ�ܣ�");
				request.getRequestDispatcher("admin/msg/index.jsp").forward(request, response);
				logger.debug((String)session.getAttribute("user")+"\tɾ��"+bt+"�γ���Ϣ\tʧ��\n");	
			}
		}
		else if(method.equals("deltz2")){//ɾ���γ�֪ͨ
			String id = request.getParameter("id"); 
			String bt = cBean.getString("select bt from msg where id='"+id+"'");
			//logger.debug((String)session.getAttribute("user")+"\tɾ��"+bt+"�γ���Ϣ\t�ɹ�\n");
			
			int flag = cBean.comUp("delete from msg where id='"+id+"'");
			if(flag == Constant.SUCCESS){ 
				request.setAttribute("message", "�����ɹ���");
				request.getRequestDispatcher("admin/msg/index2.jsp").forward(request, response);
				logger.debug((String)session.getAttribute("user")+"\tɾ��"+bt+"�γ���Ϣ\t�ɹ�\n");
			}
			else{
				request.setAttribute("message", "����ʧ�ܣ�");
				request.getRequestDispatcher("admin/msg/index2.jsp").forward(request, response);
				logger.debug((String)session.getAttribute("user")+"\tɾ��"+bt+"�γ���Ϣ\tʧ��\n");
			}
		} 
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occure
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
