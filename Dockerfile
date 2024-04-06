# Используйте официальный образ Python как базовый
FROM python:3.8-slim
RUN pip install --upgrade pip

# Установите необходимые пакеты для pyaudio
RUN pip install pyaudio
RUN pip install numpy
RUN pip install ffmpeg-python
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libavcodec-dev \
    libavformat-dev \
    libavdevice-dev \
    libportaudio2 \
    libportaudiocpp0 \
    portaudio19-dev
RUN apt-get update && apt-get install -y \
    libportaudio2 libportaudiocpp0 portaudio19-dev

# Установите pip и библиотеки Python
RUN pip install pyaudio numpy ffmpeg-python

# Скопируйте ваш код в контейнер
COPY . /app

# Установите рабочую директорию
WORKDIR /app
RUN python -m venv /venv
ENV PATH="/venv/bin:$PATH"

# Запустите ваше приложение
CMD ["python", "test.py"]
