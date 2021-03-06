<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList" import="java.util.Map"  import="csci310.*"%>
<!DOCTYPE html>
<%
	// Disable Caching
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader ("Expires", 0);

	String user = (String) session.getAttribute("uid");
	if(user == null){
		response.sendRedirect("login.jsp");
	}
	Boolean initialized = (Boolean) session.getAttribute("initialized");

	//Jung added code begin
	String pageNum = (String) session.getAttribute("page_activity");
	if(pageNum == null) {
		System.out.println("page num is null");
		session.setAttribute("page_activity", "0");
		pageNum = "0";
	}
	int currPage = Integer.parseInt(pageNum);
	System.out.println("THIS IS PAGE NUM " + currPage);
	/* //ArrayList<City> pagination_list = (ArrayList) session.getAttribute("pagination_list_vacation");
	 *///Jung added code end
	 
	if (initialized == null){
		System.out.println("Initializing values");
		session.setAttribute("initialized", true);
		session.setAttribute("location", "");
		session.setAttribute("date", "");
		session.setAttribute("temp", 0.0);
		session.setAttribute("desc", "");
		session.setAttribute("img", "");
		session.setAttribute("last_page", "");
		session.setAttribute("list_activity", new ArrayList<City>());
		session.setAttribute("list_vacation", new ArrayList<City>());
		ArrayList<ArrayList<String>> fav_data = new ArrayList<>();
		for(int i = 0; i < 23; i++){
			fav_data.add(new ArrayList<String>());
		}
		session.setAttribute("fav_data", fav_data);	
		session.setAttribute("city_selected", false);
		session.setAttribute("city_data", new ArrayList<String>());
		session.setAttribute("unit", true);
		session.setAttribute("longest_distance", 98);
	}
	
	boolean unit_c = (boolean) session.getAttribute("unit");
	session.setAttribute("last_page", "Activity.jsp");
	ArrayList<City> resultList = (ArrayList<City>)session.getAttribute("list_activity");
	ArrayList<City> favoritesList = new ArrayList<City>();
	if(resultList == null) {
		System.out.println("first time visiting vacation page");
		resultList = new ArrayList<City>();
	}
	else System.out.println("java code in VACATION JSP" + resultList.size());
	
	ArrayList<String> fav_city_names;
	ArrayList<ArrayList<String>> fav_data = (ArrayList<ArrayList<String>>)session.getAttribute("fav_data");
	if(fav_data == null){
		fav_city_names = new ArrayList<>();
	}else{
		fav_city_names = fav_data.get(0);
	}
	// Jung added begin
	ArrayList<City> pagination_list = new ArrayList<>();
	if(((currPage*5)+5) < resultList.size()) {
		for(int i=(currPage*5); i<(currPage*5)+5; i++) {
			pagination_list.add(resultList.get(i));
		}
	} else {
		for(int i=(currPage*5); i<resultList.size(); i++) {
			pagination_list.add(resultList.get(i));
		}
	}
	// Jung added end
	String error_message = (String) session.getAttribute("activity_error");
	
	Integer longest_distance = 0;	

	ArrayList<String> favorites = (ArrayList<String>) session.getAttribute("favorites_List");
	if (favorites == null)
	{
		System.out.println("Favorites doesnt exist");
	}
	
	Map<String, Integer> likes = (Map<String, Integer>) session.getAttribute("likes");
	if (likes == null)
	{
		System.out.println("likes doesnt exist");
	}

	
%>
<html>
<head>
<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <link rel = "stylesheet" type = "text/css" href="HomePage.css">
  <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script src="https://kit.fontawesome.com/a076d05399.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


<style>


