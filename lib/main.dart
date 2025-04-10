import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:spark_desafio_tecnico/app_module.dart';
import 'package:spark_desafio_tecnico/app_widget.dart';

void main() {
  runApp( ModularApp(module: AppModule(), child: AppWidget()) );
}
