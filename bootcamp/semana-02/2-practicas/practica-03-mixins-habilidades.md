# 💻 Práctica 3: Mixins - Sistema de Habilidades

**⏱️ Duración:** 45 minutos  
**📊 Dificultad:** ⭐⭐⭐ Media-Alta  
**🎯 Conceptos:** Mixins, herencia, composición, polimorfismo

---

## 🎯 Objetivo

Crear un **sistema de personajes con habilidades** usando mixins para demostrar composición de comportamientos sin herencia múltiple.

---

## 📚 Conceptos que Aplicaremos

- ✅ Mixins con `mixin` keyword
- ✅ Aplicar mixins con `with`
- ✅ Herencia con `extends`
- ✅ Composición de comportamientos
- ✅ Interfaces implícitas
- ✅ Polimorfismo

---

## 🖼️ Resultado Esperado

```
╔═══════════════════════════════════════════╗
║      SISTEMA DE PERSONAJES - RPG          ║
╚═══════════════════════════════════════════╝

🏹 CREANDO PERSONAJES
═══════════════════════════════════════════

⚔️ Guerrero: Thorin
   HP: 150/150 | MP: 50/50
   Nivel: 5

🧙 Mago: Gandalf
   HP: 80/80 | MP: 200/200
   Nivel: 8

🏹 Arquero: Legolas
   HP: 100/100 | MP: 80/80
   Nivel: 6

🗡️ Asesino: Ezio
   HP: 90/90 | MP: 70/70
   Nivel: 7

⚡ BATALLA DEMO
═══════════════════════════════════════════

Thorin ataca con espada! (Daño: 45)
Thorin realiza un ataque crítico! (Daño: 90)
Thorin se defiende! (Defensa: 30)

Gandalf lanza bola de fuego! ⚡
  Consumió 20 MP
  HP: 80/80 | MP: 180/200

Gandalf teletransporta! ✨
  Consumió 30 MP
  HP: 80/80 | MP: 150/200

Legolas dispara flecha! 🏹 (Daño: 35)
Legolas dispara flecha rápida! (Daño: 20)
Legolas se oculta en las sombras...

Ezio se oculta en las sombras...
Ezio ataca desde las sombras! (Daño crítico: 150)
Ezio ataca con veneno! (Daño + veneno)

🎯 HABILIDADES ESPECIALES
═══════════════════════════════════════════

Thorin puede:
  ⚔️ Atacar con espada
  🛡️ Defenderse
  💥 Ataque crítico

Gandalf puede:
  🔥 Lanzar bola de fuego
  ❄️ Lanzar rayo de hielo
  ✨ Teletransportar

Legolas puede:
  🏹 Disparar flechas
  👻 Ocultarse
  ⚡ Ataque rápido

Ezio puede:
  👻 Ocultarse
  🗡️ Ataque sigiloso
  ☠️ Ataque con veneno
```

---

## 📋 Instrucciones

### Paso 1: Clase Base Character (10 min)

```dart
/**
 * Clase base para todos los personajes
 */
class Character {
  String name;
  int level;
  int maxHp;
  int currentHp;
  int maxMp;
  int currentMp;

  Character({
    required this.name,
    required this.level,
    required this.maxHp,
    required this.maxMp,
  })  : currentHp = maxHp,
        currentMp = maxMp;

  void takeDamage(int damage) {
    currentHp = (currentHp - damage).clamp(0, maxHp);
    print('$name recibe $damage de daño! (HP: $currentHp/$maxHp)');
  }

  void heal(int amount) {
    currentHp = (currentHp + amount).clamp(0, maxHp);
    print('$name se cura $amount HP! (HP: $currentHp/$maxHp)');
  }

  void consumeMp(int amount) {
    currentMp = (currentMp - amount).clamp(0, maxMp);
  }

  void restoreMp(int amount) {
    currentMp = (currentMp + amount).clamp(0, maxMp);
  }

  void displayStats() {
    print('$name');
    print('   HP: $currentHp/$maxHp | MP: $currentMp/$maxMp');
    print('   Nivel: $level');
  }

  bool get isAlive => currentHp > 0;
  bool get hasMp => currentMp > 0;
}
```

### Paso 2: Definir Mixins de Habilidades (15 min)

