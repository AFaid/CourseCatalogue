<!DOCTYPE html>
<html>
<head>
    <title>Wellness Education</title>
    
  
    
    <!-- Fonts -->
    <link href="bootstrap-3.3.2-dist/css/glyphicons-social.css" rel="stylesheet">
    <link href="bootstrap-3.3.2-dist/css/glyphicons.css" rel="stylesheet">
    <link href="includes/webfonts/fontstylesheet.css" rel="stylesheet">
    
      <!-- Custom styles for this template -->
    <link href="includes/layout.css" rel="stylesheet">
    
     <!-- Custom styles for this template -->
    <link href="includes/tooltipBootstrap.css" rel="stylesheet">
    
    <script src="http://code.jquery.com/jquery-1.6.3.min.js"></script>
    <script>
		$(document).ready(function(){
		
			// set the wrapper width and height to match the img size
			$('#wrapper').css({'width':$('#wrapper img').width(),
							  'height':$('#wrapper img').height()
			})
			
			//tooltip direction
			var tooltipDirection;
						 
			for (i=0; i<$(".pin").length; i++)
			{				
				// set tooltip direction type - up or down             
				if ($(".pin").eq(i).hasClass('pin-down')) {
					tooltipDirection = 'tooltip-down';
				} else {
					tooltipDirection = 'tooltip-up';
					}
			
				// append the tooltip
				$("#wrapper").append("<div style='left:"+$(".pin").eq(i).data('xpos')+"px;top:"+$(".pin").eq(i).data('ypos')+"px' class='" + tooltipDirection +"'>\
													<div class='tooltip'>" + $(".pin").eq(i).html() + "</div>\
											</div>");
			}    
			
			// show/hide the tooltip
			$('.tooltip-up, .tooltip-down').mouseenter(function(){
						$(this).children('.tooltip').fadeIn(100);
					}).mouseleave(function(){
						$(this).children('.tooltip').fadeOut(100);
					})
		});
    </script>

    
    
</head>

 <body>
  
  	<div class="container">

    <h3 class="pageTitleHeader">Wellness Education</h3>
 


    <img src="images/Western_Logo_RGB.png" alt="Western Logo" class="WesternLogo hidden-xs hidden-sm" />
 	
    
    <div class="clearfix"></div>
    
    <!-- Static navbar -->
      <nav class="navbar navbar-default">
        <div class="container-fluid">
          <div class="navbar-header">
                       
          </div>
          <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
              <li><a href="index.cfm">Undergraduate</a></li>
              <li><a href="grad.cfm">Graduate</a></li>
             
            </ul>
          
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </nav>
      