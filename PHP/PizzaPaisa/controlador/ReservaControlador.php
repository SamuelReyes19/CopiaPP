<?php
include('../../modelar/ReservaModelo.php');

$obj = new Reserva();
if($_POST){
}

if(isset($_POST['guardar'])){
    
    $obj->idPedido = $_POST['idPedido'];
    $obj->FechaHoraRealizacio = $_POST['FechaHoraRealizacio'];
    $obj->Entregada = $_POST['Entregada'];
    $obj->FechaHoraEntrega = $_POST['FechaHoraEntrega'];
    $obj->PrecioTotal = $_POST['PrecioTotal'];
    $obj->UsuarioDocumento = $_POST['UsuarioDocumento'];
    $obj->agregar();
}

if(isset($_POST['modifica'])){

    
    $obj->idPedido = $_POST['idPedido'];
    $obj->FechaHoraRealizacio = $_POST['FechaHoraRealizacio'];
    $obj->Entregada = $_POST['Entregada'];
    $obj->FechaHoraEntrega = $_POST['FechaHoraEntrega'];
    $obj->PrecioTotal = $_POST['PrecioTotal'];
    $obj->UsuarioDocumento = $_POST['UsuarioDocumento'];
    $obj->modificar();
    
}

if(isset($_POST['elimina'])){
    $obj->idPedido = $_POST['idPedido'];
    
    $obj->eliminar();
}

$cone  = new Conexion();
$c=$cone->conectando();
$sql1="select count(*) as totalRegistro from reserva";
$ejecuta1=mysqli_query($c,$sql1);
$res1 = mysqli_fetch_array($ejecuta1);
$totalRegistros = $res1['totalRegistro'];
$maximoRegistros = 6;
 if(empty($_GET['pagina'])){
     $pagina=1;
 }else{
     $pagina=$_GET['pagina'];
 }
 $desde = ($pagina-1)*$maximoRegistros;
 $totalPaginas=ceil($totalRegistros/$maximoRegistros);
if(isset($_POST['buscar'])){
    $obj->idPedido = $_POST['idPedido'];
   

  $sql2="select * from reserva where idPedido LIKE '%$obj->idPedido%' limit $desde,$maximoRegistros ";
  $ejecuta=mysqli_query($c,$sql2);
  $res = mysqli_fetch_array($ejecuta);
  }else{
         $sql2="select * from reserva limit $desde,$maximoRegistros ";
         $ejecuta=mysqli_query($c,$sql2);
         $res = mysqli_fetch_array($ejecuta);
  }

  if(isset($_POST['listar'])){
       
    
    

  }



?>