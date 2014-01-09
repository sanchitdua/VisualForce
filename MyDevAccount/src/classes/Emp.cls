public class Emp{
    Integer id{get;set;}
    String name{get;set;}
    String job{get;set;}
    Double salary{get;set;}
    
    public Emp(Integer id, String name, String job){
    	this.id = id;
        this.name = name;
        this.job = job;
    } // END init
    
    public Boolean equals(Object obj){
        Boolean returnVal = false;
        if(obj instanceof Emp){
            Emp e = (Emp) obj;
        	returnVal = this.id == e.id && this.name.equals(e.name) && this.job.equals(e.job);
        }
    	return returnVal;
    }
    
    public Integer hashCode(){
    	return this.id + name.hashCode() + job.hashCode();
    }
    
    
}