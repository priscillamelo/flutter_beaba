import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class CuriosidadesScreen extends StatefulWidget {
  const CuriosidadesScreen({super.key});

  @override
  State<CuriosidadesScreen> createState() => _CuriosidadesScreenState();
}

class _CuriosidadesScreenState extends State<CuriosidadesScreen> {
  YoutubePlayerController? _youtubeController;
  bool _isPlayingVideo = false; // Indica se um vídeo está sendo reproduzido

  // Inicializa o controlador do YouTube
  void playYoutubeVideo(String videoId) {
    if (_youtubeController != null) {
      _youtubeController!.dispose();
    }

    setState(() {
      _isPlayingVideo = true; // Muda para o modo de reprodução
      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      )..addListener(() {
          if (_youtubeController!.value.isFullScreen) {
            return; // Evita ações indesejadas no modo tela cheia
          }
          // Verifica se o vídeo terminou
          if (_youtubeController!.value.playerState == PlayerState.ended) {
            setState(() {
              _isPlayingVideo = false; // Retorna à interface inicial
            });
          }
        });
    });
  }

  @override
  void dispose() {
    _youtubeController?.dispose();
    _youtubeController = null; // Evita referências posteriores
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Obter largura e altura da tela
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.blueAccent.shade100,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            _isPlayingVideo ? Icons.close : Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            if (_isPlayingVideo) {
              setState(() {
                _youtubeController?.dispose();
                _youtubeController =
                    null; // Garante que o controlador seja reiniciado
                _isPlayingVideo = false; // Volta para o modo inicial
              });
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: AnimatedTextKit(
          animatedTexts: [
            WavyAnimatedText(
              'CURIOSIDADES',
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
          isRepeatingAnimation: true,
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent.shade200,
        elevation: 5,
        toolbarHeight: screenHeight * 0.1, // ***10% da altura da tela
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(52),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(screenWidth * 0.05), // ***5% de margem
        padding: EdgeInsets.all(screenWidth * 0.05), // ***5% de padding interno
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: _isPlayingVideo && _youtubeController != null
            ? // ***Exibe o player do YouTube ocupando todo o espaço
            YoutubePlayerBuilder(
                player: YoutubePlayer(
                  controller: _youtubeController!,
                  showVideoProgressIndicator: true,
                ),
                builder: (context, player) {
                  return SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: player,
                  );
                },
              )
            : // ***Exibe os botões quando nenhum vídeo está sendo reproduzido
            Center(
                child: Wrap(
                  spacing: 85.0, // ***Espaço horizontal entre os widgets
                  runSpacing: 35.0, // ***Espaço vertical entre as linhas
                  alignment: WrapAlignment.center,
                  children: [
                    // Botão 1
                    InkWell(
                      onTap: () {
                        playYoutubeVideo('vtKop6XeqGg'); // ID do vídeo 1
                      },
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black, // Cor da borda
                            width: 1, // Largura da borda
                          ),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/numeros/1.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    // Botão 2
                    InkWell(
                      onTap: () {
                        playYoutubeVideo('RN1zJeFiv44');
                      },
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black, // Cor da borda
                            width: 1, // Largura da borda
                          ),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/numeros/2.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    // Botão 3
                    InkWell(
                      onTap: () {
                        playYoutubeVideo('KacvOavIp7I');
                      },
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black, // Cor da borda
                            width: 1, // Largura da borda
                          ),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/numeros/3.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        playYoutubeVideo('seNcQnkxwp8');
                      },
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black, // Cor da borda
                            width: 1, // Largura da borda
                          ),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/numeros/4.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        playYoutubeVideo('e2MYC1JpxqA');
                      },
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black, // Cor da borda
                            width: 1, // Largura da borda
                          ),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/numeros/5.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        playYoutubeVideo('TrjmQ14reMY');
                      },
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black, // Cor da borda
                            width: 1, // Largura da borda
                          ),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/numeros/6.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        playYoutubeVideo('lWfzQnSr2SE');
                      },
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black, // Cor da borda
                            width: 1, // Largura da borda
                          ),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/numeros/7.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        playYoutubeVideo('jrt2X8rXy-0');
                      },
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black, // Cor da borda
                            width: 1, // Largura da borda
                          ),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/numeros/8.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
