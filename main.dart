
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/foundation.dart' ;
import 'package:flutter/material.dart' ;
import 'package:firebase_core/firebase_core.dart' ;
import 'package:gameprojact/pages/auth_page.dart'hide User;
import 'firebase_options.dart';
// Import the User class

// user_model.dart

 class User {
  bool isLevel2Unlocked = false;
  bool isLevel3Unlocked = false; // New flag for Level 3
  int coins = 0;
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Robot Fighting',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FirstPage(),
    );
  }
}
 


class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double _volume = 0.5;
  bool _isMusicEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(

        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Volume Control',
              style: TextStyle(fontSize: 24),
            ),
            Slider(
              value: _volume,
              onChanged: (newValue) {
                setState(() {
                  _volume = newValue;
                });
              },
              min: 0.0,
              max: 1.0,
              divisions: 10,
              label: _volume.toStringAsFixed(1),
            ),
            const SizedBox(height: 20),
            const Text(
              'Music',
              style: TextStyle(fontSize: 24),
            ),
            Switch(
              value: _isMusicEnabled,
              onChanged: (newValue) {
                setState(() {
                  _isMusicEnabled = newValue;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

}

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  String message = '';

  void displayMessage(String text) {
    setState(() {
      message = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Robot Fighting'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/YellowRobot.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Robot Fighting',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  displayMessage('Sign In to your account...');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  SignInPage()),
                  );
                },
                child: const Text('Sign In'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  displayMessage('Navigating to Register Page...');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  RegisterPage()),
                  );
                },
                child: const Text('Register'),
              ),
              const SizedBox(height: 20),
              Text(
                message,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class SignInPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SignInPage({super.key});


void signInUser(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // If sign-in is successful, navigate to the home page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  HomePage()),
      );
    } catch (e) {
      // Handle sign-in error
      if (kDebugMode) {
        print('Sign-in failed: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Sign In'),
      ),
      body: Padding(
        padding:const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration:const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                signInUser(context);
              },
              child:const Text('Sign In'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child:const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  RegisterPage({super.key});

  void registerUser(BuildContext context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
       email: _emailController.text,
        password: _passwordController.text,
      );
      // If registration is successful, navigate to the home page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  HomePage()),
      );
    } catch (e) {
      // Handle registration error
      if (kDebugMode) {
        print('Registration failed: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                registerUser(context);
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
 
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Home Page',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
               Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  SettingsPage()),
                  );
                // Navigate to the settings page
              },
              child: const Text('Settings'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Start a new game
              },
              child: const Text('Start New Game'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Start a new game
              },
              child: const Text('learn how to use robot '),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  MyLearningGame()),
                  );
              },
              child: const Text('Learn Robot'),
            ),
          ],
        ),
      ),
    );
  }
}
class MyLearningGame extends StatelessWidget {
  final User user = User();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CombinedGameScreen(user: user),
    );
  }
}

class CombinedGameScreen extends StatefulWidget {
  final User user;

  CombinedGameScreen({required this.user});

  @override
  _CombinedGameScreenState createState() => _CombinedGameScreenState();
}

class _CombinedGameScreenState extends State<CombinedGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Combined Learning Game'),
            const Spacer(),
            Text('Coins: ${widget.user.coins}'),
            const SizedBox(width: 16),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LevelsScreen(user: widget.user),
                  ),
                );
                // After returning from LevelsScreen, update the coins counter
                setState(() {});
              },
              child: const Text('Levels'),
            ),
          ],
        ),
      ),
    );
  }
}

class LevelsScreen extends StatefulWidget {
  final User user;

  LevelsScreen({required this.user});

  @override
  _LevelsScreenState createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Levels'),
            const Spacer(),
            Text('Coins: ${widget.user.coins}'),
            const SizedBox(width: 16),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LevelScreen(
                      user: widget.user,
                      level: 1,
                      instructions: const [
                        'moveForward()',
                        'turnRight()',
                        'turnLeft()',
                        // Add more instructions for Level 1
                      ],
                    ),
                  ),
                );
              },
              child: const Text('Level 1'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (widget.user.isLevel2Unlocked || widget.user.coins >= 5) {
                  // Check if Level 2 is unlocked or if the user has enough coins
                  if (!widget.user.isLevel2Unlocked) {
                    widget.user.isLevel2Unlocked = true; // Unlock Level 2 only once
                    widget.user.coins -= 5; // Deduct 5 coins for unlocking Level 2
                  }
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LevelScreen(
                        user: widget.user,
                        level: 2,
                        instructions: const [
                          'turnRight()',
                          'turnLeft()',
                          // Add more instructions for Level 2
                        ],
                      ),
                    ),
                  );
                  // After returning from LevelScreen, update the coins counter
                  setState(() {});
                } else {
                  // Optionally, you can provide feedback to the user
                  showInsufficientCoinsDialog(context);
                }
              },
              child: Text(widget.user.isLevel2Unlocked ? 'Level 2' : 'Level 2 (Unlock for 5 Coins)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (widget.user.isLevel3Unlocked || widget.user.coins >= 10) {
                  // Check if Level 3 is unlocked or if the user has enough coins
                  if (!widget.user.isLevel3Unlocked) {
                    widget.user.isLevel3Unlocked = true; // Unlock Level 3 only once
                    widget.user.coins -= 10; // Deduct 10 coins for unlocking Level 3
                  }
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LevelScreen(
                        user: widget.user,
                        level: 3,
                        instructions: const [
                          'Turn On Lamp',
                          'Turn Off Lamp',
                          // Add more instructions for Level 3
                        ],
                      ),
                    ),
                  );
                  // After returning from LevelScreen, update the coins counter
                  setState(() {});
                } else {
                  // Optionally, you can provide feedback to the user
                  showInsufficientCoinsDialog(context);
                }
              },
              child: Text(widget.user.isLevel3Unlocked ? 'Level 3' : 'Level 3 (Unlock for 10 Coins)'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show a dialog when the user has insufficient coins to unlock a level
  void showInsufficientCoinsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Insufficient Coins'),
          content: const Text('You do not have enough coins to unlock this level.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class LevelScreen extends StatefulWidget {
  final User user;
  final int level;
  final List<String> instructions;

  LevelScreen({required this.user, required this.level, required this.instructions});

  @override
  _LevelScreenState createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  @override
  Widget build(BuildContext context) {
    String levelDescription = (widget.level == 1)
        ? 'Make the robot move forward.'
        : (widget.level == 2)
        ? 'Turn right and left.'
        : 'Turn On/Off the Lamp.';

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Level ${widget.level}'),
            const Spacer(),
            Text('Coins: ${widget.user.coins}'),
            const SizedBox(width: 16),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              levelDescription,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScratchGameScreen(
                      user: widget.user,
                      level: widget.level,
                      instructions: widget.instructions,
                    ),
                  ),
                );
                // After returning from ScratchGameScreen, update the coins counter
                setState(() {});
              },
              child: const Text('Start Scratch Game'),
            ),
          ],
        ),
      ),
    );
  }
}

