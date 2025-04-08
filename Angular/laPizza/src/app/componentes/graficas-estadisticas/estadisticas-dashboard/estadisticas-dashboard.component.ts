import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { ChartConfiguration } from 'chart.js';
import { NgChartsModule } from 'ng2-charts';
import { CommonModule } from '@angular/common';
import { ChartOptions, ChartType, ChartData } from 'chart.js';


@Component({
  selector: 'app-estadisticas-dashboard',
  standalone: true,
  imports: [CommonModule, NgChartsModule,],
  templateUrl: './estadisticas-dashboard.component.html',
  styleUrls: ['./estadisticas-dashboard.component.css']
})
export class EstadisticasDashboardComponent implements OnInit {
  totalOrdenes = 0;
  totalPorciones = 0;
  promedioPorciones = 0;
  promedioValor = 0;
  totalIngresos = 0;

  ordenesPorDiaChart!: ChartData<'bar'>;
  ordenesPorDiaOptions: ChartOptions = { responsive: true };

  ordenesPorMesChart!: ChartData<'line'>;
  ordenesPorMesOptions: ChartOptions = { responsive: true };

  ventasPorSaborChart!: ChartData<'bar'>;
  ventasPorSaborOptions: ChartOptions = { responsive: true };

  topPizzasVendidasChart!: ChartData<'bar'>;
  topPizzasOptions: ChartOptions = {
    responsive: true,
    plugins: {
      legend: { position: 'top' },
      title: {
        display: true,
        text: 'Top Pizzas Vendidas'
      }
    }
  };

  constructor(private http: HttpClient) {}

  ngOnInit(): void {
    this.cargarResumen();
    this.cargarOrdenesPorDia();
    this.cargarOrdenesPorMes();
    this.cargarVentasPorSabor();
    this.cargarTopPizzasVendidas();
  }

  cargarResumen() {
    this.http.get<any>('http://localhost:8000/api/total-ordenes').subscribe(r => this.totalOrdenes = r.totalOrdenes);
    this.http.get<any>('http://localhost:8000/api/total-porciones-vendidas').subscribe(r => this.totalPorciones = r.total);
    this.http.get<any>('http://localhost:8000/api/promedio-porcion-orden').subscribe(r => this.promedioPorciones = r.promedioPorcionesPorOrden);
    this.http.get<any>('http://localhost:8000/api/promedio-valor-orden').subscribe(r => this.promedioValor = r.promedio);
    this.http.get<any>('http://localhost:8000/api/total-ingresos').subscribe(r => this.totalIngresos = r.totalIngresos);
  }

  cargarOrdenesPorDia() {
    this.http.get<any>('http://localhost:8000/api/total-ordenes-por-dia').subscribe(r => {
      const data = r.ordenesPorDia;
      this.ordenesPorDiaChart = {
        labels: data.map((d: any) => d.fecha),
        datasets: [{
          label: 'Órdenes por Día',
          data: data.map((d: any) => d.total),
          backgroundColor: '#3B82F6'
        }]
      };
    });
  }

  cargarOrdenesPorMes() {
    this.http.get<any>('http://localhost:8000/api/total-ordenes-por-mes').subscribe(r => {
      const data = r.ordenesPorMes;
      this.ordenesPorMesChart = {
        labels: data.map((d: any) => d.mes),
        datasets: [{
          label: 'Órdenes por Mes',
          data: data.map((d: any) => d.total),
          borderColor: '#10B981',
          fill: true,
          tension: 0.4
        }]
      };
    });
  }

  cargarVentasPorSabor() {
    this.http.get<any>('http://localhost:8000/api/ventas-por-sabor').subscribe(r => {
      const data = r.ventasPorSabor;
      this.ventasPorSaborChart = {
        labels: data.map((d: any) => d.Nombre_Pizza),
        datasets: [{
          label: 'Ventas por Sabor',
          data: data.map((d: any) => d.totalPorciones),
          backgroundColor: '#F59E0B'
        }]
      };
    });
  }

  cargarTopPizzasVendidas() {
    this.http.get<any>('http://localhost:8000/api/top-pizzas-vendidas').subscribe(data => {
      if (!data || data.length === 0) {
        console.warn('No hay datos de pizzas vendidas.');
        return;
      }
  
      this.topPizzasVendidasChart = {
        labels: data.map((d: any) => d.Nombre_Pizza),
        datasets: [{
          label: 'Top Pizzas Vendidas',
          data: data.map((d: any) => parseInt(d.NumeroPorcionesVendidas)), // 👈 convertimos a número
          backgroundColor: ['#42A5F5', '#66BB6A', '#FFA726', '#FF7043', '#AB47BC']
        }]
      };
    });
  }
  
  
}