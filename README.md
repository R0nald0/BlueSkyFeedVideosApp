# BlueSky Videos Feed

## Sobre o Projeto
Aplicativo desenvolvido em Flutter (Dart) que apresenta um feed de vídeos verticais, no estilo TikTok/Reels, utilizando a  api de rede social Bluesky como backend, utilizando  a biblioteca atproto.  
### Explicações relevantes
Para desenvolvimento do aplicativo foi utilizado a IA ChatGPT para criação do layout base, o feed com pageBuilder e configuração do video_player,refinamento de mêtodos para busca de dados da Api,na classe reposítory.

### Imagens do App
---
<img src="https://github.com/user-attachments/assets/cfec0dec-abc8-415e-80c0-6fbb7962c92e" height="450em">

### Estrutura do Projeto
 *  **android**/: Arquivos específicos para plataforma Android:
 *  **lib/**/: Possui a pasta app com lógica do aplicativo,estrutura base, telas, widgets,controllers,data,etc.
 *  **lib/app/core**/: Possui classes de acesso global do aplicativo.
 *  **lib/app/presentation**/: Possui a classes de controllers e page.
 *  **lib/app/data**: Possui model,repositório e remote para acesso a externo 


### Como Rodar 
<p>
 Pra rodar e testar, basta ter o Flutter instalado,clonar ou fazer um fork deste repositório e executar com:
</p>

```
 flutter pub get
 flutter pub run
```

### Funcionalidades do App
---
* Permite scroll vertical entre vídeos (um por vez, tela cheia),rolagem infinita.
* Contendo funcionalidade de play/pause no vídeo atual ao tocar na tela.
* Exibição de foto de perfil do autor do vídeo.
* Exibição o nome do autor.

 ### Tecnologias utilizadas
 ---
 * Flutter modeular para injeção de Dependência
 * ChangeNotifier para Gerencimento de estado.
 * ATProto 
 * Consumo da Bluesky API via ATProto: 

  vesão do Flutter da 3.27.1
  vesão do Dart da 3.6.0
  
  ![Badge em Desenvolvimento](http://img.shields.io/static/v1?label=STATUS&message=EM%20DESENVOLVIMENTO&color=GREEN&style=for-the-badge)
  ![Badge em dart](http://img.shields.io/static/v1?label=LENGUAGE&message=%20DART&color=BLUEN&style=for-the-badge)
  ![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
  ![Visual Studio Code](https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white)
