import { Component } from '@angular/core';
import { FormBuilder, FormGroup, FormArray, FormControl, ReactiveFormsModule } from '@angular/forms';
import { HttpClient } from '@angular/common/http';
import { CommonModule } from '@angular/common';

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

  pizzasDisponibles = [
    { id: 'Crt', nombre: 'Pizza Carne Tradicional' },
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

  setFechasValidas() {
    const ahora = new Date();
    ahora.setMinutes(0);
    ahora.setSeconds(0);

    const mañana = new Date();
    mañana.setDate(mañana.getDate() + 1);
    mañana.setHours(23, 30, 0, 0);

    this.minFechaHora = ahora.toISOString().slice(0, 16);
    this.maxFechaHora = mañana.toISOString().slice(0, 16);
  }

  onSubmit() {
    if (this.form.valid) {
      const datos = this.form.value;
      const pizzasSeleccionadas = datos.pizzas.filter((pizza: { NumeroPorciones: number }) => pizza.NumeroPorciones > 0);

      if (pizzasSeleccionadas.length === 0) {
        alert("Debe seleccionar al menos una pizza con porciones.");
        return;
      }

      const TotalPrecio = pizzasSeleccionadas.reduce((acc: number, item: { NumeroPorciones: number }) => acc + item.NumeroPorciones * 14000, 0);

      this.http.post('http://127.0.0.1:8000/api/reserva', {
        FechaHoraEntrega: datos.FechaHoraEntrega,
        PrecioTotal: TotalPrecio,
        UsuarioDocumento: localStorage.getItem('documento')
      }).subscribe({
        next: (response) => {
          console.log('Reserva creada con éxito', response);
          alert("Reserva exitosa");

          pizzasSeleccionadas.forEach((item: any) => {
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

    } else {
      console.log('Formulario inválido');
    }
  }
}
