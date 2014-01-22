public class MySecondController {
    
    public String getMyVar(){
        return 'Hi there!';
    }
    
    String searchText;
    List<Account> results;
    
    public String getSearchText(){
        return searchText;
    }
    
    public void setSearchText(String searchText){
        this.searchText = searchText;
    }
    
    public List<Account> getResults(){
        return results;
    }
    // action method
    public void doSearch(){
        // List<List<Account>>
        // SOSL
        results = (List<Account>) [FIND: searchText 
                                    Returning
                                    Account(Name, Jigsaw, Phone)
                                    ][0];
        system.debug('the results obtained are: '+results);                        
        
    }
    
    public MySecondController(ApexPages.StandardSetController controller) {

    }

}