```dart
/**
 * Mixin para combate cuerpo a cuerpo
 */
mixin MeleeAttack {
  int get meleeDamage;

  void swordAttack() {
    print('${(this as Character).name} ataca con espada! (Daño: $meleeDamage)');
  }

  void criticalHit() {
    var damage = meleeDamage * 2;
    print('${(this as Character).name} realiza un ataque crítico! (Daño: $damage)');
  }
}

/**
 * Mixin para defensa
 */
mixin Defense {
  int get defenseValue;

  void defend() {
    print('${(this as Character).name} se defiende! (Defensa: $defenseValue)');
  }

  void block() {
    print('${(this as Character).name} bloquea el ataque!');
  }
}

/**
 * Mixin para magia
 */
mixin Magic {
  int get magicPower;

  void castFireball() {
    var character = this as Character;
    if (character.currentMp >= 20) {
      character.consumeMp(20);
      print('${character.name} lanza bola de fuego! 🔥');
      print('  Consumió 20 MP');
      character.displayStats();
    } else {
      print('${character.name} no tiene suficiente MP!');
    }
  }

  void castIceBolt() {
    var character = this as Character;
    if (character.currentMp >= 15) {
      character.consumeMp(15);
      print('${character.name} lanza rayo de hielo! ❄️');
      print('  Consumió 15 MP');
    } else {
      print('${character.name} no tiene suficiente MP!');
    }
  }

  void teleport() {
    var character = this as Character;
    if (character.currentMp >= 30) {
      character.consumeMp(30);
      print('${character.name} teletransporta! ✨');
      print('  Consumió 30 MP');
      character.displayStats();
    } else {
      print('${character.name} no tiene suficiente MP!');
    }
  }
}

/**
 * Mixin para ataques a distancia
 */
mixin RangedAttack {
  int get rangedDamage;

  void shootArrow() {
    print('${(this as Character).name} dispara flecha! 🏹 (Daño: $rangedDamage)');
  }

  void rapidFire() {
    var damage = (rangedDamage * 0.6).round();
    print('${(this as Character).name} dispara flecha rápida! (Daño: $damage)');
  }
}

/**
 * Mixin para sigilo
 */
mixin Stealth {
  bool _isHidden = false;

  bool get isHidden => _isHidden;

  void hide() {
    _isHidden = true;
    print('${(this as Character).name} se oculta en las sombras...');
  }

  void reveal() {
    _isHidden = false;
    print('${(this as Character).name} sale de las sombras!');
  }

  void sneakAttack() {
    var character = this as Character;
    if (_isHidden) {
      _isHidden = false;
      print('${character.name} ataca desde las sombras! (Daño crítico: 150)');
    } else {
      print('${character.name} debe estar oculto para atacar sigilosamente!');
    }
  }
}

/**
 * Mixin para veneno
 */
mixin Poison {
  void poisonAttack() {
    print('${(this as Character).name} ataca con veneno! (Daño + veneno)');
  }

  void applyPoison() {
    print('${(this as Character).name} aplica veneno al arma...');
  }
}
```

### Paso 3: Crear Clases de Personajes (10 min)

```dart
/**
 * Guerrero - Combate cuerpo a cuerpo y defensa
 */
class Warrior extends Character with MeleeAttack, Defense {
  @override
  int get meleeDamage => 45;

  @override
  int get defenseValue => 30;

  Warrior(String name, int level)
      : super(
          name: name,
          level: level,
          maxHp: 150,
          maxMp: 50,
        );
}

/**
 * Mago - Especialista en magia
 */
class Mage extends Character with Magic {
  @override
  int get magicPower => 80;

  Mage(String name, int level)
      : super(
          name: name,
          level: level,
          maxHp: 80,
          maxMp: 200,
        );
}

/**
 * Arquero - Ataque a distancia y sigilo
 */
class Archer extends Character with RangedAttack, Stealth {
  @override
  int get rangedDamage => 35;

  Archer(String name, int level)
      : super(
          name: name,
          level: level,
          maxHp: 100,
          maxMp: 80,
        );
}

/**
 * Asesino - Sigilo, veneno y ataques críticos
 */
class Assassin extends Character with Stealth, Poison, MeleeAttack {
  @override
  int get meleeDamage => 40;

  Assassin(String name, int level)
      : super(
          name: name,
          level: level,
          maxHp: 90,
          maxMp: 70,
        );
}

/**
 * Paladín - Combate, defensa y algo de magia
 */
class Paladin extends Character with MeleeAttack, Defense, Magic {
  @override
  int get meleeDamage => 40;

  @override
  int get defenseValue => 35;

  @override
  int get magicPower => 50;

  Paladin(String name, int level)
      : super(
          name: name,
          level: level,
          maxHp: 130,
          maxMp: 100,
        );

  // Habilidad especial de Paladín
  void holyLight() {
    if (currentMp >= 40) {
      consumeMp(40);
      heal(50);
      print('$name invoca luz sagrada! ✨ (Cura: 50 HP)');
    }
  }
}
```

### Paso 4: Programa Principal (10 min)

