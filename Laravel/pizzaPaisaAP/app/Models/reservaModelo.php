<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\Model;


class reservaModelo extends Model
{
    use HasFactory, Notifiable;

    protected $table = 'reserva';
    public $timestamps = true;
    protected $primaryKey = 'idPedido';
    public $incrementing = true;
    protected $keyType = 'int';
    protected $fillable = [
        'idPedido',
        'Entregada',
        'FechaHoraEntrega',
        'PrecioTotal',
        'UsuarioDocumento'
    ];
}