// Importa o pacote necessário para testes de integração.
import 'package:flutter/material.dart';
import 'package:integration_test/integration_test.dart';
// Importa o pacote de testes padrão do Flutter para ter acesso a `testWidgets`, `expect`, etc.
import 'package:flutter_test/flutter_test.dart';
// Importa o seu aplicativo. Ajuste o caminho se o seu main.dart estiver em outro lugar.
import 'package:spike_actions_app/main.dart' as app;

void main() {
  // Garante que o binding de testes de integração seja inicializado.
  // Esta linha é obrigatória no início dos seus testes de integração.
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Define um grupo de testes (opcional, mas bom para organização).
  group('End-to-End Counter Test', () {

    // Define um caso de teste individual. `testWidgets` nos dá um `tester` para interagir com os widgets.
    testWidgets('Verifica se o contador incrementa ao tocar no botão',
        (WidgetTester tester) async {

      // Inicia o seu aplicativo na tela.
      app.main();

      // `pumpAndSettle` aguarda todas as animações e microtarefas terminarem após iniciar o app.
      await tester.pumpAndSettle();

      // --- VALIDAÇÃO INICIAL ---
      // Verifica se o contador realmente começa em '0'.
      // `find.text('0')` procura por um widget de texto com o conteúdo '0'.
      // `findsOneWidget` é um "Matcher" que confirma que exatamente um widget foi encontrado.
      expect(find.text('0'), findsOneWidget);
      expect(find.text('1'), findsNothing); // Garante que o '1' não está na tela.

      // --- AÇÃO DO USUÁRIO ---
      // Encontra o botão de "+" pelo seu ícone.
      final Finder fab = find.byIcon(Icons.add);

      // Simula um toque no botão encontrado.
      await tester.tap(fab);

      // `pumpAndSettle` novamente para aguardar a UI ser reconstruída após o toque.
      // O contador muda de 0 para 1, e o framework precisa de um momento para redesenhar a tela.
      await tester.pumpAndSettle();

      // --- VALIDAÇÃO FINAL ---
      // Verifica se o contador foi incrementado corretamente para '1'.
      expect(find.text('1'), findsOneWidget);
      expect(find.text('0'), findsNothing); // Garante que o '0' não está mais na tela.
    });
  });
}