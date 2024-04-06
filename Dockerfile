# Используйте официальный образ Python как базовый
FROM python:3.8-slim

# Установите необходимые пакеты для pyaudio
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libavcodec-dev \
    libavformat-dev \
    libavdevice-dev \
    libportaudio2 \
    libportaudiocpp0 \
    portaudio19-dev \
    python3-pyaudio

# Установите pip и библиотеки Python
RUN pip install --upgrade pip && \
    pip install pyaudio numpy ffmpeg-python

# Скопируйте ваш код в контейнер
COPY . /app

# Установите рабочую директорию
WORKDIR /app

# Запустите ваше приложение
CMD ["python", "test.py"]
