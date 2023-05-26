<?php
header("Access-Control-Allow-Origin: *");
include './DatabaseConfig.php';
// Creating MySQL Connection.
$con = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName);

$land_sql = "SELECT * FROM land_bookings where status='booked'";

$land_result = $con->query($land_sql);

$landIds = array();
while ($row_lands = $land_result->fetch_assoc()) {
    array_push($landIds,$row_lands['land_id']);
}



$img_sql = "SELECT * FROM land_images";

$img_result = $con->query($img_sql);

$images = array();
while ($row_images[] = $img_result->fetch_assoc()) {
    $images = $row_images;
}


$sql = "SELECT * FROM lands";

$result = $con->query($sql);
$properties=[];

while ($row = mysqli_fetch_array($result)) {

    //  if(in_array($row['id'],$landIds)){
    //      continue;
    //  }


    $land_images =  array();

    foreach ($images as $image) {

        if ($image['land_id'] == $row['id']) {
            $land_images[] = $image;
        }
    }



    $properties[] = (object) array(
        'id' => $row['id'],
        'land_title' => $row['land_title'],
        'location' => $row['location'],
        'land_desc' => $row['land_desc'],
        'rent' => $row['rent'],
        'area' => $row['area'],
        'owner_firstname' => $row['owner_firstname'],
        'owner_lastname' => $row['owner_lastname'],
        'phone_no' => $row['phone_no'],
        'email' => $row['email'],
        'images' => $land_images,
        'booked'=> in_array($row['id'],$landIds)?1:0
    );
    // $properties['images'] = $prty_images;
}

$data = ['success' => true, 'data' => $properties];
echo json_encode($data);
