component output="false" {





	public Struct function flattenComponentMetaData(Struct metadata) {
		var flattened = {};

		if (
			structKeyExists(arguments.metadata, "extends")
		) {
			// inherit metadata
			flattened = flattenComponentMetaData(arguments.metadata.extends);
		}
		for (var item in arguments.metadata) {
			if (!compareNoCase("extends", item)) {}// skip it
			else if (isSimpleValue(arguments.metadata[item])) {
				flattened[item] = arguments.metadata[item];
			}
			else if (isStruct(arguments.metadata[item])) {
				if (!structKeyExists(flattened, item)) {
					flattened[item] = arguments.metadata[item];
				}
				else {
					structAppend(flattened[item], arguments.metadata[item], true);
				}
			}
			else if (isArray(arguments.metadata[item])) {
				if (!structKeyExists(flattened, item)) {
					flattened[item] = {};
				}
				for (var i in arguments.metadata[item]) {
					flattened[item][i.name] = i;
				}
			}
		}

		return flattened;
	}





	public Array function map(Array arr,Function fn)
	output=false {
		var result = [];
		for(var item in arr){
			arrayAppend(result, fn(item));
		}
		return result;
	}





	public Array function filter(Array arr,Function fn)
	output=false {
		var result = [];
		for(var item in arr){
			if (fn(item)) {
				arrayAppend(result, item);
			}
		}
		return result;
	}





	public function reduce(Array arr,Function fn)
	output=false {
		var arrLen = arrayLen(arr);
		if ( !arrLen ) {
			return void;
		}
		var result = arr[1];
		for(var i=2; i lte arrLen; i++){
			result = fn(result, arr[i]);
			}
		}
		return result;
	}





}
