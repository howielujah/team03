package com.services.model;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.hibernate.Query;
import org.hibernate.Session;

import com.servicecarclass.model.ServiceCarClassVO;
import com.servicestep.model.ServiceStepVO;

import hibernate.util.HibernateUtil;

public class ServicesDAO_Hibernate implements ServicesDAO_interface {
	// 照servNo去選全部
	private static final String GET_ALL_STMT = "FROM ServicesVO order by servNo ";
	// 有上架的服務，要顯示給使用者看的
	private static final String GET_ALL_ON_STMT = "FROM ServicesVO where servStatus>0 order by servNo ";
	// 照去選全部
	private static final String GET_ALL_servTypeNo_STMT = "FROM ServicesVO order by servTypeNo";
	// 選取所有日期去排序的
	private static final String GET_ALL_servEffectiveDate_STMT = "FROM ServicesVO order by servEffectiveDate";
	// 照servTypeNo選單個的
	private static final String GET_ONE_servTypeNo_STMT = "FROM ServicesVO where servTypeNo=?";
	// 依servDate選單一年分
	private static final String GET_ONE_servEffectiveDate_STMT = "FROM ServicesVO where DATEPART(yyyy,servEffectiveDate)=?";
	// 依servDate選單月分
	private static final String GET_ONE_MonthDate_STMT = "FROM ServicesVO where DATEPART(mm,servEffectiveDate)=?";

	private static final String DELETE = "DELETE FROM ServicesVO where servNo =?";
	
	//private static final String GET_ALL_PRICE_TIME = "FROM ServicesVO where servStatus>0 and serviceCarClassVO.carClassVO.carClass=? order by servNo ";
	
	private List<ServicesVO> servicesVOList;

	@Override
	public void insert(ServicesVO servo) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(servo);
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
	}

	@Override
	public void update(ServicesVO servo) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(servo);
			session.getTransaction().commit();

		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
	}

	@Override
	public void delete(Integer servNo) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {

			session.beginTransaction();
			ServicesVO serVO = (ServicesVO) session.get(ServicesVO.class, servNo);
			// Query query = session.createQuery(DELETE);
			// query.setParameter(0, servNo);
			session.delete(serVO);
			// serVO.setServNo(servNo);

			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
	}

	@Override
	public ServicesVO findByPrimaryKey(Integer servNo) {
		ServicesVO serVO = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			serVO = (ServicesVO) session.get(ServicesVO.class, servNo);
			session.getTransaction().commit();

		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return serVO;
	}

	@Override
	public List<ServicesVO> findType(String servTypeNo) {
		List<ServicesVO> list = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = (Query) session.createQuery(GET_ONE_servTypeNo_STMT).setParameter(0, servTypeNo);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return list;
	}

	@Override
	public List<ServicesVO> findYear(String servEffectiveDate) {
		List<ServicesVO> list = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = (Query) session.createQuery(GET_ONE_servEffectiveDate_STMT).setParameter(0,
					servEffectiveDate);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return list;
	}

	@Override
	public List<ServicesVO> findMonth(String servEffectiveDate) {
		List<ServicesVO> list = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = (Query) session.createQuery(GET_ONE_MonthDate_STMT).setParameter(0, servEffectiveDate);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return list;
	}

	@Override
	public List<ServicesVO> getAll() {
		List<ServicesVO> list = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = (Query) session.createQuery(GET_ALL_STMT);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return list;
	}

	@Override
	public List<ServicesVO> getAllType() {
		List<ServicesVO> list = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = (Query) session.createQuery(GET_ALL_servTypeNo_STMT);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return list;
	}

	@Override
	public List<ServicesVO> getAllDate() {
		List<ServicesVO> list = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = (Query) session.createQuery(GET_ALL_servEffectiveDate_STMT);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return list;
	}

	@Override
	public Set<ServiceCarClassVO> getCarClassByServNo(Integer servNo) {
		Set<ServiceCarClassVO> set = findByPrimaryKey(servNo).getServiceCarClassVO();
		return set;
	}

	@Override
	public Set<ServiceStepVO> getservStepByServNo(Integer servNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean servNoExists(Integer serNo) throws IOException {
		boolean exist = false; // 檢查id是否已經存在
		ServicesDAO_Hibernate sdao = new ServicesDAO_Hibernate();
		if (sdao.findByPrimaryKey(serNo) != null) {
			exist = true;
		} else {
			exist = false;
		}
		return exist;
	}

	// 後來加入的方法都放這之下-----------------------

	@Override
	public List<ServicesVO> getAllForUser() {
		List<ServicesVO> list = null;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = (Query) session.createQuery(GET_ALL_ON_STMT);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return list;
	}

//	@Override
//	public List<ServicesVO> getAllPriceTime(String size) {
//		List<ServicesVO> list = null;
//		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
//		try {
//			session.beginTransaction();
//			Query query = (Query) session.createQuery(GET_ALL_PRICE_TIME);
//			query.setParameter(0, size);
//			list = query.list();
//			session.getTransaction().commit();
//		} catch (RuntimeException e) {
//			session.getTransaction().rollback();
//			throw e;
//		}
//		return list;
//	}

}
