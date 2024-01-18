 ScheduleJobsTestBatch sch = new ScheduleJobsTestBatch();
 Datetime dt = Datetime.now().addSeconds(10);  
 String schCronExp = dt.format('s m H d M \'?\' yyyy');
 Id schedId = System.Schedule('JobName' + dt, schCronExp, sch);