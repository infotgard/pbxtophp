<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>PBX PHONELIST</title>
    
</head>


<body>
<?php

echo "<table border=1 cellspacing=0 cellpadding=3 width=100%>";
echo '<tr><td colspan=2 style="background-color:#333333;"><strong><font color=white>Nombre</font></strong></td>';
echo '<td colspan=2 style="background-color:#333333;"><strong><font color=white>Extension</font></strong></td></tr>';

$xml = simplexml_load_file("output.xml");
foreach ($xml->Contact as $name) {
  foreach($name->Phone->phonenumber as $key => $val) {

      if(strcmp(substr($val, 0, 1),"2")==0)
      {
    echo '<td colspan=2 style="background-color:#CCCCCC;"><strong><font color="black">' . $name->FirstName .' '. $name->LastName . '</font></strong></td>';
    echo '<td colspan=2 style="background-color:#FFFFFF;"><strong><font color="black">'. $name->Phone->phonenumber ."</font></strong></td>";
    echo "</tr>";
      }

  }

}

echo "</table>";

?>
</body>