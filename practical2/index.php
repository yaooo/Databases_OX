<!DOCTYPE html>

<?php
if(isset($_POST['SubmitButton'])){ //check if form was submitted
    $input = $_POST['cno']; //get input text
    $db = pg_connect("host=tr01 dbname=ms19ys user=ms19ys");

    $res = pg_query($db, "SELECT student.sname, grade FROM enroll, student where cno = $input and student.sid = enroll.sid;");
    // $val = pg_fetch_result($res, 0, 0);
    // echo "First field in the second row is: ", $val, "\n";
}
?>

<?php
if(isset($_POST['SubmitButton1'])){ //check if form was submitted
    $input1 = $_POST['K']; //get input text
    $db1 = pg_connect("host=tr01 dbname=ms19ys user=ms19ys");

    $res1 = pg_query($db1, "SELECT distinct major.dname from student, major where age < $input1 and student.sid = major.sid;");
    // $val = pg_fetch_result($res, 0, 0);
    // echo "First field in the second row is: ", $val, "\n";
}
?>


<?php
if(isset($_POST['SubmitButton2'])){ //check if form was submitted
    $input2 = $_POST['K2']; //get input text
    $db2 = pg_connect("host=tr01 dbname=ms19ys user=ms19ys");

    $res2 = pg_query($db2, "SELECT course.cname, x.sectno from
(select * from
(select cno, sectno, count(*) from enroll group by cno, sectno) t where t.count < $input2) x
left join course on course.cno = x.cno;");
}
?>

<?php

if(isset($_POST['SubmitButton3'])){ //check if form was submitted
    $input3 = $_POST['sid']; //get input text
    $db3 = pg_connect("host=tr01 dbname=ms19ys user=ms19ys");
    $res3 = pg_query($db3, "SELECT distinct cno, grade from enroll where sid = $input3;");
}
?>

<?php
if(isset($_POST['SubmitButton3'])){ //check if form was submitted
    $input3 = $_POST['sid']; //get input text
    $db3 = pg_connect("host=tr01 dbname=ms19ys user=ms19ys");
    $res3 = pg_query($db3, "SELECT distinct cno, grade from enroll where sid = $input3;");
}
?>

<!-- Optional -->
<!-- <?php
if(isset($_POST['SubmitButton4'])){ //check if form was submitted
    $input4 = $_POST['grade']; //get input text
    $db3 = pg_connect("host=tr01 dbname=ms19ys user=ms19ys");
    $res3 = pg_query($db3, "SELECT distinct cno, grade from enroll where sid = $input3;");
}
?> -->


<html lang="en">
<head>
<meta charset="utf-8">
</head>
<body>

    <form action="" method="post">
      <input type="text" name="cno"/>
      <input type="submit" name="SubmitButton"/>
    </form>

    Q1
    <?php
    echo "<table border = '1'>
    <tr>
    <th>Name</th>
    <th>grade</th>
    </tr>";
    while ($row = pg_fetch_row($res))
    {
        echo "<tr>";
        echo "<td>" . $row[0] ."</td>";
        echo "<td>" . $row[1] . "</td>";
        echo "</tr>";
    }
    echo "</table>";
    ?>

Q2
    <form action="" method="post">
      <input type="text" name="K"/>
      <input type="submit" name="SubmitButton1"/>
    </form>

    <?php
    echo "<table border = '1'>
    <tr>
    <th>Department</th>
    </tr>";
    while ($row = pg_fetch_row($res1))
    {
        echo "<tr>";
        echo "<td>" . $row[0] ."</td>";
        echo "</tr>";
    }
    echo "</table>";
    ?>

    Q3
        <form action="" method="post">
          <input type="text" name="K2"/>
          <input type="submit" name="SubmitButton2"/>
        </form>

        <?php
        echo "<table border = '1'>
        <tr>
        <th>Course number</th>
        <th>Section number</th>
        </tr>";
        while ($row = pg_fetch_row($res2))
        {
            echo "<tr>";
            echo "<td>" . $row[0] ."</td>";
            echo "<td>" . $row[1] ."</td>";
            echo "</tr>";
        }
        echo "</table>";
        ?>


optional
        <form action="" method="post">
          <input type="text" name="sid"/>
          <input type="submit" name="SubmitButton3"/>
        </form>



        <form action="" method="get">
            <?php
            echo "<select name='grade'>";
            while ($row = pg_fetch_array($res3)) {
                echo "<option value='" . $row['0'] . "'>" . $row['0'] . "</option>";
            }
            echo "</select>";
            ?>
            <input type="submit" value='check' name="SubmitButton4"/>
        </form>

        <?php
            if($_GET){
                $input5 = $_GET['grade'];
                echo 'TEST'.$input5;
                $db4 = pg_connect("host=tr01 dbname=ms19ys user=ms19ys");
                $res4 = pg_query($db4, "SELECT distinct grade from enroll where sid = 1 and cno = $input5;");
                while ($row = pg_fetch_row($res4))
                {
                    echo 'The year selected is '.$row[0];
                }

            }
        ?>

        <!-- <?php
        if(isset($_POST['SubmitButton4'])){ //check if form was submitted

            $input3 = $_POST['grade']; //get input text
            if(isset($_POST["grade"])){
                echo '$draft;';
                $draft= $_GET["grade"];
                echo $draft;
            }
        }
        ?> -->




</body>
</html>