class ScratchGameScreen extends StatefulWidget {
  final User user;
  final int level;
  final List<String> instructions;

  ScratchGameScreen({required this.user, required this.level, required this.instructions});

  @override
  _ScratchGameScreenState createState() => _ScratchGameScreenState();
}

class _ScratchGameScreenState extends State<ScratchGameScreen> {
  List<String> codeBlocks = [];

  // Additional state to track correctness
  bool isMoveForwardCorrect = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Scratch Learning Game'),
            const Spacer(),
            Text('Coins: ${widget.user.coins}'),
            const SizedBox(width: 16),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScratchWorkspace(onDrop: (command) {
              setState(() {
                codeBlocks.add(command);
              });
            }),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.grey[300],
              child: Column(
                children: [
                  for (int i = 0; i < codeBlocks.length; i++)
                    Row(
                      children: [
                        ScratchBlock(
                          label: codeBlocks[i],
                          onDrop: (label) {
                            setState(() {
                              codeBlocks.removeAt(i);
                            });
                          },
                        ),
                      ],
                    ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                executeCode();
              },
              child: Text('Run Code'),
            ),
          ],
        ),
      ),
    );
  }

  void executeCode() {
    // Check correctness after executing all commands
    if (widget.instructions.contains('moveForward()') && codeBlocks.contains('moveForward()')) {
      setState(() {
        isMoveForwardCorrect = true;
      });
    } else if (widget.level == 2 &&
        codeBlocks.contains('turnRight()') &&
        codeBlocks.contains('turnLeft()') &&
        !codeBlocks.contains('moveForward()')) {
      // Check for Level 2 specific condition
      setState(() {
        isMoveForwardCorrect = true;
      });
    } else if (widget.level == 3 &&
        codeBlocks.contains('Turn On Lamp') &&
        codeBlocks.contains('Turn Off Lamp')) {
      // Check for Level 3 specific condition
      setState(() {
        isMoveForwardCorrect = true;
      });
    } else {
      setState(() {
        isMoveForwardCorrect = false;
      });
    }

    // Optionally, you can provide feedback to the user
    showFeedback();
  }

  void showFeedback() {
    if (isMoveForwardCorrect) {
      // Show correct feedback
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Correct!'),
            content: const Column(
              children: [
                Text('You executed the commands correctly!'),
                Text('You earned 10 coins as a reward.'),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  // Update the user's coins and navigate back to the level screen
                  widget.user.coins += 10; // Give 10 coins as a reward
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(); // Pop twice to go back to the level screen
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Show incorrect feedback
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Incorrect!'),
            content: const Text('Your execution is not correct.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}

class ScratchBlock extends StatelessWidget {
  final String label;
  final Function(String) onDrop;

  ScratchBlock({required this.label, required this.onDrop});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Draggable<String>(
          data: label,
          feedback: Material(
            child: Container(
              padding: EdgeInsets.all(8.0),
              color: Colors.blueAccent,
              child: Text(label),
            ),
          ),
          child: GestureDetector(
            onTap: () {
              onDrop(label);
            },
            child: Container(
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.all(8.0),
              color: Colors.blue,
              child: Text(label),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              onDrop(label);
            },
            child: Container(
              padding: const EdgeInsets.all(4.0),
              color: Colors.red,
              child: const Icon(
                Icons.delete,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ScratchWorkspace extends StatelessWidget {
  final Function(String) onDrop;

  const ScratchWorkspace({required this.onDrop});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 3; i++)
              DragTarget<String>(
                builder: (BuildContext context, List<String?> candidateData, List<dynamic> rejectedData) {
                  return ScratchBlock(
                    label: i == 0 ? 'moveForward()' : (i == 1 ? 'turnRight()' : 'turnLeft()'),
                    onDrop: onDrop,
                  );
                },
                onWillAccept: (data) {
                  return true;
                },
                onAccept: (data) {
                  onDrop(data!);
                },
              ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 3; i < 5; i++)
              DragTarget<String>(
                builder: (BuildContext context, List<String?> candidateData, List<dynamic> rejectedData) {
                  return ScratchBlock(
                    label: i == 3 ? 'Turn On Lamp' : 'Turn Off Lamp',
                    onDrop: onDrop,
                  );
                },
                onWillAccept: (data) {
                  return true;
                },
                onAccept: (data) {
                  onDrop(data!);
                },
              ),
          ],
        ),
     ],
);
}
}