.switch {
  position: relative;
  display: inline-block;
  width: 60px;
  height: 34px;
}
/* Hide default HTML checkbox */
.switch input {
  opacity: 0;
  width: 0;
  height: 0;
}
/* The slider */
.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  -webkit-transition: .4s;
  transition: .4s;
}
.slider:before {
  position: absolute;
  content: "";
  height: 26px;
  width: 26px;
  left: 4px;
  bottom: 4px;
  background-color: white;
  -webkit-transition: .4s;
  transition: .4s;
}
input:checked + .slider {
  background-color: #2196F3;
}
input:focus + .slider {
  box-shadow: 0 0 1px #2196F3;
}
input:checked + .slider:before {
  -webkit-transform: translateX(26px);
  -ms-transform: translateX(26px);
  transform: translateX(26px);
}
/* Rounded sliders */
.slider.round {
  border-radius: 34px;
}
#location {
	display: inline-block;
}
#date {
	display: inline-block;
}
#error {
	color: #FF6347;
}
#img {
	width:170px;
	vertical-align: middle;
}
#temp {
	display: inline-block;
}
#weatherloc {
	width: 325px;
	font-size: 18px;
	color: MidnightBlue;
}
#submitbutton {

	display: inline-block;
	width: 230px;
	font-size: 18px;
	font-family: Montserrat;
	 border-radius: 34px;
	 padding: 7px;
}
.btn {
font-family: Montserrat;
 border-radius: 34px;
margin:5px;
	width: 85px;
	font-size: 15px;
	padding-top: 5px;
}
.btn1 {
font-family: Montserrat;
 border-radius: 34px;
margin:5px;
	width: 180px;
	font-size: 15px;
	padding-top: 5px;
	padding:5px;
}
#toggle {
	display: inline-block;
}
body {
	background-color: AliceBlue;
}
h1{
	color: DarkSlateGrey;
	font-family: Montserrat;
}

h2{
	color: DarkSlateGrey;
	font-family: Montserrat;
	font-size: 35px;
}


h3{
	color: DarkSlateGrey;
	font-family: Montserrat;
}
h5{
	color: Black;
	font-family: Montserrat;
}
h6{
	color: Black;
	font-family: Montserrat;
}
div {
	margin: auto;
	text-align: center;
}

span {
	position: absolute;
	bottom: -40px;
	left: 0;
	right: 0;
}
::placeholder {
	color:#C0C0C0;
}

.navbar {
    /* padding-top: 15px; */
    padding-bottom: 15px;
    border: 0;
    border-radius: 0;
    margin-bottom: 0;
    font-size: 12px;
    letter-spacing: 5px;
    background-color: DarkGrey;
    font-color: White;
  }
  .navbar-nav  li a:hover {
    color: #1abc9c !important;
  }
   li{
    color: White; 
  }
  .jumbotron{
  		background-color:SteelBlue;
  		width: 65%;
  		height:30%;
  		padding: 3px;
  	
  
  }
  
@keyframes iconAnimation {
  0%   {background-color:red;}
  25%  {background-color:yellow;}
  50%  {background-color:blue;}
  75%  {background-color:green;}
  100% {background-color:red;}
}
  #unitChanger {
	margin-right: 5px;
	width: 20%;
	border-radius: 20px;
	height: 35px;
}

.animate:hover {
	  animation-name: iconAnimation;
	  animation-duration: 5s;
	  animation-iteration-count: infinite;
}

#inlineForm {
	margin-top: 10px;
	padding-left: 12%;
	padding-right: 12%;
}

.toggle:before {
  content: "°C °F";
  display: block;
  position: absolute;
  z-index: 2;
  width: 28px;
  height: 28px;
  background: Snow;
  left: 2px;
  top: 2px;
  border-radius: 50%;
  font: 10px/28px Helvetica;
  font-size: 16px;
  text-transform: uppercase;
  text-indent: -24px;
  word-spacing: 37px;
  color: ;
  text-shadow: -1px -1px rgba(0,0,0,0.15);
  white-space: nowrap;
  box-shadow: 0 1px 2px rgba(0,0,0,0.2);
  transition: all cubic-bezier(0.3, 1.5, 0.7, 1) 0.3s;
}

.toggle:checked {
  background-color: Silver;
}

.toggle:checked:before {
  left: 32px;
}

.inlineWeather{
	display: flex;
    align-items: center;
    justify-content: center;
}


.toggle {
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
  width: 62px;
  height: 32px;
  display: inline-block;
  position: relative;
  border-radius: 50px;
  overflow: hidden;
  outline: none;
  border: none;
  cursor: pointer;
  background-color: Silver;
  transition: background-color ease 0.3s;
  

}


