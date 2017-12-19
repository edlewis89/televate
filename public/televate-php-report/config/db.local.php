<?php
$user='root';
$pass='televate';

$dbh = new PDO('mysql:host=localhost;dbname=televate_production', $user, $pass);

$dbhPerf = new PDO('mysql:host=localhost;dbname=test_performance_proto', $user, $pass);
