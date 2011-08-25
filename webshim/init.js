$.webshims.setOptions('forms', { customMessages: true}); 
$.webshims.polyfill();
		
$(function(){
  var showHideFormsExt = function(){
    $('span.forms-ext-feature')[this.checked ? 'show' : 'hide']();
  };
  $('#show-forms-ext').each(showHideFormsExt).click(showHideFormsExt);
});
