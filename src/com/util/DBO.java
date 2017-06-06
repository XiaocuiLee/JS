package com.util;

import java.sql.*;

import javax.activation.DataSource; 

public class DBO {

	private Connection conn;
	private Statement stmt;
  	@SuppressWarnings("unused")
	private DataSource ds;   //��������Դ����
	
	public DBO()
	{
	}

	/**
		�����ݿ�
	*/
	public void open() 
	{
		try 
		{
			
			Class.forName("com.mysql.jdbc.Driver");  //������������
 			conn=DriverManager.getConnection("jdbc:mysql://localhost/js","root","root");  //��������

			stmt=conn.createStatement();  //����Statement����
			System.out.println("�����ݿ�����");
		} 
		catch (Exception ex)  //������
		{
		System.err.println("�����ݿ�ʱ����: " + ex.getMessage());
		}
	}

	/**
		�ر����ݿ⣬�����ӷ��������ӳ�
	*/
	public void close() 
	{
		try 
		{	
		//	connMgr.freeConnection("java", conn);
			conn.close();
			System.out.println ("�ͷ�����");
		} 
		catch (SQLException ex) 
		{
			System.err.println("�������ӳس���: " + ex.getMessage());
		}
	}

	/**
		ִ�в�ѯ
	*/
	public ResultSet executeQuery(String sql) throws SQLException
	{
		ResultSet rs = null;       //�����
		

		rs = stmt.executeQuery(sql);
		System.out.println ("ִ�в�ѯ");
		return rs;
	}

	/**
		ִ����ɾ��
	*/
	public int executeUpdate(String sql) throws SQLException
	{
		int ret = 0;
		
	
		ret = stmt.executeUpdate(sql);
	
		System.out.println ("ִ����ɾ��");
		return ret;
	}

	/**
		��SQL�����뵽������
	*/
	public void addBatch(String sql) throws SQLException 
	{
		stmt.addBatch(sql);
	}

	/**
		ִ��������
	*/
	public int [] executeBatch() throws SQLException 
	{
		@SuppressWarnings("unused")
		boolean isAuto=conn.getAutoCommit();
		
		conn.setAutoCommit(false);
		int [] updateCounts = stmt.executeBatch();
		
		return updateCounts;
	}
	
	//���� Connection ����ĵ�ǰ�Զ��ύģʽ
	public boolean getAutoCommit() throws SQLException
	{
		return conn.getAutoCommit();
	}
	
	//�������ӵ��Զ��ύģʽ����Ϊ����״̬��
	public void setAutoCommit(boolean auto)  throws SQLException 
	{
		conn.setAutoCommit(auto);
	}
	
	//ʹ�Դ���һ���ύ/�ع��������е����и��ĳ�Ϊ�־ø���
	//���ͷŴ� Connection ����ǰ������������ݿ�������
	//�˷���Ӧ��ֻ���ѽ����Զ��ύģʽʱʹ�á� 
	public void commit() throws SQLException 
	{
		conn.commit();
	}
	
	//���ݿ������޸ĺ� δcommit֮ǰ ʹ��rollback���Իָ����ݵ��޸�֮ǰ��
	public void rollBack() throws SQLException 
	{
		conn.rollback();
//		this.close();
	}
	
}
