public class RestrictingOrgTriggerExecution {
	public static Boolean isAfterOrIsUpdate;
	public static Boolean isAfterUpdate = false;
	public static Boolean isBeforeUpdate = false;
	static{
		isAfterOrIsUpdate = false;
	}
	/* public RestrictingOrgTriggerExecution(Boolean staticVariableChange){
		isAfterOrIsUpdate = true;
	}
	public RestrictingOrgTriggerExecution(){
		
	} */
}