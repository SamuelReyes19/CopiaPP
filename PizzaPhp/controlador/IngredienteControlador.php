<?php
include('../../modelar/IngredienteModelo.php');

$obj = new Ingrediente();
if($_POST){
}

if(isset($_POST['guardar'])){
    
    $obj->idIngrediente = $_POST['idIngrediente'];
    $obj->Descripcion = $_POST['Descripcion'];
    $obj->Existenciaskg = $_POST['Existenciaskg'];
    $obj->agregar();
}

if(isset($_POST['modifica'])){

    $obj->idIngrediente = $_POST['idIngrediente'];
    $obj->Descripcion = $_POST['Descripcion'];
    $obj->Existenciaskg = $_POST['Existenciaskg'];
    $obj->modificar();
    
}

if(isset($_POST['elimina'])){
    $obj->idIngrediente = $_POST['idIngrediente'];
    
    $obj->eliminar();
}

$cone  = new Conexion();
$c=$cone->conectando();
$sql1="select count(*) as totalRegistro from ingrediente";
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
    $obj->idIngrediente = $_POST['idIngrediente'];
   

  $sql2="select * from ingrediente where idIngrediente LIKE '%$obj->idIngrediente%' limit $desde,$maximoRegistros ";
  $ejecuta=mysqli_query($c,$sql2);
  $res = mysqli_fetch_array($ejecuta);
  }else{
         $sql2="select * from ingrediente limit $desde,$maximoRegistros ";
         $ejecuta=mysqli_query($c,$sql2);
         $res = mysqli_fetch_array($ejecuta);
  }

  if(isset($_POST['listar'])){
       
    
    

  }



?>