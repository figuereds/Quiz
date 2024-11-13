import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.lightBlue[50],
      ),
      home: const StartScreen(),
    );
  }
}

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sabe tudo - Super Quiz'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Container for background image
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'lib/assets/Secao001.png'), // Verifique o caminho da imagem
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Content centered on the screen
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment
                  .center, // Garante que o conteúdo esteja centralizado
              children: [
                Image.asset(
                  'lib/assets/SABETUDO.png', // Caminho da imagem a ser exibida
                  height: 150, // Altura da imagem
                ),
                const SizedBox(height: 20),
                const Text(
                  'Bem-vindo ao Quiz!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Cor do texto sobre o background
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const QuizScreen(title: 'Sabe Tudo - Super Quiz'),
                      ),
                    );
                  },
                  child: const Text('Start'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.title});

  final String title;

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _questionIndex = 0;
  int _totalScore = 0;
  int _timer = 20; // Tempo inicial do timer
  late Timer _countdownTimer;
  double _progress = 1.0; // Progresso inicial do timer (100%)

  final List<Map<String, Object>> _questions = [
    {
      'questionText': 'Qual é a capital da França?',
      'imageUrl':
          'https://static.vecteezy.com/system/resources/previews/001/176/893/original/flag-of-france-background-vector.jpg',
      'answers': [
        {'text': 'Paris', 'score': 1},
        {'text': 'Londres', 'score': 0},
        {'text': 'Roma', 'score': 0},
        {'text': 'Berlim', 'score': 0},
      ],
    },
    {
      'questionText': 'Qual é o maior planeta do Sistema Solar?',
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToiD0JUsrkYn0rfks3RHJMecx0L7UTo_sSaA&s',
      'answers': [
        {'text': 'Terra', 'score': 0},
        {'text': 'Júpiter', 'score': 1},
        {'text': 'Marte', 'score': 0},
        {'text': 'Saturno', 'score': 0},
      ],
    },
    {
      'questionText': 'Quem pintou a Mona Lisa?',
      'imageUrl':
          'https://media.gettyimages.com/id/1174275345/photo/topshot-france-painting-heritage-art-museum.jpg?b=1&s=594x594&w=0&k=20&c=TahxNzaCQClldpPJ9mp4KNi2DfxqAy_UjpbW5x4bU-A=',
      'answers': [
        {'text': 'Vincent van Gogh', 'score': 0},
        {'text': 'Pablo Picasso', 'score': 0},
        {'text': 'Leonardo da Vinci', 'score': 1},
        {'text': 'Claude Monet', 'score': 0},
      ],
    },
    {
      'questionText': 'Qual é o animal terrestre mais rápido do mundo?',
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR38zfFXOEJgo8AsFaeCZNLVovSkctBMiLYEw&s',
      'answers': [
        {'text': 'Elefante', 'score': 0},
        {'text': 'Guepardo', 'score': 1},
        {'text': 'Leão', 'score': 0},
        {'text': 'Cavalo', 'score': 0},
      ],
    },
    {
      'questionText': 'Qual é a fórmula química da água?',
      'imageUrl':
          'https://th.bing.com/th/id/OIP.wTpSiJUKJDzzpG4Xrx0b7gHaE9?rs=1&pid=ImgDetMain',
      'answers': [
        {'text': 'H2O', 'score': 1},
        {'text': 'O2H', 'score': 0},
        {'text': 'CO2', 'score': 0},
        {'text': 'HO2', 'score': 0},
      ],
    },
    {
      'questionText': 'Em que ano o homem pisou na Lua pela primeira vez?',
      'imageUrl':
          'https://th.bing.com/th/id/OIP.SuCIqZQnfqZG4LEsx2VRDQHaGB?rs=1&pid=ImgDetMain',
      'answers': [
        {'text': '1965', 'score': 0},
        {'text': '1969', 'score': 1},
        {'text': '1975', 'score': 0},
        {'text': '1980', 'score': 0},
      ],
    },
    {
      'questionText': 'Quantos continentes existem na Terra?',
      'imageUrl':
          'https://th.bing.com/th/id/R.a8d8c6a4921e6ea361bf251e88476f46?rik=0Q6fqH74WnCW3g&riu=http%3a%2f%2f2.bp.blogspot.com%2f-LgxJkoxdTMI%2fTbF1G1UZYMI%2fAAAAAAAABgU%2f0Lb0D5Vc_0s%2fs1600%2fplaneta%2bterra.jpg&ehk=I0gjgfHrfT6d8uLnD8kBwMo1v%2fQAEqTMh8TAODQLbf4%3d&risl=&pid=ImgRaw&r=0',
      'answers': [
        {'text': '5', 'score': 0},
        {'text': '6', 'score': 0},
        {'text': '7', 'score': 1},
        {'text': '8', 'score': 0},
      ],
    },
    {
      'questionText':
          'Qual é o elemento químico representado pelo símbolo “O”?',
      'imageUrl':
          'https://th.bing.com/th/id/OIP.uswkDLbWLKLozcYEKjQuCQHaHa?rs=1&pid=ImgDetMain',
      'answers': [
        {'text': 'Ouro', 'score': 0},
        {'text': 'Oxigênio', 'score': 1},
        {'text': 'Ósmio', 'score': 0},
        {'text': 'Organônio', 'score': 0},
      ],
    },
    {
      'questionText': 'Qual é o país mais populoso do mundo?',
      'imageUrl':
          'https://th.bing.com/th/id/OIP.US-1NtwDF7dwHxPmBZXeqAHaFj?rs=1&pid=ImgDetMain',
      'answers': [
        {'text': 'Índia', 'score': 0},
        {'text': 'Estados Unidos', 'score': 0},
        {'text': 'China', 'score': 1},
        {'text': 'Brasil', 'score': 0},
      ],
    },
    {
      'questionText': 'Quantos graus tem um ângulo reto?',
      'imageUrl': 'https://m.media-amazon.com/images/I/91G5ntNn5OL.jpg',
      'answers': [
        {'text': '45', 'score': 0},
        {'text': '90', 'score': 1},
        {'text': '180', 'score': 0},
        {'text': '360', 'score': 0},
      ],
    },
  ];

  void _answerQuestion(int score) {
    setState(() {
      _totalScore += score;
      _questionIndex++;
      _timer = 20;
      _progress = 1.0;
    });

    if (_questionIndex < _questions.length) {
      _startTimer();
    }
  }

  void _startTimer() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timer > 0) {
        setState(() {
          _timer--;
          _progress = _timer / 20;
        });
      } else {
        _countdownTimer.cancel();
        _answerQuestion(0);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _countdownTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/Secao001.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (_questionIndex < _questions.length) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        CircularProgressIndicator(
                          value: _progress,
                          strokeWidth: 8.0,
                          color: Colors.green,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '$_timer',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 54, 53, 53),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.network(
                    _questions[_questionIndex]['imageUrl'] as String,
                    height: 200,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Pergunta ${_questionIndex + 1} de ${_questions.length}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _questions[_questionIndex]['questionText'] as String,
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ...(_questions[_questionIndex]['answers']
                          as List<Map<String, Object>>)
                      .map((answer) {
                    return Column(
                      children: [
                        ElevatedButton(
                          onPressed: () =>
                              _answerQuestion(answer['score'] as int),
                          child: Text(answer['text'] as String),
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  }),
                ] else ...[
                  Expanded(
                    child: Center(
                      child: _questionIndex < _questions.length
                          ? Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      _questions[_questionIndex]['imageUrl']
                                          as String,
                                      height: 200,
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      'Pergunta ${_questionIndex + 1} de ${_questions.length}',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      _questions[_questionIndex]['questionText']
                                          as String,
                                      style: const TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 20),
                                    ...(_questions[_questionIndex]['answers']
                                            as List<Map<String, Object>>)
                                        .map((answer) {
                                      return Column(
                                        children: [
                                          ElevatedButton(
                                            onPressed: () => _answerQuestion(
                                                answer['score'] as int),
                                            child: Text(answer['text'] as String),
                                          ),
                                          const SizedBox(height: 20),
                                        ],
                                      );
                                    }),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Column(
                                    children: [
                                      CircularProgressIndicator(
                                        value: _progress,
                                        strokeWidth: 8.0,
                                        color: Colors.green,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        '$_timer',
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 54, 53, 53),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Parabéns! Sua pontuação foi: $_totalScore',
                                  style: const TextStyle(fontSize: 24),
                                  textAlign: TextAlign.center,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Reiniciar o Quiz'),
                                ),
                              ],
                            ),
                    ),
                  )
                ]
              ],
            ),
          )
        ],
      ),
    );
  }
}
