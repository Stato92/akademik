<?php
header("Access-Control-Allow-Origin: *");
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');

$mail = json_decode($_POST);

$message = 'Rezerwacja pokoju nr ' . $mail->roomNumber . ' w akademiku ' . $mail->dormName;
$message = wordwrap($message, 70, "\r\n");
$headers[] = 'From: ' . $mail->email;
$headers[] = 'MIME-Version: 1.0';
$headers[] = 'Content-type: text/html; charset=iso-8859-1';

if (mail('jk22752@zut.edu.pl', $message, $mail, implode("\r\n", $headers))) {
    echo '<div class="alert alert-success" role="alert">
    <strong>Zgłoszenie zostało przyjęte, dziękujemy za dokonanie rezerwacji.</strong>
  </div>';
} else {
    echo '<div class="alert alert-danger" role="alert">
    <strong>Wystąpił błąd podczas przesyłania zgłoszenia. Sprawdź wprowadzone dane lub spróbuj ponownie później.</strong>
  </div>';
}