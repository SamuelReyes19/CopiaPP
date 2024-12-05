<?php
include('../../modelar/SaborModelo.php');

$obj = new Sabor();
if($_POST){
}

if(isset($_POST['guardar'])){
    
    $obj->idSabor = $_POST['idSabor'];
    $obj->NombrePizza = $_POST['NombrePizza'];
    $obj->PrecioPorcion = $_POST['PrecioPorcion'];
    $obj->agregar();
}

if(isset($_POST['modifica'])){
    $obj->idSabor = $_POST['idSabor'];
    $obj->NombrePizza = $_POST['NombrePizza'];
    $obj->PrecioPorcion = $_POST['PrecioPorcion'];
    $obj->modificar();
    
}

if(isset($_POST['elimina'])){
    $obj->idSabor = $_POST['idSabor'];
    $obj->eliminar();
}

$cone  = new Conexion();
$c=$cone->conectando();
$sql1="select count(*) as totalRegistro from sabor";
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
    $obj->idPedido = $_POST['idSabor'];
   

  $sql2="select * from sabor where idSabor LIKE '%$obj->idSabor%' limit $desde,$maximoRegistros ";
  $ejecuta=mysqli_query($c,$sql2);
  $res = mysqli_fetch_array($ejecuta);
  }else{
         $sql2="select * from sabor limit $desde,$maximoRegistros ";
         $ejecuta=mysqli_query($c,$sql2);
         $res = mysqli_fetch_array($ejecuta);
  }

  if(isset($_POST['listar'])){
       
    
    

  }



?>