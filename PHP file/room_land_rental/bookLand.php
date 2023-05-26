<?php
header("Access-Control-Allow-Origin: *");

include './DatabaseConfig.php';
$connect = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName);


if (isset($_POST['land_id']) && isset($_POST['user_id']) && isset($_POST['token'])) {

    $land_id = $_POST['land_id'];
    $user_id = $_POST['user_id'];
    $token = $_POST['token'];
    $date = date('Y-m-d');

    $sql = "SELECT * FROM land_bookings WHERE land_id = '$land_id' AND user_id = '$user_id'";
    $chkSql = mysqli_query($connect, $sql);

    if ($chkSql->num_rows > 0) {
        $data = ['success' => false, 'message' => ['You have already booked this land']];
        echo json_encode($data);
    } else {

        $query = "INSERT INTO land_bookings (land_id, user_id, token,status, date) VALUES ('$land_id', '$user_id', '$token','booked','$date')";
        $result = mysqli_query($connect, $query);

        if ($result) {
            $data = ['success' => true, 'message' => ['Booking successful']];
        } else {
            $data = ['success' => false, 'message' => ['Booking not successful']];
        }
        echo json_encode($data);
    }
} else {
    $data = ['success' => false, 'message' => ['All Fields are required!']];
    echo  json_encode($data);
}
