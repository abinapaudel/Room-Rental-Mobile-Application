<?php
header("Access-Control-Allow-Origin: *");
include './DatabaseConfig.php';
$connect = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName);

if (
    isset($_POST['room_title']) &&
    isset($_POST['bedroom_no']) &&
    isset($_POST['kitchen_no']) &&
    isset($_POST['hall_no']) &&
    isset($_POST['location']) &&
    isset($_POST['room_desc']) &&
    isset($_POST['rent']) &&
    isset($_POST['isBalcony']) &&
    isset($_POST['isParking']) &&
    isset($_POST['owner_firstname']) &&
    isset($_POST['owner_lastname']) &&
    isset($_POST['phone_no']) &&
    isset($_POST['email'])
) {

    $room_title = $_POST['room_title'];
    $bedroom_no =  $_POST['bedroom_no'];
    $kitchen_no =  $_POST['kitchen_no'];
    $hall_no =  $_POST['hall_no'];
    $location = $_POST['location'];
    $room_desc = $_POST['room_desc'];
    $rent =   $_POST['rent'];
    $isBalcony =  $_POST['isBalcony'];
    $isParking =   $_POST['isParking'];
    $owner_firstname = $_POST['owner_firstname'];
    $owner_lastname = $_POST['owner_lastname'];
    $phone_no = $_POST['phone_no'];
    $email = $_POST['email'];

    $maxsql = "SELECT max(id) from rooms";
    $maxresult = mysqli_query($connect, $maxsql);
    $maxcheck = mysqli_fetch_array($maxresult);
    $maxId = $maxcheck[0];
    $requiredId = $maxId + 1;

    $query = "INSERT INTO rooms (id, room_title, bedroom_no, kitchen_no, hall_no, location, room_desc, rent, isBalcony, isParking, owner_firstname, owner_lastname, phone_no, email) VALUES ('$requiredId','$room_title', '$bedroom_no', '$kitchen_no', '$hall_no', '$location', '$room_desc', '$rent', '$isBalcony', '$isParking', '$owner_firstname', '$owner_lastname', '$phone_no', '$email')";

    if (mysqli_query($connect, $query)) {
        if (isset($_FILES['images'])) {
            $countfiles = count($_FILES['images']['name']);
            for ($i = 0; $i < $countfiles; $i++) {
                $filename = $_FILES['images']['name'][$i];
                $ext1 = explode('.', $filename);
                $ext2 = strtolower($ext1[1]);
                $newFileName = $ext1[0] . time() . $requiredId . '.' . $ext2;
                $location = 'images/' . $newFileName;
                if (uploadImage($_FILES['images']['tmp_name'][$i], $location)) {
                    $imgsql = "INSERT INTO room_images (room_id, path) VALUES ('$requiredId', '$location')";
                    mysqli_query($connect, $imgsql);
                }
            }
        }
        $data = ['success' => true, 'message' => ['Room added successfully']];
        echo json_encode($data);
    } else {
        $data = ['success' => false, 'message' => ['Room not added!']];
        echo json_encode($data);
    }
} else {
    $data = ['success' => false, 'message' => ['All fields are required!']];
    echo json_encode($data);
}


function uploadImage($fileTempName, $location)
{

    if (move_uploaded_file($fileTempName, $location)) {
        return true;
    }
    return false;
}
