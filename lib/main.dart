import 'package:flutter/material.dart';
import 'package:tictactoe/ui/theme/colors.dart';
import 'package:tictactoe/ui/utils/game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {

  @override
  State<GameScreen> createState() => _MyGameScreenState();
}

class _MyGameScreenState extends State<GameScreen> {

  String lastValue = "X";
  bool gameOver = false;
  
  int turn = 0;

  String result = "";

  List<int> scoreboard = [0,0,0,0,0,0,0,0];
  Game game = Game();


  @override
  void initState() {
    super.initState();
    game.board = Game.iniGameBoard();

    debugPrint("${game.board}");
  }
  
  @override
  Widget build(BuildContext context) {

    double boardWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("It's ${lastValue} turn".toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 58.0),),
          SizedBox(height: 20.0,),
          Container(
            width: boardWidth,
            height: boardWidth,
            child: GridView.count(
              crossAxisCount: Game.boardLenght ~/ 3,
              padding: EdgeInsets.all(16.0),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: List.generate(Game.boardLenght, (index){
                return InkWell(
                  onTap: gameOver ? null : (){

                    setState(() {
                      
                      if(game.board![index] == "")
                      {
                        game.board![index] = lastValue;
                        turn ++;
                        gameOver = game.winnerCheck(lastValue, index, scoreboard, 3);

                        if(gameOver){
                          result = "${lastValue} is the winner";
                        }
                        else if(!gameOver && turn == 9){
                          result = "It's a Draw!";
                          gameOver = true;

                        }

                        if(lastValue == 'X')
                          lastValue = "O";
                        else
                          lastValue = "X";
                      }
                      

                    });

                  },
                  onDoubleTap: gameOver ? null : (){

                    /*setState(() {
                      game.board![index] = "";
                      //lastValue = "O";
                    });*/

                  },
                  child: Container(
                    width: Game.blocSize,
                    height: Game.blocSize,
                    decoration: BoxDecoration(
                      color: MainColor.secundaryColor,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Center(
                      child: Text(game.board![index], style: TextStyle(color: game.board![index] == "X" ? Colors.blue : Colors.pink, fontSize: 64.0),),
                    ),
                  ),
                );
              }),),

          ),
          SizedBox(height: 25.0,),
          Text(result, style: TextStyle(color: Colors.white, fontSize: 54.0),),
          ElevatedButton.icon(
            onPressed: (){
              setState(() {
                game.board = Game.iniGameBoard();
                lastValue = "X";
                turn = 0;
                result = "";
                gameOver = false;
                scoreboard = [0,0,0,0,0,0,0,0];

              });
            },
            icon: Icon(Icons.replay), 
            label: Text("Repeat the game"),
            
          )
        ],
      )

    );
  }
}
