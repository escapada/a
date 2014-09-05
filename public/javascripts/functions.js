function resize_monitor() {
	var windowHSize = document.body.clientWidth;
	var windowVSize = document.body.clientHeight;

	var fp_wrapHSize = windowHSize-40
	var fp_wrapVSize = windowVSize-40

	var wrapperHSize = (fp_wrapHSize-40)/3;
	var wrapperVSize = (fp_wrapVSize-40)/3;

	$("#text").text(windowHSize+" : "+windowVSize+" : "+wrapperHSize);
	$("#fp_wrap").css({"padding-top": 20, "padding-left": 20});
	$(".wrapper").css({"width": wrapperHSize, "height": wrapperVSize});
	$(".wrapper_margin").css({"height": wrapperVSize});

	if (windowHSize > 1546) {
		$("#right-top-hidden").css({"display": "block"});
		$("#contentcolumn").css({"width": 1260});
	}
	else{
		$("#right-top-hidden").css({"display": "none"});
		$("#contentcolumn").css({"width": 940});
	}
}
function clear_cash() {
	$("[name='material']").val('');
	$("[name='color']").val('');
	$("#select-tirazh").val('Тираж');
	$("[name='dp1']").val(0);
	$("[name='dp2']").val(0);
	$("[name='dp3']").val(0);
	$("[name='dp4']").val(0);
	$("[name='dp5']").val(0);
	$("[name='dp6']").val(0);
	$("[name='dp7']").val(0);
	$("[name='dp8']").val(0);
	$("[name='dp9']").val(0);
	$("[name='klishe_blint']").val(0);
	$("[name='klishe_folga']").val(0);
	$("[name='klishe_kongrev']").val(0);
	$("[name='vyrubka']").val(0);
}
function tisnenieOrVyrubkaChecked(dp, checked) {						//$(this).children("input").attr('name')
	if (dp == 'dp1') {
		if(checked){
			$("#notice1").show(0);
		}
		else{
			$("#notice1").hide(0);
			if ($("input[name='klishe_blint']").parent().hasClass('selected')) {
				$("input[name='klishe_blint']").parent().removeClass('selected');
				$("input[name='klishe_blint']").val(0);
			}
		}
	}
		if (dp == 'dp2') {
		if(checked){
			$("#notice2").show(0);
		}
		else{
			$("#notice2").hide(0);
			if ($("input[name='klishe_folga']").parent().hasClass('selected')) {
				$("input[name='klishe_folga']").parent().removeClass('selected');
				$("input[name='klishe_folga']").val(0);
			}
		}
	}
	if (dp == 'dp3') {
		if(checked){
			$("#notice3").show(0);
		}
		else{
			$("#notice3").hide(0);
			if ($("input[name='klishe_kongrev']").parent().hasClass('selected')) {
				$("input[name='klishe_kongrev']").parent().removeClass('selected');
				$("input[name='klishe_kongrev']").val(0);
			}
		}
	}
	if (dp == 'dp9') {
		if(checked){
			$("#notice4").show(0);
		}
		else{
			$("#notice4").hide(0);
			if ($("input[name='vyrubka']").parent().hasClass('selected')) {
				$("input[name='vyrubka']").parent().removeClass('selected');
				$("input[name='vyrubka']").val(0);
			}
		}
	}
}