package com.servicestep.model;

import java.util.List;

import com.services.model.ServicesVO;

public class ServiceStepService {
	private ServiceStepDAO_interface dao;

	public ServiceStepService() {
		dao = new ServiceStepDAO_Hibernate();
	}

	public ServiceStepVO addServiceStep(Integer servStep, String stepName, String stepDescp, byte[] stepPic,
			Integer servNo) {
		ServiceStepVO serviceStepVO = new ServiceStepVO();
		serviceStepVO.setServStep(servStep);
		serviceStepVO.setStepDescp(stepDescp);
		serviceStepVO.setStepName(stepName);
		serviceStepVO.setStepPic(stepPic);
		ServicesVO servicesVO = new ServicesVO();
		servicesVO.setServNo(servNo);
		dao.update(serviceStepVO);
		return serviceStepVO;
	}

	public ServiceStepVO UpdateServiceStep(Integer servStepNo, Integer servStep, String stepName, String stepDescp,
			byte[] stepPic, Integer servNo) {
		ServiceStepVO serviceStepVO = new ServiceStepVO();
		serviceStepVO.setServStepNo(servStepNo);
		serviceStepVO.setServStep(servStep);
		serviceStepVO.setStepDescp(stepDescp);
		serviceStepVO.setStepName(stepName);
		serviceStepVO.setStepPic(stepPic);
		ServicesVO servicesVO = new ServicesVO();
		servicesVO.setServNo(servNo);
		return dao.findByPrimaryKey(servStepNo);
	}

	public ServiceStepVO getOneSeviceStep(Integer servStepNo) {
		return dao.findByPrimaryKey(servStepNo);
	}

	public List<ServiceStepVO> getMoreServiceStepbyFK(Integer servNo) {
		return dao.findByForeignKey(servNo);
	}

	public List<ServiceStepVO> getAll() {
		return dao.getAll();
	}
}
