import { Component, ChangeDetectorRef } from '@angular/core';
import { FormBuilder, FormGroup, FormArray } from '@angular/forms';
import { HttpClient } from '@angular/common/http';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule } from '@angular/forms';

@Component({
  selector: 'app-orden',
  standalone: true,
  templateUrl: './orden.component.html',
  styleUrls: ['./orden.component.css'],
  imports: [CommonModule, ReactiveFormsModule]
})
export class OrdenComponent {
  form: FormGroup;
  ingredientes = [
    { id: 'Act', nombre: 'Aceitunas' },
    { id: 'Cbll', nombre: 'Cebolla' },
    { id: 'Cdr', nombre: 'Carne de Res' },
    { id: 'Chpm', nombre: 'Champiñones' },
    { id: 'Chz', nombre: 'Chorizo' },
    { id: 'Cra', nombre: 'Cereza Almibar' },
    { id: 'Drl', nombre: 'Duraznos Almibar' },
    { id: 'jlp', nombre: 'Jalapeños' },
    { id: 'Jm', nombre: 'Jamón' },
    { id: 'Mng', nombre: 'Mango' },
    { id: 'Ms', nombre: 'Masa' },
    { id: 'Mz', nombre: 'Maíz' },
    { id: 'Pll', nombre: 'Pollo' },
    { id: 'Plt', nombre: 'Plátano' },
    { id: 'Pmto', nombre: 'Pimiento' },
    { id: 'Pna', nombre: 'Piña' },
    { id: 'Pprn', nombre: 'Pepperoni' },
    { id: 'Pst', nombre: 'Pasta de Tomate' },
    { id: 'Qs', nombre: 'Queso' },
    { id: 'sBBQ', nombre: 'Salsa BBQ' },
    { id: 'Slch', nombre: 'Salchicha' },
    { id: 'Tcn', nombre: 'Tocino' },
    { id: 'Uvp', nombre: 'Uvas Pasas' }
  ];

  constructor(
    private http: HttpClient,
    private fb: FormBuilder,
    private cdRef: ChangeDetectorRef
  ) {
    this.form = this.fb.group({
      items: this.fb.array([])
    });
  }

  get items(): FormArray {
    return this.form.get('items') as FormArray;
  }

  addItem() {
    const itemGroup = this.fb.group({
      idIngrediente: [''],
      CantidadComprada: ['']
    });

    // Reiniciar campos antes de agregar
    itemGroup.reset({ idIngrediente: '', CantidadComprada: '' });

    this.items.push(itemGroup);
    this.cdRef.detectChanges(); // Forzar actualización visual
  }

  removeItem(index: number) {
    this.items.removeAt(index);
  }

  onSubmit() {
    if (this.form.valid) {
      const datos = this.form.value;
      this.http.post('http://127.0.0.1:8000/api/orden-ingrediente', datos)
        .subscribe({
          next: (response) => {
            console.log('Datos enviados exitosamente', response);
            alert("Orden registrada con éxito");
          },
          error: (error) => {
            console.log('Error al enviar los datos', error);
          }
        });
    } else {
      console.log('Formulario inválido');
    }
  }
}