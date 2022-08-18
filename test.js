function add(var1) {
    var a = var1;
    var b = 2;
    var c = 3;
}

var obj = {
    concatString: function () {
	var s1 = "hello";
	var s2 = "world";
	var s3 = s1 + s2;
    },

    func1 : function(){
	this.concatString();
    },
    func2 : function(){
	add(1);
    }
}
