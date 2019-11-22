<!DOCTYPE html>

<html lang="en">
<head>
<meta charset="utf-8">
</head>
<body>
    Q1
    <form action="" method="post">
      pname: <input type="text" name="pname"/><br>
      department: <input type="text" name="department"/><br>
      <input type="submit" name="SubmitButton"/><br>
    </form>

    <?php
	if(isset($_POST['SubmitButton'])){ //check if form was submitted
	    $input = $_POST['panme'];
	    $input1 = $_POST['department'];
	    $db = pg_connect("host=tr01 dbname=ms19ys user=ms19ys");

	    $res = pg_query($db, "INSERT into prof(pname, dname) values($input, $input1)");
	}
		echo $res;
	?>

Q2
    <form action="" method="post">
      sid: <input type="text" name="sid"/><br>
      dname: <input type="text" name="dname"/><br>
      cno: <input type="text" name="cno"/><br>
      sectno: <input type="text" name="sectno"/><br>
      <input type="submit" name="SubmitButton1"/>
    </form>
	<?php
	if(isset($_POST['SubmitButton1'])){ //check if form was submitted
	    $sid = $_POST['sid'];
	    $dname = $_POST['dname'];
	    $cno = $_POST['cno'];
	    $sectno = $_POST['sectno'];
	    $db = pg_connect("host=tr01 dbname=ms19ys user=ms19ys");
	    $res = pg_query($db, "DELETE from enroll where sid = $sid and dname = $dname and cno = $cno and sectno = $sectno");
	    echo $res;
	}
	?>
</body>
</html>
