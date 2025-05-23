import { ComponentFixture, TestBed } from '@angular/core/testing';

import { IframesComponent } from './iframes.component';

describe('IframesComponent', () => {
  let component: IframesComponent;
  let fixture: ComponentFixture<IframesComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [IframesComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(IframesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
