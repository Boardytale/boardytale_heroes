import 'package:angular/src/core/metadata.dart';

import 'package:angular/src/common/directives/core_directives.dart';

import 'package:angular_components/angular_components.dart';

import 'package:angular_components/material_input/material_number_accessor.dart';

import 'package:angular_forms/src/directives.dart';
import 'package:boardytale_heroes/src/services/heroes_service.dart';

import 'package:boardytale_heroes/src/services/items_service.dart';

import 'package:angular/src/core/metadata/lifecycle_hooks.dart';

import 'package:boardytale_heroes/src/model/model.dart';

import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

@Component(
  selector: 'edit-hero',
  template: '''
  <h1>Úprava hrdiny</h1>
     Jméno: <input [(ngModel)]="hero.name">
  <button (click)="save()">Uložit změny</button>
  ''',
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
    materialNumberInputDirectives,
    formDirectives
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
}
