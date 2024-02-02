var Voip = "Normal";
var Interval = undefined;
// -------------------------------------------------------------------------------------------
function Minimal(Seconds){
	var Days = Math.floor(Seconds / 86400)
	Seconds = Seconds - Days * 86400
	var Hours = Math.floor(Seconds / 3600)
	Seconds = Seconds - Hours * 3600
	var Minutes = Math.floor(Seconds / 60)
	Seconds = Seconds - Minutes * 60

	const [D,H,M,S] = [Days,Hours,Minutes,Seconds].map(s => s.toString().padStart(2,0))

    if (Days > 0){
        return D + ":" + H
    } else if (Hours > 0){
        return H + ":" + M
    } else if (Minutes > 0){
        return M + ":" + S
    } else if (Seconds > 0){
        return "00:" + S
    }
}
// -------------------------------------------------------------------------------------------
const FormatNumber = n => {
	var n = n.toString();
	var r = "";
	var x = 0;

	for (var i = n["length"]; i > 0; i--) {
		r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? "." : "");
		x = x == 2 ? 0 : x + 1;
	}

	return r.split("").reverse().join("");
}
// -------------------------------------------------------------------------------------------
window.addEventListener("message",function(event){
	switch (event["data"]["Action"]){
		case "ProgressBar":
			$("#ProgressHypee").is(":visible") && timeoutFn && clearTimeout(timeoutFn);
			$("#ProgressHypee").fadeIn();
			var start = new Date();
			var maxTime = event.data.time;
			var timeoutVal = Math.floor(maxTime / 115);
			animateUpdate();

			function updateProgress(percentage) {
				var $circle = $('#svg #bar');
				var r = $circle.attr('r');
				var c = Math.PI * (r * 2);
				var pct = ((100 - percentage) / 100) * c;
				$circle.css({
					strokeDashoffset: pct,
					strokeDasharray: c  // Adicione esta linha para garantir que o círculo comece do topo
				});
			}

			function animateUpdate() {
				var now = new Date();
				var timeDiff = now.getTime() - start.getTime();
				var perc = Math.round((timeDiff / maxTime) * 100);

				if (perc <= 100) {
					$('#porcentagem').html(perc + '<porcentagem>%<porcentagem>');
					updateProgress(perc);
					timeoutFn = setTimeout(animateUpdate, timeoutVal);
				} else {
					// $("#body").scale(2.0);
					// setTimeout(() => {
					$("#ProgressHypee").fadeOut(500);
					clearTimeout(timeoutFn);
					timeoutFn = undefined;
					// }, 1000);
				}
			}
		break;

		case "Frequency":
			if (event["data"]["Frequency"] == 0 ) {
				$("#radioText").html('Desligado');
			} else if (event["data"]["Frequency"] == '0 Mhz' ) {
				$("#radioText").html('Desligado');
			} else {
				$("#radioText").html(event["data"]["Frequency"]);
			}
		break;

		case "Body":
			if (event["data"]["Status"]){
				if ($("#Body").css("display") === "none"){
					$("#Body").fadeIn(1000);
				}
			} else {
				if ($("#Body").css("display") === "block"){
					$("#Body").fadeOut(1000);
				}
			}
		break;

		case "Passport":
			$(".Passport").html(FormatNumber(event["data"]["Number"]));
		break;

		case "Gemstone":
			$(".Gemstone").html(FormatNumber(event["data"]["Number"]));
		break;

		case "Voip":
			//(event["data"]["Voip"])
			if (event["data"]["Voip"] == "Offline"){
				$("#Voip-Color").html(Voip);
			} else {
				if (event["data"]["Voip"] !== "Online"){
					Voip = event["data"]["Voip"];
				}

				$("#Voip-Color").html(Voip);
			}
		break;

		case "Voice":
			if (event["data"]["Status"] == 1) {
				$("#Voip-Img").css("filter",'drop-shadow(0px 0px 0.2vw white)');
			} else {
				$("#Voip-Img").css("filter","drop-shadow(0px 0px 0.0vw white)");
			}
		break;

		case "Clock":
			var Hours = event["data"]["Hours"];
			var Minutes = event["data"]["Minutes"];

			if (Hours <= 9)
				Hours = "0" + Hours

			if (Minutes <= 9)
				Minutes = "0" + Minutes

			$(".Date").html(Hours + ":" + Minutes);
		break;

		case "Wanted":
			if (event["data"]["Number"] > 0){
				if ($(".Wanted").css("display") === "none"){
					$(".Wanted").fadeIn(1000);
				}

				$(".WantedTimer").html(Minimal(event["data"]["Number"]));
			} else {
				if ($(".Wanted").css("display") === "block"){
					$(".Wanted").fadeOut(1000);
				}
			}
		break;

		case "Hood":
			if (event["data"]["Number"] > 0){
				if ($("#hoodDisplay").css("display") === "none"){
					$("#hoodDisplay").fadeIn(500);
				}
			} else {
				if ($("#hoodDisplay").css("display") === "block"){
					$("#hoodDisplay").fadeOut(500);
				}
			}
		break;

		case "Reposed":
			if (event["data"]["Number"] > 0){
				if ($(".Reposed").css("display") === "none"){
					$(".Reposed").fadeIn(1000);
				}

				$(".ReposedTimer").html(Minimal(event["data"]["Number"]));
			} else {
				if ($(".Reposed").css("display") === "block"){
					$(".Reposed").fadeOut(1000);
				}
			}
		break;

		case "Road":
			if (event['data']['Vehicle']) {
				$('#Infos2').animate({bottom: '22.2vh'},300)
			} else {
				$('#Infos2').animate({bottom: '2.2vh'},300)
			}
			$("#title-road").html(event["data"]["Name"]);
		break;

		case "Crossing":
			if (event['data']['Vehicle']) {
				$('#Infos2').animate({bottom: '22.2vh'},300)
			} else {
				$('#Infos2').animate({bottom: '2.2vh'},300)
			}
			$("#local-text").html(event["data"]["Name"]);
		break;

		case "Oxigen":
			if (event["data"]["Number"] < 100){
				if ($(".Oxigen").css("display") === "none"){
					$(".Oxigen").fadeIn(1000);
				}
				//(event["data"]["Number"])
				if (event['data']['Number'] >= 0) {
					$(".Oxigen").css("stroke-dashoffset",100 - event["data"]["Number"]);
				}
			} else {
				if ($(".Oxigen").css("display") === "block"){
					$(".Oxigen").fadeOut(1000);
				}
			}
		break;

		case "Health":
			//('Health',event["data"]["Number"])
			if (event["data"]["Number"] > 0){
				$(".Health span").css("width",event["data"]["Number"] + '%')
			} else {
				$(".Health span").css("width",event["data"]["Number"] + '%')
			}
		break;

		case "Armour":
			//('Armour',event["data"]["Number"])
			if (event["data"]["Number"] > 0){
				$(".Armour span").css("width",event["data"]["Number"] + '%')
			} else {

				$(".Armour span").css("width",event["data"]["Number"] + '%')
			}
		break;

		case "Hunger":
			$(".Hunger").css("stroke-dashoffset",100 - event["data"]["Number"]);
		break;

		case "Thirst":
			$(".Thirst").css("stroke-dashoffset",100 - event["data"]["Number"]);
		break;

		case "Stress":
			if (event["data"]["Number"] > 0){
				if ($(".Stress").css("display") === "none"){
					$(".Stress").fadeIn(1000);
				}

				$(".Stress").css("stroke-dashoffset",100 - event["data"]["Number"]);
			} else {
				if ($(".Stress").css("display") === "block"){
					$(".Stress").fadeOut(1000);
				}
			}
		break;

		case "Luck":
			if (event["data"]["Number"] > 0){
				if ($(".Lucks").css("display") === "none"){
					$(".Lucks").fadeIn(1000);
				}

				event["data"]["Number"] = event["data"]["Number"] / 36;

				$(".Luck").css("stroke-dashoffset",100 - event["data"]["Number"]);
			} else {
				if ($(".Lucks").css("display") === "block"){
					$(".Lucks").fadeOut(1000);
				}
			}
		break;

		case "Dexterity":
			if (event["data"]["Number"] > 0){
				if ($(".Dexteritys").css("display") === "none"){
					$(".Dexteritys").fadeIn(1000);
				}

				event["data"]["Number"] = event["data"]["Number"] / 36;

				$(".Dexterity").css("stroke-dashoffset",100 - event["data"]["Number"]);
			} else {
				if ($(".Dexteritys").css("display") === "block"){
					$(".Dexteritys").fadeOut(1000);
				}
			}
		break;

		case "Thirst":
			$(".Voice").css("stroke-dashoffset",100 - event["data"]["Number"]);
		break;

		case "Vehicle":
			if (event["data"]["Status"]){
				if ($("#Vehicle").css("display") === "none"){
					$("#Vehicle").fadeIn(1000);
				}
			} else {
				if ($("#Vehicle").css("display") === "block"){
					$("#Vehicle").fadeOut(1000);
				}
			}
		break;

		case "Fuel":
			var Fuel = parseInt(event["data"]["Number"]);
			//(Fuel)
			$(".Fuel").css("stroke-dashoffset",100 - Fuel);
		break;

		case "Speed":
			var Max = 250;
			var Speed = parseInt(event["data"]["Number"]);

			if (Speed > Max)
				Max = event["data"]["Number"];

			var SpeedValue = (Speed * 46) / Max
			$(".SpeedProgress").css("stroke-dashoffset",(440 - (440 * SpeedValue) / 100));
			if (Speed == 0) {
				Speed = "<c style='color: black; opacity: 0.3;'>000</c>"
			}
			if (Speed < 10){
				Speed = "<c style='color: black; opacity: 0.3;'>00</c>" + Speed
			} else if (Speed >= 10 && Speed < 100){
				Speed = "<c style='color: black; opacity: 0.3;'>0</c>" + Speed
			}

			$(".NumSpeed").html(Speed);
		break;

		case "Rpm":
			var rpmvalue = (event["data"]["Number"] * 18)
			$(".MarchProgress").css("stroke-dashoffset",(440 - (440 * rpmvalue) / 100));
			$(".NumMarch").html(event["data"]["Gear"]);
		break;

		case "Handbrake":
			if (!event["data"]["Status"]){
				$(".Handbrake").addClass("Gray").removeClass("Red");
			} else {
				$(".Handbrake").addClass("Red").removeClass("Gray");
			}
		break;

		case "Seatbelt":
			if (!event["data"]["Status"]){
				$(".Seatbelt").addClass("Gray").removeClass("Green");
			} else {
				$(".Seatbelt").addClass("Green").removeClass("Gray");
			}
		break;

		case "Drift":
			if (!event["data"]["Status"]){
				$(".Drift").addClass("Gray").removeClass("Yellow");
			} else {
				$(".Drift").addClass("Yellow").removeClass("Gray");
			}
		break;

		case "Headlight":
			if (event["data"]["Status"] == 0){
				$(".Headlight").addClass("Gray").removeClass("Green").removeClass("Blue");
			} else {
				if (event["data"]["Beam"] == 0){
					$(".Headlight").addClass("Green").removeClass("Gray").removeClass("Blue");
				} else {
					$(".Headlight").addClass("Blue").removeClass("Gray").removeClass("Green");
				}
			}
		break;

		case "Locked":
			if (event["data"]["Status"] == 2){
				$(".Locked").addClass("Green").removeClass("Gray");
			} else {
				$(".Locked").addClass("Gray").removeClass("Green");
			}
		break;

		case "Tyres":
			if (event["data"]["Number"] == 0){
				$(".Tyres").addClass("Gray").removeClass("Yellow").removeClass("Red");
			} else if (event["data"]["Number"] == 1){
				$(".Tyres").addClass("Yellow").removeClass("Gray").removeClass("Red");
			} else if (event["data"]["Number"] >= 2){
				$(".Tyres").addClass("Red").removeClass("Gray").removeClass("Yellow");
			}
		break;

		case "Nitro":			
			//('nitro 1',event["data"]["Number"])
			event["data"]["Number"] = event["data"]["Number"] / 2
			//('NITRO 2',event["data"]["Number"])
			$(".Nitro").css("stroke-dashoffset",event["data"]["Number"] - 100);
		break;

		case "Weapons":
			if (event["data"]["Status"]){
				if (event['data']['Vehicle']) {
					$('#NaviWeapons').css({left: '17.5vw'}).fadeIn(1000);
					$('#NaviWeapons').css({bottom: '3vh'}).fadeIn(1000);
				} else {
					$('#NaviWeapons').css({left: '91.5vw'}).fadeIn(1000);
					$('#NaviWeapons').css({bottom: '18vh'}).fadeIn(1000);
				}
				if ($("#NaviWeapons").css("display") === "none"){
					$("#NaviWeapons").fadeIn(1000);
				}
				//(event["data"]["Name"])
				$("#NaviWeapons").html(`
					<div class="NameWeapon">${event["data"]["Name"]}</div>
					<div class="NameAmmos">${event["data"]["Min"] + " / " + event["data"]["Max"]}</p></div>
					<img src="armas/${event["data"]["Name"]}.png" class="ImagemWeapon">
				`);

			} else {
				if ($("#NaviWeapons").css("display") === "block"){
					$("#NaviWeapons").fadeOut(1000);
				}
			}
		break;

		case "Textform":
			if (event["data"]["Mode"] === "Create"){
				var html = `<span id=Textform-${event["data"]["Number"]} class="Textform" style="left: 0; top: 0;"></span>`;
				$(html).fadeIn("normal").appendTo("#Textform");
			} else if (event["data"]["Mode"] === "Update"){
				$("#Textform-" + event["data"]["Number"]).css("left",event["data"]["x"] * 100 + "%").css("top",event["data"]["y"] * 100 + "%");
				$("#Textform-" + event["data"]["Number"]).html(event["data"]["Text"])
			} else if (event["data"]["Mode"] === "Remove"){
				$("#Textform-" + event["data"]["Number"]).fadeOut("normal",function(){ $(this).remove(); });
			}
		break;
	}
});