"""
Aluno: Marcello dos Santos
Bootcamp: BairesDev - Machine Learning Practitioner - Fevereiro 2025
Prova de Conceito - "Criação de Assistente Virtual"
"""

# Importação das bibliotecas necessárias
import speech_recognition as sr # Para reconhecimento de fala (Speech-to-Text)
from gtts import gTTS           # Para conversão de texto em fala (Text-to-Speech)
import playsound                # Para tocar áudio gerado
import webbrowser               # Para abrir URLs no navegador
import os                       # Para manipulação de arquivos (remoção de áudios antigos)

# Função 1: Converter texto em fala (Text-to-Speech - TTS)
def text_to_speech(text):
    """
    Converte texto em áudio e reproduz a mensagem.
    
    Parâmetros:
    text (str): O texto a ser convertido em fala.

    Retorno:
    Nenhum. Apenas executa o áudio.
    """
    tts = gTTS(text=text, lang='pt')  # Converte texto para áudio em português
    filename = "voice.mp3"  # Nome do arquivo de saída

    # Remove o arquivo anterior para evitar conflito
    try:
        os.remove(filename)
    except OSError:
        pass

    # Salva e reproduz o áudio
    tts.save(filename)
    playsound.playsound(filename)

# Função 2: Capturar fala e converter para texto (Speech-to-Text - STT)
def speech_to_text():
    """
    Captura a fala do usuário pelo microfone e converte em texto.
    
    Retorno:
    str: O texto reconhecido pela IA.
    None: Se não foi possível reconhecer a fala.
    """
    recognizer = sr.Recognizer()  # Inicializa o reconhecedor de áudio

    with sr.Microphone() as source:                              # Acessa o microfone do sistema
        recognizer.pause_threshold = 1                           # Aguarda até 1 segundo de silêncio antes de processar a fala
        recognizer.adjust_for_ambient_noise(source, duration=1)  # Ajusta para ruído ambiente

        print("Ouvindo...")  # Indica que está capturando áudio

        try:
            audio = recognizer.listen(source)  # Captura o áudio do usuário
            text = recognizer.recognize_google(audio, language="pt-BR").lower()  # Converte fala para texto

            print(f"Você disse: {text}")  # Exibe a saída no terminal
            return text  # Retorna o texto reconhecido

        except sr.UnknownValueError:  # Se não entender a fala
            text_to_speech("Desculpe, não entendi. Tente novamente.")
            return None
        except sr.RequestError:  # Se houver erro na API de reconhecimento
            text_to_speech("Erro no serviço de reconhecimento de fala.")
            return None

# Função 3: Gerar busca no Google Maps
def search_on_google_maps(query):
    """
    Gera uma pesquisa no Google Maps a partir do texto capturado.

    Parâmetros:
    query (str): O termo de busca a ser pesquisado no Google Maps.

    Retorno:
    Nenhum. Apenas abre o navegador com a busca.
    """
    if query:
        text_to_speech(f"OK, procurando por {query}")           # Confirma a busca antes de abrir
        url = f"https://www.google.com/maps/search/{query}/"    # Gera a URL da pesquisa
        webbrowser.open(url)                                    # Abre o navegador com a busca

# Função principal: Loop para capturar e processar comandos continuamente
def main():
    """
    Função principal que mantém o assistente virtual em loop contínuo,
    ouvindo e respondendo ao usuário até que seja solicitado o encerramento.
    """
    text_to_speech("Olá! O que você deseja procurar no Google Maps?")  # Mensagem inicial

    while True:
        user_input = speech_to_text()  # Captura o que o usuário falou

        if user_input:                                      # Se capturou alguma fala
            if user_input in ["fim", "encerrar", "sair"]:   # Se o usuário pedir para sair
                text_to_speech("Encerrando. Até logo!")     # Mensagem de despedida
                break                                       # Sai do loop e encerra o programa
            
            search_on_google_maps(user_input)               # Executa a pesquisa no Google Maps

# Executa o script apenas se ele for rodado diretamente (e não importado como módulo)
if __name__ == "__main__":
    main()
