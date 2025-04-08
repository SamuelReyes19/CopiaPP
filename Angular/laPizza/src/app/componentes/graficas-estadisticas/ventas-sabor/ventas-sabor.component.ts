import { Component, OnInit} from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { ChartConfiguration } from 'chart.js';
import { NgChartsConfiguration } from 'ng2-charts';
import { CommonModule } from '@angular/common';
import { NgChartsModule } from 'ng2-charts';

@Component({
  selector: 'app-ventas-sabor',
  standalone: true,
  imports: [CommonModule, NgChartsModule],
  templateUrl: './ventas-sabor.component.html',
  styleUrls: ['./ventas-sabor.component.css']
})
export class VentasSaborComponent implements OnInit {
  public barChartData: ChartConfiguration<'bar'>['data'] = {
    labels: [],
    datasets: [
      { data: [], label: 'Porciones vendidas por sabor' }
    ]
  };

  constructor(private http: HttpClient) {}

  ngOnInit(): void {
    this.http.get<any>('http://localhost:8000/api/ventas-por-sabor').subscribe(res => {
      const datos = res.ventasPorSabor;
      console.log('Datos recibidos:', datos); // 👈 Verifica esto en la consola
      this.barChartData.labels = datos.map((d: any) => d.Nombre_Pizza);
      this.barChartData.datasets[0].data = datos.map((d: any) => Number(d.totalPorciones));
    });
  }

  public barChartOptions: ChartConfiguration<'bar'>['options'] = {
    responsive: true,
    plugins: {
      legend: {
        display: true,
        position: 'top',
      },
      title: {
        display: true,
        text: 'Ventas de Pizzas por Sabor'
      }
    }
  };
}


