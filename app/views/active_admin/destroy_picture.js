$('.image-view#<%= @picture.id %>').fadeOut('quick', function(){ 
	this.remove();
});