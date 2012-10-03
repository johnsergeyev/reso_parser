package classes
{
	public class Car
	{
		private var name:String;
		private var id:String = "id не указан";
		private var group:String;
		
		public function Car(str:String, group:String = null)
		{
			str = str.replace(/;/gi,",");
			var _index:int = str.indexOf(" [");
			this.group = group;
			this.name = correct(str.slice(0, _index));
			if (_index != -1)
				this.id = str.slice(_index+2,str.indexOf("]"));
			if (group == null) {
				trace(name+" "+id);
				Controller.tracer.call(null,name+" "+id); 
			} else {
				trace(group+" : "+name+" "+id);
				Controller.tracer.call(null,group+" : "+name+" "+id);
			}
		}
		
		public function get getName():String 
		{
			return this.name;
		}
		
		public function get getId():String
		{
			return this.id;
		}
		
		public function get getGroup():String
		{
			return this.group;
		}
		
		private function correct(str:String):String 
		{
			while ((str.charAt(0)==',')||(str.charAt(0)==" ")) {
				str = str.slice(1);
			}
			while ((str.charAt(str.length-1)==',')||(str.charAt(str.length-1)==" ")) {
				str = str.slice(0,str.length-1);
			}
			return str;
		}
	}
}