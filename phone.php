<!DOCTYPE html>
<html>
<head>
<style>
body {
  font-size: 1.0em;
  font-family: Arial, Helvetica, sans-serif;
  color: #00000A;
  background-color: #F1F1F1;
  margin: 0;
  padding: 0;
}
span {
  width: 7em;
  margin: 0.7em 0.5em;
  text-align: right;
  display: inline-block; 
}
input[type="text"] {
  height: 1.5em;
  font-size: 1.2em;
  color: #00000A;
  background-color: #F7F7F7;
  border: 2px solid #21BBFF;
  border-radius: 5px;
  box-shadow: 0 0 8px #21BBFF;
  margin: 0.3em 1em 0.2em 0.2em;
}
input[type="submit"] {
  font-size: 1.1em;
  text-align: center;
  color: #00000A;
  border: none;
  border-radius: 4px;
  box-shadow: inset 0 0 8px #111;
  padding: 0.5em 1.5em;
  display: inline-block;  
  cursor: pointer;
  background-color: #C0C0C0;
  margin: 1em 15em;
}
.area {
  width: 80%;
  border: 2px solid gray;
  padding: 1em;
  margin: 2em auto;
  border-radius: 5px;
  background: #F7F7F7;
  box-shadow: 1px 2px 8px rgba(0, 0, 0, .5);
}
</style>
<meta charset="UTF-8" />
<title>Test Phonebook</title>
</head>


<body>
<?php
//Deliberately vulnerable page to demo how to protect against SQL Injection attacks
DEFINE('SERVERNAME', 'localhost');
DEFINE('USERNAME', 'test');
DEFINE('PASSWORD', 'test123');
DEFINE('DBNAME', 'phonedb');

//-------------------------------------------------------------------
function add_record() {
  global $db;
  
  if (preg_match('/^[\w\d\s\-\._+]+$/', $_POST['ph_firstname']) > 0) {
    $ph_firstname = $_POST['ph_firstname'];
  }
  else {
    die ('Invalid first name');
  }
  if (preg_match('/^[\w\d\s\-\._+]+$/', $_POST['ph_surname']) > 0) {
    $ph_surname = $_POST['ph_surname'];
  }
  else {
    die ('Invalid surname');
  }
  if (preg_match('/^[\d\s\-+]+$/', $_POST['ph_number']) > 0) {
    $ph_number = $_POST['ph_number'];
  }
  else {
    die ('Invalid number');
  }
  
  $cmd = 'INSERT INTO phone(id, surname, firstname, number) VALUES (\'null\', \''.$ph_surname.'\', \''.$ph_firstname.'\', \''.$ph_number.'\')';
  if ($db->query($cmd) === true) {
    echo 'New record created successfully';
  }
  else {
    die('Error: '.$db->error);
  }
}
//-------------------------------------------------------------------
function draw_search() {
  echo '<form method="post" name="Search_Form">'.PHP_EOL;
  echo '<div align="right"><span>Search:</span><input name="ph_search" size="50" type="text" onchange="submit()"></div>'.PHP_EOL;
  echo '</form>'.PHP_EOL;
}
//-------------------------------------------------------------------
function search_record($search) {
  global $db;
//' OR '1=1'; INSERT INTO phone(id,surname,firstname,number) VALUES('null','konsole','test','222')'
  $query = "SELECT * FROM phone WHERE surname = '$search'";
  
  echo $query.'<br />';
  
  if(!$result = $db->query($query)){
    die('There was an error running the query'.$db->error);
  }
  
  print_r($result);
  if ($result->num_rows == 0) {
    echo 'Nothing found';
  }
  else {
    while($row = $result->fetch_assoc()) {
      echo '<div class="area">'.PHP_EOL;
      echo '<span>Surname:</span>'.$row['surname'].'<br />'.PHP_EOL;
      echo '<span>Firstname:</span>'.$row['firstname'].'<br />'.PHP_EOL;
      echo '<span>Number:</span>'.$row['number'].'<br />'.PHP_EOL;
      echo '</div>'.PHP_EOL;
    }
  }
  
  $result->free();
}
//-------------------------------------------------------------------
function show_form() {
  echo '<div class="area">'.PHP_EOL;
  echo '<form method="post" name="Edit_Form">'.PHP_EOL;
  echo '<span>Surname:</span><input name="ph_surname" type="text" size="30"><br />'.PHP_EOL;
  echo '<span>Firstname:</span><input name="ph_firstname" type="text" size="30"><br />'.PHP_EOL;
  echo '<span>Number:</span><input name="ph_number" type="text" size="30"><br />'.PHP_EOL;
  echo '<input type="submit" value="Submit">'.PHP_EOL;
  echo '</form>'.PHP_EOL;
  echo '</div>'.PHP_EOL;
}
//-------------------------------------------------------------------
function show_all() {
  global $db;
  
  $query = 'SELECT * FROM `phone` ORDER BY `surname` DESC';
  
  if(!$result = $db->query($query)){
    die('There was an error running the query'.$db->error);
  }
    
  if ($result->num_rows == 0) {
    echo 'Nothing found';
  }
  else {
    while($row = $result->fetch_assoc()) {
      echo '<div class="area">'.PHP_EOL;
      echo '<span>Surname:</span>'.$row['surname'].'<br />'.PHP_EOL;
      echo '<span>Firstname:</span>'.$row['firstname'].'<br />'.PHP_EOL;
      echo '<span>Number:</span>'.$row['number'].'<br />'.PHP_EOL;
      echo '</div>'.PHP_EOL;
    }
  }
  
  $result->free();
}
//-------------------------------------------------------------------
$db = new mysqli(SERVERNAME, USERNAME, PASSWORD, DBNAME);

draw_search();

if ((isset($_POST['ph_surname'])) && (isset($_POST['ph_firstname'])) && (isset($_POST['ph_number']))) {
  add_record();
}
elseif (isset($_POST['ph_search'])) {
  $search = preg_replace('/[^\w\d\s\.\-_+]/', '', $_POST['ph_search']);
  search_record($search);
}
else {
  show_form();
  show_all();
}

$db->close();
?>
</body>
</html>

