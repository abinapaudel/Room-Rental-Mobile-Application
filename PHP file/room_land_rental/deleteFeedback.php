<?php
header("Access-Control-Allow-Origin: *");

include './DatabaseConfig.php';
$connect = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName);

if (isset($_POST['id'])) {

    $id = $_POST['id'];

    $query = "DELETE from feedbacks where id = '$id'";
    $result = mysqli_query($connect, $query);

    if ($result) {
        $data = ['success' => true, 'message' => ['Feedback deleted successfully']];
    } else {
        $data = ['success' => false, 'message' => ['Feedback not deleted']];
    }
    echo json_encode($data);
} else {
    $data = ['success' => false, 'message' => ['Feedback id is required']];
    echo json_encode($data);
}
