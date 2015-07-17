$(document).ready(function(){
	
	var colors = ["#FBE9E7","#FFCCBC","#FFAB91","#FF8A65","#FF7043","#FF5722","#F4511E","#E64A19","#D84315", "#BF360C"]
	
	$(".lists").each(function(){
		
		for (i = 0; i < colors.length; i++){
		$('#'+i).css( "background-color", colors[i] );
		}
	});
	
	$("label").click(function() {
	$(this).parent("li").toggleClass(".active");
	$("#start").click(function(){
		$(".bar-one .bar").progress();
		setTimeout(function(){ $("#tally").submit() }, 5000);	
	});
	
	
	

});
});




(function ( $ ) {
  $.fn.progress = function() {
    var percent = this.data("percent");
    this.css("width", percent+"%");
  };
}( jQuery ));
