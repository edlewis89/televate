<?php

namespace Model;

class ViewModel {

   private function wrapPageContent($content) {

       $html = '<!doctype html>
<html lang="en">
  <head>
    <title>Cell Data</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
  </head>
  <body>

'.$content.'

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script>
  </body>
</html>';

       return $html;
   }

   public function getHtml($data) {

      // print headers
       $data_html = $this->wrapTableHeaders($data[0]);
      foreach ($data as $key => $row) {
          $data_html .= $this->wrapTableRow($row);
      }

      $content = $this->wrapTable($data_html);
      $page = $this->wrapPageContent($content);
      return $page;
   }

   private function wrapTable($data_html) {
      return sprintf('<table class="table table-sm table-bordered table-dark table-striped">%s</table>', $data_html);
   }

   private function wrapTableHeaders($data) {
      $html = '<tr>';
      $headers = array_keys($data);
      foreach ($headers as $header) {
         $html .= sprintf('<th scope="row">%s</th>',$header);
      }
      $html .= '</tr>';
      return $html;
   }

   private function wrapTableRow($row) {

       $event_style = '';
       $event = array_search('Event Report', $row);

       if ($event !== false) {
          $event_style = 'class="bg-danger"';
       }

       $html = sprintf('<tr %s>',$event_style);
       foreach ($row as $key => $data) {
           $html .= sprintf('<td>%s</td>',$data);
       }
       $html .= '</tr>';
       return $html;
   }
}

?>