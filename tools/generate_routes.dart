import 'dart:io';

void main() {
  print('🚀 Generating routes...');
  
  // قراءة ملف Routes
  final routesFile = File('lib/app/core/routes/app_route.dart');
  if (!routesFile.existsSync()) {
    print('❌ app_route.dart not found!');
    return;
  }

  final routesContent = routesFile.readAsStringSync();
  
  // استخراج الـ routes من الملف
  final routes = _extractRoutes(routesContent);
  
  if (routes.isEmpty) {
    print('❌ No routes found!');
    return;
  }

  // توليد RouteGenerator
  final generatedCode = _generateRouteGenerator(routes);
  
  // كتابة الملف
  final outputFile = File('lib/app/core/routes/route_generator.dart');
  outputFile.writeAsStringSync(generatedCode);
  
  print('✅ RouteGenerator generated successfully!');
  print('📝 Total routes: ${routes.length}');
  for (var route in routes.values) {
    print('   - ${route.fieldName}');
  }
}

// استخراج الـ routes من Routes class
Map<String, RouteInfo> _extractRoutes(String content) {
  final routes = <String, RouteInfo>{};
  
  // Pattern للـ static const String
  final pattern = RegExp(
  r'''static\s+const\s+(?:String\s+)?([A-Za-z_]\w*)\s*=\s*['"]([^'"]+)['"]\s*;'''
);
  
  final matches = pattern.allMatches(content);
  
  for (final match in matches) {
    final fieldName = match.group(1)!;
    final routeName = match.group(2)!;
    
    routes[fieldName] = RouteInfo(
      fieldName: fieldName,
      routeName: routeName,
      screenName: _generateScreenName(fieldName),
      importPath: _generateImportPath(fieldName),
    );
  }
  
  return routes;
}

// توليد اسم الـ Screen من اسم الـ route
String _generateScreenName(String fieldName) {
  if (fieldName.isEmpty) return 'Screen';
  
  final capitalized = fieldName[0].toUpperCase() + fieldName.substring(1);
  return '${capitalized}Screen';
}

// توليد الـ import path
String _generateImportPath(String fieldName) {
  final snakeCase = _toSnakeCase(fieldName);
  return 'package:flowery_rider_app/app/feature/$snakeCase/presentation/views/${snakeCase}_screen.dart';
}

String _toSnakeCase(String input) {
  return input
      .replaceAllMapped(RegExp(r'[A-Z]'), (match) => '_${match.group(0)}')
      .toLowerCase()
      .replaceFirst(RegExp(r'^_'), '');
}

// توليد كود RouteGenerator
String _generateRouteGenerator(Map<String, RouteInfo> routes) {
  final buffer = StringBuffer();
  
  buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
  buffer.writeln('// Generated at: ${DateTime.now()}');
  buffer.writeln();
  
  // Imports
  buffer.writeln("import 'package:flowery_rider_app/app/core/routes/app_route.dart';");
  buffer.writeln("import 'package:flutter/material.dart';");
  buffer.writeln();
  
  // Import screens (commented for manual activation)
  buffer.writeln('// TODO: Uncomment imports when screens are ready:');
  for (var route in routes.values) {
    buffer.writeln("// import '${route.importPath}';");
  }
  buffer.writeln();
  
  // RouteGenerator class
  buffer.writeln('class RouteGenerator {');
  buffer.writeln('  static Route<dynamic> getRoutes(RouteSettings settings) {');
  buffer.writeln('    switch (settings.name) {');
  
  // Generate cases
  for (var entry in routes.entries) {
    final fieldName = entry.key;
    final route = entry.value;
    buffer.writeln('      case Routes.$fieldName:');
    buffer.writeln('        // TODO: Uncomment when ${route.screenName} is ready');
    buffer.writeln('        // return MaterialPageRoute(builder: (_) => const ${route.screenName}());');
    buffer.writeln('        return unDefinedRoute();');
  }
  
  buffer.writeln('      default:');
  buffer.writeln('        return unDefinedRoute();');
  buffer.writeln('    }');
  buffer.writeln('  }');
  buffer.writeln();
  buffer.writeln('  static Route<dynamic> unDefinedRoute() {');
  buffer.writeln('    return MaterialPageRoute(');
  buffer.writeln('      builder: (_) => Scaffold(');
  buffer.writeln("        appBar: AppBar(title: const Text('No Route Found')),");
  buffer.writeln("        body: const Center(child: Text('No Route Found')),");
  buffer.writeln('      ),');
  buffer.writeln('    );');
  buffer.writeln('  }');
  buffer.writeln('}');
  
  return buffer.toString();
}

class RouteInfo {
  final String fieldName;
  final String routeName;
  final String screenName;
  final String importPath;

  RouteInfo({
    required this.fieldName,
    required this.routeName,
    required this.screenName,
    required this.importPath,
  });
}