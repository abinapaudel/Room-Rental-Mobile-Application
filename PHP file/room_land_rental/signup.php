<?php
header("Access-Control-Allow-Origin: *");

include './DatabaseConfig.php';
$connect = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName);


if (
    isset($_POST['first_name']) &&
    isset($_POST['last_name']) &&
    isset($_POST['dob']) &&
    isset($_POST['gender']) &&
    isset($_POST['username']) &&
    isset($_POST['email']) &&
    isset($_POST['phone_number']) &&
    isset($_POST['address']) &&
    isset($_POST['password'])
) {
    $first_name = $_POST['first_name'];
    $last_name = $_POST['last_name'];
    $dob = $_POST['dob'];
    $gender = $_POST['gender'];
    $username = $_POST['username'];
    $email = $_POST['email'];
    $phone_number = $_POST['phone_number'];
    $address = $_POST['address'];
    $password = password_hash($_POST['password'], PASSWORD_DEFAULT);

    $sql = "SELECT * FROM users where email = '$email'";
    $chkResult = mysqli_query($connect, $sql);
    if ($chkResult->num_rows > 0) {
        $data = ['success' => false, 'message' => ['Email is already used!']];
        echo  json_encode($data);
    } else {

        $query = "INSERT into users (first_name, last_name, dob, gender, username, email, phone_number, address, password) values('$first_name', '$last_name', '$dob', '$gender', '$username', '$email', '$phone_number', '$address', '$password')";
        if ($result = mysqli_query($connect, $query)) {
            $data = ['success' => true, 'message' => ['User Sucessfully signed up!']];
        } else {
            $data = ['success' => false, 'message' => ['Something went wrong!']];
        }
        echo  json_encode($data);
    }
} else {
    $data = ['success' => false, 'message' => ['Something went wrong!']];
    echo  json_encode($data);
}
