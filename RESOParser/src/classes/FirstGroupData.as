package classes
{
	import interfaces.IDataString;
	
	import org.osmf.net.StreamType;

	public class FirstGroupData extends GroupData implements IDataString
	{
		private var colums:Array = ["2012","2011","2010","2009","2008","2007","2006","2005","f","k"];
		private var column_ids:Array = new Array();
		private var rows:Array  = ["РСС, тыс.руб.","ТХ, %","МБП, тыс.руб.","ТДУ, %"];
		private var row_ids:Array = new Array();
		private var out_data:Array = new Array();
		
		public function FirstGroupData()
		{
			super();
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
				for (i = 0; i < cars.length; i++) {
					out_data.push({"car":new Car(cars[i]),params:"params"});
				}
			}
		}
	}
}