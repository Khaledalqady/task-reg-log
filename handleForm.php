<?php 

require_once 'dbConnection.php';

if(isset($_POST['signup'])){
  trim(htmlspecialchars(string: extract($_POST)));

  $errors=[];

  if(empty($UserName)){
    $errors[]= "username required";

    if(! is_string($UserName)){
        $errors[]= "alphabetic only";
    }
    if(empty($email)){
        $errors[]= "email required";
    }
   if(!filter_var($email,FILTER_VALIDATE_EMAIL)){
    $errors[]= "email must be valid";
   }
   if(empty($password)){
    $errors[]= "password required";
   }
   if(!is_string($password)){
    $errors[]= "password must be character and number";
   }
   if(strlen($password)<8){
    $errors[]= "password must be more than 8 character";
   }
   if(empty($phone)){
    $errors[]= "phone required";
   }
   if(! is_numeric($phone)){
    $errors[]= "phone must be number";
   }

   if(empty($address)){
    $errors[]= "address required";
   }
}
   if(empty($errors)){
      $query= "insert into users (`username`,`email`,`password`,`phone`,`address`) values
      ('$UserName','$email','$password','$phone','$address')";
      $result= mysqli_query($conn,$query);
   }else{
    $_SESSION['username']= $UserName;
    $_SESSION['email']= $email;
    $_SESSION['password']= $password;
    $_SESSION['phone']= $phone;
    $_SESSION['address']= $address;
    $_SESSION['errors']= $errors;
    header("location:signup.php");

   }
 
}else{
    header("location:signup.php");
}


?>