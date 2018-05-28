var dtCh= "/";
var minYear=1900;
var Digital=new Date()
var tday=Digital.getDate()
var tmonth=Digital.getMonth()+1
var maxYear=Digital.getYear();
//function Start
function isInteger(s){
	var i;
    for (i = 0; i < s.length; i++){
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    // All characters are numbers.
    return true;
}
function stripCharsInBag(s, bag){
	var i;
    var returnString = "";
    // Search through string's characters one by one.
    // If character is not in bag, append to returnString.
    for (i = 0; i < s.length; i++){
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}
function daysInFebruary (year){
	// February has 29 days in any year evenly divisible by four,
    // EXCEPT for centurial years which are not also divisible by 400.
    return (((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
}
function DaysArray(n) 
{
	for (var i = 1; i <= n; i++) 
	{
		this[i] = 31;
		if (i==4 || i==6 || i==9 || i==11) {this[i] = 30}
		if (i==2) {this[i] = 29}
   }
   return this
}
function isDate(dtStr)
{
	if (dtStr=="")
		{
		alert("Please Enter Value For Date")
		return false
		}
	var daysInMonth = DaysArray(12)
	var pos1=dtStr.indexOf(dtCh)
	var pos2=dtStr.indexOf(dtCh,pos1+1)
	var strDay=dtStr.substring(0,pos1)
	var strMonth=dtStr.substring(pos1+1,pos2)
	var strYear=dtStr.substring(pos2+1)
	strYr=strYear
	if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
	if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
	for (var i = 1; i <= 3; i++) {
		if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
	}
	month=parseInt(strMonth)
	day=parseInt(strDay)
	year=parseInt(strYr)
	if (pos1==-1 || pos2==-1){
		alert("The date format should be : dd/mm/yyyy")
		return false;
	}
	if (strMonth.length<1 || month<1 || month>12){
		alert("Please enter a valid date. (dd/mm/yyyy Format)")
		return false;
	}
	if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]){
		alert("Please enter a valid date. (dd/mm/yyyy Format)")
		return false;
	}
	if (strYear.length <4 || year==0|| strYear.length>4)
	{
		alert("Please enter a valid 4 Digit Year and between "+ minYear+" to "+ maxYear)
		return false;
	}
//	if(strYear.length == 4 && parseInt(strYear) < parseInt(minYear))
//	{
//	    alert("Please enter Year between "+ minYear+" and "+ maxYear);
//		return false;
//	}
//	if(strYear.length == 4 && parseInt(strYear) > parseInt(maxYear))
//	{
//	    alert("Please enter Year between "+ minYear+" and "+ maxYear);
//	    return false;
//	}
	if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false){
		alert("Please enter a valid date. (dd/mm/yyyy Format)")
		return false;
	}
	
	/*if((day>tday && month>tmonth && year>maxYear)||((day>=tday ||day<tday) && month>tmonth && year>=maxYear)||(year>maxYear)||((day>tday) &&(month>=tmonth) &&(year>=maxYear)))
		{
		alert("Date Can't Be Greater Than Current Date")
		return false
		}*/
return true
}


function echeck(emailStr)
{
	var emailPat=/^(.+)@(.+)$/
	var specialChars="\\(\\)<>@,;:\\\\\\\"\\.\\[\\]"
	var validChars="\[^\\s" + specialChars + "\]"
	var quotedUser="(\"[^\"]*\")"
	var ipDomainPat=/^\[(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\]$/
	var atom=validChars + '+'
	var word="(" + atom + "|" + quotedUser + ")"
	var userPat=new RegExp("^" + word + "(\\." + word + ")*$")
	var domainPat=new RegExp("^" + atom + "(\\." + atom +")*$")
	var matchArray=emailStr.match(emailPat)
	if (matchArray==null)
		{
		alert("Please Check E-Mail Address")
		return false
		}
	var user=matchArray[1]
	var domain=matchArray[2]
	if (user.match(userPat)==null)
		{
		alert("The username doesn't seem to be valid.")
	    return false
		}
	var IPArray=domain.match(ipDomainPat)
	if (IPArray!=null)
		{
    // this is an IP address
		for (var i=1;i<=4;i++)
			{
			if (IPArray[i]>255)
				{
				alert("Destination IP address is invalid!")
				return false
				}
			}
		return true
		}
	// Domain is symbolic name
	var domainArray=domain.match(domainPat)
	if (domainArray==null)
		{
		alert("The domain name doesn't seem to be valid.")
		return false
		}
	var atomPat=new RegExp(atom,"g")
	var domArr=domain.match(atomPat)
	var len=domArr.length
	if (domArr[domArr.length-1].length<2 ||  domArr[domArr.length-1].length>3)
		{
		// the address must end in a two letter or three letter word.
		alert("The address must end in a three-letter domain, or two letter country.")
		return false
		}
	// Make sure there's a host name preceding the domain.
	if (len<2)
		{
		var errStr="This address is missing a hostname!"
		alert(errStr)
		return false
		}

	// If we've gotten this far, everything's valid!
	return true;


}


function chfile(filePath)
{
   var fname=filePath.toLowerCase();
   var flag=0;
   var fname1=fname.replace(/\\/g, "/");
   if(fname1.lastIndexOf("/")>0)
   {
   var fname1Arr=fname1.split("/");
   var filename=fname1Arr[(fname1Arr.length)-1];
   //alert(filename);
    if(filename.indexOf(" ")>0) 
    {
        alert("File Name Cannot Have Blank Spaces. Please Remove Blank Spaces and Re-Try.");
        return false;
    }
    
   }
   if(fname.lastIndexOf(".")>0)
   {
    
    var ext=fname.substring(fname.lastIndexOf(".")+1);
    var extarr=['docx', 'doc', 'xlsx', 'gif', 'jpg', 'xls', 'pdf', 'zip'];
    for(i=0;i<extarr.length;i++)
    {
     if(ext==extarr[i])
     {
       flag=1;
       break;
      }
    }
    if(flag!=1)
    {
     alert("Please Enter The File of Any Given Extension: '.docx', '.doc', '.xlsx', '.gif', '.jpg', '.xls', '.pdf', '.zip'");
     return false;
    }
   }
   else
   {
   alert("Please Enter The File of Any Given Extension: '.docx', '.doc', '.xlsx', '.gif', '.jpg', '.xls', '.pdf', '.zip'");
   return false;
   }
   return true;
}
function churl(url)
{
 var flag=0;
 var ptc=url.substring(0,7);
 if(ptc.toLowerCase()!="http://")
 {
  flag=1;
 }
 if(url.lastIndexOf(".")>0)
 {
  if(url.substring(url.lastIndexOf(".")).length<2)
  {
   flag=1;
  }
  if(flag==1)
  {
   alert("Enter Proper URL start with 'http://' and end with atleast two char after dot.");
   return false;
  }
 }
 else
 {
  alert("Enter Proper URL start with 'http://' and end with atleast two char after dot.");
  return false;
 }
 return true;
}



function trim(inputString)
{
   if (typeof inputString != "string") { return inputString; }
   var retValue = inputString;
   var ch = retValue.substring(0, 1);
   while (ch == " ") {
      retValue = retValue.substring(1, retValue.length);
      ch = retValue.substring(0, 1);
   }
   ch = retValue.substring(retValue.length-1, retValue.length);
   while (ch == " ") {
      retValue = retValue.substring(0, retValue.length-1);
      ch = retValue.substring(retValue.length-1, retValue.length);
   }
   while (retValue.indexOf("  ") != -1) {
      retValue = retValue.substring(0, retValue.indexOf("  ")) + retValue.substring(retValue.indexOf("  ")+1, retValue.length);
   }
   return retValue;
}

function RemoveSpecialChar(strRep)
{
    var str=strRep.replace(/[^a-zA-Z\ \_]+/g,"");
    return str;
}


function RemoveSpecialCharCom(strRep)
{
	strRep=strRep.replace(/\\|\<|\>|\'|\$|\$|\`|\|\$\||\|\~\||/g,"");
	return strRep;
}
function RemoveSpecialCharCom_un(strRep)
{
	strRep=strRep.replace(/\\|\<|\>|\'|\,|\*|\ |\|\$\||\|\~\||\"/g,"");
	return strRep;
}

function RemoveDigits(strRep)
{
	strRep = strRep.replace(1|2|3|4|5|6|7|8|9|0,"");
	return strRep;
}

function SpecialChar_un(formstr)
{

   //var strSpacial="\,\*\<\>\"\ ";
   var strSpacial="\,\*\<\>";
  // alert(strSpacial);
   var  str=formstr;
	ln=str.length;
	var FinVal="";
	var newStr="";
	for (i=0;i<ln;i++)
	{
		var strtemp,index,al;

		strtemp=str.charAt(i);
		index=strSpacial.indexOf(strtemp);
		if (index>0)
		{
		    return true;
		}
	}
	return SpecialChar(formstr);
}

function SpecialChar(formstr)
{

   var strSpacial="\'\<\>\$\&\~\`";
   var str=formstr;
	ln=str.length;
	var FinVal="";
	var newStr="";
	for (i=0;i<ln;i++)
	{
		var strtemp,index,al;

		strtemp=str.charAt(i);
		if(strtemp=="\\")
		{
		    return true;
		}
		else
		{
		    if(strtemp=="\'")
		    {
		        return true;
		    }
		    else
		    {
			    index=strSpacial.indexOf(strtemp);
			 }
	    }
		if (index>0)
		{
		    return true;
		}
		else
		{
			newStr=strtemp;
		}
	    FinVal=FinVal+newStr;
	}
	var ch=FinVal.indexOf("\|\$\|");
	if(ch>0)
	{
		return true;
	}
	var ch=FinVal.indexOf("\|\~\|");
	if(ch>-1)
	{
	    return true;
	}
    return false;
}

function SpecialCharCom(formstr)
{
//alert(formstr)
var strSpacial="\~\'\!\'\#\$\%\^\&\*\+\;\<\>\""
//var strSpacial="/\~|\<\>\""
//var strSpacial="\'\!\#\%\^\&\*\+\;\<\>\"\,";
    //var strSpacial="\'\<\>\"";
    str=formstr;
	ln=str.length;
	var FinVal="";
	var newStr="";
	for (i=0;i<ln;i++)
	{
		var strtemp,index,al;

		strtemp=str.charAt(i);
		//index=strSpacial.indexOf(strtemp);
		if(strtemp=="\\")
		{
		    return true;
		}
		else
		{
		    index=strSpacial.indexOf(strtemp);
	    }
		if (index>0)
		{
		    return true;
		}
		else
		{
			newStr=strtemp;
		}
	    FinVal=FinVal+newStr;
	}
	var ch=FinVal.indexOf("\|\$\|");
	if(ch>0)
	{
		return true;
	}
	var ch=FinVal.indexOf("\|\~\|");
	if(ch>-1)
	{
	    return true;
	}
    return false;
}



function remdigit(strRep)
{
//alert(strRep);
/*var strarr=new Array('1','2','3','4','5','6','7','8','9','0');
var x="";
var newvar="";
	for(x in strarr)
	{
	newvar=strRep.replace(strarr[x],"")
	//alert(newvar);
	}
return newvar;*/
strRep = strRep.replace(/\1|\2|\3|\4|\5|\6|\7|\8|\9|\0/,"");
return strRep;
}


function digitcheck(formstr)
{
//alert(formstr)
var strSpacial="0123456789";
//var strSpacial="1\2\3\4\5\6\7\8\9\0";
	str=formstr;
	ln=str.length;
	var FinVal="";
	var newStr="";
	for (i=0;i<ln;i++)
	{
		var strtemp,index,al;
		//alert(strSpacial);
		strtemp=str.charAt(i);
		index=strSpacial.indexOf(strtemp);
		if (index>=0)
		{
		//alert(index);

			//al=RemoveDigits(strtemp);
			strtemp="";
			al=strtemp
			//alert(al);
			newStr=al;

		}
		else
		{
			newStr=strtemp;
		}
	FinVal=FinVal+newStr;

	}
//alert(FinVal);
return FinVal;
}

function formchkcount1(formname,formstr,count)
	{
	    
	    var cnt = eval("document."+formname+"."+count);
	   
	    var i=0;
	    var cntval = cnt.value;
	 //   alert(cntval);
	  //  alert("here");
	  //  var cntval = 2;
	 
	    arr=formstr.split("|~|");
	    
	    var fields=arr[0];
	 
	    for(i=1;i<=cntval;i++)
	    {
	  
	        str1= "";
	        feildSplit=fields.split("|$|");
	        
	        for(val in feildSplit)
		    {
		        if(str1 == "")
		        {
		           str1 =  feildSplit[val]+i;
		        }
		         else
		         {
		         str1 = str1+"|$|"+feildSplit[val]+i;
		         
		         }    
		       	      		
		    }
		    strmain = str1+"|~|"+arr[1]+"|~|"+arr[2];
		   
		    if(formchk(formname,strmain)==false)
		    {
		        return false;
		    }
		    
	    }
	    return true;
	
	}
	

  function formchkcount(formname,formstr,count)
	{
	    var cnt = eval("document."+formname+"."+count);
	    
	    var cntval = cnt.value;
	 //   alert(cntval);
	  //  alert("here");
	  //  var cntval = 2;
	    arr=formstr.split("|~|");
	    var fields=arr[0];
	    
	    for(i=0;i<cntval;i++)
	    {
	        str1= "";
	        feildSplit=fields.split("|$|");
	        for(val in feildSplit)
		    {
		        if(str1 == "")
		        {
		           str1 =  feildSplit[val]+i;
		        }
		         else
		         {
		         str1 = str1+"|$|"+feildSplit[val]+i;
		         
		         }       
		      		
		    }

		    strmain = str1+"|~|"+arr[1]+"|~|"+arr[2];
		   
		    if(formchk(formname,strmain)==false)
		    {
		        return false;
		    }
		    
	    }
	    return true;
	
	}
	
	
	function formchkid(formname,formstr,count)
	{//alert("hi");
	    var cnt = eval("document."+formname+"."+count);
	   // alert(cnt.value);
	    var cntval = cnt.value;
	     idarr=cntval.split(",");
	 
	    arr=formstr.split("|~|");
	    var fields=arr[0];
	    
	    for(ii in idarr)
	    {
	        str1= "";
	       // alert(ii);
	     //   alert(idarr[ii]);
	        feildSplit=fields.split("|$|");
	        for(val in feildSplit)
		    {
		        if(str1 == "")
		        {
		           str1 =  feildSplit[val]+idarr[ii];
		        }
		         else
		         {
		         str1 = str1+"|$|"+feildSplit[val]+idarr[ii];
		         
		         }       
		      		
		    }
		    strmain = str1+"|~|"+arr[1]+"|~|"+arr[2];
		//   alert(strmain);
		    if(formchk(formname,strmain)==false)
		    {
		        return false;
		    }
		    
	    }
	    return true;
    }

	function formchk(formname,formstr)
	{
	//s for string with or without numbers
	//ss for string without numbers
	//snull  for string with/without numbers null allowed
	//ssnull
	//sc for string with  comma(S type string)

		//alert(formname);
		//alert(formstr);
		var val=0;
		var nxtarr;
		var val1;
		arr=formstr.split("|~|");
		var fields=arr[0];
		var datatype=arr[1];
		var length=arr[2];
		feildSplit=fields.split("|$|");
		datatypeSplit=datatype.split("|$|");
		lengthSplit=length.split("|$|");

		for(val in feildSplit)
		{
			//alert(feildSplit[val]);
			//alert(datatypeSplit[val]);
			//alert(lengthSplit[val]);
				//alert(feildSplit);
   	        if(datatypeSplit[val].toLowerCase()=="ph" || datatypeSplit[val].toLowerCase()=="phnull" )
		    {	

			//alert("hello");
				formfeild=eval("document."+formname+"."+feildSplit[val]);

				if(trim(formfeild.value)=="" && datatypeSplit[val].toLowerCase()=="ph"  )
					{
					alert("Please Enter Phone/Fax No." )
					formfeild.focus();
					formfeild.select();
					return false;
					}


				if(formfeild.value.length>lengthSplit[val] && !(formfeild.value)=="")
					{
					alert("Data Exceeds the limit of "+lengthSplit[val]+ " characters")
					formfeild.focus();
					formfeild.select();
					return false;
					}
                    
                 var arr=new Array('0','1','2','3','4','5','6','7','8','9','-',' ');
                 
                    for(i=0;i<=formfeild.value.length-1;i++)
                	{
                		phx=0	
                		var phChar=formfeild.value.charAt(i);
                		for(x in arr)
                		{
                			if(String(arr[x])==String(phChar))
                			{
                				phx=1;
                			}
                			//alert(String(arr[x])+"  "+String(phChar)+" "+phx);
                		}
                			//alert("phx= "+phx);
                		if(phx==0)
                		{
                			alert("Only Digits and '-' is allowed in Phone Number")
                			formfeild.select();
                			return false;
                				break;
                		}
                	}
			}    
                
                
                
                
			if(datatypeSplit[val].toLowerCase()=="s" || datatypeSplit[val].toLowerCase()=="snull" )
		    {	

			//alert("hello");
				formfeild=eval("document."+formname+"."+feildSplit[val]);

				if(trim(formfeild.value)=="" && ( datatypeSplit[val].toLowerCase()=="s"  || datatypeSplit[val].toLowerCase()=="sc" ) )
					{
					alert("Please Enter value" )
					formfeild.focus();
					formfeild.select();
					return false;
					}


				if(formfeild.value.length>lengthSplit[val] && !(formfeild.value)=="")
					{
					alert("Data Exceeds the limit of "+lengthSplit[val]+ " characters")
					formfeild.focus();
					formfeild.select();
					return false;
					}
				
					spcheck=SpecialChar(formfeild.value);
				if(spcheck==true)
				{
				    var cf=confirm("Value entered by you contains some disallowed Characters e.g. \,>,<,',|$|,|~|,\" and the same will be removed onclicking OK button, so do want to remove them?");
			        if(cf==true)
			        {
			            newStr=RemoveSpecialCharCom(formfeild.value);
			        }
			        else
			        {
			            return false;
			        }
			     }
			     else
			     {
			        newStr=formfeild.value;
			     }
				//newStr=SpecialCharCom(formfeild.value);
				formfeild.value=newStr;
			}

            if(datatypeSplit[val].toLowerCase()=="un" || datatypeSplit[val].toLowerCase()=="unnull" )
		    {	

			//alert("hello");
				formfeild=eval("document."+formname+"."+feildSplit[val]);

				if(trim(formfeild.value)=="")
					{
					alert("Please Enter value" )
					formfeild.focus();
					formfeild.select();
					return false;
					}


				    if(formfeild.value.length>lengthSplit[val] && !(formfeild.value)=="")
					{
					alert("Data Exceeds the limit of "+lengthSplit[val]+ " characters")
					formfeild.focus();
					formfeild.select();
					return false;
					}
					
					spcheck=SpecialChar_un(formfeild.value);
				if(spcheck==true)
				{
				    var cf=confirm("Value entered by you contains some disallowed Characters e.g. \,>,<,',|$|,|~|,\" and the same will be removed onclicking OK button, so do want to remove them?");
			        if(cf==true)
			        {
			            newStr=RemoveSpecialCharCom_un(formfeild.value);
			        }
			        else
			        {
			            return false;
			        }
			     }
			     else
			     {
			        newStr=formfeild.value;
			     }
				//newStr=SpecialCharCom(formfeild.value);
				formfeild.value=newStr;
			}


			if(datatypeSplit[val].toLowerCase()=="ss" || datatypeSplit[val].toLowerCase()=="ssnull")
			{
				formfeild1=eval("document."+formname+"."+feildSplit[val]);
				//alert(formfeild.value);
				if(trim(formfeild1.value)=="" && datatypeSplit[val].toLowerCase()=="ss")
					{
					alert("Please Enter value")
					formfeild1.focus();
					formfeild1.select();
					return false;
					}

				if(isNaN(formfeild1.value)==false && !(formfeild1.value)=="")
					{
					alert("Please Enter Proper values")
					formfeild1.focus();
					formfeild1.select();
					return false;
					}

				if(formfeild1.value.length>lengthSplit[val] && !(formfeild1.value)=="")
				{
				    alert("Data Exceeds the limit of "+lengthSplit[val]+ " characters")
				    formfeild1.focus();
				    formfeild1.select();
				    return false;
				}
                if(formfeild1.value!="")
                {
                    if (/^ *[A-Za-z\ \_]+ *$/.test(formfeild1.value))
    				{
    				    newStr=formfeild1.value;
                    }
                    else
                    {
                       
                       var cf=confirm("Value entered by you contains some disallowed Characters e.g. \,>,<,',|$|,|~|,\" and the same will be removed onclicking OK button, so do want to remove them?");
    			        if(cf==true)
    			        {
    			            newStr=RemoveSpecialChar(formfeild1.value);
    			            //newStr=RemoveDigits(newStr);
    			        }
    			        else
    			        {
    			            return false;
    			        }
                    }
                }
                else
                {
                    newStr=formfeild1.value;
                }
				
				//newStr=RemoveSpecialChar(formfeild1.value);
				formfeild1.value=newStr;
				newstr1=digitcheck(formfeild1.value);
				formfeild1.value=newstr1;
			}
			if(datatypeSplit[val].toLowerCase()=="di" || datatypeSplit[val].toLowerCase()=="sdrp" || datatypeSplit[val].toLowerCase()=="drp" || datatypeSplit[val].toLowerCase()=="ds")
			{
				dropfield=eval("document."+formname+"."+feildSplit[val]);
					if(dropfield.value<0)
					{
					alert("Please Select Value")
					dropfield.focus();
					return false;
					}
			}
			if(datatypeSplit[val].toLowerCase()=="dinull" || datatypeSplit[val].toLowerCase()=="dsnull" || datatypeSplit[val].toLowerCase()=="sdrpnull" || datatypeSplit[val].toLowerCase()=="drpnull" || datatypeSplit[val].toLowerCase()=="linull" )
			{
				
			}
			
			if(datatypeSplit[val].toLowerCase()=="li")
			{
			    	dropfield=eval("document."+formname+"."+feildSplit[val]);
					if(dropfield.value<=0)
					{
					alert("Please Select Value")
					dropfield.focus();
					return false;
					}
										
			}
			if(datatypeSplit[val].toLowerCase()=="da")
			{
				dropfield=eval("document."+formname+"."+feildSplit[val]);
					if(trim(dropfield.value)=="")
					{
					alert("Please Select Value")
					dropfield.focus();
					return false;
					}

			}

			if(datatypeSplit[val].toLowerCase()=="i" || datatypeSplit[val].toLowerCase()=="inull" )
			{
				intfield=eval("document."+formname+"."+feildSplit[val]);
					if(trim(intfield.value)=="" && datatypeSplit[val].toLowerCase()=="i" )
					{
					alert("Please Enter Value")
					intfield.focus();
					return false;
					}
					if(isNaN(intfield.value)==true && !(intfield.value)=="")
					{
					alert("Please Enter Numeric values")
					intfield.focus();
					return false;
					}
					if(intfield.value%1!=0 && !(intfield.value)=="")
					{
					alert("Please Enter Integer values")
					intfield.focus();
					return false;
					}
					
					if(intfield.value.length>lengthSplit[val] && !(intfield.value)=="")
					{
					alert("Data Exceeds the limit of "+lengthSplit[val]+ " characters")
					intfield.select();
					intfield.focus();
					return false
					}

			}
			if(datatypeSplit[val].toLowerCase()=="dc" || datatypeSplit[val].toLowerCase()=="dcnull" )
			{
				    intfield=eval("document."+formname+"."+feildSplit[val]);
					if(trim(intfield.value)=="" && datatypeSplit[val].toLowerCase()=="dc" )
					{
					alert("Please Enter Value")
					intfield.focus();
					return false;
					}

					if(isNaN(intfield.value)==true && !(intfield.value)=="")
					{
					alert("Please Enter Numeric values")
					intfield.focus();
					return false;
					}
                    var cklen=lengthSplit[val].split(',');
			if(intfield.value!="" && intfield.value.indexOf(".")<=0)
				{
				intfield.value=intfield.value+".00"
				//alert("Please Enter Values in decimal Values")
				//intfield.select();
				//intfield.focus();
				//return false
				}
                    if(!(intfield.value)==""   && intfield.value.indexOf(".")>-1)
                    {
                        var ckval=intfield.value.split('.');
                        if(ckval[0].length>cklen[0])
                        {
                            alert("Data before Decimal(.),Exceeds the limit of "+cklen[0]+ " digits")
					        intfield.select();
					        intfield.focus();
					        return false
                        }
                        if(ckval[1].length>cklen[1])
                        {
                            alert("Data after Decimal(.),Exceeds the limit of "+cklen[1]+ " digits")
				            intfield.select();
				            intfield.focus();
				            return false
                        }
                    }   
                    else
                    {
					    if(!(intfield.value)==""   &&  intfield.value.length>cklen[0])
					    {
					    alert("Data Exceeds the limit of "+lengthSplit[val]+ " digits")
					    intfield.select();
					    intfield.focus();
					    return false
					    }
					}
			}
			if(datatypeSplit[val].toLowerCase()=="d" || datatypeSplit[val].toLowerCase()=="dnull")
			{
				var DateArr=new Array();
				datefield=eval("document."+formname+"."+feildSplit[val]);
				if(trim(datefield.value)=="" && datatypeSplit[val].toLowerCase()=="d")
				{
				    alert("Please Enter Date")
				    datefield.focus();
				    return false;
				}
                if(datatypeSplit[val].toLowerCase()=="d" || (trim(datefield.value)!="" && datatypeSplit[val].toLowerCase()=="dnull"))
				{
				    DateSplit=datefield.value;
				    DateSplit=DateSplit.split(",");
				    var x,DateReturn,Num;
				    for(x in DateSplit)
				    {
				        DateReturn=isDate(DateSplit[x]);
				        DateArr=DateSplit[x];
				        if(DateReturn==false)
					    {
					        datefield.focus();
					        datefield.select();
					        return false
					    }
				    }
				}
			}


			if(datatypeSplit[val].toLowerCase()=="f")
			// f for file
			// null is sent when file selection is not compulsory
			// nnull or anything would make this box mandatory
			{

				filefield=eval("document."+formname+"."+feildSplit[val]);
			
				if(trim(lengthSplit[val])=="null")
				{
					//alert("hello");
					if(trim(filefield.value)!="")
					{
					   	//alert(filefield.value);
                        //return false;
    					if(chfile(filefield.value)=="")
						{
						    filefield.focus();
						    filefield.select();
						    return false;
						}
					}
                    
                    
                    
                    
				}
				if(trim(lengthSplit[val])=="nnull")
				{
					//	alert("hello1");
					if(trim(filefield.value)=="")
					{
						alert("Please Enter File");
						filefield.focus();
						filefield.select();
						return false;
					}
			
					if(chfile(filefield.value)=="")
					{
						filefield.focus();
						filefield.select();
						return false;
					}
				}
    		}
    		if(datatypeSplit[val].toLowerCase()=="u" || datatypeSplit[val].toLowerCase()=="unull")
	    	// u for url
    		{
//alert("url hai")
    			urlfield=eval("document."+formname+"."+feildSplit[val]);

				//if(datatypeSplit[val].toLowerCase()=="u" && urlfield.value=="")
				//{
					//alert("Please Enter URL")
	    				//urlfield.focus();
    	    				//urlfield.select();
			    	//return false;
				//}
				if(urlfield.value!="" &&  churl(urlfield.value)=="")
				
				{
				
	    			urlfield.focus();
    	    		urlfield.select();
			    	return false;
				}
				if(urlfield.value!="" && urlfield.value.length>lengthSplit[val])
				{
				    alert("Data Exceeds the limit of "+lengthSplit[val]+ " characters")
   					urlfield.focus();
    				urlfield.select();
	    			return false;
				}
   			}
   			if(datatypeSplit[val].toLowerCase()=="e" || datatypeSplit[val].toLowerCase()=="enull")
    		// e for email
   			{

    			emailfield=eval("document."+formname+"."+feildSplit[val]);
			
			  if(emailfield.value=="" && datatypeSplit[val].toLowerCase()=="e" )
			   {
			        alert("Please Enter Email")
			        emailfield.focus();
				    emailfield.select();
				    return false;
			   }

				if(emailfield.value!="" && echeck(emailfield.value)=="")
				{
       				emailfield.focus();
	    			emailfield.select();
		    		return false;
				}
			
    			if(emailfield.value!="" && emailfield.value.length>lengthSplit[val])
				{
			    	alert("Data Exceeds the limit of "+lengthSplit[val]+ " characters")
				    emailfield.focus();
				    emailfield.select();
				    return false;
				}
			
		    }

			if(datatypeSplit[val].toLowerCase()=="o" || datatypeSplit[val].toLowerCase()=="os")
			// o paramter can have both checkboxes and radio
			// this check would only validate for value

			{
				var x=0;
				otherfield=eval("document."+formname+"."+feildSplit[val]);


				for(i=0;i<=otherfield.length-1;i++)
				{
					if(otherfield[i].checked==true)
					{
					x=1
					}
				}

				if(x==0)
				{
				alert("Please Select atleast one value to proceed");
				return false;
				}
			}

			if(datatypeSplit[val].toLowerCase()=="ao")
			{
				var x=0;
				otherfield=eval("document."+formname+"."+feildSplit[val]);


				for(i=0;i<=otherfield.length-1;i++)
				{
					if(otherfield[i].checked==true)
					{
					x=1
					}
				}


				if(x==0)
				{
				alert("Please Select atleast one value to proceed");
				return false;
				}
			}
			/////////////
			if(datatypeSplit[val].toLowerCase()=="dg_ao_all")
			{
				str='_'+feildSplit[val];
                for(i=0;i<document.all.length;i++)
                {
                   var x = document.all.item(i);
                   if(x!=null && x.id !=null &&  x.id.indexOf(str)!=-1)
                   {
                       if(x.checked==false)
                       {
                            alert("Please Select all checks to proceed");
                            return false;
                       }
                   }           
                }
           }
			
			/////////////
			if(datatypeSplit[val].toLowerCase()=="dg_ao")
			{
				str='_'+feildSplit[val];
                for(i=0;i<document.all.length;i++)
                {
                   var x = document.all.item(i);
                   if(x!=null && x.id !=null &&  x.id.indexOf(str)!=-1)
                   {
                       if(x.checked==true)
                       {
                       //     alert("hello");
                            return true;
                       }
                   }           
                }
       			alert("Please Select atleast one value to proceed");
       			return false;
			}
			if(datatypeSplit[val].toLowerCase()=="dg_ao_enable")
			{
				str='_'+feildSplit[val];
                for(i=0;i<document.all.length;i++)
                {
                   var x = document.all.item(i);
                   if(x!=null && x.id !=null &&  x.id.indexOf(str)!=-1)
                   {
                       if(x.checked==true && x.disabled==false)
                       {
                       //     alert("hello");
                            return true;
                       }
                   }           
                }
       			alert("Please Select atleast one value to proceed");
       			return false;
			}
			if(datatypeSplit[val].toLowerCase()=="dg_ao_enable1")
			{
				str='_'+feildSplit[val];
                for(i=0;i<document.all.length;i++)
                {
                   var x = document.all.item(i);
                   if(x!=null && x.id !=null &&  x.id.indexOf(str)!=-1)
                   {
                       if(x.checked==true && x.disabled==false)
                       {
                       //     alert("hello");
                            return "1";
                       }
                   }           
                }
       			//alert("Please Select atleast one value to proceed");
       			return "0";
			}
			if(datatypeSplit[val].toLowerCase()=="dg_i" || datatypeSplit[val].toLowerCase()=="dg_inull")
			{
				str='_'+feildSplit[val];
                for(i=0;i<document.all.length;i++)
                {
                   var x = document.all.item(i);
                   if(x!=null && x.id !=null &&  x.id.indexOf(str)!=-1)
                   {
                       
                       if(x.value=="" && datatypeSplit[val].toLowerCase()=="dg_i" )
                       {
                            alert("Please Enter Numeric value in Text Box");
                            x.select();
                            x.focus();
                            return false;
                       }
                       if(x.value!="" && isNaN(x.value)==true )
					   {
					        alert("Please Enter Numeric values")
					        x.focus();
					        x.select();
					        return false;
					   }
					   if(x.value!="" && x.value%1!=0)
					   {
					        alert("Please Enter Integer values")
					        x.focus();
					        x.select();
					        return false;
					   }
					
					   if( x.value!="" && x.value.length>lengthSplit[val])
					   {
					        alert("Data Exceeds the limit of "+lengthSplit[val]+ " Digits")
					        x.select();
					        x.focus();
					        return false
					   }
                   }           
                }
			}
			
			
			
			
			
			
			if(datatypeSplit[val].toLowerCase()=="dg_dc" || datatypeSplit[val].toLowerCase()=="dg_dcnull")
			{
				str='_'+feildSplit[val];
                for(i=0;i<document.all.length;i++)
                {
                   var x = document.all.item(i);
                   if(x!=null && x.id !=null &&  x.id.indexOf(str)!=-1)
                   {
                        if(trim(x.value)=="" && datatypeSplit[val].toLowerCase()=="dg_dc" )
					    {
					        alert("Please Enter Value")
					        x.select();
					        x.focus();
					        return false;
					    }

					    if(isNaN(x.value)==true && !(x.value)=="")
					    {
					        alert("Please Enter Numeric values")
					        x.select();
					        x.focus();
					        return false;
					    }
                        var cklen=lengthSplit[val].split(',');
                        if(!(x.value)==""   && x.value.indexOf(".")>-1)
                        {
                            var ckval=x.value.split('.');
                            if(ckval[0].length>cklen[0])
                            {
                                alert("Data before Decimal(.),Exceeds the limit of "+cklen[0]+ " digits")
					            x.select();
					            x.focus();
					            return false
                            }
                            if(ckval[1].length>cklen[1])
                            {
                                alert("Data after Decimal(.),Exceeds the limit of "+cklen[1]+ " digits")
				                x.select();
				                x.focus();
				                return false
                            }
                        }   
                        else
                        {
					        if(!(x.value)==""   &&  x.value.length>cklen[0])
					        {
					            alert("Data Exceeds the limit of "+lengthSplit[val]+ " digits")
					            x.select();
					            x.focus();
					            return false
					        }
					    }
                   }           
                }
			}
			
			
			
			
			
			
			
		}
		return true;
	}



function showTT(el) 
{
var ttext=el.title;
//alert(ttext)
var tt=document.createElement('SPAN');
var tnode=document.createTextNode(ttext);
tt.appendChild(tnode);
el.parentNode.insertBefore(tt,el.nextSibling);
tt.className="tt";
el.title="";
}
function hideTT(el) 
{
    if(el.nextSibling.childNodes[0]!=null)
    {
        var ttext=el.nextSibling.childNodes[0].nodeValue;
        el.parentNode.removeChild(el.nextSibling);
        el.title=ttext;
    }

}
function tooltip(id) 
{
   var imgs=document.getElementsByTagName('img');
 
    for (i=0; i<imgs.length; i++) 
    {
           imgs[ i ].onclick=function() 
        {
            
            if (this.nextSibling && this.nextSibling.className=="tt") 
            {
                hideTT(this);
            }
            else 
            {
                showTT(this);
            } 
        }
    }
}
window.onload=tooltip;