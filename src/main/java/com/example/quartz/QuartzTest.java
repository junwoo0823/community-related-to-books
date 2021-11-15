package com.example.quartz;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

public class QuartzTest implements Job {
	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		System.out.println("작동 중...");
	}

}
