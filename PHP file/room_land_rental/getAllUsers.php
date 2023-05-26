<?php
header("Access-Control-Allow-Origin: *");

include './DatabaseConfig.php';
$connect = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName);


$query = "SELECT * from users where role <> 'admin'";
$result = mysqli_query($connect, $query);

while ($row = mysqli_fetch_array($result)) {

    $user_data[] =  array(
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
}
$data = [
    'success' => true,
    'message' => ['User fetched successfully'],
    'data' => $user_data
];

echo json_encode($data);
