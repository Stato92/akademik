<?php
header("Access-Control-Allow-Origin: *");
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');
$mail = $_POST;
$message = 'Rezerwacja pokoju nr ' . $mail['roomNumber'] . ' w akademiku ' . $mail['dormName'];
$message .= 'Dane z formularza: ' . '\r\n';
$message .= 'Imię: ' . $mail['name'] . '\r\n';
$message .= 'Nazwisko: ' . $mail['surname'] . '\r\n';
$message .= 'Nr indeksu: ' . $mail['indexNumber'] . '\r\n';
$message .= 'Email: ' . $mail['email'] . '\r\n';
$message .= 'Telefon: ' . $mail['phone'] . '\r\n';
$message = wordwrap($message, 70, "\r\n");
$headers[] = 'From: ' . $mail['email'];
$headers[] = 'MIME-Version: 1.0';
$headers[] = 'Content-type: text/html; charset=iso-8859-1';

class Response
{
    public $status;
    public $message;
}

$response = new Response;
if (mail('admin@local', 'Rezerwacja', $message, implode("\r\n", $headers))) {
    $response->status = true;
    $response->message = '<div class="alert alert-success" role="alert">
    <strong>Zgłoszenie zostało przyjęte, dziękujemy za dokonanie rezerwacji.</strong>
  </div>';
} else {
    $response->status = false;
    $response->message = '<div class="alert alert-danger" role="alert">
    <strong>Wystąpił błąd podczas przesyłania zgłoszenia. Sprawdź wprowadzone dane lub spróbuj ponownie później.</strong>
  </div>';
}
echo json_encode($response);