<?php

namespace Model;

class DataModel {

    public function __construct() {
    }

    public function getJLData(\PDO $dbh) {

        $data = [];

        $sql = <<<EOF
SELECT a.id, cm.metric_id, a.cell_device_id, a.line1number
,m.network_state_id, ns.network_type, ns.system_timestamp_millis, ns.network_state
,m.location_id, l.mlatitude, l.mlongitude, l.mspeed
,m.report_id, r.report_type, r.drive_mode, r.event_type
,m.ping_id, p.ping_avg, p.ping_min, p.ping_max, p.ttl, p.time, p.output
,ltem.lte_identity_id, lte.mci, lte.mmcc, lte.mregistered
FROM cells a
JOIN cells_metrics cm ON cm.cell_id = a.id
LEFT JOIN metrics m ON m.id = cm.metric_id
LEFT JOIN locations l ON l.id = m.location_id
LEFT JOIN network_states ns ON ns.id = m.network_state_id
LEFT JOIN reports r ON r.id = m.report_id
LEFT JOIN pings p ON p.id = m.ping_id
LEFT JOIN lte_identities_metrics ltem ON ltem.metric_id = m.id
  JOIN lte_identities lte ON lte.id = ltem.lte_identity_id AND lte.mregistered = 1
WHERE a.cell_device_id = 354774070232022
AND ns.system_timestamp_millis >= '2017-12-11' and ns.system_timestamp_millis <= '2017-12-30'
ORDER BY COALESCE(ns.system_timestamp_millis) DESC
EOF;
        try {

           $sth = $dbh->prepare($sql);
           $sth->execute();
           $data = $sth->fetchAll(\PDO::FETCH_ASSOC);

           $dbh = null;
        } catch (\PDOException $e) {
            print "Error!: " . $e->getMessage() . "<br/>";
            die();
        }

        return $data;
    }

    public function saveData(\PDO $dbh, \Entity\PerformanceReportEntity $data) {

        $result = false;

        try {


            $data->device_id = $_POST['device_id'];
            $data->line1number = $_POST["line1number"];
            $data->cellinfo = $_POST['cellinfo'];
            $data->location = $_POST['location'];
            $data->report_type = $_POST['report_type'];
            $data->ping = $_POST['ping'];
            $data->throughput = $_POST['throughput'];
            $data->network_state = $_POST['network_state'];

            $sql = "INSERT INTO performance_data (report_id, device_id, line1number, report_type, cellinfo, location, ping, throughput, network_state)
               VALUES (NULL, :device_id, :line1number, :report_type, :cellinfo, :location, :ping, :throughput, :network_state)";

            $stmt = $dbh->prepare($sql);
            $stmt->bindParam(':device_id', $data->device_id);
            $stmt->bindParam(':line1number', $data->line1number);
            $stmt->bindParam(':report_type', $data->report_type);
            $stmt->bindParam(':cellinfo', $data->cellinfo);
            $stmt->bindParam(':location', $data->location);
            $stmt->bindParam(':ping', $data->ping);
            $stmt->bindParam(':throughput', $data->throughput);
            $stmt->bindParam(':network_state', $data->network_state);

            $result = $stmt->execute();

            $dbh = null;

            return $result;
        } catch (\PDOException $e) {
            print "Error!: " . $e->getMessage() . "<br/>";
            die();
        }
    }

}

?>