#??????https://git-scm.com/book/zh/v1/Git-%E5%88%86%E6%94%AF-%E5%88%86%E6%94%AF%E7%9A%84%E6%96%B0%E5%BB%BA%E4%B8%8E%E5%90%88%E5%B9%B6
var TakeMod = func(Num1,Num2){
    var About = Num1/Num2;
    var Number = int(About);
    var Final = Num1-Number
    return Number;
}
var echoStars = func(page,Nums){
    var apt = airportinfo(getprop("/autopilot/route-manager/departure/airport"));
    var allStars = apt.stars();
    var starsNum = size(apt.stars());
    var pageNo = 0;
    if(page == true){
        if(pageNo < starsNum){
            pageNo = pageNo + 1;
            setprop(("/instrumentation/cdu/output/line"~apt.stars[TakeMod(starsNum,pageNo)]~/"left",apt.stars[TakeMod(starsNum,pageNo);
            
        }
    }
    else{
        if(1 > pageNo){
            pageNo = pageNo - 1;
        }
    }
}
var echoSids = func(page){
	var apt = airportinfo(getprop("/autopilot/route-manager/departure/airport"));
	var allSids = apt.sids();
	var echoedSids = [];
	var i = 0;
	var sidsNum = size(apt.sids());
	
	var countStart = (page - 1) * 5;
	if(countStart > sidsNum){
		die("No more SIDS");
	}
	count = countStart;
	while(i <= 5){
	    if(count <= sidsNum){
			append(echoedSids, allSids[count]);
			i = i + 1;
			count = count + 1;
		}else{
			append(echoedSids, "");
			i = i + 1;
		}
	}
	return echoedSids;
}
var inputPosLatConversion = func(inputedPos){
	var isNorth = 1;
	
	if(find("N", inputedPos) != -1){
		isNorth = 1;
	}else{
		isNorth = 0;
	}
	
	var outputLat = string.trim(string.trim(string.trim(string.trim(inputedPos, 1, string.isdigit), 1, string.ispunct), 1, string.isdigit), 1, string.isalpha);
	var outputLatMin = string.trim(right(outputLat, 4));
	var outputLatMinInDeg = outputLatMin/60;
	var outputLatDeg = (substr(outputLat, 1, size(outputLat) - 5)) + outputLatMinInDeg;
	if(isNorth != 1){
		outputLatDeg = outputLatDeg * -1;
	}
	#print(outputLat);
	#print(outputLatDeg);
	return(outputLatDeg);
}
var inputPosLonConversion = func(inputedPos){
	var isEast = 1;
	
	if(find("E", inputedPos) != -1){
		isEast = 1;
	}else{
		isEast = 0;
	}
	
	var outputLon = string.trim(string.trim(string.trim(string.trim(inputedPos, -1, string.isalpha), -1, string.isdigit), -1, string.ispunct), -1, string.isdigit);
	var outputLonMin = string.trim(right(outputLon, 4));
	var outputLonMinInDeg = outputLonMin/60;
	var outputLonDeg = (substr(outputLon, 1, size(outputLon) - 5)) + outputLonMinInDeg;
	if(isEast != 1){
		outputLonDeg = outputLonDeg * -1;
	}
	#print(outputLon);
	#print(outputLonDeg);
	return(outputLonDeg);
}
var LatDMMunsignal = func(LatDeg){
	var latdegree_INIT = int(LatDeg);
	var latminint_INIT = int((LatDeg - latdegree_INIT) * 60);
	var latmindouble_INIT = int((((LatDeg - latdegree_INIT) * 60) - latminint_INIT) * 10);
	if(latminint_INIT < 10){
		var outlatminint_INIT = "0"~abs(latminint_INIT);
	}else{
		var outlatminint_INIT = abs(latminint_INIT);
	}
	var latmin_INIT = outlatminint_INIT~"."~abs(latmindouble_INIT);
	var isNS_INIT = "N";
	if(LatDeg > 0){
			isNS_INIT = "N";
	}else{
			isNS_INIT = "S";
	}
	if(latdegree_INIT < 10){
		var outlatdegree_INIT = "0"~abs(latdegree_INIT);
	}else{
		var outlatdegree_INIT = abs(latdegree_INIT);
	}
		var latresults_INIT = isNS_INIT~outlatdegree_INIT~""~latmin_INIT;
		return latresults_INIT;
	}
	
var LonDmmUnsignal = func(LonDeg){
	var londegree_INIT = int(LonDeg);
	var lonminint_INIT = int((LonDeg - londegree_INIT) * 60);
	var lonmindouble_INIT = int((((LonDeg - londegree_INIT) * 60) - lonminint_INIT) * 10);
	if(lonminint_INIT < 10){
		var outlonminint_INIT = "0"~abs(lonminint_INIT);
	}else{
	var outlonminint_INIT = abs(lonminint_INIT);
	}
	var lonmin_INIT = outlonminint_INIT~"."~abs(lonmindouble_INIT);
	var isEW_INIT = "E";
	if(LonDeg > 0){
		isEW_INIT = "E";
	}else{
		isEW_INIT = "W";
	}
	if(londegree_INIT < 10){
		var outlondegree_INIT = "0"~abs(londegree_INIT);
	}else{
		var outlondegree_INIT = abs(londegree_INIT);
	}
	var lonresults_INIT = isEW_INIT~outlondegree_INIT~lonmin_INIT;
		return lonresults_INIT;
	}
var getIRSPos = func(cduInputedPos){
	setprop("/instrumentation/fmc/inertialposlat", inputPosLatConversion(cduInputedPos));
	setprop("/instrumentation/fmc/inertialposlon", inputPosLonConversion(cduInputedPos));
	setprop("/instrumentation/fmc/inertialpos", latdeg2latDMM(getprop("/instrumentation/fmc/inertialposlat"))~" "~londeg2lonDMM(getprop("/instrumentation/fmc/inertialposlon")));
	}
var getGpsPos = func(){
	var gpsPosGot = latdeg2latDMM(getprop("/position/latitude-deg"))~" "~londeg2lonDMM(getprop("/position/longitude-deg"));
	setprop("/instrumentation/fmc/gpspos", gpsPosGot);
	return gpsPosGot;
	}
var getLastPos = func(){
	setprop("/instrumentation/fmc/lastposlat", getprop("/position/latitude-deg"));
	setprop("/instrumentation/fmc/lastposlon", getprop("/position/longitude-deg"));
	var lastPosGot = latdeg2latDMM(getprop("/position/latitude-deg"))~" "~londeg2lonDMM(getprop("/position/longitude-deg"));
	setprop("/instrumentation/fmc/lastpos", lastPosGot);
	return lastPosGot;
	}
var latdeg2latDMM = func(inLatDeg){
	var latdegree_INIT = int(inLatDeg);
	var latminint_INIT = int((inLatDeg - latdegree_INIT) * 60);
	var latmindouble_INIT = int((((inLatDeg - latdegree_INIT) * 60) - latminint_INIT) * 10);
	if(latminint_INIT < 10){
		var outlatminint_INIT = "0"~abs(latminint_INIT);
	}else{
		var outlatminint_INIT = abs(latminint_INIT);
	}
	var latmin_INIT = outlatminint_INIT~"."~abs(latmindouble_INIT);
	var isNS_INIT = "N";
	if(inLatDeg	> 0){
			isNS_INIT = "N";
	}else{
			isNS_INIT = "S";
	}
	if(latdegree_INIT < 10){
		var outlatdegree_INIT = "0"~abs(latdegree_INIT);
	}else{
		var outlatdegree_INIT = abs(latdegree_INIT);
	}
	var latresults_INIT = isNS_INIT~outlatdegree_INIT~"*"~latmin_INIT;
	return latresults_INIT;
}
var londeg2lonDMM = func(inLonDeg){
	var londegree_INIT = int(inLonDeg);
	var lonminint_INIT = int((inLonDeg - londegree_INIT) * 60);
	var lonmindouble_INIT = int((((inLonDeg - londegree_INIT) * 60) - lonminint_INIT) * 10);
	if(lonminint_INIT < 10){
		var outlonminint_INIT = "0"~abs(lonminint_INIT);
	}else{
		var outlonminint_INIT = abs(lonminint_INIT);
	}
	var lonmin_INIT = outlonminint_INIT~"."~abs(lonmindouble_INIT);
	var isEW_INIT = "E";
	if(inLonDeg > 0){
		isEW_INIT = "E";
	}else{
		isEW_INIT = "W";
	}
	if(londegree_INIT < 10){
		var outlondegree_INIT = "0"~abs(londegree_INIT);
	}else{
		var outlondegree_INIT = abs(londegree_INIT);
	}
	var lonresults_INIT = isEW_INIT~outlondegree_INIT~"*"~lonmin_INIT;
	return lonresults_INIT;
}
var input = func(v) {
		setprop("/instrumentation/cdu/input",getprop("/instrumentation/cdu/input")~v);
	}
	
var input = func(v) {
		setprop("/instrumentation/cdu/input",getprop("/instrumentation/cdu/input")~v);
	}
	
var key = func(v) {
		var cduDisplay = getprop("/instrumentation/cdu/display");
		var serviceable = getprop("/instrumentation/cdu/serviceable");
		var eicasDisplay = getprop("/instrumentation/eicas/display");
		var cduInput = getprop("/instrumentation/cdu/input");
		
		if (serviceable == 1){
			if (v == "LSK1L"){
				if (cduDisplay == "DEP_ARR_INDEX"){
					cduDisplay = "RTE1_DEP";
				}
				if (cduDisplay == "EICAS_MODES"){
					eicasDisplay = "ENG";
				}
				if (cduDisplay == "EICAS_SYN"){
					eicasDisplay = "ELEC";
				}
				if (cduDisplay == "INIT_REF"){
					cduDisplay = "IDENT";
				}
				if (cduDisplay == "NAV_RAD"){
					if (int(cduInput) > 107 and int(cduInput) < 119) {
						setprop("/instrumentation/nav[0]/frequencies/selected-mhz",cduInput);
					}
					cduInput = "";
				}
				if (cduDisplay == "RTE1_1"){
					setprop("/autopilot/route-manager/departure/airport",cduInput);
					cduInput = "";
				}
				if (cduDisplay == "RTE1_LEGS"){
					if (cduInput == "DELETE"){
						setprop("/autopilot/route-manager/input","@DELETE1");
						cduInput = "";
					}
					else{
						setprop("/autopilot/route-manager/input","@INSERT2:"~cduInput);
					}
				}
				if (cduDisplay == "TO_REF"){
					setprop("/instrumentation/fmc/to-flap",cduInput);
					cduInput = "";
				}
				if (cduDisplay == "POS_REF_0"){
					cduInput = LatDMMunsignal(getprop("/position/latitude-deg"))~LonDmmUnsignal(getprop("/position/longitude-deg"));
				}
				if (cduDisplay == "POS_REF"){
					cduInput = LatDMMunsignal(getprop("/position/latitude-deg"))~LonDmmUnsignal(getprop("/position/longitude-deg"));
				}
			}
			if (v == "LSK1R"){
				if (cduDisplay == "EICAS_MODES"){
					eicasDisplay = "FUEL";
				}
				if (cduDisplay == "EICAS_SYN"){
					eicasDisplay = "HYD";
				}
				if (cduDisplay == "POS_INIT"){
					#setprop("/instrumentation/fmc/lastposlat", " ");
					#setprop("/instrumentation/fmc/lastposlon", " ");
					cduInput = LatDMMunsignal(getprop("/instrumentation/fmc/lastposlat"))~LonDmmUnsignal(getprop("/instrumentation/fmc/lastposlon"));
				}
				if (cduDisplay == "NAV_RAD"){
					if (int(cduInput) > 107 and int(cduInput) < 119) {
						setprop("/instrumentation/nav[1]/frequencies/selected-mhz",cduInput);
					}
					cduInput = "";
				}
				if (cduDisplay == "RTE1_1"){
					setprop("/autopilot/route-manager/destination/airport",cduInput);
					cduInput = "";
				}
				if (cduDisplay == "RTE1_LEGS"){
					setprop("/autopilot/route-manager/route/wp[1]/altitude-ft",cduInput);
					if (substr(cduInput,0,2) == "FL"){
						setprop("/autopilot/route-manager/route/wp[1]/altitude-ft",substr(cduInput,2)*100);
					}
					cduInput = "";
				}
			}
			if (v == "LSK2L"){
				if (cduDisplay == "EICAS_MODES"){
					eicasDisplay = "STAT";
				}
				if (cduDisplay == "EICAS_SYN"){
					eicasDisplay = "ECS";
				}
				if (cduDisplay == "POS_INIT"){
					setprop("/instrumentation/fmc/ref-airport",cduInput);
					var RefApt = airportinfo(getprop("/instrumentation/fmc/ref-airport"));
					setprop("/instrumentation/fmc/ref-airport-poslat",RefApt.lat);
					setprop("/instrumentation/fmc/ref-airport-poslon",RefApt.lon);
					cduInput = "";
				}
				if (cduDisplay == "NAV_RAD"){
					if (int(cduInput) < 360) {
						setprop("/instrumentation/nav[0]/radials/selected-deg",cduInput);
					}
					cduInput = "";
				}
				if (cduDisplay == "INIT_REF"){
					cduDisplay = "POS_INIT";
				}
				if (cduDisplay == "RTE1_1"){
					if (getprop("/autopilot/route-manager/departure/airport") == ""){
						cduInput = cduInput;
					}
					else{
					setprop("/autopilot/route-manager/departure/runway",cduInput);
					cduInput = "";
					}
				}
				if (cduDisplay == "RTE1_LEGS"){
					if (cduInput == "DELETE"){
						setprop("/autopilot/route-manager/input","@DELETE2");
						cduInput = "";
					}
					else{
						setprop("/autopilot/route-manager/input","@INSERT3:"~cduInput);
					}
				}
				if (cduDisplay == "POS_REF_0"){
					cduInput = LatDMMunsignal(getprop("/position/latitude-deg"))~LonDmmUnsignal(getprop("/position/longitude-deg"));
				}
				if (cduDisplay == "POS_REF"){
					cduInput = LatDMMunsignal(getprop("/position/latitude-deg"))~LonDmmUnsignal(getprop("/position/longitude-deg"));
				}
			}
			if (v == "LSK2R"){
				if (cduDisplay == "DEP_ARR_INDEX"){
					cduDisplay = "RTE1_ARR";
				}
				else if (cduDisplay == "EICAS_MODES"){
					eicasDisplay = "GEAR";
				}
				else if (cduDisplay == "EICAS_SYN"){
					eicasDisplay = "DRS";
				}else if (cduDisplay == "POS_INIT"){
					if(getprop("/instrumentation/fmc/ref-airport") != ""){
						cduInput = LatDMMunsignal(getprop("/instrumentation/fmc/ref-airport-poslat"))~LonDmmUnsignal(getprop("/instrumentation/fmc/ref-airport-poslon"));
					}
				}
				else if (cduDisplay == "NAV_RAD"){
					if (int(cduInput) < 360) {
						setprop("/instrumentation/nav[1]/radials/selected-deg",cduInput);
					}
					cduInput = "";
				}
				else if (cduDisplay == "MENU"){
					eicasDisplay = "EICAS_MODES";
				}
				else if (cduDisplay == "RTE1_LEGS"){
					setprop("/autopilot/route-manager/route/wp[2]/altitude-ft",cduInput);
					if (substr(cduInput,0,2) == "FL"){
						setprop("/autopilot/route-manager/route/wp[2]/altitude-ft",substr(cduInput,2)*100);
					}
					cduInput = "";
				}
				else if (cduDisplay = "RTE1_1"){
					setprop("/instrumentation/fmc/FLT_NO",cduInput);
					cduInput = "";
				}
			}
			if (v == "LSK3L"){
				if (cduDisplay == "INIT_REF"){
					cduDisplay = "PERF_INIT";
				}
				if (cduDisplay == "POS_INIT"){
					setprop("/instrumentation/fmc/gate",cduInput);
					cduInput = "";
				}
				if (cduDisplay == "NAV_RAD"){
					if (int(cduInput) > 189 and int(cduInput) < 1751) {
						setprop("/instrumentation/adf[0]/frequencies/selected-khz",cduInput);
					}
					cduInput = "";
				}
				if (cduDisplay == "RTE1_LEGS"){
					if (cduInput == "DELETE"){
						setprop("/autopilot/route-manager/input","@DELETE3");
						cduInput = "";
					}
					else{
						setprop("/autopilot/route-manager/input","@INSERT4:"~cduInput);
					}
				}
				if (cduDisplay == "POS_REF_0"){
					cduInput = LatDMMunsignal(getprop("/position/latitude-deg"))~LonDmmUnsignal(getprop("/position/longitude-deg"));
				}
				if (cduDisplay == "POS_REF"){
					cduInput = LatDMMunsignal(getprop("/position/latitude-deg"))~LonDmmUnsignal(getprop("/position/longitude-deg"));
				}
			}
			if (v == "LSK3R"){
				if (cduDisplay == "NAV_RAD"){
					if (int(cduInput) > 189 and int(cduInput) < 1751) {
						setprop("/instrumentation/adf[1]/frequencies/selected-khz",cduInput);
					}
					cduInput = "";
				}
				if (cduDisplay == "RTE1_LEGS"){
					setprop("/autopilot/route-manager/route/wp[3]/altitude-ft",cduInput);
					if (substr(cduInput,0,2) == "FL"){
						setprop("/autopilot/route-manager/route/wp[3]/altitude-ft",substr(cduInput,2)*100);
					}
					cduInput = "";
				}
			}
			if (v == "LSK4L"){
				if (cduDisplay == "INIT_REF"){
					cduDisplay = "THR_LIM";
				}
				if (cduDisplay == "RTE1_LEGS"){
					if (cduInput == "DELETE"){
						setprop("/autopilot/route-manager/input","@DELETE4");
						cduInput = "";
					}
					else{
						setprop("/autopilot/route-manager/input","@INSERT5:"~cduInput);
					}
				}
			}
			if (v == "LSK4R"){
				if (cduDisplay == "POS_INIT"){
					setprop("/instrumentation/fmc/gpspos", " ");
					setprop("/instrumentation/fmc/gpsposlat", " ");
					setprop("/instrumentation/fmc/gpsposlon", " ");
					cduInput = LatDMMunsignal(getprop("/position/latitude-deg"))~LonDmmUnsignal(getprop("/position/longitude-deg"));
				}
				if (cduDisplay == "RTE1_LEGS"){
					setprop("/autopilot/route-manager/route/wp[4]/altitude-ft",cduInput);
					if (substr(cduInput,0,2) == "FL"){
						setprop("/autopilot/route-manager/route/wp[4]/altitude-ft",substr(cduInput,2)*100);
					}
					cduInput = "";
				}
			}
			if (v == "LSK5L"){
				if (cduDisplay == "INIT_REF"){
					cduDisplay = "TO_REF";
				}
				if (cduDisplay == "RTE1_LEGS"){
					if (cduInput == "DELETE"){
						setprop("/autopilot/route-manager/input","@DELETE5");
						cduInput = "";
					}
					else{
						setprop("/autopilot/route-manager/input","@INSERT6:"~cduInput);
					}
				}
			}
			if (v == "LSK5R"){
				if (cduDisplay == "RTE1_LEGS"){
					setprop("/autopilot/route-manager/route/wp[5]/altitude-ft",cduInput);
					if (substr(cduInput,0,2) == "FL"){
						setprop("/autopilot/route-manager/route/wp[5]/altitude-ft",substr(cduInput,2)*100);
					}
					cduInput = "";
				}
				if (cduDisplay == "POS_INIT"){
				call(func getIRSPos(cduInput), var err = []);
				if (size(err)){
					setprop("/instrumentation/cdu/input", "INVALID");
				}else{
					cduInput = "";
					}
				}
			}
			if (v == "LSK6L"){
				if (cduDisplay == "INIT_REF"){
					cduDisplay = "APP_REF";
				}
				if (cduDisplay == "APP_REF"){
					cduDisplay = "INIT_REF";
				}
				if ((cduDisplay == "IDENT") or (cduDisplay = "MAINT") or (cduDisplay = "PERF_INIT") or (cduDisplay = "POS_INIT") or (cduDisplay = "POS_REF") or (cduDisplay = "THR_LIM") or (cduDisplay = "TO_REF")){
					cduDisplay = "INIT_REF";
				}
			}
			if (v == "LSK6R"){
				if (cduDisplay == "THR_LIM"){
					cduDisplay = "TO_REF";
				}
				else if (cduDisplay == "APP_REF"){
					cduDisplay = "THR_LIM";
				}
				else if ((cduDisplay == "RTE1_1") or (cduDisplay == "RTE1_LEGS")){
					setprop("/autopilot/route-manager/input","@ACTIVATE");
				}
				else if ((cduDisplay == "POS_INIT") or (cduDisplay == "DEP") or (cduDisplay == "RTE1_ARR") or (cduDisplay == "RTE1_DEP")){
					cduDisplay = "RTE1_1";
				}
				else if ((cduDisplay == "IDENT") or (cduDisplay == "TO_REF")){
					cduDisplay = "POS_INIT";
				}
				else if (cduDisplay == "EICAS_SYN"){
					cduDisplay = "EICAS_MODES";
				}
				else if (cduDisplay == "EICAS_MODES"){
					cduDisplay = "EICAS_SYN";
				}
				else if (cduDisplay == "INIT_REF"){
					cduDisplay = "MAINT";
				}
			}
			
			setprop("/instrumentation/cdu/display",cduDisplay);
			if (eicasDisplay != nil){
				setprop("/instrumentation/eicas/display",eicasDisplay);
			}
			setprop("/instrumentation/cdu/input",cduInput);
		}
	}
	
var delete = func {
		var length = size(getprop("/instrumentation/cdu/input")) - 1;
		setprop("/instrumentation/cdu/input",substr(getprop("/instrumentation/cdu/input"),0,length));
	}
	
var i = 0;

var plusminus = func {	
	var end = size(getprop("/instrumentation/cdu/input"));
	var start = end - 1;
	var lastchar = substr(getprop("/instrumentation/cdu/input"),start,end);
	if (lastchar == "+"){
		me.delete();
		me.input('-');
		}
	if (lastchar == "-"){
		me.delete();
		me.input('+');
		}
	if ((lastchar != "-") and (lastchar != "+")){
		me.input('+');
		}
	}

var cdu = func{
		
		var display = getprop("/instrumentation/cdu/display");
		var serviceable = getprop("/instrumentation/cdu/serviceable");
		title = "";		page = "";
		line1l = "";	line2l = "";	line3l = "";	line4l = "";	line5l = "";	line6l = "";
		line1lt = "";	line2lt = "";	line3lt = "";	line4lt = "";	line5lt = "";	line6lt = "";
		line1c = "";	line2c = "";	line3c = "";	line4c = "";	line5c = "";	line6c = "";
		line1ct = "";	line2ct = "";	line3ct = "";	line4ct = "";	line5ct = "";	line6ct = "";
		line1r = "";	line2r = "";	line3r = "";	line4r = "";	line5r = "";	line6r = "";
		line1rt = "";	line2rt = "";	line3rt = "";	line4rt = "";	line5rt = "";	line6rt = "";
		
		if (display == "MENU") {
			title = "MENU";
			line1l = "<FMC";
			line1rt = "EFIS CP";
			line1r = "SELECT>";
			line2l = "<ACARS";
			line2rt = "EICAS CP";
			line2r = "SELECT>";
			line6l = "<ACMS";
			line6r = "CMC>";
		}
		if (display == "ALTN_NAV_RAD") {
			title = "ALTN NAV RADIO";
		}
		if (display == "APP_REF") {
			title = "APPROACH REF";
			line1lt = "GROSS WT";
			line1rt = "FLAPS    VREF";
			if (getprop("/instrumentation/fmc/vspeeds/Vref") != nil){
				line1l = getprop("/instrumentation/fmc/vspeeds/Vref");
			}
			if (getprop("/autopilot/route-manager/destination/airport") != nil){
				line4lt = getprop("/autopilot/route-manager/destination/airport");
			}
			line6l = "<INDEX";
			line6r = "THRUST LIM>";
		}
		if (display == "DEP_ARR_INDEX") {
			title = "DEP/ARR INDEX";
			line1l = "<DEP";
			line1ct = "RTE 1";
			if (getprop("/autopilot/route-manager/departure/airport") != nil){
				line1c = getprop("/autopilot/route-manager/departure/airport");
			}
			line1r = "ARR>";
			if (getprop("/autopilot/route-manager/destination/airport") != nil){
				line2c = getprop("/autopilot/route-manager/destination/airport");
			}
			line2r = "ARR>";
			line3l = "<DEP";
			line3r = "ARR>";
			line4r = "ARR>";
			line6lt ="DEP";
			line6l = "<----";
			line6c = "OTHER";
			line6rt ="ARR";
			line6r = "---->";
		}
		if (display == "EICAS_MODES") {
			title = "EICAS MODES";
			line1l = "<ENG";
			line1r = "FUEL>";
			line2l = "<STAT";
			line2r = "GEAR>";
			line5l = "<CANC";
			line5r = "RCL>";
			line6r = "SYNOPTICS>";
		}
		if (display == "EICAS_SYN") {
			title = "EICAS SYNOPTICS";
			line1l = "<ELEC";
			line1r = "HYD>";
			line2l = "<ECS";
			line2r = "DOORS>";
			line5l = "<CANC";
			line5r = "RCL>";
			line6r = "MODES>";
		}
		if (display == "FIX_INFO") {
			title = "FIX INFO";
			line1l = sprintf("%3.2f", getprop("/instrumentation/nav[0]/frequencies/selected-mhz-fmt"));
			line1r = sprintf("%3.2f", getprop("/instrumentation/nav[1]/frequencies/selected-mhz-fmt"));
			line2l = sprintf("%3.2f", getprop("/instrumentation/nav[0]/radials/selected-deg"));
			line2r = sprintf("%3.2f", getprop("/instrumentation/nav[1]/radials/selected-deg"));
			line6l = "<ERASE FIX";
		}
		if (display == "IDENT") {
			title = "IDENT";
			line1lt = "MODEL";
			if (getprop("/instrumentation/cdu/ident/model") != nil){
				line1l = getprop("/instrumentation/cdu/ident/model");
			}
			line1rt = "ENGINES";
			line2lt = "NAV DATA";
			if (getprop("/instrumentation/cdu/ident/engines") != nil){
				line1r = getprop("/instrumentation/cdu/ident/engines");
			}
			line6ct = "----------------------------------------";
			line6l = "<INDEX";
			line6r = "POS INIT>";
		}
		if (display == "INIT_REF") {
			title = "INIT/REF INDEX";
			line1l = "<IDENT";
			line1r = "NAV DATA>";
			line2l = "<POS";
			line3l = "<PERF";
			line4l = "<THRUST LIM";
			line5l = "<TAKEOFF";
			line6l = "<APPROACH";
			line6r = "MAINT>";
		}
		if (display == "MAINT") {
			title = "MAINTENANCE INDEX";
			line1l = "<CROS LOAD";
			line1r = "BITE>";
			line2l = "<PERF FACTORS";
			line3l = "<IRS MONITOR";
			line6l = "<INDEX";
		}
		if (display == "NAV_RAD") {
			title = "NAV RADIO";
			line1lt = "VOR L";
			line1l = sprintf("%3.2f", getprop("/instrumentation/nav[0]/frequencies/selected-mhz-fmt"));
			line1rt = "VOR R";
			line1r = sprintf("%3.2f", getprop("/instrumentation/nav[1]/frequencies/selected-mhz-fmt"));
			line2lt = "CRS";
			line2ct = "RADIAL";
			line2c = sprintf("%3.2f", getprop("/instrumentation/nav[0]/radials/selected-deg"))~"   "~sprintf("%3.2f", getprop("/instrumentation/nav[1]/radials/selected-deg"));
			line2rt = "CRS";
			line3lt = "ADF L";
			line3l = sprintf("%3.2f", getprop("/instrumentation/adf[0]/frequencies/selected-khz"));
			line3rt = "ADF R";
			line3r = sprintf("%3.2f", getprop("/instrumentation/adf[1]/frequencies/selected-khz"));
		}
		if (display == "PERF_INIT") {
			title = "PERF INIT";
			line1lt = "GR WT";
			line1rt = "CRZ ALT";
			line1r = getprop("/autopilot/route-manager/cruise/altitude-ft");
			line2lt = "FUEL";
			line3lt = "ZFW";
			line4lt = "RESERVES";
			line4rt = "CRZ CG";
			line5lt = "COST INDEX";
			line5rt = "STEP SIZE";
			line6l = "<INDEX";
			line6r = "THRUST LIM>";	
			if (getprop("/sim/flight-model") == "jsb") {
				line1l = sprintf("%3.1f", (getprop("/fdm/jsbsim/inertia/weight-lbs")/1000));
				line2l = sprintf("%3.1f", (getprop("/fdm/jsbsim/propulsion/total-fuel-lbs")/1000));
				line3l = sprintf("%3.1f", (getprop("/fdm/jsbsim/inertia/empty-weight-lbs")/1000));
			}
			elsif (getprop("/sim/flight-model") == "yasim") {
				line1l = sprintf("%3.1f", (getprop("/yasim/gross-weight-lbs")/1000));
				line2l = sprintf("%3.1f", (getprop("/consumables/fuel/total-fuel-lbs")/1000));

				yasim_emptyweight = getprop("/yasim/gross-weight-lbs");
				yasim_emptyweight -= getprop("/consumables/fuel/total-fuel-lbs");
				yasim_weights = props.globals.getNode("/sim").getChildren("weight");
				for (i = 0; i < size(yasim_weights); i += 1) {
					yasim_emptyweight -= yasim_weights[i].getChild("weight-lb").getValue();
				}

				line3l = sprintf("%3.1f", yasim_emptyweight/1000);
			}
		}
		if (display == "POS_INIT") {
			title = "POS INIT";
			page = "1/3";
			line1rt = "LAST POS";
			line1r = getLastPos();
			line2lt = "REF AIRPORT";
			var getRefApt = func(){
				var aptA_INIT = getprop("/instrumentation/fmc/ref-airport") or "";
				if (aptA_INIT == ""){
				    setprop("/instrumentation/fmc/gate", " ");
					setprop("/instrumentation/fmc/ref-airport-pos", "");
					return "----";
				}else{
					var refAptLat = airportinfo(aptA_INIT).lat;
					var refAptLon = airportinfo(aptA_INIT).lon;
					var refAptPosStr = latdeg2latDMM(refAptLat)~" "~londeg2lonDMM(refAptLon);
					setprop("/instrumentation/fmc/gate", "-----");
					setprop("/instrumentation/fmc/ref-airport-pos", refAptPosStr);
					return aptA_INIT;
				}
			}
			var line2ltmp = call(func getRefApt(), nil, var err = []);
			if (size(err)){
				setprop("/instrumentation/fmc/ref-airport", "");
				setprop("/instrumentation/cdu/input", "NOT IN DATABASE");
			}else{
				line2l = line2ltmp;
			}
			line2r = getprop("/instrumentation/fmc/ref-airport-pos");
			line3lt = "GATE";
			line3l = getprop("/instrumentation/fmc/gate");
			line4rt = "GPS POS";
			line4r = getGpsPos();
			line4lt = "UTC";
			if(getprop("/instrumentation/clock/indicated-hour") < 10){
				if(getprop("/instrumentation/clock/indicated-min") < 10){
					line4l = "0"~getprop("/instrumentation/clock/indicated-hour")~"0"~getprop("/instrumentation/clock/indicated-min")~"z";
				}else{
					line4l = "0"~getprop("/instrumentation/clock/indicated-hour")~getprop("/instrumentation/clock/indicated-min")~"z";
				}
			}else if(getprop("/instrumentation/clock/indicated-min") < 10){
				line4l = getprop("/instrumentation/clock/indicated-hour")~"0"~getprop("/instrumentation/clock/indicated-min")~"z";
			}else{
				line4l = getprop("/instrumentation/clock/indicated-hour")~getprop("/instrumentation/clock/indicated-min")~"z";
			}
			line5rt = "SET INERTIAL POS";
			line6ct = "----------------------------------------";
			line6l = "<INDEX";
			line6r = "ROUTE>";
		}
		if (display == "POS_REF_0") {
			title = "POS REF";
			page = "2/3";
			line1lt = "FMC(GPS)        ACTUAL";
			line1l = getGpsPos();
			line2lt = "IRS(3)        ACTUAL";
			line2l = getGpsPos();
			line3lt = "GPS        ACTUAL";
			line3l = getGpsPos();
			line6ct = "----------------------------------------";
			line6l = "<INDEX";
		}
		if (display == "POS_REF") {
			title = "POS REF";
			page = "3/3";
			line1lt = "IRS L";
			line1rt = "GS";	
			line1l = getGpsPos();
			line1r = sprintf("%3.0f", getprop("/velocities/groundspeed-kt"));
			line2lt = "IRS C";
			line2rt = "GS";	
			line2l = getGpsPos();
			line2r = sprintf("%3.0f", getprop("/velocities/groundspeed-kt"));
			line3lt = "IRS R";
			line3rt = "GS";	
			line3l = getGpsPos();
			line3r = sprintf("%3.0f", getprop("/velocities/groundspeed-kt"));
			line5l = "<PURGE";
			line5r = "INHIBIT>";
			line6l = "<INDEX";
			line6r = "BRG/DIST>";
		}
		if (display == "RTE1_1") {
			title = "RTE 1";
			page = "1/2";
			line1lt = "ORIGIN";
			if (getprop("/autopilot/route-manager/departure/airport") != nil){
				line1l = getprop("/autopilot/route-manager/departure/airport");
			}
			line1rt = "DEST";
			if (getprop("/autopilot/route-manager/destination/airport") != nil){
				line1r = getprop("/autopilot/route-manager/destination/airport");
			}
			line2lt = "RUNWAY";
			if (getprop("/autopilot/route-manager/departure/runway") != nil){
				line2l = getprop("/autopilot/route-manager/departure/runway");
			}
			line2rt = "FLT NO";
			line3rt = "CO ROUTE";
			line5l = "<RTE COPY";
			line6l = "<RTE 2";
			line6r = "ACTIVATE>";
		}
		if (display == "RTE1_2") {
			title = "RTE 1";
			page = "2/2";
			line1lt = "VIA";
			line1rt = "TO";
			if (getprop("/autopilot/route-manager/route/wp[1]/id") != nil){
				line1r = getprop("/autopilot/route-manager/route/wp[1]/id");
				}
			if (getprop("/autopilot/route-manager/route/wp[2]/id") != nil){
				line2r = getprop("/autopilot/route-manager/route/wp[2]/id");
				}
			if (getprop("/autopilot/route-manager/route/wp[3]/id") != nil){
				line3r = getprop("/autopilot/route-manager/route/wp[3]/id");
				}
			if (getprop("/autopilot/route-manager/route/wp[4]/id") != nil){
				line4r = getprop("/autopilot/route-manager/route/wp[4]/id");
				}
			if (getprop("/autopilot/route-manager/route/wp[5]/id") != nil){
				line5r = getprop("/autopilot/route-manager/route/wp[5]/id");
				}
			line6l = "<RTE 2";
			line6r = "ACTIVATE>";
		}
		if (display == "RTE1_ARR") {
			if (getprop("/autopilot/route-manager/destination/airport") != nil){
				title = getprop("/autopilot/route-manager/destination/airport")~" ARRIVALS";
			}
			else{
				title = "ARRIVALS";
			}
			line1lt = "STARS";
			line1rt = "APPROACHES";
			if (getprop("/autopilot/route-manager/destination/runway") != nil){
				line1r = getprop("/autopilot/route-manager/destination/runway");
			}
			line2lt = "TRANS";
			line3rt = "RUNWAYS";
			line6l = "<INDEX";
			line6r = "ROUTE>";
		}
		if (display == "RTE1_DEP") {
		
			if (getprop("/autopilot/route-manager/departure/airport") != nil){
				title = getprop("/autopilot/route-manager/departure/airport")~" DEPARTURES";
			}
			else{
				title = "DEPARTURES";
			}
			line2ct = "RTE 1";
			line1lt = "SIDS";
			line1l = echoSids(1)[0];
			line2l = echoSids(1)[1];
			line3l = echoSids(1)[2];
			line4l = echoSids(1)[3];
			line5l = echoSids(1)[4];
			line6ct = "----------------------------------------";
			line1rt = "RUNWAYS";
			if (getprop("/autopilot/route-manager/departure/runway") != nil){
				line1r = getprop("/autopilot/route-manager/departure/runway");
			}
			#line2lt = "TRANS";
			line6l = "<ERASE";
			line6r = "ROUTE>";
		}
		if (display == "RTE1_LEGS") {
			if (getprop("/autopilot/route-manager/active") == 1){
				title = "ACT RTE 1 LEGS";
				}
			else {
				title = "RTE 1 LEGS";
				}
			if (getprop("/autopilot/route-manager/route/wp[1]/id") != nil){
				line1lt = sprintf("%3.0f", getprop("/autopilot/route-manager/route/wp[1]/leg-bearing-true-deg"));
				line1l = getprop("/autopilot/route-manager/route/wp[1]/id");
				line2ct = sprintf("%3.0f", getprop("/autopilot/route-manager/route/wp[1]/leg-distance-nm"))~" NM";
				line1r = sprintf("%5.0f", getprop("/autopilot/route-manager/route/wp[1]/altitude-ft"));
				if (getprop("/autopilot/route-manager/route/wp[1]/speed-kts") != nil){
					line4r = getprop("/autopilot/route-manager/route/wp[1]/speed-kts")~"/"~sprintf("%5.0f", getprop("/autopilot/route-manager/route/wp[1]/altitude-ft"));
					}
				}
			if (getprop("/autopilot/route-manager/route/wp[2]/id") != nil){
				if (getprop("/autopilot/route-manager/route/wp[2]/leg-bearing-true-deg") != nil){
					line2lt = sprintf("%3.0f", getprop("/autopilot/route-manager/route/wp[2]/leg-bearing-true-deg"));
				}
				line2l = getprop("/autopilot/route-manager/route/wp[2]/id");
				if (getprop("/autopilot/route-manager/route/wp[2]/leg-distance-nm") != nil){
					line3ct = sprintf("%3.0f", getprop("/autopilot/route-manager/route/wp[2]/leg-distance-nm"))~" NM";
				}
				line2r = sprintf("%5.0f", getprop("/autopilot/route-manager/route/wp[2]/altitude-ft"));
				if (getprop("/autopilot/route-manager/route/wp[2]/speed-kts") != nil){
					line4r = getprop("/autopilot/route-manager/route/wp[2]/speed-kts")~"/"~sprintf("%5.0f", getprop("/autopilot/route-manager/route/wp[2]/altitude-ft"));
					}
				}
			if (getprop("/autopilot/route-manager/route/wp[3]/id") != nil){
				if (getprop("/autopilot/route-manager/route/wp[3]/leg-bearing-true-deg") != nil){
					line3lt = sprintf("%3.0f", getprop("/autopilot/route-manager/route/wp[3]/leg-bearing-true-deg"));
				}
				line3l = getprop("/autopilot/route-manager/route/wp[3]/id");
				if (getprop("/autopilot/route-manager/route/wp[3]/leg-distance-nm") != nil){
					line4ct = sprintf("%3.0f", getprop("/autopilot/route-manager/route/wp[3]/leg-distance-nm"))~" NM";
				}
				line3r = sprintf("%5.0f", getprop("/autopilot/route-manager/route/wp[3]/altitude-ft"));
				if (getprop("/autopilot/route-manager/route/wp[3]/speed-kts") != nil){
					line3r = getprop("/autopilot/route-manager/route/wp[3]/speed-kts")~"/"~sprintf("%5.0f", getprop("/autopilot/route-manager/route/wp[3]/altitude-ft"));;
					}
				}
			if (getprop("/autopilot/route-manager/route/wp[4]/id") != nil){
				if (getprop("/autopilot/route-manager/route/wp[4]/leg-bearing-true-deg") != nil){
					line4lt = sprintf("%3.0f", getprop("/autopilot/route-manager/route/wp[4]/leg-bearing-true-deg"));
				}
				line4l = getprop("/autopilot/route-manager/route/wp[4]/id");
				if (getprop("/autopilot/route-manager/route/wp[4]/leg-distance-nm") != nil){
					line5ct = sprintf("%3.0f", getprop("/autopilot/route-manager/route/wp[4]/leg-distance-nm"))~" NM";
				}
				line4r = sprintf("%5.0f", getprop("/autopilot/route-manager/route/wp[4]/altitude-ft"));
				if (getprop("/autopilot/route-manager/route/wp[4]/speed-kts") != nil){
					line4r = getprop("/autopilot/route-manager/route/wp[4]/speed-kts")~"/"~sprintf("%5.0f", getprop("/autopilot/route-manager/route/wp[4]/altitude-ft"));
					}
				}
			if (getprop("/autopilot/route-manager/route/wp[5]/id") != nil){
				if (getprop("/autopilot/route-manager/route/wp[5]/leg-bearing-true-deg") != nil){
					line5lt = sprintf("%3.0f", getprop("/autopilot/route-manager/route/wp[5]/leg-bearing-true-deg"));
				}
				line5l = getprop("/autopilot/route-manager/route/wp[5]/id");
				line5r = sprintf("%5.0f", getprop("/autopilot/route-manager/route/wp[5]/altitude-ft"));
				if (getprop("/autopilot/route-manager/route/wp[5]/speed-kts") != nil){
					line4r = getprop("/autopilot/route-manager/route/wp[5]/speed-kts")~"/"~sprintf("%5.0f", getprop("/autopilot/route-manager/route/wp[5]/altitude-ft"));
					}
				}
			line6l = "<RTE 2 LEGS";
			if (getprop("/autopilot/route-manager/active") == 1){
				line6r = "RTE DATA>";
				}
			else{
				line6r = "ACTIVATE>";
				}
		}
		if (display == "THR_LIM") {
			title = "THRUST LIM";
			line1lt = "SEL";
			line1ct = "OAT";
			line1c = sprintf("%2.0f", getprop("/environment/temperature-degc"))~" �C";
			line1rt = "TO 1 N1";
			line2l = "<TO";
			line2r = "CLB>";
			line3lt = "TO 1";
			line3l = "<-10%";
			line3c = "<SEL> <ARM>";
			line3r = "CLB 1>";
			line4lt = "TO 2";
			line4l = "<-20%";
			line4r = "CLB 2>";
			line6l = "<INDEX";
			line6r = "TAKEOFF>";
		}
		if (display == "TO_REF") {
			title = "TAKEOFF REF";
			line1lt = "FLAP/ACCEL HT";
			line1l = sprintf("%2.0f", getprop("/instrumentation/fmc/to-flap"));
			line1rt = "REF V1";
			if (getprop("/instrumentation/fmc/vspeeds/V1") != nil){
				line1r = sprintf("%3.0f", getprop("/instrumentation/fmc/vspeeds/V1"));
			}
			line2lt = "E/O ACCEL HT";
			line2rt = "REF VR";
			if (getprop("/instrumentation/fmc/vspeeds/VR") != nil){
				line2r = sprintf("%3.0f", getprop("/instrumentation/fmc/vspeeds/VR"));
			}
			line3lt = "THR REDUCTION";
			line3rt = "REF V2";
			if (getprop("/instrumentation/fmc/vspeeds/V2") != nil){
				line3r = sprintf("%3.0f", getprop("/instrumentation/fmc/vspeeds/V2"));
			}
			line4lt = "WIND/SLOPE";
			line4rt = "TRIM   CG";
			line5rt = "POS SHIFT";
			line6l = "<INDEX";
			line6r = "POS INIT>";
		}
		
		if (serviceable != 1){
			title = "";		page = "";
			line1l = "";	line2l = "";	line3l = "";	line4l = "";	line5l = "";	line6l = "";
			line1lt = "";	line2lt = "";	line3lt = "";	line4lt = "";	line5lt = "";	line6lt = "";
			line1c = "";	line2c = "";	line3c = "";	line4c = "";	line5c = "";	line6c = "";
			line1ct = "";	line2ct = "";	line3ct = "";	line4ct = "";	line5ct = "";	line6ct = "";
			line1r = "";	line2r = "";	line3r = "";	line4r = "";	line5r = "";	line6r = "";
			line1rt = "";	line2rt = "";	line3rt = "";	line4rt = "";	line5rt = "";	line6rt = "";
		}
		
		setprop("/instrumentation/cdu/output/title",title);
		setprop("/instrumentation/cdu/output/page",page);
		setprop("/instrumentation/cdu/output/line1/left",line1l);
		setprop("/instrumentation/cdu/output/line2/left",line2l);
		setprop("/instrumentation/cdu/output/line3/left",line3l);
		setprop("/instrumentation/cdu/output/line4/left",line4l);
		setprop("/instrumentation/cdu/output/line5/left",line5l);
		setprop("/instrumentation/cdu/output/line6/left",line6l);
		setprop("/instrumentation/cdu/output/line1/left-title",line1lt);
		setprop("/instrumentation/cdu/output/line2/left-title",line2lt);
		setprop("/instrumentation/cdu/output/line3/left-title",line3lt);
		setprop("/instrumentation/cdu/output/line4/left-title",line4lt);
		setprop("/instrumentation/cdu/output/line5/left-title",line5lt);
		setprop("/instrumentation/cdu/output/line6/left-title",line6lt);
		setprop("/instrumentation/cdu/output/line1/center",line1c);
		setprop("/instrumentation/cdu/output/line2/center",line2c);
		setprop("/instrumentation/cdu/output/line3/center",line3c);
		setprop("/instrumentation/cdu/output/line4/center",line4c);
		setprop("/instrumentation/cdu/output/line5/center",line5c);
		setprop("/instrumentation/cdu/output/line6/center",line6c);
		setprop("/instrumentation/cdu/output/line1/center-title",line1ct);
		setprop("/instrumentation/cdu/output/line2/center-title",line2ct);
		setprop("/instrumentation/cdu/output/line3/center-title",line3ct);
		setprop("/instrumentation/cdu/output/line4/center-title",line4ct);
		setprop("/instrumentation/cdu/output/line5/center-title",line5ct);
		setprop("/instrumentation/cdu/output/line6/center-title",line6ct);
		setprop("/instrumentation/cdu/output/line1/right",line1r);
		setprop("/instrumentation/cdu/output/line2/right",line2r);
		setprop("/instrumentation/cdu/output/line3/right",line3r);
		setprop("/instrumentation/cdu/output/line4/right",line4r);
		setprop("/instrumentation/cdu/output/line5/right",line5r);
		setprop("/instrumentation/cdu/output/line6/right",line6r);
		setprop("/instrumentation/cdu/output/line1/right-title",line1rt);
		setprop("/instrumentation/cdu/output/line2/right-title",line2rt);
		setprop("/instrumentation/cdu/output/line3/right-title",line3rt);
		setprop("/instrumentation/cdu/output/line4/right-title",line4rt);
		setprop("/instrumentation/cdu/output/line5/right-title",line5rt);
		setprop("/instrumentation/cdu/output/line6/right-title",line6rt);
		settimer(cdu,0.2);
    }
_setlistener("/sim/signals/fdm-initialized", cdu); 
