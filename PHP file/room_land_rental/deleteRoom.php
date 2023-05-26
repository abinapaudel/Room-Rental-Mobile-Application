<?php
header("Access-Control-Allow-Origin: *");
include './DatabaseConfig.php';
$connect = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName);

if (isset($_POST['room_id'])) {

    $roomId = $_POST['room_id'];

    $roomBookSql = "DELETE FROM room_bookings WHERE room_id = '$roomId'";
    $imageSql = "DELETE FROM room_images WHERE room_id = '$roomId'";
    $roomSql = "DELETE FROM rooms WHERE id = '$roomId'";

    $roomBookResult = mysqli_query($connect, $roomBookSql);
    $imageResult = mysqli_query($connect, $imageSql);
    $roomResult = mysqli_query($connect, $roomSql);

    if ($roomBookResult && $roomResult && $imageResult) {
        $data = ['success' => true, 'message' => ['Room deleted successfully']];
    } else {
        $data = ['success' => false, 'message' => ['Room not deleted']];
    }
    echo  json_encode($data);
} else {
    $data = ['success' => false, 'message' => ['All Fields are required!']];
    echo  json_encode($data);
}
