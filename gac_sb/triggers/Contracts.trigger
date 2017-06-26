/**
 * Class Cases Trigger
 * @Author Didier HUGUET
 * @Date 2012-06-13
 * @Site http://www.synefo.fr
 * @Description Trigger on Contracts
 */
trigger Contracts on Contract (after delete, after insert, after update,before delete, before insert, before update,after undelete) {
	TriggerFactory.createHandler(Contract.sObjectType);
}