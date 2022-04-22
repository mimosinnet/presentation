/** Do not load sound by default **/
function NoAutoSound() {
	var videos = document.getElementsByTagName('VIDEO').length;
	var audios = document.getElementsByTagName('AUDIO').length;
	for ( i = 0; i < videos ; i++) {
		document.getElementsByTagName('VIDEO')[i].pause();
	}
	for ( i = 0; i < audios ; i++) {
		document.getElementsByTagName('AUDIO')[i].pause();
	}
}
