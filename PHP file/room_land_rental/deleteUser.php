<?php
header("Access-Control-Allow-Origin: *");
include './DatabaseConfig.php';
$connect = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName);

if (isset($_POST['user_id'])) {

    $userId = $_POST['user_id'];

    $roomSql = "DELETE FROM room_bookings WHERE user_id = '$userId'";
    $landSql = "DELETE FROM land_bookings WHERE user_id = '$userId'";
    $feedSql = "DELETE FROM feedbacks WHERE user_id = '$userId'";
    $visitSql = "DELETE FROM visit_request WHERE user_id = '$userId'";
    $userSql = "DELETE FROM users WHERE id = '$userId'";

    $roomResult = mysqli_query($connect, $roomSql);
    $landResult = mysqli_query($connect, $landSql);
    $feedResult = mysqli_query($connect, $feedSql);
    $visitResult = mysqli_query($connect, $visitSql);
    $userResult = mysqli_query($connect, $userSql);

    if ($roomResult && $landResult && $feedResult && $visitResult && $userResult) {
        $data = ['success' => true, 'message' => ['User deleted successfully']];
    } else {
        $data = ['success' => false, 'message' => ['User not deleted']];
    }
    echo  json_encode($data);
} else {
    $data = ['success' => false, 'message' => ['All Fields are required!']];
    echo  json_encode($data);
}
