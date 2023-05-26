<?php
header("Access-Control-Allow-Origin: *");
include './DatabaseConfig.php';
$connect = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName);


if (
    isset($_POST['user_id']) &&
    isset($_POST['first_name']) &&
    isset($_POST['last_name']) &&
    isset($_POST['dob']) &&
    isset($_POST['gender']) &&
    isset($_POST['username']) &&
    isset($_POST['phone_number']) &&
    isset($_POST['address'])
) {

    $user_id = $_POST['user_id'];
    $first_name = $_POST['first_name'];
    $last_name = $_POST['last_name'];
    $dob = $_POST['dob'];
    $gender = $_POST['gender'];
    $username = $_POST['username'];
    $phone_number = $_POST['phone_number'];
    $address = $_POST['address'];

    $query = "UPDATE users set first_name = '$first_name', last_name = '$last_name', dob = '$dob', gender = '$gender', username='$username', address='$address', phone_number='$phone_number' where id = '$user_id'";
    if (mysqli_query($connect, $query)) {
        $data = ['success' => true, 'message' => ['Profile successfully edited!']];
        echo  json_encode($data);
    } else {
        $data = ['success' => false, 'message' => ['Something went wrong!']];
        echo  json_encode($data);
    }
} else {
    $data = ['success' => false, 'message' => ['Something went wrong!']];
    echo  json_encode($data);
}
