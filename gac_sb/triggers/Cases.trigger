/**
 * Class Cases Trigger
 * @Author Didier HUGUET
 * @Date 2012-05-24
 * @Site http://www.synefo.fr
 * @Description Trigger on Case
 */
trigger Cases on Case (after delete, after insert, after update, before delete, before insert, before update, after undelete) {
	TriggerFactory.createHandler(Case.sObjectType);
}