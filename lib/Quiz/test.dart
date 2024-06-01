
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/Quiz/Model.dart';
import 'package:quiz_app/config/get_it_config.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Quiz extends StatelessWidget {
  const Quiz({super.key});

  Future<List<QuizModel>> getQuiz() async {
    Dio req = Dio();
    try {
      Response response =
      await req.get("https://663f9699e3a7c3218a4d776a.mockapi.io/quiz");
      List<QuizModel> quiz = List.generate(
        response.data.length,
            (index) => QuizModel.fromMap(response.data[index]),
      );
      return quiz;
    } catch (e) {
      print("Failed to load quiz data: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffDA8BD9),
      appBar: AppBar(
        title: Text("Welcome  ${core.get<SharedPreferences>().getString('name')}"),
        backgroundColor: Color(0xff8D376F),
        leading: Icon(Icons.arrow_back),
      ),

      body: FutureBuilder<List<QuizModel>>(
        future: getQuiz(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('Failed to load quiz data'),
            );
          } else {
            return QuestionPage(quiz: snapshot.data!, currentQuestionIndex: 0, answers: []);
          }
        },
      ),
    );
  }
}

class QuestionPage extends StatelessWidget {
  final List<QuizModel> quiz;
  final int currentQuestionIndex;
  final List<int> answers;

  const QuestionPage({
    required this.quiz,
    required this.currentQuestionIndex,
    required this.answers,
  });

  void _onOptionSelected(BuildContext context, int answerIndex) {
    final newAnswers = List<int>.from(answers)..add(answerIndex);
    if (currentQuestionIndex < quiz.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => QuestionPage(
            quiz: quiz,
            currentQuestionIndex: currentQuestionIndex + 1,
            answers: newAnswers,
          ),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsScreen(
            name: core.get<SharedPreferences>().getString('name') ?? 'User',
            answers: newAnswers,
            quiz: quiz,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final quizItem = quiz[currentQuestionIndex];
    return Scaffold(
      backgroundColor: Colors.purple[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LinearProgressIndicator(
              value: (currentQuestionIndex + 1) / quiz.length,
              backgroundColor: Color(0xffDA8BD9),
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
            SizedBox(height: 20),
            CircleAvatar(
              backgroundColor: Colors.purple[300],
              child: Text('${currentQuestionIndex + 1}', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 20),
            Text(
              'Question ${currentQuestionIndex + 1}/${quiz.length}',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(height: 20),
            Card(
              color: Colors.orange[100],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  quizItem.question,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: quizItem.answer.length,
                itemBuilder: (context, ind) {
                  return OptionButton(
                    text: quizItem.answer[ind],
                    onPressed: () => _onOptionSelected(context, ind),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OptionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  OptionButton({
    required this.text,
    required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.purple[100],
          minimumSize: Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class ResultsScreen extends StatelessWidget {
  final String name;
  final List<int> answers;
  final List<QuizModel> quiz;

  ResultsScreen({required this.name, required this.answers, required this.quiz});

  @override
  Widget build(BuildContext context) {
    int correctCount = 0;
    for (int i = 0; i < answers.length; i++) {
      if (answers[i] == quiz[i].indexOfCorrect) {
        correctCount++;
      }
    }

    return Scaffold(
        backgroundColor: Color(0xffDA8BD9),
      appBar: AppBar(
        title: Text("Quiz Results"),
        backgroundColor: Color(0xff8D376F),
      ),
      body: Padding(
        padding:  EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'Hello $name,',
                style: TextStyle(fontSize: 24),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'You got $correctCount out of ${answers.length} correct!',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'Here are your answers:',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: answers.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Question ${index + 1}: ${quiz[index].answer[answers[index]]}'),
                    subtitle: Text('Correct answer: ${quiz[index].answer[quiz[index].indexOfCorrect]}'),
                    tileColor: answers[index] == quiz[index].indexOfCorrect
                        ? Colors.green[100]
                        : Colors.red[100],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

