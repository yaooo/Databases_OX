<?php
// attempt a connection
$dbh    = pg_connect("host=tr01 dbname=ms19ys user=ms19ys");
$sql    = "SELECT s.sname,e.grade from student s, enroll e where s.sid = e.sid and e.cno = 310;";
$result = pg_query($dbh, $sql);
?>

 <!DOCTYPE html>
 <html>
      <head>
           <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
           <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

           <script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
           <script src="https://cdn.datatables.net/1.10.19/js/dataTables.bootstrap.min.js"></script>
           <link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/dataTables.bootstrap.min.css" />
      </head>
      <body>

          <form action="welcome.php" method="post">
              student id: <input type="text" name="name"><br>
                    <input type="submit">
                </form>
           <div class="container">
                <h3 align="left">Q1<br></h3>
                <div class="table-responsive">
                     <table id="bar_data" id = "costumer" class="table table-striped table-bordered">
                              <thead class="thead-dark">

                                  <tr>
                                  <th scope="col">Name</th>
                              <th scope="col">Grade</th>
                  </tr>
                          </thead>
                          <?php
while ($row = mysqli_fetch_array($result)) {
    echo '
                               <tr>
                                    <td>' . $row["sname"] . '</td>
                                    <td>' . $row["grade"] . '</td>
                               </tr>
                               ';
}
echo '

                          <tfoot>
                          <tr>
                              <th>Name</th>
                              <th>Grade</th>
                          </tr>
                          </tfoot> ';
?>
                     </table>
                </div>
           </div>
      </body>
 </html>
 <script>

 $(document).ready(function() {
    $('#bar_data').DataTable( {
        initComplete: function () {
            this.api().columns().every( function () {
                var column = this;
                var select = $('<select><option value=""></option></select>')
                    .appendTo( $(column.footer()).empty() )
                    .on( 'change', function () {
                        var val = $.fn.dataTable.util.escapeRegex(
                            $(this).val()
                        );

                        column
                            .search( val ? '^'+val+'$' : '', true, false )
                            .draw();
                    } );

                column.data().unique().sort().each( function ( d, j ) {
                    select.append( '<option value="'+d+'">'+d+'</option>' )
                } );
            } );
        }
    } );
} );
 </script>
