<?php
header("Access-Control-Allow-Origin: *");

include './DatabaseConfig.php';
$connect = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName);


if (isset($_POST['message']) && isset($_POST['user_id'])) {

    $message = $_POST['message'];
    $user_id = $_POST['user_id'];

    $query = "INSERT INTO feedbacks (feedback, user_id) VALUES ('$message', '$user_id')";
    $result = mysqli_query($connect, $query);

    if ($result) {
        $data = ['success' => true, 'message' => ['Feedback sent successfully']];
    } else {
        $data = ['success' => false, 'message' => ['Feedback not sent']];
    }
    echo json_encode($data);
} else {
    $data = ['success' => false, 'message' => ['Something went wrong!']];
    echo  json_encode($data);
}
