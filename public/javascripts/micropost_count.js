$(document).ready( function() {
	if ($('#micropost_content').length > 0) {
		$('#micropost_content').keydown( function() {
			var charsLeft = 139 - $(this).val().length;
			$('#charsLeft').html(charsLeft);
			if (charsLeft < 0) {
				$('#charsLeft').css('color', 'red');
			} else {
				$('#charsLeft').css('color', 'black')
			}
		});
	
		$('#micropost_content').keyup( function() {
			var charsLeft = 140 - $(this).val().length;
			$('#charsLeft').html(charsLeft);
			if (charsLeft < 0) {
				$('#charsLeft').css('color', 'red');
			} else {
				$('#charsLeft').css('color', 'black')
			}
		});
	}
});