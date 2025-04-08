import { ComponentFixture, TestBed } from '@angular/core/testing';

import { VentasSaborComponent } from './ventas-sabor.component';

describe('VentasSaborComponent', () => {
  let component: VentasSaborComponent;
  let fixture: ComponentFixture<VentasSaborComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [VentasSaborComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(VentasSaborComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
