<?php
header("Access-Control-Allow-Origin: *");
include './DatabaseConfig.php';
$connect = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName);

if (isset($_POST['land_id'])) {

    $landId = $_POST['land_id'];

    $landBookSql = "DELETE FROM land_bookings WHERE land_id = '$landId'";
    $imageSql = "DELETE FROM land_images WHERE land_id = '$landId'";
    $landSql = "DELETE FROM lands WHERE id = '$landId'";

    $landBookResult = mysqli_query($connect, $landBookSql);
    $imageResult = mysqli_query($connect, $imageSql);
    $landResult = mysqli_query($connect, $landSql);

    if ($landBookResult && $landResult && $imageResult) {
        $data = ['success' => true, 'message' => ['Land deleted successfully']];
    } else {
        $data = ['success' => false, 'message' => ['Land not deleted']];
    }
    echo  json_encode($data);
} else {
    $data = ['success' => false, 'message' => ['All Fields are required!']];
    echo  json_encode($data);
}
