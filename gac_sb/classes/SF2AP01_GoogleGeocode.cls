public class SF2AP01_GoogleGeocode {

	@future(callout=true)
	public static void geocodeAccount(Id accId){
		
		Account acc = [SELECT Id, GoogleGeocoded__c ,BillingStreet, BillingPostalCode, BillingCity, BillingState, BillingCountry FROM Account WHERE Id = :accId];
		
		Coordinates coords = geocodeAddress(getValue(acc.BillingStreet) + ',' + getValue(acc.BillingPostalCode) + getValue(acc.BillingCity) + ',' + getValue(acc.BillingState) + ',' + getValue(acc.BillingCountry));
		
		if(coords != null){
			acc.BillingCoordinates__latitude__s = coords.lat;
			acc.BillingCoordinates__longitude__s = coords.lng;
			acc.GoogleGeocoded__c = true;
			system.debug(acc);
			update acc;
		}
		
	}
	
	
	public static Coordinates geocodeAddress(String address){
		
		
		HttpRequest req = new HttpRequest();   
		String endpoint = GoogleMapSettings__c.getInstance().Endpoint__c + '?key=' + GoogleMapSettings__c.getInstance().APIkey__c + '&address=' + EncodingUtil.urlEncode(address, 'UTF-8');

		req.setEndpoint( endpoint );
		req.setMethod('GET');
		
		try {
			Http http = new Http();
			HttpResponse response = http.send(req);
			
			if(response.getStatusCode() == 200){
				Dom.XmlNode root = response.getBodyDocument().getRootElement();
				
				if(root.getChildElement('status', null).getText() == 'OK'){
					Dom.XmlNode location = root.getChildElement('result', null).getChildElement('geometry', null).getChildElement('location', null);
					
					if(location != null){
						return new Coordinates(location);
					}
				}
			}
			
		} catch( System.Exception e) {
			System.debug('ERROR: '+ e.getMessage());
		}  

		return null;
	}
	
	
	
	public static String getValue(String value){
        return (value == null) ? '' : value + ' ';
    }
    
    
	
	public class Coordinates{
		
		public Double lat {get; set;}
		public Double lng {get; set;}
		
		public Coordinates(Double lat, Double lng){
			this.lat = lat;
			this.lng = lng;
		}
		
		public Coordinates(Dom.XmlNode locationNode){
			this.lat = Double.valueOf(locationNode.getChildElement('lat', null).getText());
			this.lng = Double.valueOf(locationNode.getChildElement('lng', null).getText());
		}
		
	}
}