function isNum (v){
	return (v.toString() && !/\D/.test(v));
}

function onlyNumber(){
	if ((event.keyCode < 48) || (event.keyCode > 57) ) 
	{
		event.preventDefault?event.preventDefault():event.returnValue = false;
	}
}

function onlyFCPhone(){
	if ( ((event.keyCode < 48) || (event.keyCode > 57)) && (event.keyCode != 43 && event.keyCode != 45)  ) 
	{
		event.preventDefault?event.preventDefault():event.returnValue = false;
	}
}

function onlySysNumber(){
	if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;
}

function ifr_Height(v) {
	try{
		var height = document.getElementById(v).contentWindow.document.body.scrollHeight;
		if (height==0){  height=0; }
		document.getElementById(v).height = height;
	} catch(e){
		alert(e);
	}
}

function fGetSelectedText( pSelectBoxId ){
	return document.getElementById(pSelectBoxId).options[document.getElementById(pSelectBoxId).selectedIndex].text;
}

//달력형식 입력
function fn_calInput(event){//fn_calInput(event){ 

     var time = new Date() 
       , y = String(time.getFullYear()) 
       , m = time.getMonth() 
       , d = time.getDate() 
       , h = '-' 
       , lists = { 
                keyup : [ 
      // 숫자, - 외 제거 
      [/[^\d\-]/, ''] 
      // 0000 > 00-00 
      , [/^(\d\d)(\d\d)$/, '$1-$2'] 
      // 00-000 > 00-00-0 
      , [/^(\d\d\-\d\d)(\d+)$/, '$1-$2'] 
      // 00-00-000 > 0000-00-0 
      , [/^(\d\d)-(\d\d)-(\d\d)(\d+)$/, '$1$2-$3-$4'] 
      // 00-00-0-0 > 0000-0-0 
      , [/^(\d\d)-(\d\d)-(\d\d?)(-\d+)$/, '$1$2-$3$4'] 
      // 0000-0000 > 0000-00-00 
      , [/^(\d{4}-\d\d)(\d\d)$/, '$1-$2'] 
      // 00000000 > 0000-00-00 
      , [/^(\d{4})(\d\d)(\d\d)$/, '$1-$2-$3'] 
      // 이탈 제거 
      , [/(\d{4}-\d\d?-\d\d).+/, '$1'] 
      ] 
      , blur : [ 
        // 날짜만 있을 때 월 붙이기 
      [/^(0?[1-9]|[1-2][0-9]|3[0-1])$/, m+'-$1', 1] 
      // 월-날짜 만 있을 때 연도 붙이기 
      , [/^(0?[1-9]|1[0-2])\-?(0[1-9]|[1-2][0-9]|3[01])$/, y+'-$1-$2'] 
      , [/^((?:0m?[1-9]|1[0-2])\-[1-9])$/, y+'-$1'] 
      // 연도 4 자리로 
      , [/^(\d\-\d\d?\-\d\d?)$/, y.substr(0, 3)+'$1', 1] 
      , [/^(\d\d\-\d\d?\-\d\d?)$/, y.substr(0, 2)+'$1', 1] 
      // 0 자리 붙이기 
      , [/(\d{4}-)(\d-\d\d?)$/, '$10$2', 1] 
      , [/(\d{4}-\d\d-)(\d)$/, '$10$2'] 
      ] 
     } 
     event = event || window.event; 
     var input = event.target || event.srcElement 
       , value = input.value 
       , list = lists[event.type] 
       ; 
     for(var i=0, c=list.length, match; i<c; i++){ 
        match = list[i]; 
        if(match[0].test(value)){ 
               input.value = value.replace(match[0], match[1]); 
               if(!match[2]) 
                   break; 
        } 
     } 
} 


/*
	내    용 : 체크박스들의 체크상태를 일괄 변경
	파라미터 : pCheckBoxName - 체크상태를 변경할 체크박스 이름
	Return값 : 없슴
*/
function fSelectAllCheckBox(pCheckBoxName)
{

	// 파라미터로 받은 이름을 가진 Element 의 배열을 변수에 저장
	var vCheckBoxArray = document.getElementsByName(pCheckBoxName);
	// 배열의 갯수만큼 loop
	for(var i=0; i<vCheckBoxArray.length; i++)
	{
		// 체크상태 변경
		vCheckBoxArray[i].checked = event.srcElement.checked;
	}
}

