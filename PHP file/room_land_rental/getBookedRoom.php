<?php
header("Access-Control-Allow-Origin: *");

include './DatabaseConfig.php';
$connect = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName);

if (isset($_POST['user_id'])) {
    $query = "Select room_bookings.*, rooms.room_title from room_bookings join rooms on room_bookings.room_id = rooms.id where room_bookings.user_id = '" . $_POST['user_id'] . "'";
} else {

    $query = "Select room_bookings.*, rooms.room_title, users.first_name from room_bookings join rooms on room_bookings.room_id = rooms.id join users on room_bookings.user_id = users.id";
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
