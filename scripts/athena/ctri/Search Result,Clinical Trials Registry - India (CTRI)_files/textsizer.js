/*------------------------------------------------------------
	Document Text Sizer- Copyright 2003 - Taewook Kang.  All rights reserved.
	Coded by: Taewook Kang (txkang.REMOVETHIS@hotmail.com)
	Web Site: http://txkang.com
	Script featured on Dynamic Drive (http://www.dynamicdrive.com)

	Please retain this copyright notice in the script.
	License is granted to user to reuse this code on 
	their own website if, and only if, 
	this entire copyright notice is included.
--------------------------------------------------------------*/

//Specify affected tags. Add or remove from list:
var tgs = new Array( 'div','td','tr', 'p', 'li', 'a', 'style');

//Specify spectrum of different font sizes:
var szs = new Array( 'xx-small','x-small','small','medium','large','x-large','xx-large' );
var startSz = 2;

function ts( trgt,inc ) {
	if (!document.getElementById) return
	var d = document,cEl = null,sz = startSz,i,j,cTags;
	
	sz = inc;
	if ( sz < 0 ) sz = 0;
	if ( sz > 6 ) sz = 6;
	startSz = sz;
		
	if ( !( cEl = d.getElementById( trgt ) ) ) cEl = d.getElementsByTagName( trgt )[ 0 ];

	cEl.style.fontSize = szs[ sz ];

	for ( i = 0 ; i < tgs.length ; i++ ) {
		cTags = cEl.getElementsByTagName( tgs[ i ] );
		for ( j = 0 ; j < cTags.length ; j++ ) cTags[ j ].style.fontSize = szs[ sz ];
	}
	
	// Added by Elmer
	createCookie("prefSize", sz);
}

//------------------------ Added by Elmer
this.onload = function() {
	if (readCookie("prefSize") != null) {
		var v_domain = document.domain.toString().toLowerCase();
		var v_location = document.location.toString().toLowerCase();
		var v_url = "";

		try {
			var fs = readCookie("prefSize");
			v_location = v_location.replace("http:\/\/wwww." + v_domain,  "");
			v_location = v_location.replace("http:\/\/" + v_domain,  "");

			if (v_location == "\/" || v_location == "\/default.asp") {
				ts("content", fs);
			}
			else {
				ts("DocumentContent", fs);
			}

			js_SetActiveFont(null, (parseInt(fs) + 1));
			
			
		}
		catch (e) {}
	}
}

function createCookie(name,value,days) {
	var v_domain = document.domain.toString().toLowerCase();
	if (days) {
		var date = new Date();
		date.setTime(date.getTime()+(days*24*60*60*1000));
		var expires = "; expires="+date.toGMTString();
	}
	else var expires = "";
	
	//document.cookie = name+"="+value+expires+"; path=/;domain=" + v_domain + ";";
	//document.cookie = name+"="+value+expires+"; path=/;";
	document.cookie = name+"="+value+expires+"; path=/;domain=adb.org;";
}

function readCookie(name) {
	var nameEQ = name + "=";
	var ca = document.cookie.split(';');
	for(var i=0;i < ca.length;i++) {
		var c = ca[i];
		while (c.charAt(0)==' ') c = c.substring(1,c.length);
		if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
	}
	return null;
}

function eraseCookie(name) {
	createCookie(name,"",-1);
}

function js_SetActiveFont(p_obj, p_n) {
	if (p_n == null) {
		for (var i=1; i < 5; i++) {
			document.getElementById('fs' + i).style.backgroundColor='';
			document.getElementById('fs' + i).style.color='';
		}
		p_obj.style.backgroundColor="#D4E2F7";
		p_obj.style.color="#333366";
	}
	else {
		document.getElementById("fs" + p_n).style.backgroundColor="#D4E2F7";
		document.getElementById("fs" + p_n).style.color="#333366";
	}
}