# Используйте официальный образ Python как базовый
FROM python:3.8-slim

# Установите ffmpeg
RUN apt-get update && apt-get install -y ffmpeg

# Установите pip и библиотеки Python
RUN pip install pyaudio numpy ffmpeg-python

# Скопируйте ваш код в контейнер
COPY . /app

# Установите рабочую директорию
WORKDIR /app

# Запустите ваше приложение
CMD ["python", "test.py"]
