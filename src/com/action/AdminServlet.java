package com.action;
/**
 * 管理员登陆 增加 修改 删除  
 */
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
public class AdminServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;  
    private static Logger logger = Logger.getLogger(AdminServlet.class);
	/**
	 * Constructor of the object.
	 */
	public AdminServlet() {
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
	 * The doGet method of the servlet. 
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doPost(request,response);
	}

	/**
	 * The doPost method of the servlet. 
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
		String date=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());
		String date2=new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
		try{
			String method=request.getParameter("method").trim();
			ComBean cBean = new ComBean();
			HttpSession session = request.getSession();   
			if(method.equals("one")){//用户登录
				String username = request.getParameter("username");
				String password = request.getParameter("password"); 
				String sf = request.getParameter("sf"); 
					String str=cBean.getString("select realname from admin where username='"+username+"' and  password='"+password+"' and  sf='"+sf+"'");
					if(str==null){
						request.setAttribute("message", "登录信息错误！");
						request.getRequestDispatcher("index.jsp").forward(request, response); 
						logger.debug(sf+":"+username+"\t"+"登录失败\n"); 
					}
					else{
						session.setAttribute("user", username); 
						session.setAttribute("sf", sf); 
						request.getRequestDispatcher("admin/index.jsp").forward(request, response); 
						logger.debug(sf+":"+username+"\t"+"登录成功\n");
					} 
			}
			else if(method.equals("uppwd")){//修改密码
				String username=(String)session.getAttribute("user"); 
				String oldpwd = request.getParameter("oldpwd"); 
				String newpwd = request.getParameter("newpwd"); 
				String str=cBean.getString("select id from admin where username='"+username+"' and  password='"+oldpwd+"'");
				if(str==null){
					request.setAttribute("message", "原始密码信息错误！");
					request.getRequestDispatcher("admin/system/editpwd.jsp").forward(request, response); 
				}
				else{
					int flag=cBean.comUp("update admin set password='"+newpwd+"' where username='"+username+"'");
					if(flag == Constant.SUCCESS){ 
						request.setAttribute("message", "操作成功！");
						request.getRequestDispatcher("admin/system/editpwd.jsp").forward(request, response);
						logger.debug(session.getAttribute("sf")+":"+username+"\t"+"修改密码成功\n");
					}
					else { 
						request.setAttribute("message", "操作失败！");
						request.getRequestDispatcher("admin/system/editpwd.jsp").forward(request, response);
						logger.debug(session.getAttribute("sf")+":"+username+"\t"+"修改密码失败\n");
					}
				}
			}
			else if(method.equals("adminexit")){//退出登录
				logger.debug(session.getAttribute("sf")+":"+session.getAttribute("user")+"\t"+"退出登录\n");
				session.removeAttribute("user");
				session.removeAttribute("sf");
				request.getRequestDispatcher("index.jsp").forward(request, response);
			}
			else if(method.equals("addm")){//增加教师用户
				String username = request.getParameter("username"); 
				String password = request.getParameter("password"); 
				String realname = request.getParameter("realname"); 
				String sex = request.getParameter("sex"); 
				String age = request.getParameter("age"); 
				String address = request.getParameter("address"); 
				String tel = request.getParameter("tel");
				String str=cBean.getString("select id from admin where username='"+username+"'");
				if(str==null){ 
						int flag=cBean.comUp("insert into admin(username,password,realname,sex,age,address,tel,addtime,sf) " +
								"values('"+username+"','"+password+"','"+realname+"','"+sex+"','"+age+"','"+address+"','"+tel+"','"+date+"','教师用户')");
						if(flag == Constant.SUCCESS){ 
							request.setAttribute("message", "操作成功！");
							request.getRequestDispatcher("admin/system/index.jsp").forward(request, response); 
							logger.debug("增加教师用户:"+request.getParameter("username")+"\t"+"成功\n");
						}
						else { 
							request.setAttribute("message", "操作失败！");
							request.getRequestDispatcher("admin/system/index.jsp").forward(request, response);
							logger.debug("增加教师用户:"+request.getParameter("username")+"\t"+"失败\n");
						} 
				}
				else{
					request.setAttribute("message", "该用户名已存在！");
					request.getRequestDispatcher("admin/system/index.jsp").forward(request, response); 
					logger.debug("用户名已存在，增加教师用户:"+request.getParameter("username")+"\t"+"失败\n");
					
				} 
			}
			else if(method.equals("upm")){//修改教师用户
				String id = request.getParameter("id");
				String password = request.getParameter("password");
				String realname = request.getParameter("realname"); 
				String sex = request.getParameter("sex"); 
				String age = request.getParameter("age"); 
				String address = request.getParameter("address"); 
				String tel = request.getParameter("tel"); 
				int flag=cBean.comUp("update admin set password='"+password+"',realname='"+realname+"',sex='"+sex+"',age='"+age+"'," +
						"address='"+address+"',tel='"+tel+"' where id='"+id+"'");
				if(flag == Constant.SUCCESS){ 
					request.setAttribute("message", "操作成功！");
					request.getRequestDispatcher("admin/system/index.jsp").forward(request, response); 
					logger.debug("修改教师用户:"+request.getParameter("username")+"\t"+"成功\n");
				}
				else { 
					request.setAttribute("message", "操作失败！");
					request.getRequestDispatcher("admin/system/index.jsp").forward(request, response); 
					logger.debug("修改教师用户:"+request.getParameter("username")+"\t"+"失败\n");
				}
			}
			else if(method.equals("delm")){//删除教师用户
				String id = request.getParameter("id");  
				int flag=cBean.comUp("delete from admin where id='"+id+"'");
				if(flag == Constant.SUCCESS){ 
					request.setAttribute("message", "操作成功！");
					request.getRequestDispatcher("admin/system/index.jsp").forward(request, response); 
					logger.debug("删除教师用户:"+request.getParameter("username")+"\t"+"成功\n");
				}
				else { 
					request.setAttribute("message", "操作失败！");
					request.getRequestDispatcher("admin/system/index.jsp").forward(request, response); 
					logger.debug("删除教师用户:"+request.getParameter("username")+"\t"+"失败\n");
				}
			}
			
			
			else if(method.equals("addxs")){//增加学生用户
				String username = request.getParameter("username"); 
				String password = request.getParameter("password"); 
				String realname = request.getParameter("realname"); 
				String sex = request.getParameter("sex"); 
				String age = request.getParameter("age"); 
				String address = request.getParameter("address"); 
				String tel = request.getParameter("tel");
				String str=cBean.getString("select id from admin where username='"+username+"'");
				if(str==null){ 
						int flag=cBean.comUp("insert into admin(username,password,realname,sex,age,address,tel,addtime,sf) " +
								"values('"+username+"','"+password+"','"+realname+"','"+sex+"','"+age+"','"+address+"','"+tel+"','"+date+"','学生用户')");
						if(flag == Constant.SUCCESS){ 
							request.setAttribute("message", "操作成功！");
							request.getRequestDispatcher("admin/xs/index.jsp").forward(request, response); 
							logger.debug("增加学生用户:"+request.getParameter("username")+"\t"+"成功\n");
						}
						else { 
							request.setAttribute("message", "操作失败！");
							request.getRequestDispatcher("admin/xs/index.jsp").forward(request, response); 
							logger.debug("增加学生用户:"+request.getParameter("username")+"\t"+"失败\n");
						} 
				}
				else{
					request.setAttribute("message", "该用户名已存在！");
					request.getRequestDispatcher("admin/xs/index.jsp").forward(request, response); 
					logger.debug("用户名已存在,增加学生用户:"+request.getParameter("username")+"\t"+"失败\n");
				} 
			}
			else if(method.equals("upxs")){//修改学生用户
				String id = request.getParameter("id");
				String password = request.getParameter("password");
				String realname = request.getParameter("realname"); 
				String sex = request.getParameter("sex"); 
				String age = request.getParameter("age"); 
				String address = request.getParameter("address"); 
				String tel = request.getParameter("tel"); 
				int flag=cBean.comUp("update admin set password='"+password+"',realname='"+realname+"',sex='"+sex+"',age='"+age+"'," +
						"address='"+address+"',tel='"+tel+"' where id='"+id+"'");
				if(flag == Constant.SUCCESS){ 
					request.setAttribute("message", "操作成功！");
					request.getRequestDispatcher("admin/xs/index.jsp").forward(request, response); 
					logger.debug("修改学生用户:"+request.getParameter("username")+"\t"+"成功\n");
				}
				else { 
					request.setAttribute("message", "操作失败！");
					request.getRequestDispatcher("admin/xs/index.jsp").forward(request, response); 
					logger.debug("修改学生用户:"+request.getParameter("username")+"\t"+"失败\n");
				}
			}
			else if(method.equals("delxs")){//删除学生用户
				String id = request.getParameter("id");  
				int flag=cBean.comUp("delete from admin where id='"+id+"'");
				if(flag == Constant.SUCCESS){ 
					request.setAttribute("message", "操作成功！");
					request.getRequestDispatcher("admin/xs/index.jsp").forward(request, response); 
					logger.debug("删除学生用户:"+request.getParameter("username")+"\t"+"成功\n");
				}
				else { 
					request.setAttribute("message", "操作失败！");
					request.getRequestDispatcher("admin/xs/index.jsp").forward(request, response); 
					logger.debug("删除学生用户:"+request.getParameter("username")+"\t"+"失败\n");
				}
			}
			else{//无参数传入转到错误页面
				request.getRequestDispatcher("error.jsp").forward(request, response);
			}
		}catch(Exception e){
			e.printStackTrace();
			request.getRequestDispatcher("error.jsp").forward(request, response);
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
