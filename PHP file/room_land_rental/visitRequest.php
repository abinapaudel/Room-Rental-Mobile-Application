<?php
header("Access-Control-Allow-Origin: *");

include './DatabaseConfig.php';
$connect = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName);

if (isset($_POST['user_id'])) {
    $user_id = $_POST['user_id'];
    $query = "SELECT visit_request.*, users.first_name from visit_request join users on visit_request.user_id = users.id where visit_request.user_id = '$user_id'";
} else {
    $query = "SELECT visit_request.*, users.first_name from visit_request join users on visit_request.user_id = users.id";
}


$result = mysqli_query($connect, $query);

$request_data = [];

while ($row = mysqli_fetch_array($result)) {

    $request_data[] = (object) array(
        'id' => $row['id'],
        'type' => $row['type'],
        'message' => $row['message'],
        'date' => $row['date'],
        'title' => $row['title'],
        'name' => $row['first_name'],
    );
}
$data = [
    'success' => true,
    'message' => ['Requests fetched successfully'],
    'data' => $request_data
];

echo json_encode($data);
