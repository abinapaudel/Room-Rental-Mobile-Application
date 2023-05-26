<?php
header("Access-Control-Allow-Origin: *");

include './DatabaseConfig.php';
$connect = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName);


if (isset($_POST['email']) && isset($_POST['password'])) {
    $email = $_POST['email'];
    $password = $_POST['password'];

    $query = "SELECT * from users";
    $result = mysqli_query($connect, $query);

    while ($row = mysqli_fetch_array($result)) {

        if ($row['email'] === $email && password_verify($password, $row['password'])) {
            $user_data = (object) array(
                'id' => $row['id'],
                'first_name' => $row['first_name'],
                'last_name' => $row['last_name'],
                'username' => $row['username'],
                'dob' => $row['dob'],
                'gender' => $row['gender'],
                'email' => $row['email'],
                'phone_number' => $row['phone_number'],
                'address' => $row['address'],
                'role' => $row['role'],
                'image' => $row['image'],
            );

            $data = [
                'success' => true,
                'message' => ['Welcome ' . $row['username']],
                'data' => $user_data
            ];

            break;
        } else {

            $data = ['success' => false, 'message' => ['User not found!']];
        }
    }

    echo json_encode($data);
} else {
    $data = ['success' => false, 'message' => ['Email or Password required!']];
    echo json_encode($data);
}
