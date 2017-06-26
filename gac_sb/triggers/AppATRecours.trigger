trigger AppATRecours on AppATrecours__c (after insert, after update, after delete, after undelete) {
 // modified objects whose parent records should be updated
    
    Set<Id> involvedOrganismesIds = new Set<Id>();
    
     if (Trigger.isDelete) {
         
         for(AppATrecours__c rec : trigger.old){
             involvedOrganismesIds.add(rec.OrganismeJuridiction__c);
         }
     } else {
        
       
        for(AppATrecours__c rec : trigger.new){
             involvedOrganismesIds.add(rec.OrganismeJuridiction__c);
             
             if(Trigger.isUpdate)
                involvedOrganismesIds.add(trigger.oldMap.get(rec.Id).OrganismeJuridiction__c);
                
        }
     }
     
     involvedOrganismesIds.remove(null);

     /*
      First step is to create a context for LREngine, by specifying parent and child objects and
      lookup relationship field name
     */
     LREngine.Context ctx = new LREngine.Context(AppATorganisme__c.SobjectType, // parent object
                                            AppATrecours__c.SobjectType,  // child object
                                            Schema.SObjectType.AppATrecours__c.fields.OrganismeJuridiction__c // relationship field name
                                            );     
     /*
      Next, one can add multiple rollup fields on the above relationship. 
      Here specify 
       1. The field to aggregate in child object
       2. The field to which aggregated value will be saved in master/parent object
       3. The aggregate operation to be done i.e. SUM, AVG, COUNT, MIN/MAX
     */
     ctx.add(
            new LREngine.RollupSummaryField(
                                            Schema.SObjectType.AppATorganisme__c.fields.NombreTotalRecours__c,
                                            Schema.SObjectType.AppATrecours__c.fields.RecoursFerme__c,
                                            LREngine.RollupOperation.Sum
                                         )); 
                                         
                                         
                                   
    ctx.add(
            new LREngine.RollupSummaryField(
                                            Schema.SObjectType.AppATorganisme__c.fields.NombreRecoursGagnes__c,
                                               Schema.SObjectType.AppATrecours__c.fields.recours_gagnee__c,
                                               LREngine.RollupOperation.Sum
                                         ));                                       

     /* 
      Calling rollup method returns in memory master objects with aggregated values in them. 
      Please note these master records are not persisted back, so that client gets a chance 
      to post process them after rollup
      */ 
     Sobject[] masters = LREngine.rollUp(ctx, involvedOrganismesIds);    

     // Persiste the changes in master
     update masters;

}