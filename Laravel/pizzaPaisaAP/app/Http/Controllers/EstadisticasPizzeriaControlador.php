<?php

namespace App\Http\Controllers;

use App\Models\lineaModelo;
use App\Http\Controllers;
use App\Models\SaborModelos;
use App\Models\reservaModelo;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;

class EstadisticasPizzeriaControlador extends Controller
{
    public function topPizzasVendidas()
    {
        // Obtener las pizzas más vendidas
        $topPizzas = DB::table('linea')
        ->join('reserva', 'linea.idPedido', '=', 'reserva.idPedido') // Hacemos un JOIN entre 'linea' y 'reserva'
        ->select('linea.idSabor', DB::raw('SUM(linea.NumeroPorciones) as total_porciones'))
        ->where('reserva.Entregada', 1) // Filtramos por reservas entregadas
        ->groupBy('linea.idSabor')
        ->orderByDesc('total_porciones')
        ->limit(5)
        ->get();

        // Verificar si no hay registros
        if ($topPizzas->isEmpty()) {
            $data = [
                'message' => 'No se encontraron datos de pizzas vendidas.',
                'status' => 404
            ];
            return response()->json($data, 404);
        }

        // Recuperar la información de las pizzas más vendidas con los nombres y precios
        $result = [];
        foreach ($topPizzas as $pizza) {
            $sabor = SaborModelos::where('idSabor', $pizza->idSabor)->first();

            $result[] = [
                'Nombre_Pizza' => $sabor ? $sabor->Nombre_Pizza : 'Desconocida',
                'NumeroPorcionesVendidas' => $pizza->total_porciones,
                'PrecioPorcion' => $sabor ? $sabor->Precio_Porcion : 'Desconocido'
            ];
        }

        // Devolver los resultados en formato JSON
        return response()->json($result, 200);
    }

    public function promedioValorPorOrden()
    {
    $promedio = (float) DB::table('reserva')->avg('PrecioTotal');

    return response()->json([
        'promedio' => $promedio
    ]);
    }

        public function totalPorcionesVendidas()
    {
        
        $totalPorciones = lineaModelo::sum('NumeroPorciones');

        return response()->json([
            'total' => $totalPorciones
        ]);
        
    }

    public function totalDeOrdenes(){
        

        $totalOrdenes = lineaModelo::count('idPedido');
        return response()->json([
            'totalOrdenes'=> $totalOrdenes
        ]);
        
    }

    public function promedioPorcionesPorOrden()
    {
        $totalPorciones = LineaModelo::sum('NumeroPorciones'); // Suma total de porciones pedidas
        $totalOrdenes = Pedido::count(); // Total de órdenes registradas

        $promedio = $totalOrdenes > 0 ? $totalPorciones / $totalOrdenes : 0;

        return response()->json([
            'promedioPorcionesPorOrden' => round($promedio, 2) // Redondeado a 2 decimales
        ]);
    }
}