/*
	내      용 : 체크된 체크박스 갯수를 리턴한다.
	파라미터 : pCheckBoxName - 체크상태를 변경할 체크박스 이름
	Return값 : 갯수
*/
function fCountCheckedCheckBox(pCheckBoxName)
{
	// 파라미터로 받은 이름을 가진 Element 의 배열을 변수에 저장
	var vCheckBoxArray = document.getElementsByName(pCheckBoxName);
	var nChk = 0;			//Checked CheckBox Count

	// 배열의 갯수만큼 loop
	for(var i=0; i<vCheckBoxArray.length; i++){
		// 체크상태 변경
		if(vCheckBoxArray[i].checked)  nChk++;
	}

	return nChk;
}

/*
	내    용 : Radio Box 체크
	파라미터 :	 pRadioBoxName - 라디오박스 이름
					pCheckedValue - 체크할 값
	Return값 : 없슴
*/
function fSetRadioChecked(pRadioBoxName, pCheckedValue){
	// 파라미터로 받은 이름을 가진 Element 의 배열을 변수에 저장
	var vRadioBoxArray = document.getElementsByName(pRadioBoxName);
	// 배열의 갯수만큼 loop
	for(var i=0; i<vRadioBoxArray.length; i++){
		// 체크상태 변경
		if(vRadioBoxArray[i].value == pCheckedValue) vRadioBoxArray[i].checked = true;
		else vRadioBoxArray[i].checked = false;
	}
}

/*
	내    용 :Radio Box checked True인 값을 리턴
	파라미터 :  pCtlName(개체명)
	Return값 : 없슴
*/
function fGetRadioChecked(pRadioBoxName){

	var vRtn = "";
	// 파라미터로 받은 이름을 가진 Element 의 배열을 변수에 저장
	var vRadioBoxArray = document.getElementsByName(pRadioBoxName);
	// 배열의 갯수만큼 loop

	for(var i=0; i<vRadioBoxArray.length; i++){
		// 체크상태 변경
		if(vRadioBoxArray[i].checked){
			vRtn = vRadioBoxArray[i].value;break;
		}
	}
	return vRtn
}


function goPrint( div ){

	pDoc = document.body.innerHTML;
	if(pDoc) {

		pDoc = document.getElementById(div).innerHTML;
		var printWinId = window.open('','','width=730,height=600,top=50,left=170,scrollbars=yes');
		var strTmp = "";
		strTmp += "<html><head>";
		strTmp += "<title>인쇄</title>\n";
		strTmp += "<style type='text/css'>";
		strTmp += "body, table, tr, td, li {font-size:1em;}";
		strTmp += "</style>";
		strTmp += "<link rel='stylesheet' type='text/css' href='../css/crisstyle.css'/>";
		strTmp += "<link href='../style/cris2014_base.css' rel='stylesheet' type='text/css' />";
		strTmp += "<link href='../style/cris2014_layout.css' rel='stylesheet' type='text/css' />";
		strTmp += "</head>\n";
		strTmp += "<body>\n";
		strTmp += "<table border=0 cellspacing=0 cellpadding=0 width=100%>";
		strTmp += "<tr><td><div style='padding:10px;'>\n";
		strTmp +=  pDoc;
		strTmp += "\n\n</div></td></tr>";
		strTmp += "</table>";
		strTmp += "</body></html>";

		printWinId.document.open();
		printWinId.document.write(strTmp);
		printWinId.focus();
		printWinId.document.close();
		printWinId.print();

	} else alert("페이지 내용을 불러오는데 문제가 발생했습니다.");
}

//GST_kdh_20120813 EMAIL 체크추가
/**
* Function      : 이메일체크
* @param        : String
* @return       : boolean
*/
function EmailCheck(email) {

	//var str = obj.value;
	if(email == "") return false;

	var i = email.indexOf("@");
	if(i < 0)	return false;

	i = email.indexOf(".");
	if(i < 0)	return false;

	return true;
}


//GST_kdh_20150114 rexport 프린터 적용
function goRexPrint()
{
	var rform = document.getElementById("rexform");
	rform.submit();
}

//GST_kdh_20170811 clip report 적용
function goCreport()
{
	var crfName = "/cris/cris_report_";
	var crfDbName = "ncrc_100";
	var clArr = ["kr", "en", "kren"];
	var chkDigit = /\d/;	
	var chkt = false;
	var chks = false;
	
	var cltype = $('#cltype').val();
	var cseq = $('#crfSeq').val();

	for(var i=0; i<clArr.length; i++)
	{
		if(cltype==clArr[i])
		{
			chkt = true;
			break;
		}
	}
	if(chkDigit.test(cseq))
	{
		chks = true;
	}
	if(chkt==false||chks==false)
	{
		alert("잘못된 요청입니다.");
		return;
	}


	$('#crfParams').val("seq:"+cseq);
	
	$('#crfName').val(crfName+cltype);
	$('#crfDbName').val(crfDbName);

	window.open('about:blank','crfpop','width=1200,height=600');
	
	$("#crfForm").submit();
}


