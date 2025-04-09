import { Component } from '@angular/core';
import { FormBuilder, FormGroup, FormArray, FormControl, ReactiveFormsModule } from '@angular/forms';
import { HttpClient } from '@angular/common/http';
import { CommonModule } from '@angular/common';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-reserva',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './reserva.component.html',
  styleUrl: './reserva.component.css'
})
export class ReservaComponent {
  form: FormGroup;
  minFechaHora: string = '';
  maxFechaHora: string = '';
  resumenPedido: any = {};

  pizzasDisponibles = [
    { id: 'Crt', nombre: 'Pizza Carne' },
    { id: 'PcBBQ', nombre: 'Pizza de CarneBBQ' },
    { id: 'Phw', nombre: 'Pizza Hawaiana' },
    { id: 'Pllc', nombre: 'Pollo Champiñones' },
    { id: 'Pm', nombre: 'Pizza de Maduro' },
    { id: 'Pmt', nombre: 'Pizza MangoTocineta' },
    { id: 'Pmx', nombre: 'Pizza Mexicana' },
    { id: 'Pps', nombre: 'Pizza Paisa' },
    { id: 'Prh', nombre: 'Pizza Ranchera' },
    { id: 'Ptrp', nombre: 'Pizza Tropical' }
  ];

  constructor(private fb: FormBuilder, private http: HttpClient) {
    this.form = this.fb.group({
      FechaHoraEntrega: [''],
      pizzas: this.fb.array(this.pizzasDisponibles.map(pizza => this.crearPizzaFormGroup(pizza)))
    });

    this.setFechasValidas();
  }

  crearPizzaFormGroup(pizza: { id: string; nombre: string }): FormGroup {
    return this.fb.group({
      idSabor: [pizza.id],
      NumeroPorciones: [0]
    });
  }

  get pizzas(): FormArray {
    return this.form.get('pizzas') as FormArray;
  }

  esFechaValida(fechaHoraStr: string): boolean {
    const fecha = new Date(fechaHoraStr);
    const dia = fecha.getDay();
    const hora = fecha.getHours();
    const minutos = fecha.getMinutes();

    if (![5, 6, 0].includes(dia)) return false;
    if (hora < 15 || hora > 22 || (hora === 22 && minutos > 30)) return false;
    if (minutos !== 0 && minutos !== 30) return false;

    return true;
  }

  setFechasValidas() {
    const hoy = new Date();
    const dia = hoy.getDay();

    let diasHastaFin = 0;

    if (dia === 5 || dia === 6 || dia === 0) {
      diasHastaFin = 0;
    } else {
      diasHastaFin = (5 + 7 - dia) % 7;
    }

    const fechaMin = new Date(hoy);
    fechaMin.setDate(hoy.getDate() + diasHastaFin);
    fechaMin.setHours(15, 0, 0, 0);

    const fechaMax = new Date(fechaMin);
    fechaMax.setDate(fechaMax.getDate() + 1);
    fechaMax.setHours(23, 0, 0, 0);

    this.minFechaHora = fechaMin.toISOString().slice(0, 16);
    this.maxFechaHora = fechaMax.toISOString().slice(0, 16);

    console.log('Día actual:', dia, 'Min:', this.minFechaHora, 'Max:', this.maxFechaHora);
  }

  validarFechaHora() {
    const fechaHora = this.form.get('FechaHoraEntrega')?.value;
    if (!this.esFechaValida(fechaHora)) {
      Swal.fire({
        icon: 'error',
        title: 'Fecha y hora inválida',
        text: 'Debe ser viernes, sábado o domingo entre 3:00 PM y 11:00 PM en intervalos de 30 minutos.'
      });
      this.form.get('FechaHoraEntrega')?.setValue('');
    }
  }



  prepararResumen() {
    const datos = this.form.value;
    const pizzasSeleccionadas = datos.pizzas
      .map((pizza: any, index: number) => ({
        ...pizza,
        nombre: this.pizzasDisponibles[index].nombre
      }))
      .filter((pizza: { NumeroPorciones: number }) => pizza.NumeroPorciones > 0);

    if (pizzasSeleccionadas.length === 0) {
      Swal.fire({
        icon: 'warning',
        title: 'Atención',
        text: 'Debe seleccionar al menos una pizza con porciones.'
      });
      return;
    }

    if (!this.esFechaValida(datos.FechaHoraEntrega)) {
      Swal.fire({
        icon: 'error',
        title: 'Fecha no válida',
        text: 'La fecha/hora debe ser viernes, sábado o domingo entre 3:00 PM y 11:00 PM, en intervalos de 30 minutos.'
      });
      return;
    }

    const TotalPrecio = pizzasSeleccionadas.reduce((acc: number, item: { NumeroPorciones: number }) => acc + item.NumeroPorciones * 14000, 0);

    this.resumenPedido = {
      FechaHoraEntrega: datos.FechaHoraEntrega,
      pizzas: pizzasSeleccionadas,
      TotalPrecio: TotalPrecio
    };
  }


  confirmarReserva() {
    if (!this.resumenPedido.FechaHoraEntrega || this.resumenPedido.pizzas.length === 0) {
      Swal.fire({
        icon: 'error',
        title: 'Datos incompletos',
        text: 'No hay datos válidos para la reserva. Asegúrate de seleccionar una fecha de entrega y al menos una pizza.',
        confirmButtonText: 'OK'
      });
      return;
    }


    this.http.post('http://127.0.0.1:8000/api/reserva', {
      FechaHoraEntrega: this.resumenPedido.FechaHoraEntrega,
      PrecioTotal: this.resumenPedido.TotalPrecio,
      UsuarioDocumento: localStorage.getItem('documento')
    }).subscribe({
      next: (response) => {
        console.log('Reserva creada con éxito', response);
        Swal.fire({
          position: "top",
          icon: "success",
          title: "Reserva creada con exito",
          showConfirmButton: false,
          timer: 3000
        });

        this.resumenPedido.pizzas.forEach((item: any) => {
          this.http.post('http://127.0.0.1:8000/api/linea', item).subscribe({
            next: (res) => console.log('Item enviado exitosamente', res),
            error: (err) => console.log('Error al enviar el item', err)
          });
        });
      },
      error: (error) => {
        console.log('Error al enviar la reserva', error);
      }
    });
  }
}