.col-sm-4 {

	display: inline;

}

.inlineWeather{
	display: flex;
    align-items: center;
    justify-content: center;
    padding: 10px;
}




#weather-space {

	margin: auto;

	text-align: center;

	border: 1px solid MidnightBlue;

	border-radius: 30px;

}



#five-day {

	text-align: center;

	/* margin: auto;

	text-align:center;

	  border: 1px solid MidnightBlue;

  border-radius: 30px; */

}

#prevButton{
	background-color: DimGrey;
  border-radius: 12px;
  font-family: Montserrat;
  color: white;
  padding: 5px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 12px;
 
}
.btn2 {
font-family: Montserrat;
 border: none;
margin:5px;
	width: 85px;
	font-size: 15px;
	padding-top: 5px;
	color: Black;
	background-color: AliceBlue;
	
}
#pagination-button{
	background-color: DimGrey;
  border-radius: 12px;
  font-family: Montserrat;
  color: white;
  padding: 5px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 12px;
  }
#nextButton{
	background-color: DimGrey;
  border-radius: 12px;
  font-family: Montserrat;
  color: white;
  padding: 5px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 12px;
  }



</style>
<title>ActivityPage</title>
</head>

<script>
function getLocation() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(showPosition);
  } else { 
    x.innerHTML = "Geolocation is not supported by this browser.";
  }
}

function showPosition(position) {
  x.innerHTML = "<h5 style='font-size: 5px; color: AliceBlue '>Latitude: " + position.coords.latitude + 
  "<br>Longitude: " + position.coords.longitude + "</h5>";
  document.getElementById("lat").value = position.coords.latitude;
  document.getElementById("lon").value = position.coords.longitude;
  
  
}
</script>

<body>

<h5 id="longest_distance" style="font-size: 5px; color: AliceBlue " name=<%=longest_distance%>><%=longest_distance%></h5>
        <h1 id="title" style="text-align: center;font-size: 40px;"> Activity Planning </h1>

		<h1 id="error"></h1>
        <div class="container">
            <div class="row">
                <div class="col-sm-3"  style= "padding-top:90px;">
					<!-- form and information to send to VAAservlet -->
                    <form method="GET" action="VAAServlet">
                    	<input type="hidden" name="jspname" value="activity">
						<!-- outdoor activity 
							a. Snow or ice related sports ok<= 40F
							b. Outdoor games (eg, soccer, hiking, football) 40F<ok<80F
							c. Water sports (eg surfing) ok>80F
							should be converted in servlet
						-->
                        <div class="form-group">
                          <label for="outdoorActivity" style="font-family: Montserrat;">Activity</label>
                          <input type="text" list="activities" style="font-family: Montserrat; <% if(error_message.equals("Activity")){ %>border: 2px solid red;border-radius: 4px;<%} %>" class="form-control" id="outdoorActivity" placeholder="Activity" name="activity" >
                          <datalist id="activities">
						    <option value="outdoor">
						    <option value="snow">
						    <option value="water">
						  </datalist>
                        </div>
                        

                        <!-- change to input hidden -->
                        <input id="lat" type="hidden" style="font-size: 5px; color: AliceBlue " name="lat" >
                        <input id="lon" type="hidden"  style="font-size: 5px; color: AliceBlue "name="lon" >
                        
                        <div id="currLoc"><script type="text/javascript" >var x = document.getElementById("currLoc");getLocation();</script></div>
                        
                        
                        <!-- number of results
                        <div class="form-group">
<!-- <<<<<<< auth_sprint3
                        <!-- number of results -->
<!--                         <div class="form-group">

                          <label for="numResults">Number of Results</label>
                          <input type="number" class="form-control" id="numResults" placeholder="Number of Results" name="numResults" <% if(error_message.equals("Number of Results")){ %>style="border: 2px solid red;border-radius: 4px;" <%} %>>
                        </div> -->

                        <!-- current location -->
