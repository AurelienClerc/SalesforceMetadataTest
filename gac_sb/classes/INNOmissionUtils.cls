global with sharing class INNOmissionUtils {

	/**
	*	Retourne true si l'utilisateur passé en parametre est un manager
	*/
	global static Boolean userIsManager(User user){
		return userHasFullAccess(user.Id) || user.UserRole.DeveloperName == 'SCIENTIFIQUE_DIRECTION' || user.UserRole.DeveloperName == 'SCIENTIFIQUE_MANAGER';
	}
	
	/**
	*	Retourne true si l'utilisateur en parametre est un manager ou un superviseur
	*/
	global static Boolean userIsManagerOrSuperviseur(User user){
		return userHasFullAccess(user.Id) || user.UserRole.DeveloperName == 'SCIENTIFIQUE_DIRECTION' || user.UserRole.DeveloperName == 'SCIENTIFIQUE_MANAGER' || user.UserRole.DeveloperName == 'SCIENTIFIQUE_SUPERVISEUR';
	}
	
	
	
	/**
	*	Retourne true si l'utilisateur dont l'Id est passé en parametre est un manager
	*/
	global static Boolean userIsManager(Id userId){
		return userIsManager([SELECT Id, UserRole.DeveloperName FROM User WHERE Id = :userId LIMIT 1][0]);
	}
	
	/**
	*	Retourne true si l'utilisateur dont l'Id est passé en parametre est un manager ou un superviseur
	*/
	global static Boolean userIsManagerOrSuperviseur(Id userId){
		return userIsManagerOrSuperviseur([SELECT Id, UserRole.DeveloperName FROM User WHERE Id = :userId LIMIT 1][0]);
	}
	
	
	
	/**
	*	Retourne true si l'utilisateur courant est un manager
	*/
	global static Boolean userIsManager(){
		
		return userIsManager(UserInfo.getUserId());
	}
	
	/**
	*	Retourne true si l'utilisateur courant est un manager ou un superviseur
	*/
	global static Boolean userIsManagerOrSuperviseur(){
		return userIsManagerOrSuperviseur(UserInfo.getUserId());
	}
	
	
	/**
	*	Retourne true si l'utilisateur courant est dans le groupe INNO_ADVANCE_FULL_ACCESS
	*/
	global static Boolean userHasFullAccess(){
		return userHasFullAccess(UserInfo.getUserId());
	}
	
	
	/**
	*	Retourne true si l'utilisateur dont l'Id est passé en parametre dans le groupe INNO_ADVANCE_FULL_ACCESS
	*/
	global static Boolean userHasFullAccess(Id userId){
		return [SELECT id FROM GroupMember WHERE UserOrGroupId = :userId AND Group.DeveloperName = 'INNO_ADVANCE_FULL_ACCESS'].size() > 0;
	}

}