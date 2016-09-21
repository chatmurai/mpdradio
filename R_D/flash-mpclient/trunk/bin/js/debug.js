function debugMessage(str)
{
	
	document.getElementById('debugOutput').innerHTML+=str+'<br/>';
}

function populateTag(id,data)
{
	
	var out='';
	for(var n in data)
	{
		out+=n+' : '+data[n]+'\n';
	}
		
	document.getElementById(id).innerHTML=out;
}

document.write('<div id="debugOutput"></div>');