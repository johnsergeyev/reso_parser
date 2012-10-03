package classes
{
	import interfaces.IDataString;
	
	import org.osmf.net.StreamType;

	public class GroupData implements IDataString
	{
		private var columns:Array = ["2012","2011","2010","2009","2008","2007","2006","2005","f","k"];
		private var column_ids:Array = new Array();
		private var rows:Array  = ["РСС, тыс.руб.","ТХ, %","МБП, тыс.руб.","ТДУ, %"];
		private var row_ids:Array = new Array();
		private var groups:Array = new Array();
		private var out_data:Array = new Array();
		private var type:String;
		
		public function GroupData(type:String)
		{
			this.type = type;
			columns = Controller.initData[type]["columns"];
			for (var i:int = 0; i < columns.length; i++)
				column_ids.push("c"+(i+1).toString());
			rows = Controller.initData[type]["rows"];
			for (i = 0; i < rows.length; i++)
				row_ids.push("r"+(i+1).toString());
		}
		
		public function getType():String 
		{
			return this.type;	
		}
		
		public function addDataString(str:String):void
		{
			if (isData(str, rows)) {
				if (str.indexOf('"')!=-1) {
					str = applyCommaChange(str);
				}
				var cars:Array = removeEmpty(str.slice(0, str.indexOf(rows[0])).split(','));
				var params:Object = new Object();
				str = str.slice(str.indexOf(rows[0]));
				for (var i:int = (row_ids.length-1); i >= 0; i--) {
					var row_data:Object = new Object();
					var data:String = str.slice(str.indexOf(rows[i])+(rows[i] as String).length);
					var data_array:Array = data.split(" ");
					data_array = removeEmpty(data_array);
					for (var j:int = 0; j < data_array.length; j++) {
						row_data[column_ids[j]] = data_array[j];
					}
					str = str.slice(0, str.indexOf(rows[i]));
					params[row_ids[i]] = row_data;
				}
				if (cars.length) {
					var arr:Array = getCarGroup(cars[0], groups);
					var cars_group:String = arr[0];
					cars[0] = arr[1];
				}
				for (i = 0; i < cars.length; i++) {
					out_data.push({"car":new Car(cars[i]),params:"params"});
				}
			}
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
		
		public function isCopy(str:String):Boolean
		{
			if (str.indexOf("СТРАХУЕТСЯ КАК") == -1) return false;
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