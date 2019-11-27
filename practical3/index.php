<!DOCTYPE html>
<html lang="en">

<body>
    Q1
    <form action="" method="post">
      pname: <input type="text" name="pname"/><br>
      department: <input type="text" name="department"/><br>
      <input type="submit" name="SubmitButton"/><br>
    </form>
    <?php
        if(isset($_POST['SubmitButton'])){ //check if form was submitted
            $input = $_POST['pname'];
            $input1 = $_POST['department'];
            $db = pg_connect("host=tr01 dbname=ms19ys user=ms19ys");

            $query = "SELECT dname from dept where dname='$input1';";
            $result = pg_query($query);

            if(pg_num_rows($result) > 0)
            {
                if (pg_send_query($db, "INSERT into prof(pname, dname) values('$input', '$input1');")) {
                  $res=pg_get_result($db);
                  if ($res) {
                    $state = pg_result_error_field($res, PGSQL_DIAG_SQLSTATE);
                    if ($state==0) {
                      echo 'Insertion was successful.';
                    }
                    else {
                        $error = pg_last_error($db);
                        echo $error;
                    }
                  }
                }
            }else echo "Error: The value entered for dname does not exist.";

        }
    ?>

<br>
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

        if (pg_send_query($db, "DELETE from enroll where sid = $sid and dname = '$dname' and cno = $cno and sectno = $sectno;")) {
          $res=pg_get_result($db);
          $cmdtuples = pg_affected_rows($res);

          if ($res) {
            $state = pg_result_error_field($res, PGSQL_DIAG_SQLSTATE);
            if ($cmdtuples>0) {

              echo 'Deletion was successful.';
            }
            else {
                $error = pg_last_error($db);
                echo 'Deletion failed because the key does not matchany entry in the enroll table.<br>';
                echo $error;
            }
          }
        }
	}
	?>
</body>
</html>