//GST_kdh_20160831 input 입력길이 체크
function fn_lengchk(obj, len)
{
	if(obj.value.length==12)
		alert("비밀번호는 12자리까지만 입력 가능합니다.");
}

function fn_onlynum()
{
	if( !((event.keyCode >= 48 && event.keyCode <= 57) || (event.keyCode>=96&&event.keyCode<=105) || event.keyCode==8 || event.keyCode==13))
	{
		alert("숫자만 입력하세요.");
		event.returnValue = false;		
	}
}

//GST_kdh_20160831 스페이스바 입력 방지 onkeydown
function fn_spacechk()
{
	var keycode = event.keyCode;
	if(keycode == 32)
	{
		alert("공백은 입력할 수 없습니다.");
		event.returnValue = false;
	}
}

//GST_kdh_20160907 SNS 공유기능 추가
function sendSns(sns, url, txt)
{

	//alert("href==="+location.href)
	//alert("title==="+document.title)

    var o;
    var _url = encodeURIComponent(url);
    var _txt = encodeURIComponent(txt);
    var _br  = encodeURIComponent('\r\n');
 
    switch(sns)
    {
        case 'facebook':
            o = {
                method:'popup',
                url:'http://www.facebook.com/sharer/sharer.php?u=' + _url
            };
            break;
 
        case 'twitter':
            o = {
                method:'popup',
                url:'http://twitter.com/intent/tweet?text=' + _txt + '&url=' + _url
            };
            break;
 
        case 'me2day':
            o = {
                method:'popup',
                url:'http://me2day.net/posts/new?new_post[body]=' + _txt + _br + _url + '&new_post[tags]=epiloum'
            };
            break;
 
        case 'kakaotalk':
            o = {
                method:'web2app',
                param:'sendurl?msg=' + _txt + '&url=' + _url + '&type=link&apiver=2.0.1&appver=2.0&appid=dev.epiloum.net&appname=' + encodeURIComponent('Epiloum 개발노트'),
                a_store:'itms-apps://itunes.apple.com/app/id362057947?mt=8',
                g_store:'market://details?id=com.kakao.talk',
                a_proto:'kakaolink://',
                g_proto:'scheme=kakaolink;package=com.kakao.talk'
            };
            break;
 
        case 'kakaostory':
            o = {
                method:'web2app',
                param:'posting?post=' + _txt + _br + _url + '&apiver=1.0&appver=2.0&appid=dev.epiloum.net&appname=' + encodeURIComponent('Epiloum 개발노트'),
                a_store:'itms-apps://itunes.apple.com/app/id486244601?mt=8',
                g_store:'market://details?id=com.kakao.story',
                a_proto:'storylink://',
                g_proto:'scheme=kakaolink;package=com.kakao.story'
            };
            break;
 
        case 'band':
            o = {
                method:'web2app',
                param:'create/post?text=' + _txt + _br + _url,
                a_store:'itms-apps://itunes.apple.com/app/id542613198?mt=8',
                g_store:'market://details?id=com.nhn.android.band',
                a_proto:'bandapp://',
                g_proto:'scheme=bandapp;package=com.nhn.android.band'
            };
            break;

        default:
            alert('지원하지 않는 SNS입니다.');
            return false;
    }
 
    switch(o.method)
    {
        case 'popup':
            window.open(o.url);
            break;
 
        case 'web2app':
            if(navigator.userAgent.match(/android/i))
            {
                // Android
                setTimeout(function(){ location.href = 'intent://' + o.param + '#Intent;' + o.g_proto + ';end'}, 100);
            }
            else if(navigator.userAgent.match(/(iphone)|(ipod)|(ipad)/i))
            {
                // Apple
                setTimeout(function(){ location.href = o.a_store; }, 200);          
                setTimeout(function(){ location.href = o.a_proto + o.param }, 100);
            }
            else
            {
                alert('이 기능은 모바일에서만 사용할 수 있습니다.');
            }
            break;
            
        default:
            alert('잘못된 접근입니다.');
            return false;            
    }

}
