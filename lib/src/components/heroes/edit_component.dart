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
         Hotovost:   <input type="number" [(ngModel)]="hero.money" step="1"><br>
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
      Body přesnosti: {{hero.getWeapon()?.precision}}<br>
      Efektivní síla: {{hero.getWeapon()?.effectiveStrength}}<br>
      Efektivní inteligence: {{hero.getWeapon()?.effectiveIntelligence}}<br>
      Efektivní obratnost: {{hero.getWeapon()?.effectiveAgility}}<br>
      Základní útok: {{hero.getWeapon()?.baseAttack}}<br>
      <button (click)="removeWeapon()">Odebrat</button>
    
    </div>
  </div>
  <div class="row">
    <div class="col-4">
    <h3>Mezivýpočty</h3>
        Tělesná hmotnost: {{hero.getState().bodyWeight}}<br>
        Hmotnost výbavy: {{hero.getState().itemWeight}}<br>
        Mana: {{hero.getState().mana}}<br>
        Obratnost: {{hero.getState().agility}}<br>
        Síla: {{hero.getState().strength}}<br>
        Inteligence: {{hero.getState().intelligence}}<br>
        Základ počtu životů (6 + 2*síla): {{hero.getState().baseHealth}}<br>
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
       <div *ngFor="let item of hero.items">{{item.name}} - {{item.getType()}}<button (click)="sellItem(item)">Prodat ({{(item.suggestedPrice / 2).floor()}})</button></div>
    </div>
  </div>
  <div class="row">
    <div class="col-3">
    <h3>Rychlost</h3>
        Hmotnost: {{hero.getState().weight}}<br>
        Obratnost: {{hero.getState().agility}}<br>
        Síla: {{hero.getState().strength}}<br>
        Body rychlosti: {{hero.getState().speedPoints.toStringAsFixed(2)}}<br>
        Rychlost: {{hero.getState().speed}}<br>
        Životy: {{hero.getState().unusedSpeedPointsHealth.toStringAsFixed(2)}}<br>
    </div>
    <div class="col-3">
    <h3>Zbroj</h3>
        Hmotnost: {{hero.getState().weight}}<br>
        Síla: {{hero.getState().strength}}<br>
        Obratnost: {{hero.getState().agility}}<br>
        Postih hmotností: {{hero.getState().fatWeight.toStringAsFixed(2)}}<br>
        Body z obratnosti: {{hero.getState().agilityArmorPoints.toStringAsFixed(2)}}<br>
        Body zbroje: {{hero.getState().armorPoints.toStringAsFixed(2)}}<br>
        Zbroj: {{hero.getState().armor}}<br>
        Životy: {{hero.getState().armorHealth.toStringAsFixed(2)}}<br>
    </div>
    <div class="col-3">
    <h3>Rozsah útoku</h3>
     Přesnost zbraně: {{hero.getWeapon()?.precision}}<br>
     Síla a obratnost: {{hero.getState().precisionOnAgilityAndStrength.toStringAsFixed(2)}}<br>
     Body přesnosti: {{hero.getState().precisionPoints.toStringAsFixed(2)}}<br>
     Přesnost: {{hero.getState().precision}}<br>
     Životy: {{hero.getState().unusedPrecisionHealth.toStringAsFixed(2)}}<br>
    </div>
    <div class="col-3">
    <h3>Síla útoku</h3>
     Obratnost: {{hero.getState().agility}}<br>
     Síla: {{hero.getState().strength}}<br>
     Inteligence: {{hero.getState().intelligence}}<br>
     Úroveň: {{hero.getState().level}}<br>
     Útok na úroveň: {{hero.getState().levelDamage.toStringAsFixed(2)}}<br>
     Efektivita: {{hero.getState().efficiency.toStringAsFixed(2)}} <br>
     Využití inteligence: {{hero.getState().intelligenceDistance?.toStringAsFixed(2)}} <br>
     Využití síly: {{hero.getState().strengthDistance?.toStringAsFixed(2)}} <br>
     Využití obratnosti: {{hero.getState().agilityDistance?.toStringAsFixed(2)}} <br>
     Plné využití: {{hero.getState().fullDistance?.toStringAsFixed(2)}} <br>
     Základní útok: {{hero.getWeapon()?.baseAttack}}<br>
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
  ]
)
class EditHeroComponent {
  @Input()
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

  void sellItem(Item item) {
    hero.items.removeWhere((Item value) => value == item);
    hero.money += (item.suggestedPrice / 2).floor();
    save();
  }
}
