<?php 

require_once 'dbConnection.php';

if(isset($_POST['login'])){
    trim(htmlspecialchars(string: extract($_POST)));

    $errors=[];

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

   if(empty($errors)){
    $query= "select `role` from users where `email`='$email' and `password`= '$password'";
    $result = mysqli_query($conn,$query);
    if(mysqli_num_rows($result)==1){
        $users= mysqli_fetch_assoc($result);
        if($users['role']===1){
            header("location:admin/view/layout.php");
        }else{
            header("location:shop.php");
        }
    }else{
        header("location:login.php");
    }
   }else{
    $_SESSION['email']= $email;
    $_SESSION['password']= $password;
    header("location:login.php");
   }


}else{
    header("location:login.php");
}