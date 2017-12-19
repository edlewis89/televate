<?php

require_once 'src/Autoloader.php';
include 'config/db.local.php';

use Model\DataModel;
use Model\ViewModel;

$viewM = new ViewModel();

$dataM = new DataModel();
$data = $dataM->getJLData($dbh);

$html = $viewM->getHtml($data);

echo $html;
?>