<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
   <title>Calculator</title>
  
   
</head>
<body style="display: flex;justify-content: center;align-items: center;">
<div id="container" style="width:250px;background-color:#3e3939;margin: 50px auto;padding: 30px;border: 2px solid #000000;border-radius: 20px;display: flex;justify-content: center;
  align-items: center;">
   	<form  name ="calculator" action="Calculator" method="post">
   		<input name="display" type="text" value="<%= request.getAttribute("result") != null ? request.getAttribute("result") : "" %>" style="width:210px;height:40px">

   		<br><br>
   		<input id="btn" type="button" value='C' onclick="calculator.display.value=''" style="width:50px;height:50px;background-color:#d12727;color:#ffffff;text:bold;border-radius: 5px;">
   		<input id="btn" type="button" value='/' onclick="calculator.display.value+='/'" style="margin-left:110px;width:50px;height:50px;background-color:#587de8;color:#ffffff;text:bold;border-radius: 5px;">
   		<br><br>
   		<input id="btn" type="button" value='7' onclick="calculator.display.value+='7'" style="width:50px;height:50px;color:#ffffff;text:bold;background-color:#587de8;border-radius: 5px;">
   		<input id="btn" type="button" value='8' onclick="calculator.display.value+='8'" style="width:50px;height:50px;color:#ffffff;text:bold;background-color:#587de8;border-radius: 5px;">
   		<input id="btn" type="button" value='9' onclick="calculator.display.value+='9'" style="width:50px;height:50px;color:#ffffff;text:bold;background-color:#587de8;border-radius: 5px;">
   		<input id="operator" type="button" value='*' onclick="calculator.display.value+='*'" style="width:50px;height:50px;color:#ffffff;text:bold;background-color:#587de8;border-radius: 5px;">
   		<br><br>
   		<input id="operator" type="button" value='4' onclick="calculator.display.value+='4'" style="width:50px;height:50px;color:#ffffff;text:bold;background-color:#587de8;border-radius: 5px;">
   		<input id="operator" type="button" value='5' onclick="calculator.display.value+='5'" style="width:50px;height:50px;color:#ffffff;text:bold;background-color:#587de8;border-radius: 5px;">
   		<input id="operator" type="button" value='6' onclick="calculator.display.value+='6'" style="width:50px;height:50px;color:#ffffff;text:bold;background-color:#587de8;border-radius: 5px;">
   		<input id="operator" type="button" value='-' onclick="calculator.display.value+='-'" style="width:50px;height:50px;color:#ffffff;text:bold;background-color:#587de8;border-radius: 5px;">
   		<br><br>
   		<input id="operator" type="button" value='1' onclick="calculator.display.value+='1'" style="width:50px;height:50px;color:#ffffff;text:bold;background-color:#587de8;border-radius: 5px;">
   		<input id="operator" type="button" value='2' onclick="calculator.display.value+='2'" style="width:50px;height:50px;color:#ffffff;text:bold;background-color:#587de8;border-radius: 5px;">
   		<input id="operator" type="button" value='3' onclick="calculator.display.value+='3'" style="width:50px;height:50px;color:#ffffff;text:bold;background-color:#587de8;border-radius: 5px;">
   		<input id="operator" type="button" value='+' onclick="calculator.display.value+='+'" style="width:50px;height:50px;color:#ffffff;text:bold;background-color:#587de8;border-radius: 5px;">
   		<br><br>
   		<input id="operator" type="button" value='00' onclick="calculator.display.value+='00'" style="width:50px;height:50px;color:#ffffff;text:bold;background-color:#587de8;border-radius: 5px;">
   		<input id="operator" type="button" value='0' onclick="calculator.display.value+='0'" style="width:50px;height:50px;color:#ffffff;text:bold;background-color:#587de8;border-radius: 5px;">
   		<input id="operator" type="button" value='.' onclick="calculator.display.value+='.'" style="width:50px;height:50px;color:#ffffff;text:bold;background-color:#587de8;border-radius: 5px;">
   		<input id="operator" type="submit" value='=' style="width:50px;height:50px;color:#ffffff;text:bold;background-color:#587de8;border-radius: 5px;">
   	</form>
  </div>
  <div style="color: white; margin-top: 10px;">
    <h3>History</h3>
    <ul style="list-style-type: none; padding: 0;">
        <%
            ArrayList<String> history = (ArrayList<String>) session.getAttribute("history");
            if (history != null) {
                for (String entry : history) {
        %>
        <li><%= entry %></li>
        <%
                }
            }
        %>
    </ul>
</div>
  
 <script >
 document.addEventListener("keydown", function(event) {
     const key = event.key;
     if (!isNaN(key) || ['+', '-', '*', '/', '.'].includes(key)) {
         appendValue(key);
     } else if (key === "Enter") {
         document.calculator.submit();
     } else if (key === "Backspace") {
         document.calculator.display.value = document.calculator.display.value.slice(0, -1);
     }
 });
 </script>
</body>
</html>
