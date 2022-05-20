import 'package:example_app/utils/ai_utils.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main(){
  group('tests for ai utils class', (){
    test('unit test for getScore method', (){
      int score = AiUtils.getScore([1, 0, 0, 0, 0, 0, 0, 0, 0], 2);
      expect(score, 0);

      score = AiUtils.getScore([1, 2, 1, 2, 1, 2, 1, 0, 0], 2);
      expect(score, -100);

      score = AiUtils.getScore([1, 2, 1, 2, 1, 1, 2, 1, 2], 2);
      expect(score, -50);

      score = AiUtils.getScore([1, 1, 1, 2, 1, 2, 2, 1, 2], 1);
      expect(score, 100);

    });

    test('unit test for getBestMove method', (){
      Move move = AiUtils.getBestMove([1, 0, 1, 2, 0, 0, 0, 0, 0], 2);
      expect(move.index, 1);
    });
  });
}