import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ClienteService {
  private apiUrl = 'http://backend:8000/api'; // Asegúrate de que esta URL sea correcta

  constructor(private http: HttpClient) { }

  getTiposUsuario(): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/tipos-usuario`); // Uso correcto de la plantilla literal
  }

  getTiposDocumento(): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/tipos-documento`); // Uso correcto de la plantilla literal
  }
  getClientes(): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/pizzapaisa`); // Cambia la URL según sea necesario
}

  //updateCliente(usuario: any) {
   // const url = http://backend:8000/api/pizzapaisa/${usuario.UsuarioDocumento};
//return this.http.put(url, usuario);}

}
