package com.mucfc;  

import java.io.File;
import java.io.IOException;

import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.BasicConfigurator;
import org.apache.log4j.PropertyConfigurator;

/** 
 * Servlet implementation class Log4JInitServlet 
 */  
//@WebServlet("/Log4JInitServlet")  
public class Log4JInitServlet extends HttpServlet {  
    private static final long serialVersionUID = 1L;  

    /** 
     * @see HttpServlet#HttpServlet() 
     */  
    public Log4JInitServlet() {  
        super();  
        // TODO Auto-generated constructor stub  
    }  

    /** 
     * @see Servlet#init(ServletConfig) 
     */  
    public void init(ServletConfig config) throws ServletException {  
        System.out.println("Log4JInitServlet ���ڳ�ʼ�� log4j��־������Ϣ");  
        String log4jLocation = config.getInitParameter("log4j-properties-location");  

        ServletContext sc = config.getServletContext();  

        if (log4jLocation == null) {  
            System.err.println("*** û�� log4j-properties-location ��ʼ�����ļ�, ����ʹ�� BasicConfigurator��ʼ��");  
            BasicConfigurator.configure();  
        } else {  
            String webAppPath = sc.getRealPath("/");  
            String log4jProp = webAppPath + log4jLocation;  
            File yoMamaYesThisSaysYoMama = new File(log4jProp);  
            if (yoMamaYesThisSaysYoMama.exists()) {  
                System.out.println("ʹ��: " + log4jProp+"��ʼ����־������Ϣ");  
                PropertyConfigurator.configure(log4jProp);  
            } else {  
                System.err.println("*** " + log4jProp + " �ļ�û���ҵ��� ����ʹ�� BasicConfigurator��ʼ��");  
                BasicConfigurator.configure();  
            }  
        }  
        super.init(config);  
    }  

    /** 
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response) 
     */  
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {  
        // TODO Auto-generated method stub  
    }  

    /** 
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response) 
     */  
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {  
        // TODO Auto-generated method stub  
    }  

}
