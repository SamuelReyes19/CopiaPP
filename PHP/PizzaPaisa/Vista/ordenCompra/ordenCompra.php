<?php
    include("../../conectar/conexion.php");
    include('../../controlador/ordenCompraControlador.php');
    ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Orden de compra Pizzas</title>
    <link rel="stylesheet" href="../../Config/css/bootstrap.min.css">
    <link rel="stylesheet" href="../estilos.css">
    <script href="../Config/js/bootstrap.min.js"></script>
    <script src="https://kit.fontawesome.com/7e532953a9.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <script src="function.js"></script>
</head>
<body>
    <main id="mainadmin">
    
      <div class="modal fade" id="Ordenar" name=""   data-bs-keyboard="false" tabindex="-1" aria-labelledby="" aria-hidden="" style="color: Black;">
        <div class="modal-dialog">
            <div class="modal-content">
            <form action="" class="" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="staticBackdropLabel">Orden de Compra</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body row g-3">
                                     
                        <div class="col-md-6">
                                <label for="inputAddress" class="form-label">Id orden</label>
                                <input type="number" name="idOrden" id="" class="form-control" >
                        </div>
                        <div class="col-md-6">
                            <label for="inputAddress2" class="form-label">Fecha del Pedido</label>
                            <input type="date" name="FechaPedido" id="" class="form-control"  placeholder="">
                        </div>
                        <div class="col-md-6">
                                <label for="inputPassword4" class="UsuarioDocumento">Documento del usuario</label>
                                <input type="number" name="UsuarioDocumento" id="" value="" class="form-control">
                         </div>
                        
                        
                        
                     
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    <button type="submit"  href="UsuarioAdmin.php" name="guardar" class="btn btn-primary">Ordenar Compra</button>
                </div>
            </div>
            </form> 
         </div>
        </div>
</div>
    


<!-- modal editar-->
    <div class="modal fade" id="editar" name=""   data-bs-keyboard="false" tabindex="-1" aria-labelledby="" aria-hidden="" style="color: Black; ">
        <div class="modal-dialog">
            <div class="modal-content">
            <form action="" class="" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="staticBackdropLabel">Modificar</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" ></button>
                </div>
                <div class="modal-body row g-3">
                                     
                        <div class="col-md-6">
                                <label for="inputAddress" class="form-label">Id de la orden</label>
                                <input type="number" name="idOrden" id="idOrden" class="form-control" readonly>
                        </div>
                        <div class="col-md-6">
                            <label for="inputAddress2" class="form-label">Fecha de Pedido</label>
                            <input type="date" name="FechaPedido" id="FechaPedido" class="form-control"  placeholder="">
                        </div>
                        <div class="col-md-6">
                                <label for="inputPassword4" class="form-label">Documento del Usuario</label>
                                <input type="number" name="UsuarioDocumento" id="UsuarioDocumento" class="form-control" readonly>
                         </div>
                        
                        
                        
                     
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    <button type="submit"  href="UsuarioAdmin.php" name="modifica" class="btn btn-primary">modificar</button>
                </div>
            </div>
            </form> 
         </div>
        </div>
        <!-- Modal -->
        <div class="modal fade" class="botone" id="botoneliminar" name="Eliminar1" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <form action="" method="post">
              <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel" style="color:black">Eliminar</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" style="color: black;">
                            <div class="col-12">
                                    <label for="inputAddress" class="form-label">Id de la orden</label>
                                    <input type="text" name="idOrden" id="idOrden1" class="form-control"  >
                            </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" name="elimina" class="btn btn-danger">Confirmar</button>
                </div>
              </div>
             </form>
            </div>
        </div> 
        
    <div class="container-md bg-light mt-5 py-4 px-4" style ="width:1100px; ">
    
            
            
        <div class="container-fluid mb-3 mt-4 d-flex justify-content-between ">
            
            <form action="" method="post" id="form-buscar">
            <input class=" me-2 " id="mortorbusq" name="idOrden" type="search" placeholder="Buscar" aria-label="Search" style="width:400px;">
            <button class="btn btn-outline-success" name="buscar" value="buscar" type="submit">Buscar orden</button>
            </form>
            
    
           
        </div>
        
        <table  class="table border border-1 border-dark rounded-3 bg-light" id="latabla" >
         <thead class=" " id="succes" style = "background-color: #239227;">
        <tr style ="color: white;" >
            
            <th scope="col">Id de la Orden</th>
            <th scope="col">Fecha de la orden</th>
            <th scope="col">Documento del usuario</th>
            <th scope="col">Accion</th>
           
            

         </tr>
        </thead>
        <tbody>
            <?php
                $GAU = 1;
                if($res == 0){
                    echo "No hay registros";
                }else {
                    do{
            ?>
                <tr>
                
                
                <td><?php echo $res[0]?></td>
                <td><?php echo $res[1]?></td>
                <td><?php echo $res[2]?></td>
                
                
                <td><form  class="d-flex  justify-content-center align-items-center" action="" method="post">
                
                    <button type="button"   class="btn btn-sm btn-danger elimin" ><i class="fa-solid fa-trash"></i></button>
                    
                    <button type="button" class="btn btn-sm btn-primary boton editM "   style="color:black;" ><i class="fa-solid fa-pen-to-square"></i></buttom>
                    </form>
                </td>
                
                </tr>
                
            <?php
                    }while($res = mysqli_fetch_array($ejecuta));

                }

         
            ?>
        </tbody>
    </table>
    <nav aria-label="Page navigation example">
                <ul class="pagination justify-content-center">
                    <?php 
                    if($pagina!=1){
                    ?>
                    <li class="page-item ">
                        <a class="page-link" href="?pagina=<?php echo 1; ?>"><</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="?pagina=<?php echo $pagina-1; ?>"><<</a>
                    </li>
                    <?php
                    }
                    for($i=1; $i<=$totalPaginas; $i++){
                        if($i==$pagina){
                            echo'<li class="page-item active" aria-current="page"><a class="page-link" href="?pagina='.$i.'">'.$i.'</a></li>';    
                        }
                        else{
                            echo'<li class="page-item "><a class="page-link" href="?pagina='.$i.'">'.$i.'</a></li>'; 
                        }
                    }
                    if($pagina !=$totalPaginas){
                    ?>
                    
                    <li class="page-item">
                        <a class="page-link" href="?pagina=<?php echo $pagina+1; ?>">>></a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="?pagina=<?php echo $totalPaginas; ?>">></a>
                    </li>
                    <?php
                    }
                    ?>
                </ul>
            </nav>
</div>

    </main>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
   
        
        
</body>
</html>
<script>
    $(document).ready(function(){

            $('.editM').on('click', function(){
                $('#editar').modal('show');
                $tr = $(this).closest('tr');
                var data = $tr.children('td').map(function(){
                return $(this).text();    
                }).get();
                console.log(data);
                $('#idOrden').val(data[0]);
                $('#FechaPedido').val(data[1]);
                $('#UsuarioDocumento').val(data[2]);
                
                
    

            });

            $('.elimin').on('click', function(){
            $('#botoneliminar').modal('show');
            $tr = $(this).closest('tr');
            var data = $tr.children('td').map(function(){
            return $(this).text();    
            }).get();
            console.log(data);
            $('#idOrden1').val(data[0]);
            


        });

        });
  

        

</script>
