# 💻 Práctica 1: POO - Sistema de Biblioteca

**⏱️ Duración:** 45 minutos  
**📊 Dificultad:** ⭐⭐ Media  
**🎯 Conceptos:** Clases, objetos, métodos, listas, búsqueda

---

## 🎯 Objetivo

Crear un **sistema de gestión de biblioteca** usando POO que permita registrar libros, usuarios y gestionar préstamos.

---

## 📚 Conceptos que Aplicaremos

- ✅ Clases y objetos
- ✅ Constructores
- ✅ Métodos de instancia
- ✅ Listas como propiedades
- ✅ Búsqueda y filtrado
- ✅ Validaciones

---

## 🖼️ Resultado Esperado

Tu programa debe ejecutarse y mostrar:

```
╔══════════════════════════════════════════╗
║     SISTEMA DE GESTIÓN - BIBLIOTECA      ║
╚══════════════════════════════════════════╝

📚 Agregando libros al catálogo...
✓ Libro agregado: El Quijote
✓ Libro agregado: Cien Años de Soledad
✓ Libro agregado: 1984

👥 Registrando usuarios...
✓ Usuario registrado: Ana García (ID: U001)
✓ Usuario registrado: Carlos Ruiz (ID: U002)

📖 PRÉSTAMOS
══════════════════════════════════════════
✓ "El Quijote" prestado a Ana García
✗ "El Quijote" no disponible (ya prestado)
✓ "1984" prestado a Carlos Ruiz

📊 ESTADO DE LA BIBLIOTECA
══════════════════════════════════════════
Total de libros: 3
Libros disponibles: 1
Libros prestados: 2

📚 Libros de Ana García:
  • El Quijote (Miguel de Cervantes)

📚 Libros de Carlos Ruiz:
  • 1984 (George Orwell)
```

---

## 📋 Instrucciones

### Paso 1: Crear la Clase `Book` (10 min)

```dart
class Book {
  String title;
  String author;
  String isbn;
  bool isAvailable;
  
  Book({
    required this.title,
    required this.author,
    required this.isbn,
    this.isAvailable = true,
  });
  
  void displayInfo() {
    String status = isAvailable ? '✓ Disponible' : '✗ Prestado';
    print('$title - $author [$status]');
  }
}
```

**Tareas:**
1. Copia el código de la clase `Book`
2. Entiende cada propiedad:
   - `title`: Título del libro
   - `author`: Autor
   - `isbn`: Código único
   - `isAvailable`: ¿Está disponible?
3. Analiza el método `displayInfo()`

### Paso 2: Crear la Clase `User` (10 min)

```dart
class User {
  String id;
  String name;
  List<Book> borrowedBooks;
  
  User({
    required this.id,
    required this.name,
  }) : borrowedBooks = [];
  
  void borrowBook(Book book) {
    borrowedBooks.add(book);
  }
  
  void returnBook(Book book) {
    borrowedBooks.remove(book);
  }
  
  void showBorrowedBooks() {
    if (borrowedBooks.isEmpty) {
      print('$name no tiene libros prestados');
    } else {
      print('📚 Libros de $name:');
      for (var book in borrowedBooks) {
        print('  • ${book.title} (${book.author})');
      }
    }
  }
}
```

**Tareas:**
1. Crea la clase `User`
2. Inicializa `borrowedBooks` como lista vacía
3. Implementa los métodos para agregar y quitar libros

### Paso 3: Crear la Clase `Library` (15 min)

```dart
class Library {
  String name;
  List<Book> catalog;
  List<User> users;
  
  Library(this.name)
      : catalog = [],
        users = [];
  
  // Agregar libro al catálogo
  void addBook(Book book) {
    catalog.add(book);
    print('✓ Libro agregado: ${book.title}');
  }
  
  // Registrar usuario
  void registerUser(User user) {
    users.add(user);
    print('✓ Usuario registrado: ${user.name} (ID: ${user.id})');
  }
  
  // Prestar libro
  bool lendBook(String isbn, String userId) {
    // Buscar libro por ISBN
    Book? book;
    for (var b in catalog) {
      if (b.isbn == isbn) {
        book = b;
        break;
      }
    }
    
    if (book == null) {
      print('✗ Libro no encontrado');
      return false;
    }
    
    if (!book.isAvailable) {
      print('✗ "${book.title}" no disponible (ya prestado)');
      return false;
    }
    
    // Buscar usuario por ID
    User? user;
    for (var u in users) {
      if (u.id == userId) {
        user = u;
        break;
      }
    }
    
    if (user == null) {
      print('✗ Usuario no encontrado');
      return false;
    }
    
    // Realizar préstamo
    book.isAvailable = false;
    user.borrowBook(book);
    print('✓ "${book.title}" prestado a ${user.name}');
    return true;
  }
  
  // Devolver libro
  bool returnBook(String isbn, String userId) {
    // Buscar libro
    Book? book;
    for (var b in catalog) {
      if (b.isbn == isbn) {
        book = b;
        break;
      }
    }
    
    if (book == null) {
      print('✗ Libro no encontrado');
      return false;
    }
    
    // Buscar usuario
    User? user;
    for (var u in users) {
      if (u.id == userId) {
        user = u;
        break;
      }
    }
    
    if (user == null) {
      print('✗ Usuario no encontrado');
      return false;
    }
    
    // Realizar devolución
    book.isAvailable = true;
    user.returnBook(book);
    print('✓ "${book.title}" devuelto por ${user.name}');
    return true;
  }
  
  // Mostrar estadísticas
  void showStats() {
    int available = catalog.where((book) => book.isAvailable).length;
    int borrowed = catalog.length - available;
    
    print('\n📊 ESTADO DE LA BIBLIOTECA');
    print('═' * 42);
    print('Total de libros: ${catalog.length}');
    print('Libros disponibles: $available');
    print('Libros prestados: $borrowed');
  }
  
  // Listar libros disponibles
  void listAvailableBooks() {
    var available = catalog.where((book) => book.isAvailable).toList();
    
    if (available.isEmpty) {
      print('No hay libros disponibles');
    } else {
      print('\n📚 LIBROS DISPONIBLES');
      print('═' * 42);
      for (var book in available) {
        book.displayInfo();
      }
    }
  }
}
```

