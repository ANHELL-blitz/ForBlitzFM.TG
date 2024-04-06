import pyaudio
import numpy as np
import ffmpeg

# Инициализация PyAudio
p = pyaudio.PyAudio()

# Параметры потока
format = pyaudio.paInt16
channels = 2
rate = 44100
chunk = 1024

# Открытие потока для чтения данных
stream = p.open(format=format, channels=channels, rate=rate, input=True, frames_per_buffer=chunk)

# Параметры сервера RTMPS
rtmps_url = 'rtmps://dc4-1.rtmp.t.me/s/'
stream_key = '2054612373:pAnQTZ0cqGIVYWnrvUWx9w'

# URL вашего MP3-потока
mp3_stream_url = 'https://a8.radioheart.ru:9038/RH75642'

# Команда FFmpeg для захвата MP3-потока и отправки его на RTMPS-сервер
command = ['ffmpeg',
           '-re',
           '-i', mp3_stream_url,
           '-c:a', 'libmp3lame',
           '-ar', str(rate),
           '-b:a', '128k',
           '-f', 'flv',
           rtmps_url + stream_key]

# Запуск FFmpeg
process = ffmpeg.run_async(command, pipe_stdin=True)

try:
    # Чтение и трансляция данных
    while True:
        data = stream.read(chunk)
        process.stdin.write(data)
except KeyboardInterrupt:
    # Закрытие потока и FFmpeg
    stream.stop_stream()
    stream.close()
    p.terminate()
    process.stdin.close()
    process.wait()