<!--                         <div class="form-group">
                            <label for="currLocation">Current Location</label>
                            <input type="text" class="form-control" id="currLocation" placeholder="Current Location" name="currLocation">
						</div>
 -->
                        <!-- change to input hidden -->
                        <input id="lat" type="hidden" name="lat" >
                        <input id="lon" type="hidden" name="lon" >
                       
                       
                       
                        <!-- uses geolocation of computers current location -->
                       <!--  <div id="currLoc"><script type="text/javascript">var x = document.getElementById("currLoc");getLocation();</script></div> -->
                        

						<!-- distance radius -->
                        <div class="form-group">
                            <label for="radius" style="font-family: Montserrat;">Distance Radius</label>
                            <input type="number" class="form-control" id="radius" style="font-family: Montserrat; <% if(error_message.equals("Radius")){ %>border: 2px solid red;border-radius: 4px;<%} %>" placeholder="Radius" name="radius" >
                        </div>
                        
                        <button type="submit" class="btn1 btn-primary" id="search">Find My Activity Spot</button>
                    </form>
				</div>
				<input type="hidden" id="unit" value="true">
				<!-- col-8 is bootstrap to make the table bigger than the form on the left -->
                <div class="col-sm-8">
					<!-- if statement here is to check whether the API call from the VAA servlet returned anything (VAA should refresh the page) -->
                    <% if(resultList.size() == 0) { 
                    	if(error_message.equals("")) { %>
							<h1 style="text-align: center;">No locations found.</h1>
						<%}else { %>
							<h1 style="text-align: center;" id="error_message">Illegal value for input <%=error_message%>.</h1>
						<%} 
                    } else { %> 
                    <table class="table">
                        <thead>
							<!-- first row of the table (column titles) -->
                            <tr>
                              <th scope="col" style="font-family: Montserrat; text-align: center;"></th>
                              <th scope="col" style="font-family: Montserrat; text-align: center;">City</th>
                              <th scope="col" style="font-family: Montserrat;text-align: center; ">Country</th>
                              <th scope="col" style="font-family: Montserrat;text-align: center;">Current temp</th>
                              <th scope="col" style="font-family: Montserrat; text-align:center;">
                                <form method="GET" action="VAAServlet" style="display: inline;">
                                    <!-- distance sort -->
                                        <input id="distsort" class="btn2 btn-primary" type="submit" value="Distance"class="form-control">
                                        <input type="hidden" name="util" value="distance">
                                        <input type="hidden" name="radius" value="0">
                                        <input type="hidden" name="jspname" value="activity">
                                </form>
​
                              </th>
                              <th scope="col" style="font-family: Montserrat; text-align:center;">Favorite/Remove </th>
                                  <%--Jung begin --%>
                              <th scope="col" style="font-family: Montserrat; text-align:center;">
                              	<form method="GET" action="VAAServlet" style="display: inline;">
                              			<input class="btn2 btn-primary" type="submit" value="Likes" class="form-control">
                              			<input type="hidden" name="util" value="likes">
                              			<input type="hidden" name="radius" value="0">
                              			<input type="hidden" name="jspname" value="activity">
                              	</form>
                              </th>
                              <%--Jung end --%>
                            </tr>
                        </thead>
                        <tbody>
							<!-- using java for loop to display all the results from VAAservlet -->
                    <% for(int i = 0; i < pagination_list.size(); i++){ %>
                        <tr>
                        	
                              <%--JUNG ADDED SPRINT 2 BEGIN --%>
                        	<%
                        	if(i==pagination_list.size()-1)
                        	{
                        		
                        		session.setAttribute("longest_distance", pagination_list.get(i).distance);
                        	}
                        	
                        	int city_number = (currPage*5)+i+1; %>
                            <th id="cityNum" scope="row" style="font-family: Montserrat;"><%= city_number %></th>
                            <%--JUNG ADDED SPRINT 2 END --%>
                            <td id="<%= pagination_list.get(i).city %>" style="font-family: Montserrat;"><%= pagination_list.get(i).city %></td>
                            <td style="font-family: Montserrat;"><%= pagination_list.get(i).country %></td>
                            <td style="font-family: Montserrat;" class="temp"><%= pagination_list.get(i).curr_temp %></td>
							<td style="font-family: Montserrat;" id="dist"><%= pagination_list.get(i).distance %></td>
							<!-- if statement to check if city is in the favorites list or not -->
                           <% 
                             System.out.print("FAVORITE OR NOT? : " );                           
                             System.out.println(favorites.contains(pagination_list.get(i).city));
                             if(favorites.contains(pagination_list.get(i).city)){ 
                             
                             %>
                                <td>&nbsp;<form method="POST" action="/favorites">
                                    <input class="btn btn-danger" type="submit" value="Remove"class="form-control" id="rmv_btn">
                                    <input type="hidden" name="cityname" id="location" style="font-family: Montserrat;" value="<%= pagination_list.get(i).city %>">
                                    <input type="hidden" name="action" value="remove">
                                </form></td>
                            <% } else { %>
                                <td>&nbsp;<form method="POST" action="/favorites">

                                    <input class="btn btn-primary" type="submit" value="Favorite"class="form-control" id="fav_btn">
                                    <input type="hidden" name="cityname" id="location" style="font-family: Montserrat;" value="<%= pagination_list.get(i).city %>">

                                    <input type="hidden" name="action" value="fav">
                                </form></td>
                            <% } %>
                             <%--Jung begin --%>
                             <% if (likes.containsKey(pagination_list.get(i).city)) {
                            	 System.out.println(pagination_list.get(i).city);
                            	 System.out.println(likes.get(pagination_list.get(i).city) );
                             %>
   	                            <td style="font-family: Montserrat;" id="likes"><img src="img/heart.png" alt="" style="width:25px; height:25px; "><%=likes.get(pagination_list.get(i).city) %></td>
                             	
                             <% } else  { %>
                                <td style="font-family: Montserrat;" id="likes"><img src="img/heart.png" alt="" style="width:25px; height:25px; "> 0</td>
                             
                             <% }  %>
                              <%--Jung begin --%>
                            <%--Jung end --%>
                        </tr>
                    <% } %>
                        </tbody>
					</table>
					
						<%--JUNG ADDED CODE BEGIN--%>
                      <%--<nav aria-label="Page navigation example"> --%>  
						  <ul class="pagination">
						  <div class = "inlineWeather" id="inlineForm">
						   <%-- <li class="page-item"><a class="page-link" href="#">Previous</a></li>--%> 
						    <%
						    int numOfPagesNeeded = 0;
						    if(resultList.size() % 5 == 0) numOfPagesNeeded = resultList.size()/5;
						    else numOfPagesNeeded = (resultList.size()/5) + 1; 
						    int startpoint = Integer.parseInt(pageNum);
							 // jung added sprint 2 begin
							    for(int i=0; i<5; i++) {
							    	if(startpoint <= 0) break;
							    	if(i == 4) break;
							    	if(i == 3 && (numOfPagesNeeded - (currPage+1)) >= 1) break;
							    	if(i == 2 && (numOfPagesNeeded - (currPage+1)) >= 2) break;
							    	if(startpoint > 0) startpoint -= 1;
							    }
							    int endpoint = currPage;
							    for(int i=endpoint-startpoint; i<5; i++) {
							    	if(endpoint < numOfPagesNeeded) endpoint += 1;
							    }
							    // jung added sprint 2 end
						    if(Integer.parseInt(pageNum) + 5 <= endpoint) endpoint = Integer.parseInt(pageNum) + 5;
						    if(Integer.parseInt(pageNum) > 0) {%>
						    <form method="GET" action="/VAAServlet">
						    	<input type="hidden" name="prevNext" value="0">
						    	<input type="hidden" name="pageNum" value=<%=pageNum%>>
						    	<input type="hidden" name="whatPage" value="activity">
						    	<button id="prevButton" type="submit" class="page-link">Previous</button>
						    </form>
						    <%} %>
						   <%  for(int i=startpoint; i<endpoint; i++) { %>
						   		<%if(currPage == i) { %>
						   			<form method="GET" action="/VAAServlet">
						    			<input type="hidden" name="pageNum" value="<%=i%>">
						    			<input type="hidden" name="whatPage" value="activity">
						    			<button id="pagination-button" style="background-color:black;" type="submit" class="page-link"><%=i+1 %></button>
						    		</form>
						   		<%} else {%>
						    	<form method="GET" action="/VAAServlet">
						    		<input type="hidden" name="pageNum" value="<%=i%>">
						    		<input type="hidden" name="whatPage" value="activity">
						    		<button id="pagination-button" type="submit" class="page-link"><%=i+1 %></button>
						    	</form>
						    	<%--<li class="page-item"><a onclick='<%session.setAttribute("page", Integer.toString(i)); System.out.println("set page session to " + i);%>' class="page-link" href="Vacation.jsp"><%=i+1 %></a></li> --%>
						    	<%} %>
						   <% } %>
						   <%if(Integer.parseInt(pageNum) < numOfPagesNeeded-1) { %>
						   <form method="GET" action="/VAAServlet">
						    	<input type="hidden" name="prevNext" value="1">
						    	<input type="hidden" name="pageNum" value=<%=pageNum%>>
						    	<input type="hidden" name="whatPage" value="activity">
						    	<button id="nextButton" type="submit" class="page-link">Next</button>
						    </form>
						    <%} %>
					
					
					<%--JUNG ADDED CODE BEGIN--%>
                </div>
						 
						  </ul>
					<div class = "inlineWeather" id="inlineForm" style="padding-top: 0px;">
			<!-- <button type="button" class="btn btn-primary" onclick="change_unit()" >Change Units</button> -->
			<input class="toggle" type="checkbox" name="toggle" id="toggle" onclick="change_unit()"/>
			</div>
                    <!-- <button class="btn btn-primary" onclick="change_unit()">Unit Change</button> -->
                  
                    <% } %>