**Tareas:**
1. Crea la clase `Library`
2. Implementa el método `lendBook()` siguiendo la lógica:
   - Buscar libro por ISBN
   - Verificar disponibilidad
   - Buscar usuario
   - Realizar préstamo
3. Implementa `returnBook()` de forma similar
4. Completa los métodos de estadísticas

### Paso 4: Programa Principal (10 min)

```dart
void main() {
  print('╔══════════════════════════════════════════╗');
  print('║     SISTEMA DE GESTIÓN - BIBLIOTECA      ║');
  print('╚══════════════════════════════════════════╝\n');
  
  // Crear biblioteca
  var library = Library('Biblioteca Municipal');
  
  // Agregar libros
  print('📚 Agregando libros al catálogo...');
  library.addBook(Book(
    title: 'El Quijote',
    author: 'Miguel de Cervantes',
    isbn: 'ISBN-001',
  ));
  
  library.addBook(Book(
    title: 'Cien Años de Soledad',
    author: 'Gabriel García Márquez',
    isbn: 'ISBN-002',
  ));
  
  library.addBook(Book(
    title: '1984',
    author: 'George Orwell',
    isbn: 'ISBN-003',
  ));
  
  // Registrar usuarios
  print('\n👥 Registrando usuarios...');
  library.registerUser(User(
    id: 'U001',
    name: 'Ana García',
  ));
  
  library.registerUser(User(
    id: 'U002',
    name: 'Carlos Ruiz',
  ));
  
  // Realizar préstamos
  print('\n📖 PRÉSTAMOS');
  print('═' * 42);
  library.lendBook('ISBN-001', 'U001');
  library.lendBook('ISBN-001', 'U002');  // Intentar prestar libro no disponible
  library.lendBook('ISBN-003', 'U002');
  
  // Mostrar estadísticas
  library.showStats();
  
  // Mostrar libros de usuarios
  print('');
  library.users[0].showBorrowedBooks();
  print('');
  library.users[1].showBorrowedBooks();
  
  // Listar libros disponibles
  library.listAvailableBooks();
  
  // Devolver un libro
  print('\n📥 DEVOLUCIONES');
  print('═' * 42);
  library.returnBook('ISBN-001', 'U001');
  
  // Actualizar estadísticas
  library.showStats();
}
```

---

## ✅ Checklist de Completación

Antes de terminar, verifica que:

- [ ] La clase `Book` tiene todas las propiedades
- [ ] La clase `User` maneja la lista de libros prestados
- [ ] La clase `Library` gestiona catálogo y usuarios
- [ ] El método `lendBook()` valida disponibilidad
- [ ] El método `returnBook()` actualiza el estado
- [ ] Las estadísticas se calculan correctamente
- [ ] El programa muestra el output esperado
- [ ] El código está comentado

---

## 🚀 Desafíos Opcionales

1. **Búsqueda avanzada:**
   ```dart
   List<Book> searchByAuthor(String author) {
     return catalog.where((book) => 
       book.author.toLowerCase().contains(author.toLowerCase())
     ).toList();
   }
   ```

2. **Límite de préstamos:**
   ```dart
   // Usuario solo puede tener máximo 3 libros
   bool canBorrowMore() {
     return borrowedBooks.length < 3;
   }
   ```

3. **Fecha de devolución:**
   ```dart
   class Book {
     DateTime? dueDate;
     
     bool isOverdue() {
       if (dueDate == null) return false;
       return DateTime.now().isAfter(dueDate!);
     }
   }
   ```

4. **Multas por retraso:**
   ```dart
   double calculateFine() {
     if (!isOverdue()) return 0.0;
     var daysLate = DateTime.now().difference(dueDate!).inDays;
     return daysLate * 0.50; // $0.50 por día
   }
   ```

---

## 📚 Recursos Adicionales

- [Dart Classes](https://dart.dev/guides/language/language-tour#classes)
- [Working with Lists](https://dart.dev/guides/libraries/library-tour#lists)
- [DartPad](https://dartpad.dev/)

---

**💡 Tip:** Este sistema es la base de muchas aplicaciones CRUD (Create, Read, Update, Delete). ¡Domina este patrón!

**⏱️ Tiempo:** 45 minutos  
**🎯 Dificultad:** ⭐⭐ Media
