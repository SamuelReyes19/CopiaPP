<?php

namespace App\Http\Controllers;
use App\Models\OrdenCompraModelo;
use App\Models\OrdenIngredienteModelo;
use App\Http\Controllers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class OrdenIngredienteControlador extends Controller
{
    public function store(Request $request){
        // Cambiamos validación para aceptar arreglo de items
        $validacion = Validator::make($request->all(), [
            'items' => 'required|array|min:1',
            'items.*.idIngrediente' => 'required|string',
            'items.*.CantidadComprada' => 'required|numeric'
        ]);

        if($validacion->fails()){
            $data = [
                'message' => 'Error en la validacion de datos',
                'errors' => $validacion->errors(),
                'status' => 200
            ];
            return response()->json($data, 400);
        }

        $ordenes = [];
        $idOrden = OrdenCompraModelo::max('idOrden');

        // Recorremos cada item enviado desde Angular
        foreach ($request->items as $item) {
            $ordenIngrediente = OrdenIngredienteModelo::create([
                'idOrden' => $idOrden,
                'idIngrediente' => $item['idIngrediente'],
                'CantidadSolicitada' => 0,
                'idProveedor' => 1,
                'CantidadComprada' => $item['CantidadComprada'],
            ]);

            $ordenes[] = $ordenIngrediente;
        }

        $data = [
            'Orden Ingrediente' => $ordenes,
            'status' => 201
        ];
        return response()->json($data, 201);
    }
}