```dart
void main() {
  print('╔═══════════════════════════════════════════╗');
  print('║      SISTEMA DE PERSONAJES - RPG          ║');
  print('╚═══════════════════════════════════════════╝\n');

  print('🏹 CREANDO PERSONAJES');
  print('═' * 43);
  print('');

  // Crear personajes
  var warrior = Warrior('Thorin', 5);
  print('⚔️ Guerrero: ${warrior.name}');
  warrior.displayStats();
  print('');

  var mage = Mage('Gandalf', 8);
  print('🧙 Mago: ${mage.name}');
  mage.displayStats();
  print('');

  var archer = Archer('Legolas', 6);
  print('🏹 Arquero: ${archer.name}');
  archer.displayStats();
  print('');

  var assassin = Assassin('Ezio', 7);
  print('🗡️ Asesino: ${assassin.name}');
  assassin.displayStats();
  print('');

  var paladin = Paladin('Arthas', 10);
  print('⚜️ Paladín: ${paladin.name}');
  paladin.displayStats();
  print('');

  // Demo de batalla
  print('⚡ BATALLA DEMO');
  print('═' * 43);
  print('');

  // Guerrero ataca
  warrior.swordAttack();
  warrior.criticalHit();
  warrior.defend();
  print('');

  // Mago usa magia
  mage.castFireball();
  print('');
  mage.teleport();
  print('');

  // Arquero dispara
  archer.shootArrow();
  archer.rapidFire();
  archer.hide();
  print('');

  // Asesino usa sigilo
  assassin.hide();
  assassin.sneakAttack();
  assassin.poisonAttack();
  print('');

  // Paladín usa habilidades combinadas
  paladin.swordAttack();
  paladin.defend();
  paladin.castFireball();
  paladin.holyLight();
  print('');

  // Mostrar habilidades
  print('🎯 HABILIDADES ESPECIALES');
  print('═' * 43);
  print('');

  print('${warrior.name} puede:');
  print('  ⚔️ Atacar con espada');
  print('  🛡️ Defenderse');
  print('  💥 Ataque crítico');
  print('');

  print('${mage.name} puede:');
  print('  🔥 Lanzar bola de fuego');
  print('  ❄️ Lanzar rayo de hielo');
  print('  ✨ Teletransportar');
  print('');

  print('${archer.name} puede:');
  print('  🏹 Disparar flechas');
  print('  👻 Ocultarse');
  print('  ⚡ Ataque rápido');
  print('');

  print('${assassin.name} puede:');
  print('  👻 Ocultarse');
  print('  🗡️ Ataque sigiloso');
  print('  ☠️ Ataque con veneno');
  print('');

  print('${paladin.name} puede:');
  print('  ⚔️ Atacar con espada');
  print('  🛡️ Defenderse');
  print('  🔥 Usar magia');
  print('  ✨ Luz sagrada (curación)');
}
```

---

## ✅ Checklist de Completación

- [ ] Clase base `Character` implementada
- [ ] 5+ mixins definidos con diferentes habilidades
- [ ] Mixins usan `(this as Character)` correctamente
- [ ] 5 clases de personajes diferentes
- [ ] Cada personaje combina 2-3 mixins
- [ ] Métodos de mixins funcionan correctamente
- [ ] Consumo de MP implementado
- [ ] Sistema de sigilo funciona
- [ ] Output muestra todas las habilidades
- [ ] Código bien documentado

---

## 🚀 Desafíos Opcionales

1. **Sistema de experiencia:**

   ```dart
   mixin Experience {
     int _experience = 0;
     int get experience => _experience;

     void gainExperience(int amount) {
       _experience += amount;
       print('${(this as Character).name} ganó $amount XP!');
       _checkLevelUp();
     }

     void _checkLevelUp() {
       var character = this as Character;
       var requiredXp = character.level * 100;
       if (_experience >= requiredXp) {
         character.level++;
         _experience -= requiredXp;
         print('¡${character.name} subió al nivel ${character.level}!');
       }
     }
   }
   ```

2. **Inventario:**

   ```dart
   mixin Inventory {
     List<String> _items = [];

     void addItem(String item) {
       _items.add(item);
       print('${(this as Character).name} obtuvo: $item');
     }

     void useItem(String item) {
       if (_items.remove(item)) {
         print('${(this as Character).name} usa: $item');
       }
     }

     void showInventory() {
       print('Inventario de ${(this as Character).name}:');
       for (var item in _items) {
         print('  - $item');
       }
     }
   }
   ```

3. **Efectos de estado:**

   ```dart
   enum StatusEffect { poisoned, burned, frozen, stunned, blessed }

   mixin StatusEffects {
     Set<StatusEffect> _effects = {};

     void applyEffect(StatusEffect effect) {
       _effects.add(effect);
       print('${(this as Character).name} está ${_effectName(effect)}!');
     }

     void removeEffect(StatusEffect effect) {
       _effects.remove(effect);
     }

     String _effectName(StatusEffect effect) {
       switch (effect) {
         case StatusEffect.poisoned: return 'envenenado';
         case StatusEffect.burned: return 'quemado';
         case StatusEffect.frozen: return 'congelado';
         case StatusEffect.stunned: return 'aturdido';
         case StatusEffect.blessed: return 'bendecido';
       }
     }
   }
   ```

---

## 📚 Recursos Adicionales

- [Dart Mixins](https://dart.dev/guides/language/language-tour#adding-features-to-a-class-mixins)
- [Mixin Use Cases](https://medium.com/flutter-community/dart-what-are-mixins-3a72344011f3)

---

**💡 Tip:** Los mixins son perfectos para compartir comportamiento entre clases sin usar herencia múltiple. Son muy usados en Flutter!

**⏱️ Tiempo:** 45 minutos  
**🎯 Dificultad:** ⭐⭐⭐ Media-Alta
