# Используем Node.js в качестве базового образа
FROM node:18-alpine

# Устанавливаем рабочую директорию в контейнере
WORKDIR /app

# Копируем файлы package.json и package-lock.json (если есть)
COPY package*.json ./

# Устанавливаем зависимости
RUN npm install

# Копируем исходный код приложения
COPY . .

# Собираем приложение
RUN npm run build

# Открываем порт, который будет использоваться приложением
EXPOSE 3000

# Запускаем приложение
CMD ["npm", "run", "dev"]