package controller.comands
{
	import model.proxy.FlashVarsProxy;
	import model.proxy.GameModProxy;
	import model.proxy.GameProxy;
	import model.proxy.KeyboardProxy;
	import model.proxy.LettersProxy;
	import model.proxy.ServerProxy;
	import model.proxy.SharedObjectProxy;
	import model.proxy.StatisticsProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class GeneralCommand extends SimpleCommand{
		override public function execute(notification:INotification):void{
			super.execute(notification);
		}
		public function get gameProxy():GameProxy{
			return facade.retrieveProxy( GameProxy.NAME ) as GameProxy;
		}	
		public function get gameModProxy():GameModProxy{
			return facade.retrieveProxy( GameModProxy.NAME ) as GameModProxy;
		}	
		public function get statisticsProxy():StatisticsProxy{
			return facade.retrieveProxy( StatisticsProxy.NAME ) as StatisticsProxy;
		}	
		public function get sharedObjectProxy():SharedObjectProxy{
			return facade.retrieveProxy( SharedObjectProxy.NAME ) as SharedObjectProxy;
		}
		public function get lettersProxy():LettersProxy{
			return facade.retrieveProxy( LettersProxy.NAME ) as LettersProxy;
		}
		public function get keyboardProxy():KeyboardProxy{
			return facade.retrieveProxy( KeyboardProxy.NAME ) as KeyboardProxy;
		}
		public function get flashVarsProxy():FlashVarsProxy{
			return facade.retrieveProxy( FlashVarsProxy.NAME ) as FlashVarsProxy;
		}
		public function get serverProxy():ServerProxy{
			return facade.retrieveProxy( ServerProxy.NAME ) as ServerProxy;
		}
	}
}