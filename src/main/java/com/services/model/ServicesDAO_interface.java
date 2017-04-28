package com.services.model;

import java.util.List;
import java.util.Set;

import com.servicecarclass.model.ServiceCarClassVO;
import com.servicestep.model.ServiceStepVO;

public interface ServicesDAO_interface {
	public void insert(ServicesVO servo);
	public void update(ServicesVO servo);
	public void delete(Integer servNo);
	public ServicesVO findByPrimaryKey(Integer servNo);
	public List<ServicesVO> findType(String servTypeNo);
	public List<ServicesVO> findYear(String servEffectiveDate);
	public List<ServicesVO> findMonth(String servEffectiveDate);
	public List<ServicesVO> getAll();
	public List<ServicesVO> getAllType();
	public List<ServicesVO> getAllDate();
	
	public Set<ServiceCarClassVO> getCarClassByServNo(Integer servNo);
	public Set<ServiceStepVO> getservStepByServNo(Integer servNo);
	
}