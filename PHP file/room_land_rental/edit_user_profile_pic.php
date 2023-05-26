<?php

header("Access-Control-Allow-Origin: *");
include './DatabaseConfig.php';
$connect = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName);

$userId = isset($_POST['userId']) ? $_POST['userId'] : "";
$user_data = array();

if (isset($_POST['userId']) && isset($_FILES['image'])) {
    $userId = $_POST['userId'];
    $timestamp = time();
    $filename = $_FILES['image']['name'];
    $valid_ext = array('png', 'jpeg', 'jpg');
    $photoExt1 = explode('.', $filename);
    $photoExt2 = strtolower($photoExt1[1]);

    $newFileName = $photoExt1[0] . time() . '.' . $photoExt2;

    $location = 'images/' . $newFileName;
    $img_loc = 'images/' . $newFileName;

    $file_type = pathinfo($location, PATHINFO_EXTENSION);
    $file_ext = strtolower($file_type);
    if (in_array($file_ext, $valid_ext)) {



        if (move_uploaded_file($_FILES['image']['tmp_name'], $location)) {
            $updateDetails = "UPDATE users set image = '$img_loc' where id = '$userId'";

            if (mysqli_query($connect, $updateDetails)) {
                $data = ['success' => true, 'message' => ['Successfully updated!'], 'data' => $img_loc];
                echo json_encode($data);
            } else {
                $data = ['success' => false, 'message' => ['Something went wrong!']];
                echo json_encode($data);
            }
        } else {
            $data = ['success' => false, 'message' => ['Something went wrong!']];
            echo json_encode($data);
        }
    }
} else {
    $data = ['success' => false, 'message' => ['UserId required']];
    echo json_encode($data);
}