​
                    
				<!-- end of col-8 div -->
				</div>
			<!-- end of row div -->
			</div>
		<!-- end of container div -->
        </div>
		
	<!-- navbar from Alex -->
	
	<nav class="navbar navbar-default" name="navName" style="background-color: DimGray; position: fixed; bottom: 0;width: 100%; padding-top: 10px;">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>      
         <span class="icon-bar"></span>    
          <span class="icon-bar"></span>                      
      </button>

		  <form name="formname" action="/UserAuthServlet" method="POST">
				<input type="hidden" name="action" value="signout">

				<button id="signout_btn" type="button" class="navbar-brand" onclick= "callServlet1()" style="color: White; background-color: DimGrey; font-size: 15px;" ><i class = "fa fa-fw fa-user"></i>Logout</button>	       

			</form>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav navbar-right">
      <li><a href="HomePage.jsp"  style="color: White;"><i class=" fa fa-fw fa-home"></i> Home</a> </li>
     

      
       <li><a href="Vacation.jsp"  style="color: White;"><i class="fas fa-umbrella-beach"></i> Vacation</a></li> 
       <li><a href="Activity.jsp" style="color: White;"><i class="fas fa-futbol"></i> Activity</a> </li> 
       <li><a href="AnalysisPage.jsp"  style="color: White;"><i class=" fa fa-fw fa-calculator"></i> Analysis 	</a></li>
     	 <!-- <li><a href="SearchHistory.jsp" style="color: White;"><i class="fa fa-fw fa-search"></i>  Search History</a></li> -->
      </ul>
    </div>
  </div>
</nav>

	<script>
	
	function callServlet1(){
		r = confirm("Are you sure you want to logout?");
		if(r){
			document.formname.submit();
		 }
	  }
		function change_unit(){
			var unit_c = document.getElementById("unit").value
			console.log(unit_c)
			
			var elements = document.getElementsByClassName("temp");
			for (let i = 0; i < elements.length; i++){
				var original = elements[i].innerHTML;
				if (unit_c == "false"){
					console.log("C->F");
					original = Math.round(10 * ((original * 9/5) + 32))/10;
					document.getElementById("unit").value = true;
				}else{
					console.log("F->C");
					original = Math.round(10 * ((original - 32) * 5 / 9))/10;
					document.getElementById("unit").value = false;
				}
				elements[i].innerHTML = original;
			}
		}
		
	</script>
	
</body>
</html>