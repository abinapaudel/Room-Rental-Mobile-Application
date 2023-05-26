<?php
header("Access-Control-Allow-Origin: *");

include './DatabaseConfig.php';
$connect = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName);

if (isset($_POST['type']) && isset($_POST['user_id']) && isset($_POST['message']) && isset($_POST['title']) && isset($_POST['date'])) {

    $type = $_POST['type'];
    $user_id = $_POST['user_id'];
    $message = $_POST['message'];
    $title = $_POST['title'];
    $date = $_POST['date'];

    $query = "INSERT INTO visit_request (type, user_id, message, title, date) VALUES ('$type', '$user_id', '$message', '$title', '$date')";
    $result = mysqli_query($connect, $query);

    if ($result) {
        $data = ['success' => true, 'message' => ['Request sent successfully']];
    } else {
        $data = ['success' => false, 'message' => ['Request not sent']];
    }
    echo json_encode($data);
} else {
    $data = ['success' => false, 'message' => ['All fields are required!']];
    echo json_encode($data);
}
