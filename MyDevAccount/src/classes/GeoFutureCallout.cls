public class GeoFutureCallout{
    public static String cityName = '';
    
	@future(callout='true')
    public static void callout(String zipCode){
        String response = '';
    	Dom.Document doc = null;
        
        Http h = new Http();
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('http://api.geonames.org/postalCodeSearch?postalcode='+zipCode+'&maxRows=1&username=sanchitdua');
    	req.setMethod('GET');
        
        HttpResponse res = h.send(req);
        // String response = res.getBody();
        system.debug('response: '+response);
        doc = res.getBodyDocument();
        Dom.XmlNode geoNames = doc.getRootElement();
        Dom.XmlNode[] child = geoNames.getChildElement('code', null).getChildElements();
        integer counter=0;
        for(Dom.XmlNode xn: child){
            counter++;
            if(counter==2)
                response = xn.getText();
        }
        
       cityName = response;
    }
}