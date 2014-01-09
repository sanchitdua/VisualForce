public class Employee {
	private String name, job;
	private Integer age, salary;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public Integer getAge() {
		return age;
	}
	public void setAge(Integer age) {
		this.age = age;
	}
	public Integer getSalary() {
		return salary;
	}
	public void setSalary(Integer salary) {
		this.salary = salary;
	}
	
    /* public boolean equals(Object o){
        Boolean returnVal = false;
        if (o instanceof Employee) {
            Employee e = (Employee)o;
            returnVal =  this.name.equals(e.name) && this.job.equals(e.job) 
            && this.salary==e.salary && this.age==e.age;
        }
    	return returnVal;
    } */
    public Integer hashCode(){
    
    	return name.hashCode()+ job.hashCode()+ salary + age;
    }
}