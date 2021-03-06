package com.gamehero.sxd2.util
{
	import flash.utils.ByteArray;
	
	/**
	 * @author shenliangliang
	 * @E-mail: 971935832@qq.com
	 * 创建时间：2015-11-19 下午8:54:04
	 * 
	 */
	public class SortonUtil
	{
		public static const CHINESE:String = "chinese";
		
		/** 
		 * 获取一串中文的拼音字母 
		 * @param chinese Unicode格式的中文字符串 
		 * @return 
		 * 
		 */   
		private static function convertString(chinese:String):String 
		{ 
			var len:int = chinese.length; 
			var ret:String = ""; 
			for (var i:int = 0; i < len; i++) 
			{ 
				ret += convertChar(chinese.charAt(i)); 
			} 
			return ret; 
		} 
		
		/** 
		 * 获取中文第一个字的拼音首字母 
		 * @param chineseChar 
		 * @return 
		 * 
		 */   
		private static function convertChar(chineseChar:String):String 
		{ 
			var bytes:ByteArray = new ByteArray 
			bytes.writeMultiByte(chineseChar.charAt(0), "cn-gb"); 
			var n:int = bytes[0] << 8; 
			n += bytes[1]; 
			if (isIn(0xB0A1, 0xB0C4, n)) 
				return "a"; 
			if (isIn(0XB0C5, 0XB2C0, n)) 
				return "b"; 
			if (isIn(0xB2C1, 0xB4ED, n)) 
				return "c"; 
			if (isIn(0xB4EE, 0xB6E9, n)) 
				return "d"; 
			if (isIn(0xB6EA, 0xB7A1, n)) 
				return "e"; 
			if (isIn(0xB7A2, 0xB8c0, n)) 
				return "f"; 
			if (isIn(0xB8C1, 0xB9FD, n)) 
				return "g"; 
			if (isIn(0xB9FE, 0xBBF6, n)) 
				return "h"; 
			if (isIn(0xBBF7, 0xBFA5, n)) 
				return "j"; 
			if (isIn(0xBFA6, 0xC0AB, n)) 
				return "k"; 
			if (isIn(0xC0AC, 0xC2E7, n)) 
				return "l"; 
			if (isIn(0xC2E8, 0xC4C2, n)) 
				return "m"; 
			if (isIn(0xC4C3, 0xC5B5, n)) 
				return "n"; 
			if (isIn(0xC5B6, 0xC5BD, n)) 
				return "o"; 
			if (isIn(0xC5BE, 0xC6D9, n)) 
				return "p"; 
			if (isIn(0xC6DA, 0xC8BA, n)) 
				return "q"; 
			if (isIn(0xC8BB, 0xC8F5, n)) 
				return "r"; 
			if (isIn(0xC8F6, 0xCBF0, n)) 
				return "s"; 
			if (isIn(0xCBFA, 0xCDD9, n)) 
				return "t"; 
			if (isIn(0xCDDA, 0xCEF3, n)) 
				return "w"; 
			if (isIn(0xCEF4, 0xD188, n)) 
				return "x"; 
			if (isIn(0xD1B9, 0xD4D0, n)) 
				return "y"; 
			if (isIn(0xD4D1, 0xD7F9, n)) 
				return "z"; 
			return "\0"; 
		} 
		
		private static function isIn(from:int, to:int, value:int):Boolean 
		{ 
			return ((value >= from) && (value <= to)); 
		} 
		
		/** 
		 * 是否为中文 
		 * @param chineseChar 
		 * @return 
		 * 
		 */   
		public static function isChinese(chineseChar:String):Boolean 
		{ 
			if (convertChar(chineseChar) == "\0") 
			{ 
				return false; 
			} 
			return true; 
		} 
		/**
		 * 
		 * @param arr 数组
		 * @param sortKey 数组中的键值
		 * @param sortType 排序规则
		 * @param arrKey 中文对应的键值
		 * @return 排序后数组
		 * 
		 */		
		public static function sortByChinese(arr:Array,sortKey:Array = null,sortType:Array = null,arrKey:String = "",key:String = ""):Array
		{
			var byte:ByteArray = new ByteArray(); 
			var sortedArr:Array = []; 
			var returnArr:Array = []; 
			sortKey = sortKey? sortKey : [];
			sortType = sortType? sortType : [];
			var item:*; 
			for each (item in arr) 
			{ 
				if (arrKey == "") 
				{ 
					byte.writeMultiByte(String(item).charAt(0), "gb2312"); 
				} 
				else 
				{ 
					item = item[arrKey];
					byte.writeMultiByte(String(item[key]).charAt(0), "gb2312"); 
				} 
			} 
			byte.position = 0; 
			var len:int = byte.length / 2; 
			for (var i:int = 0; i < len; i++) 
			{ 
				var o:Object = {object: arr[i],a: byte[i * 2], b: byte[i * 2 + 1]};
				for each (var j:String in sortKey) 
				{
					if(arrKey == ""){
						o[j] = arr[i][j]; 
					}else{
						o[j] = arr[i][arrKey][j];
					}
					
				}
				sortedArr[sortedArr.length] = o;
			} 
			sortedArr.sortOn(["a", "b"].concat(sortKey), [Array.DESCENDING | Array.NUMERIC,Array.NUMERIC,Array.NUMERIC].concat(sortType)); 
			for each (var obj:Object in sortedArr)
			{ 
				returnArr[returnArr.length] = obj.object; 
			} 
			return returnArr; 
		}
		
		
	}
}

