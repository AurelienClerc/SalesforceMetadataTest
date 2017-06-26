/**
 * Class Cases Trigger
 * @Author Didier HUGUET
 * @Date 2012-06-05
 * @Site http://www.synefo.fr
 * @Description Trigger on Events
 */
trigger Events on Event (after delete, after insert, after update,before delete, before insert, before update, after undelete) {
	TriggerFactory.createHandler(Event.sObjectType);
}