package com.util;

import java.sql.*;

import javax.activation.DataSource; 

public class DBO {

	private Connection conn;
	private Statement stmt;
  	@SuppressWarnings("unused")
	private DataSource ds;   //缓冲数据源服务
	
	public DBO()
	{
	}

	/**
		打开数据库
	*/
	public void open() 
	{
		try 
		{
			
			Class.forName("com.mysql.jdbc.Driver");  //加载驱动程序
 			conn=DriverManager.getConnection("jdbc:mysql://localhost/js","root","root");  //建立连接

			stmt=conn.createStatement();  //创建Statement对象
			System.out.println("打开数据库连接");
		} 
		catch (Exception ex)  //出错处理
		{
		System.err.println("打开数据库时出错: " + ex.getMessage());
		}
	}

	/**
		关闭数据库，将连接返还给连接池
	*/
	public void close() 
	{
		try 
		{	
		//	connMgr.freeConnection("java", conn);
			conn.close();
			System.out.println ("释放连接");
		} 
		catch (SQLException ex) 
		{
			System.err.println("返还连接池出错: " + ex.getMessage());
		}
	}

	/**
		执行查询
	*/
	public ResultSet executeQuery(String sql) throws SQLException
	{
		ResultSet rs = null;       //结果集
		

		rs = stmt.executeQuery(sql);
		System.out.println ("执行查询");
		return rs;
	}

	/**
		执行增删改
	*/
	public int executeUpdate(String sql) throws SQLException
	{
		int ret = 0;
		
	
		ret = stmt.executeUpdate(sql);
	
		System.out.println ("执行增删改");
		return ret;
	}

	/**
		将SQL语句加入到批处理
	*/
	public void addBatch(String sql) throws SQLException 
	{
		stmt.addBatch(sql);
	}

	/**
		执行批处理
	*/
	public int [] executeBatch() throws SQLException 
	{
		@SuppressWarnings("unused")
		boolean isAuto=conn.getAutoCommit();
		
		conn.setAutoCommit(false);
		int [] updateCounts = stmt.executeBatch();
		
		return updateCounts;
	}
	
	//检索 Connection 对象的当前自动提交模式
	public boolean getAutoCommit() throws SQLException
	{
		return conn.getAutoCommit();
	}
	
	//将此连接的自动提交模式设置为给定状态。
	public void setAutoCommit(boolean auto)  throws SQLException 
	{
		conn.setAutoCommit(auto);
	}
	
	//使自从上一次提交/回滚以来进行的所有更改成为持久更改
	//并释放此 Connection 对象当前保存的所有数据库锁定。
	//此方法应该只在已禁用自动提交模式时使用。 
	public void commit() throws SQLException 
	{
		conn.commit();
	}
	
	//数据库里做修改后 未commit之前 使用rollback可以恢复数据到修改之前。
	public void rollBack() throws SQLException 
	{
		conn.rollback();
//		this.close();
	}
	
}
