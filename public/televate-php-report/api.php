<?php

require_once 'src/Autoloader.php';
include 'config/db.local.php';

use Model\DataModel;
use Entity\PerformanceReportEntity;

$dataM = new DataModel();

$data = new PerformanceReportEntity();

$data->device_id = $_POST['device_id'];
$data->line1number = $_POST["line1number"];
$data->cellinfo = $_POST['cellinfo'];
$data->location = $_POST['location'];
$data->report_type = $_POST['report_type'];
$data->ping = $_POST['ping'];
$data->throughput = $_POST['throughput'];
$data->network_state = $_POST['network_state'];

$result = $dataM->saveData($dbhPerf, $data);

?>