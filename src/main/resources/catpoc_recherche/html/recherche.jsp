<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="s" uri="http://www.jahia.org/tags/search" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>


<script>
	$(document).ready(function() {
		
		function myF() {			  
			var term = $('#term').val();
			$('#imagediv').html('');
		    
		    $.ajax({
		    	  url: '/cms/elements?searchedText=' + term,
		    	})
		    	.done(function(data) {
		    		for (i = 0; i < data.length; i++) {
		    	        var img = $('<img id="imgage' + i + '">');
		    	        img.attr('src', '/files/' + '${workspace}' + data[i]);
		    	        img.appendTo('#imagediv');
		    	    }
		    	})
		    	.fail(function() {
		    	  alert("Ajax failed to fetch data")
		    	})
		  };
	  
	  $('#hit').click(myF);
	  $("#term").keypress(function(e) {
		    if(e.which == 13) {
		    	myF();
		    }
		});
	});

</script>
<div id="search">
  <input id="term" type="text" />
  <a href="#" id="hit">Recherche</a> <i>Goat, Raccoon, Cat, Dog</i>
</div>
<div id="imagediv">
</div>