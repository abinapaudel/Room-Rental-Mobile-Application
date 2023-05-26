<?php
header("Access-Control-Allow-Origin: *");
include './DatabaseConfig.php';
$connect = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName);

if (
    isset($_POST['land_id']) &&
    isset($_POST['land_title']) &&
    isset($_POST['location']) &&
    isset($_POST['land_desc']) &&
    isset($_POST['rent']) &&
    isset($_POST['area']) &&
    isset($_POST['owner_firstname']) &&
    isset($_POST['owner_lastname']) &&
    isset($_POST['phone_no']) &&
    isset($_POST['email'])
) {

    $land_id = $_POST['land_id'];
    $land_title = $_POST['land_title'];
    $location = $_POST['location'];
    $land_desc = $_POST['land_desc'];
    $rent =   $_POST['rent'];
    $area =   $_POST['area'];
    $owner_firstname = $_POST['owner_firstname'];
    $owner_lastname = $_POST['owner_lastname'];
    $phone_no = $_POST['phone_no'];
    $email = $_POST['email'];

    $query = "UPDATE lands SET land_title='$land_title', location='$location', land_desc='$land_desc', rent='$rent', area='$area', owner_firstname='$owner_firstname', owner_lastname='$owner_lastname', phone_no='$phone_no', email='$email' WHERE id='$land_id'";

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
                    $imgsql = "INSERT INTO land_images (land_id, path) VALUES ('$requiredId', '$location')";
                    mysqli_query($connect, $imgsql);
                }
            }
        }
        $data = ['success' => true, 'message' => ['Land edited successfully']];
        echo json_encode($data);
    } else {
        $data = ['success' => false, 'message' => ['Land not edited!']];
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
