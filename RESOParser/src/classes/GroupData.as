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
		
		public function getCarGroup(str:String):Array
		{
			if ((str.indexOf(string_a) == -1)&&(str.indexOf(string_b) == -1)) return null;
			else {
				var index:int = (str.indexOf(string_a)>str.indexOf(string_b))?(str.indexOf(string_a)+string_a.length):(str.indexOf(string_b)+string_b.length);
				return [str.slice(0, index),str.slice(index)];
			}
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