<?php
header("Access-Control-Allow-Origin: *");

include './DatabaseConfig.php';
$connect = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName);


if (
    isset($_POST['user_id'])
    && isset($_POST['id'])
) {

    $user_id = $_POST['user_id'];
    $id = $_POST['id'];

    $query = "DELETE from land_bookings where user_id='$user_id' and id='$id'";
    $result = mysqli_query($connect, $query);

    if ($result) {
        $data = ['success' => true, 'message' => ['Cancellation successful']];
    } else {
        $data = ['success' => false, 'message' => ['Cancellation not successful']];
    }
    echo json_encode($data);
} else {
    $data = ['success' => false, 'message' => ['All fields are required!']];
    echo json_encode($data);
}
