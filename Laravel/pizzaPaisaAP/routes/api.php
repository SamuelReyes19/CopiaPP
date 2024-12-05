<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\usuarioControlador;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/
Route::post('/login',[usuarioControlador::class,'login']);
Route::get('/pizzapaisa',[usuarioControlador::class,'index']);
Route::post('/pizzapaisa',[usuarioControlador::class, 'store']);
Route::get('/pizzapaisa/{UsuarioDocumento}',[usuarioControlador::class, 'show']);
Route::put('/pizzapaisa/{UsuarioDocumento}',[usuarioControlador::class, 'update']);
Route::delete('/pizzapaisa/{UsuarioDocumento}',[usuarioControlador::class,'destroy']);
