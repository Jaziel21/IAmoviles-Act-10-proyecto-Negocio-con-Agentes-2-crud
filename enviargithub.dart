import 'dart:io';

void main() async {
  print('========================================');
  print('  Agente para enviar repositorio a GitHub');
  print('========================================\n');

  // 1. Que pregunte por el link del nuevo repositorio como entrada de dato
  stdout.write('1. Ingresa el link del nuevo repositorio de GitHub: ');
  String? repoUrl = stdin.readLineSync();
  if (repoUrl == null || repoUrl.trim().isEmpty) {
    print('Error: El link del repositorio no puede estar vacío.');
    return;
  }

  // 2. Que pregunte por el commit como entrada de dato
  stdout.write('2. Ingresa el mensaje para el commit: ');
  String? commitMessage = stdin.readLineSync();
  if (commitMessage == null || commitMessage.trim().isEmpty) {
    commitMessage = 'Initial commit';
    print('   -> Mensaje vacío. Se usará por defecto: "$commitMessage"');
  }

  // 3. Establezca la rama main por default o pedir nombre de la rama
  stdout.write('3. Ingresa el nombre de la rama (presiona Enter para usar "main" por defecto): ');
  String? branchName = stdin.readLineSync();
  if (branchName == null || branchName.trim().isEmpty) {
    branchName = 'main';
    print('   -> Rama establecida por defecto: "$branchName"');
  } else {
    branchName = branchName.trim();
  }

  print('\n----------------------------------------');
  print('Ejecutando comandos de Git...');
  print('----------------------------------------\n');

  // Inicializar git
  await runCommand('git', ['init'], 'Inicializando repositorio...');
  
  // Agregar archivos
  await runCommand('git', ['add', '.'], 'Agregando archivos al area de preparación...');
  
  // Hacer commit
  await runCommand('git', ['commit', '-m', commitMessage], 'Creando commit...');
  
  // Establecer la rama actual
  await runCommand('git', ['branch', '-M', branchName], 'Renombrando la rama a $branchName...');
  
  // Configurar remoto origin
  print('Configurando el repositorio remoto...');
  var remoteResult = await Process.run('git', ['remote', 'add', 'origin', repoUrl.trim()]);
  if (remoteResult.exitCode != 0) {
    // Si ya existe el origen, intentar cambiarlo
    var setUrlResult = await Process.run('git', ['remote', 'set-url', 'origin', repoUrl.trim()]);
    if (setUrlResult.exitCode != 0) {
      print('Error al configurar el remoto origin:\\n${remoteResult.stderr}\\n${setUrlResult.stderr}');
      exit(1);
    }
  } else {
    print('✓ Remoto configurado');
  }

  // Subir cambios (push)
  await runCommand('git', ['push', '-u', 'origin', branchName], '\nSubiendo los cambios a GitHub en la rama $branchName...');

  print('\n========================================');
  print('   ¡Proceso completado exitosamente!      ');
  print('========================================');
}

/// Función auxiliar para ejecutar comandos y manejar errores visualmente
Future<void> runCommand(String executable, List<String> arguments, String startMessage) async {
  print(startMessage);
  var result = await Process.run(executable, arguments);
  
  if (result.exitCode != 0) {
    print('Error ejecutando $executable ${arguments.join(' ')}:\\n${result.stderr}');
    exit(1);
  } else {
    if (result.stdout.toString().trim().isNotEmpty) {
      print(result.stdout.toString().trim());
    }
    print('✓ Listo');
  }
}
