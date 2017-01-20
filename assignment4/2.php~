<?php
include './search.php';

// Create connection
$conn = mysqli_connect($host, $username, $password,$database,$port);

// Check connection
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

?>



<html>
<body>
<table width="40%" border="1" cellpadding="1" cellspacing="1" table align="center" >



<h1 align="center"> DETAILS</h1>
 

<tr><th>IP</th>
<th>PORT</th>
<th>COMMUNITY</th>
<th>sysuptime</th>
<th>syscontact</th>
<th>syslocation</th>
<th>sentreq</th>
<th>reqlost</th>
<th>lastupdate</th></tr>
<form action="db.php">
<?php
if(isset($_GET['id'])){
$x=$_GET['id'];
$query="select * FROM UPTIMES where id='".$x."'";

$result=mysqli_query($conn,$query);

while($row=mysqli_fetch_assoc($result)){

echo"<td>".$row['IP']."</td>";
echo"<td>".$row['PORT']."</td>";
echo"<td>".$row['COMMUNITY']."</td>";
echo"<td>".$row['sysuptime']."</td>";
echo"<td>".$row['syscontact']."</td>";
echo"<td>".$row['syslocation']."</td>";
echo"<td>".$row['sentreq']."</td>";
echo"<td>".$row['reqlost']."</td>";
echo"<td>".$row['lastupdate']."</td>";
}
}
?>
<td><button type='submit' formaction='db.php'>BACK</button></td>

</body>


</html>



