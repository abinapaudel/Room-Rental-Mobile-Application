<?php
header("Access-Control-Allow-Origin: *");
include './DatabaseConfig.php';
// Creating MySQL Connection.
$con = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName);

$room_sql = "SELECT * FROM room_bookings where status='booked'";

$room_result = $con->query($room_sql);

$roomIds = array();
while ($row_rooms = $room_result->fetch_assoc()) {
    array_push($roomIds,$row_rooms['room_id']);
}

$img_sql = "SELECT * FROM room_images";

$img_result = $con->query($img_sql);

$images = array();
while ($row_images[] = $img_result->fetch_assoc()) {
    $images = $row_images;
}


$sql = "SELECT * FROM rooms";

$result = $con->query($sql);
$properties=[];
while ($row = mysqli_fetch_array($result)) {
    // if(in_array($row['id'],$roomIds)){
    //     continue;
    // }

    $room_images =  array();

    foreach ($images as $image) {

        if ($image['room_id'] == $row['id']) {
            $room_images[] = $image;
        }
    }



    $properties[] = (object) array(
        'id' => $row['id'],
        'room_title' => $row['room_title'],
        'bedroom_no' => $row['bedroom_no'],
        'kitchen_no' => $row['kitchen_no'],
        'hall_no' => $row['hall_no'],
        'location' => $row['location'],
        'room_desc' => $row['room_desc'],
        'rent' => $row['rent'],
        'isBalcony' => $row['isBalcony'],
        'isParking' => $row['isParking'],
        'owner_firstname' => $row['owner_firstname'],
        'owner_lastname' => $row['owner_lastname'],
        'phone_no' => $row['phone_no'],
        'email' => $row['email'],
        'images' => $room_images,
        'booked'=> in_array($row['id'],$roomIds)?1:0
    );
    // $properties['images'] = $prty_images;
}

$data = ['success' => true, 'data' => $properties];
echo json_encode($data);
