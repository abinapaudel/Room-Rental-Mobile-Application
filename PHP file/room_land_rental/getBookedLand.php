<?php
header("Access-Control-Allow-Origin: *");

include './DatabaseConfig.php';
$connect = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName);

if (isset($_POST['user_id'])) {
    $query = "Select land_bookings.*, lands.land_title from land_bookings join lands on land_bookings.land_id = lands.id where land_bookings.user_id = '" . $_POST['user_id'] . "'";
} else {

    $query = "Select land_bookings.*, lands.land_title, users.first_name from land_bookings join lands on land_bookings.land_id = lands.id join users on land_bookings.user_id = users.id";
}


$result = mysqli_query($connect, $query);

$request_data = [];

while ($row[] = mysqli_fetch_assoc($result)) {

    $request_data = $row;
}
$data = [
    'success' => true,
    'message' => ['Requests fetched successfully'],
    'data' => $request_data
];

echo json_encode($data);
