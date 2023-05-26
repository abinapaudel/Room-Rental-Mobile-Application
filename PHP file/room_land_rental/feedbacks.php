<?php
header("Access-Control-Allow-Origin: *");

include './DatabaseConfig.php';
$connect = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName);


$query = "SELECT feedbacks.*, users.first_name from feedbacks join users on feedbacks.user_id = users.id";
$result = mysqli_query($connect, $query);
$feedbacks = [];
while ($row = mysqli_fetch_array($result)) {

    $feedbacks[] = (object) array(
        'id' => $row['id'],
        'name' => $row['first_name'],
        'feedback' => $row['feedback'],
    );
}
$data = [
    'success' => true,
    'message' => ['Feedback fetched successfully'],
    'data' => $feedbacks
];

echo json_encode($data);
