package classes
{
	import org.osmf.net.StreamType;

	public class GroupData 
	{
		public function GroupData()
		{
		}
		
		public static function removeEmpty(arr:Array):Array
		{
			var _arr:Array = new Array();
			for (var i:int = 0; i < arr.length; i++) {
				var str:String = correct(arr[i]);
				if (str == "") {
					continue;
				}
				_arr.push(str);
			}
			return _arr;
		}
		
		public function isData(str:String, rows:Array):Boolean
		{
			for (var i:int = 0; i < rows.length; i++) {
				if (str.indexOf(rows[i])==-1) return false;
			}
			return true;
		}
		
		public function applyCommaChange(str:String):String
		{
			var opened:Boolean = false;
			var index:int = 0;
			var _str:String = "";
			while (index < str.length) {
				if (str.charAt(index) == '"') {
					opened = !opened;
				}
				if (str.charAt(index) == ",") {
					if (opened) {
						_str+=";";
					} else {
						_str+=str.charAt(index);
					}
				} else {
					_str+=str.charAt(index);
				}
				index++;
			}
			return _str;
		}
		
		public function getCarGroup(str:String, car_groups:Array):Array
		{
			if (!hasCarGroup(str, car_groups)) return [null, str];
			else {
				var index:int = getCarGroupIndex(str, car_groups);
				return [str.slice(0, index),str.slice(index)];
			}
		}
		
		private function getCarGroupIndex(str:String, car_groups:Array):int
		{
			var index:int = 0;
			var _index:int;
			var _str:String = str.toLocaleLowerCase();
			for (var i:int = 0; i < car_groups.length; i++) {
				var __str:String = (car_groups[i] as String).toLocaleLowerCase();
				if (_str.indexOf(__str) != -1) {
					_index = _str.indexOf(__str) + (car_groups[i] as String).length;
					 if (_index > index) {
						 index = _index;
					 }
				}
			}
			return index;
		}
		
		private function hasCarGroup(str:String, car_groups:Array):Boolean
		{
			for (var i:int = 0; i < car_groups.length; i++) {
				if (str.toLocaleLowerCase().indexOf((car_groups[i] as String).toLocaleLowerCase()) != -1) return true;
			}
			return false;
		}
		
		public static function correct(str:String):String 
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