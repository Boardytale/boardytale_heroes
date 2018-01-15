import 'package:angular/src/core/metadata.dart';
import 'package:angular/src/common/directives/core_directives.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_components/material_input/material_number_accessor.dart';
import 'package:angular_forms/src/directives.dart';
import 'package:boardytale_heroes/src/components/shared/buttoned_number_input_component.dart';
import 'package:boardytale_heroes/src/services/heroes_service.dart';
import 'package:boardytale_heroes/src/services/items_service.dart';
import 'package:boardytale_heroes/src/model/model.dart';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

@Component(
  selector: 'edit-hero',
  template: '''
    <h1>Úprava hrdiny</h1>
  <div class="row">
    <div class="col-4">
    <h3>Vlastnosti postavy</h3>
         Jméno: <input [(ngModel)]="hero.name"><br>
         Síla: <buttoned-input [(value)]="hero.strength"></buttoned-input><br>
         Obratnost: <buttoned-input [(value)]="hero.agility"></buttoned-input><br>
         Inteligence: <buttoned-input [(value)]="hero.intelligence"></buttoned-input><br>
         Přesnost: <buttoned-input [(value)]="hero.precision" [decimal]="true"></buttoned-input><br>
         Spiritualita: <buttoned-input [(value)]="hero.spirituality" [decimal]="true"></buttoned-input> <br>
         Energie:  <buttoned-input [(value)]="hero.energy" [decimal]="true"></buttoned-input><br>
         Zkušenosti:  <buttoned-input [(value)]="hero.experience" [decimal]="true"></buttoned-input><br>
      <button (click)="save()">Uložit změny</button>
    
    </div>
    <div class="col-4">
    <h3>Předměty</h3>
      Hmotnost: {{hero.getItemSum().weight}} <br>
      Body zbroje: {{hero.getItemSum().armorPoints}} <br>
      Bonus k životu: {{hero.getItemSum().healthBonus}} <br>
      Bonus k maně: {{hero.getItemSum().manaBonus}} <br>
      Bonus k síle: {{hero.getItemSum().strengthBonus}} <br>
      Bonus k obratnosti: {{hero.getItemSum().agilityBonus}} <br>
      Bonus k inteligenci: {{hero.getItemSum().intelligenceBonus}}<br> 
      Bonus ke spiritualitě: {{hero.getItemSum().spiritualityBonus}}<br>
      Bonus k preciznosti: {{hero.getItemSum().precisionBonus}} <br>
      Bonus k energii: {{hero.getItemSum().energyBonus}} <br>
    
    </div>
    <div class="col-4">
    <h3>Zbraň</h3>
      Název: {{hero.getWeapon()?.name}}<br>
      Útočnost: {{hero.getWeapon()?.damage}}<br>
      Rozsah: {{hero.getWeapon()?.precision}}<br>
      Efektivní síla: {{hero.getWeapon()?.effectiveStrength}}<br>
      Efektivní obratnost: {{hero.getWeapon()?.effectiveIntelligence}}<br>
      Efektivní inteligence: {{hero.getWeapon()?.effectiveAgility}}<br>
      Maska útoku: {{hero.getWeapon()?.mask}}<br>
      <button (click)="removeWeapon()">Odebrat</button>
    
    </div>
  </div>
  <div class="row">
    <div class="col-4">
    <h3>Mezivýpočty</h3>
        Tělesná hmotnost: {{hero.getState().bodyWeight}}<br>
        Hmotnost výbavy: {{hero.getState().itemWeight}}<br>
        Hmotnost celkem: {{hero.getState().weight}}<br>
        Obratnost: {{hero.getState().agility}}<br>
        Síla: {{hero.getState().strength}}<br>
        Inteligence: {{hero.getState().intelligence}}<br>
        Základ počtu životů (6 + 2*síla): {{hero.getState().baseHealth}}<br>
        Bonus životů z nevyužitých bodů zbroje: {{hero.getState().armorHealth}} <br>
        Efektivita zbraně: {{hero.getState().efficiency}} <br>
    </div>
    <div class="col-4">
    <h3>Postava</h3>
        Úroveň: {{hero.getState().level}}<br>
        Životy: {{hero.getState().health}}<br>
        Zbroj: {{hero.getState().armor}}<br>
        Rychlost: {{hero.getState().speed}}<br>
        Útok {{hero.getState().attack}}<br>
    </div>
    <div class="col-4">
    <h3>Seznam vybavení</h3>
       <div *ngFor="let item of hero.items">{{item.name}}<button (click)="removeItem(item)">Odebrat</button></div>
    </div>
  </div>
  <br>
  <hr>
  <br>
  ''',
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
    materialNumberInputDirectives,
    formDirectives,
    ButtonedNumberInputComponent
  ],
  providers: const [ItemsService],
)
class EditHeroComponent {
  @Input("hero")
  Hero hero = new Hero();

  HeroesService heroService;

  EditHeroComponent(this.heroService);

  void save() {
    this.heroService.createOrEditHero(hero);
  }

  void removeWeapon() {
    hero.items.removeWhere((Item item) => item is Weapon);
    save();
  }

  void removeItem(Item item) {
    hero.items.removeWhere((Item value) => value == item);
    save();
  }
}
